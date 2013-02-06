/*******************************************************************************
 * Copyright (c) 2012, Directors of the Tyndale STEP Project
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without 
 * modification, are permitted provided that the following conditions 
 * are met:
 * 
 * Redistributions of source code must retain the above copyright 
 * notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright 
 * notice, this list of conditions and the following disclaimer in 
 * the documentation and/or other materials provided with the 
 * distribution.
 * Neither the name of the Tyndale House, Cambridge (www.TyndaleHouse.com)  
 * nor the names of its contributors may be used to endorse or promote 
 * products derived from this software without specific prior written 
 * permission.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS 
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT 
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS 
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE 
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, 
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, 
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER 
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT 
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING 
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF 
 * THE POSSIBILITY OF SUCH DAMAGE.
 ******************************************************************************/
package com.tyndalehouse.step.core.service.jsword.helpers;

import java.io.IOException;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.SortedSet;
import java.util.TreeMap;
import java.util.TreeSet;

import org.apache.lucene.index.Term;
import org.apache.lucene.index.TermDocs;
import org.apache.lucene.search.IndexSearcher;
import org.crosswire.jsword.book.Book;
import org.crosswire.jsword.book.BookData;
import org.crosswire.jsword.book.BookException;
import org.crosswire.jsword.book.Books;
import org.crosswire.jsword.book.OSISUtil;
import org.crosswire.jsword.index.Index;
import org.crosswire.jsword.index.IndexManager;
import org.crosswire.jsword.index.IndexManagerFactory;
import org.crosswire.jsword.index.lucene.LuceneIndex;
import org.crosswire.jsword.passage.Key;
import org.crosswire.jsword.passage.NoSuchKeyException;
import org.crosswire.jsword.passage.Verse;
import org.crosswire.jsword.versification.Testament;
import org.crosswire.jsword.versification.Versification;
import org.jdom.Element;
import org.jdom.filter.Filter;
import org.slf4j.Logger;

import com.tyndalehouse.step.core.data.EntityDoc;
import com.tyndalehouse.step.core.data.EntityIndexReader;
import com.tyndalehouse.step.core.data.EntityManager;
import com.tyndalehouse.step.core.exceptions.StepInternalException;
import com.tyndalehouse.step.core.models.LexiconSuggestion;
import com.tyndalehouse.step.core.models.search.BookAndBibleCount;
import com.tyndalehouse.step.core.models.search.StrongsAndCounts;
import com.tyndalehouse.step.core.service.jsword.JSwordVersificationService;
import com.tyndalehouse.step.core.utils.StringConversionUtils;

/**
 * Provides each strong number given a verse.
 * <p>
 * TODO: is it worth introducing a cache here for all verses? Raise JIRA to work that one out at some point //
 * TODO: change to ESV book, rather than KJV TOD: Should we cache intermediate strongs? since they can be
 * re-used without looking up Lucene - on the other hand, Lucene is very quick
 */
public class JSwordStrongNumberHelper {
    private static final Logger LOG = org.slf4j.LoggerFactory.getLogger(JSwordStrongNumberHelper.class);
    private static final String STRONG_REF_VERSION = "KJV";
    private static final Book STRONG_REF_VERSION_BOOK = Books.installed().getBook(STRONG_REF_VERSION);
    private final JSwordVersificationService versification;
    private Map<String, SortedSet<LexiconSuggestion>> verseStrongs;
    private Map<String, BookAndBibleCount> allStrongs;
    private boolean isOT;

    /**
     * Instantiates a new strong number provider impl.
     * 
     * @param manager the manager that helps look up references
     * @param reference the reference in the KJV versification equivalent
     * @param versification the versification service to lookup the versification of the reference book
     *            (avoiding statics here!)
     */
    public JSwordStrongNumberHelper(final EntityManager manager, final String reference,
            final JSwordVersificationService versification) {
        this.versification = versification;
        try {
            final Key key = STRONG_REF_VERSION_BOOK.getKey(reference);
            this.verseStrongs = new TreeMap<String, SortedSet<LexiconSuggestion>>();
            this.allStrongs = new HashMap<String, BookAndBibleCount>(256);

            final List<Element> elements = getOsisElements(key);

            for (final Element e : elements) {
                readDataFromLexicon(manager.getReader("definition"),
                        e.getAttributeValue(OSISUtil.OSIS_ATTR_OSISID), OSISUtil.getStrongsNumbers(e));
            }

            // now get counts in the relevant portion of text
            applySearchCounts(getBookFromKey(key));

            // is it OT or NT
            final Versification v11n = versification.getVersificationForVersion(STRONG_REF_VERSION_BOOK);
            this.isOT = v11n.getTestament(v11n.getOrdinal((Verse) key.get(0))) == Testament.OLD;

        } catch (final NoSuchKeyException ex) {
            LOG.warn("Unable to enhance verse numbers.", ex);
        } catch (final BookException ex) {
            LOG.warn("Unable to enhance verse number", ex);
        }
    }

    /**
     * The book of the OSIS ID reference, or the passed in parameter in every other case where the OSIS ID
     * does not contain multiple part.
     * 
     * @param key the key, used to lookup the OSIS ID
     * @return the book from osis
     */
    private String getBookFromKey(final Key key) {
        final String osisID = key.getOsisID();
        final int firstPartStart = osisID.indexOf('.');
        if (firstPartStart == -1) {
            // then looking at a whole book, so just return
            return osisID;
        }
        return osisID.substring(0, firstPartStart);
    }

    /**
     * Applies the search counts for every strong number.
     * 
     * @param bookName the book name
     */
    private void applySearchCounts(final String bookName) {
        final IndexManager indexManager = IndexManagerFactory.getIndexManager();
        Index index;
        try {
            index = indexManager.getIndex(STRONG_REF_VERSION_BOOK);

            if (!(index instanceof LuceneIndex)) {
                LOG.warn("Unsupport Lucene Index type [{}]", index.getClass());
                return;
            }

            @SuppressWarnings("resource")
            final LuceneIndex li = (LuceneIndex) index;
            final IndexSearcher is = (IndexSearcher) li.getSearcher();

            final TermDocs termDocs = is.getIndexReader().termDocs();
            for (final Entry<String, BookAndBibleCount> strong : this.allStrongs.entrySet()) {
                termDocs.seek(new Term(LuceneIndex.FIELD_STRONG, strong.getKey()));
                int bible = 0;
                int book = 0;
                while (termDocs.next()) {
                    final int freq = termDocs.freq();
                    bible += freq;

                    final String docRef = is.doc(termDocs.doc()).get(LuceneIndex.FIELD_KEY);
                    if (docRef != null && docRef.startsWith(bookName)) {
                        book += freq;
                    }
                }
                final BookAndBibleCount value = strong.getValue();

                value.setBible(bible);
                value.setBook(book);
                bible = 0;
                book = 0;
            }
        } catch (final BookException e) {
            throw new StepInternalException(e.getMessage(), e);
        } catch (final IOException e) {
            throw new StepInternalException(e.getMessage(), e);
        }
    }

    /**
     * Read data from lexicon.
     * 
     * @param reader the reader
     * @param verseRef the verse ref
     * @param strongNumbers the strong numbers
     */
    private void readDataFromLexicon(final EntityIndexReader reader, final String verseRef,
            final String strongNumbers) {

        final String strongQuery = StringConversionUtils.getStrongPaddedKey(strongNumbers);

        final EntityDoc[] docs = reader.search("strongNumber", strongQuery);
        final SortedSet<LexiconSuggestion> verseSuggestions = new TreeSet<LexiconSuggestion>(
                new Comparator<LexiconSuggestion>() {

                    @Override
                    public int compare(final LexiconSuggestion o1, final LexiconSuggestion o2) {
                        return o1.getGloss().toLowerCase(Locale.ENGLISH)
                                .compareTo(o2.getGloss().toLowerCase(Locale.ENGLISH));
                    }
                });

        for (final EntityDoc d : docs) {
            final LexiconSuggestion ls = new LexiconSuggestion();
            ls.setStrongNumber(d.get("strongNumber"));
            ls.setGloss(d.get("stepGloss"));
            ls.setMatchingForm(d.get("accentedUnicode"));
            ls.setStepTransliteration(d.get("stepTransliteration"));
            verseSuggestions.add(ls);

            this.allStrongs.put(ls.getStrongNumber(), new BookAndBibleCount());
        }

        this.verseStrongs.put(verseRef, verseSuggestions);
    }

    /**
     * Gets the osis elements.
     * 
     * @param key the key
     * @return the osis elements
     * @throws NoSuchKeyException the no such key exception
     * @throws BookException the book exception
     */
    @SuppressWarnings({ "unchecked", "serial" })
    private List<Element> getOsisElements(final Key key) throws NoSuchKeyException, BookException {
        final BookData data = new BookData(STRONG_REF_VERSION_BOOK, key);
        final List<Element> elements = data.getOsisFragment().getContent(new Filter() {
            @Override
            public boolean matches(final Object object) {
                if (object instanceof Element) {
                    final Element element = (Element) object;
                    if (OSISUtil.OSIS_ELEMENT_VERSE.equals(element.getName())) {
                        return true;
                    }
                }
                return false;
            }
        });
        return elements;
    }

    /**
     * @return the verseStrongs
     */
    public StrongsAndCounts getVerseStrongs() {
        final StrongsAndCounts sac = new StrongsAndCounts();
        sac.setCounts(this.allStrongs);
        sac.setStrongData(this.verseStrongs);
        sac.setOT(this.isOT);
        return sac;
    }
}
