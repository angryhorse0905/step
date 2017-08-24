<%@ page import="com.google.inject.Injector" %>
<%@ page import="java.util.Locale" %>
<%@ page import="javax.servlet.jsp.jstl.core.Config" %>
<%@ page import="com.tyndalehouse.step.core.service.AppManagerService" %>
<%@ page import="com.tyndalehouse.step.core.models.ClientSession" %>
<%@ page import="com.tyndalehouse.step.rest.controllers.SearchPageController" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    Injector injector = (Injector) pageContext.getServletContext().getAttribute(Injector.class.getName());
    Locale locale = injector.getInstance(ClientSession.class).getLocale();
    Config.set(session, Config.FMT_LOCALE, locale.getLanguage());
    AppManagerService appManager = injector.getInstance(AppManagerService.class);
    request.setAttribute("analyticsToken", Boolean.TRUE.equals(Boolean.getBoolean("step.development")) ? SearchPageController.DEV_TOKEN : SearchPageController.LIVE_TOKEN);
%>
<fmt:setBundle basename="HtmlBundle"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<HTML>
<HEAD>
    <META http-equiv="Content-Type" content="text/html; charset=utf-8">
    <TITLE>E4.org</TITLE>
    <%@include file="jsps/offlinePage.jsp" %>
    <link href="css/bootstrap.css" rel="stylesheet" media="screen"/>
    <link href="css/bootstrap-theme.min.css" rel="stylesheet" media="screen"/>
    <link rel="stylesheet" type="text/css" href="static/static.css"/>
    <link rel="shortcut icon" href="images/step-favicon.ico"/>
    <script src="international/interactive.js" type="text/javascript"></script>
    <script src="libs/sprintf-0.7-beta1.js" type="text/javascript"></script>
    <script src="js/step_constants.js" type="text/javascript"></script>
    <script src="js/step.util.js" type="text/javascript"></script>

    <style type="text/css">
        .pageContent {
            margin: 20px;
        }

        .navTree {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;
        }

        .navTreeSub {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 10px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;
        }

        body {
            margin: 0px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        p {
            margin: 12px;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        td {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
        }

        .copyright {
            font-family: Verdana, Arial, Helvetica, sans-serif;
            font-size: 10px;
            color: #000000;
            text-decoration: none;
        }

        .bottomnav {
            color: #999999;
            text-decoration: none;
        }

        a {
            color: #5A75A5;
        }

        .g1 {
            color: #5A75A5;
            text-decoration: none;
        }

        .g2 {
            color: #F7AA10;
            text-decoration: none;
        }

        .g3 {
            color: #ADA608;
            text-decoration: none;
        }

        .contactform {
            font-size: 10px;

        }

        .contactheader {
            font-size: 12px;
            color: #FFFFFF;
            font-weight: bold;
        }

        .quote {
            font-family: "Times New Roman", Times, serif;
            font-size: 12px;
            font-style: italic;
            font-weight: bold;
        }

        .quotetitle {
            font-family: "Times New Roman", Times, serif;
            font-size: 18px;
            font-style: italic;
            font-weight: bold;
        }

        .prod {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #CCCCCC;

        }

        .proddescr {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            text-align: justify;
            color: #444444;

        }

        .prodprice {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 12px;
            font-weight: bold;
            color: #5A75A5;

        }

        .prodtitle {
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            font-weight: bold;
            color: #5A75A5;
            text-decoration: none;

        }

        ul {
            margin-top: 0;
            margin-bottom: 0;
            list-style-position: outside;
        }
    </style>

</HEAD>
<body>
<div>
    <a href="/">
        <div class="header">
            <h1></h1>
        </div>
    </a>
    <div class="pageContent">


        <table border="0" width="100%" cellspacing="0" cellpadding="0">
            <tbody><tr>
                <td colspan="2"><img border="0" src="/pictures/tl_CSGU.gif" alt="The Christmas Story: God with Us"></td>

            </tr>
            <tr><td>&nbsp;</td></tr>
            <tr>


                <td width="25%">
                    <img border="0" src="/pictures/bsml_CSGU.png" alt="The Christmas Story: God with Us">
                </td>


                <td width="75%" valign="top">
                    <b>
                        <br>



                        <font color="#DF0000">



                            <!--On Sale for only $22.95 <br>
                            </font><span class="style1">Regular $51.95</span><font color="#DF0000"> <br> -->
                            Price: $22.95 <br>


                            <br>



                            <br>
                            <br>
                            <!--added by sam-->



                            <a href="/cart/viewcartmodify.asp?library=259">
                                <img border="0" src="../img/btn_addtocartsml.gif" alt="Add to cart"></a>




                            <a href="newlibraries.asp">
                                <img border="0" src="../img/btn_viewalllibrariessm.gif" alt="View All Libraries"></a>


                        </font></b></td>
            </tr>
            </tbody></table>

        <table border="0" width="490" cellspacing="0" cellpadding="0">
            <tbody><tr>
                <td width="488" height="15" colspan="2" valign="top">&nbsp;

                </td>
            </tr>
            <tr>
                <td width="488" valign="top" colspan="2" class="proddescr">
                    <b>Vibrant with hope</b>! The <b>magnitude</b> of the <b>mystery of Christmas</b>! God manifest in human form! The <b>Eternal One</b> born into Time; the <b>Omnipresent One</b> confined by space; the <b>Omniscient One</b> compressed within a human frame. The <b>Master of the Universe</b>  - a Servant on earth! The <b>Object of the Father’s delight</b> - weary, thirsty and rejected - dies on a cross but triumphantly<b> rises to reconcile</b> sinful man with a Holy God. Savor this <b>specially selected</b> compendium of notable works in E4’s <i>The Christmas Story: God With Us Library.</i> &nbsp;
                    <b>
                        <font size="2" color="#DF0000"><br>Just Released Dec 10th  2013!!</font></b>
                </td>
            </tr>



            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Virgin_Birth_of_Christ.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Virgin Birth of Christ <br><i>J. Gresham Machen</i></span>




                    <br>
                    <p><b>Persuasive</b>! <i>The Virgin Birth of Christ</i> by J. Gresham Machen is one of the <b>best objective sources</b> for the Virgin Birth account. Systematically studying the four gospels, Machen’s work remains the most <b>methodical</b> and <b>erudite</b> treatment of this most <b>widely discussed</b> and <b>hotly disputed</b> subject of over a century. <b>Priceless</b> as an apologetic, it is also <b>invaluable</b> as a treasury of knowledge. <b>Exhaustive</b>, simple and lucid, Machen’s <b>splendid book</b> is highly reputed for its acumen, relevance, and stringent defense of orthodox Protestantism. A <b>must-have reference</b> for apologetics!</p><p align="center"><i><b>"Perfect!"</b> —  Brian T. Murphy</i></p><p align="center"><i><b>"Wonderfully written!"</b> — John A. Tanner</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Miracles_of_Our_Lord.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Miracles of Our Lord <br><i>George MacDonald</i></span>




                    <br>
                    <p><b>Elegant and poetic</b>! In <i>Miracles of Our Lord </i>George MacDonald’s acumen is evident as he addresses the debate on science and religion, and Human arguments versus Miracles. Easing the strain between them, MacDonald claims the <b>true nature</b> of the miracles, are an <b>epitome of God’s processes</b> in nature perceived in immediate connection with their source, still invisible to human eyes and hearts! Christ’s <b>physical miracles</b> always demonstrated a <b>moral miracle</b>, the forgiveness of sins! God is perfecting us preparing us to become one with Him, and love as He does!</p><p align="center"><i><b>"Worth reading!"</b> — Matthew</i></p><p align="center"><i><b>"Excellent and inspiring!"</b> — Unclepeacock</i></p><p align="center"><i><b>"Sums up what I believe to be the nature of God!"</b> — Renee Wolcott </i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Spirit_of_Christmas.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Spirit of Christmas<br><i>Andrew Murray </i></span>




                    <br>
                    <p>Intensely passionate, Andrew Murray’s <i>The Spirit of Christ</i> contains 31 condensed inspiring and practical devotional studies on how the Holy Spirit works in a believer’s life. Understand, with ease, the Biblical differences between flesh and spirit, the practical truth of being filled with the Spirit, the relationship between the conscience and the Holy Spirit and the Spirit’s ministry in the church. Delve deeper in faith to ascertain the reality of who the Spirit of Christ really is. Grow in spiritual maturity. Awesome!.</p><p align="center"><i><b>"Spiritual Enlightenment!"</b> — Michael Blackburn</i></p><p align="center"><i><b>"Great, down to earth, practical guide about the Spirit!"</b> — M. Young</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Messiah_in_Moses_and_the_Prophets.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Messiah in Moses and the Prophets <br><i>Eleazar Lord</i></span>




                    <br>
                    <p><b>Eye-opener</b>! Eleazar Lord in <i>The Messiah in Moses and the Prophets </i>pries open the less discussed subject of the visible appearances and the <b>doctrine of the incarnation</b> occurring both in the Hebrew and Christian Scriptures. God became incarnate and walked this earth as Jesus, the Christ, and is also Jehovah, Immanuel, God with us. Under <b>various designations</b>, He appeared visibly as man to the early Patriarchs, Moses and others. The author also explains such a translation occurred, as the early translations were done using the "pointed" Hebrew texts. <b>Highly informative</b>!</p><p align="center"><i><b>"Still worth reading for the content and concepts!"</b> — D. Blankenship</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Christmas_Its_Origin_and_Associations.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Christmas: Its Origin and Associations<br><i>William Francis Dawson</i></span>




                    <br>
                    <p><b>Charming legendary lore</b>! <i>Christmas: Its Origin and Associations</i> by William Francis Dawson Christmas contains a <b>classic collection</b> of renowned <b>Christmas tales</b> admired across the world.  Meticulously recording successive celebrations of Christmas <b>over last the nineteen centuries</b> Dawson highlights them as significant links in the chain of historical Christian evidences. Of <b>historic and pictorial interest</b>, he also includes picturesque customs and popular games. Kingsley’s work could be considered a chronological account of the Christmas celebrations and observances from Christ’s birth to the end of the nineteenth century, throughout the civilized countries!</p><p align="center"><i><b>"An informative, helpful guide!"</b> — Jing Causon</i></p><p align="center"><i><b>"An ‘older’ yet very informative survey of Christmas lore!"</b> — Steven H. Propp</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_At_Last_A_Christmas_in_the_West_Indies.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">At Last: A Christmas in the West Indies <br><i>Charles Kingsley</i></span>




                    <br>
                    <p><b>Excellent portrait</b> of an era gone by! <i>At Last: A Christmas in the West Indies </i>by Charles Kingsley brings to life locales in the Trinidad and West Indies of the late 1800s. Enjoy reading man’s interventions and impacts on the natural landscape from this ‘imperial’ outlook on the colony. More like an old Victorian travel narrative, Kingsley provides <b>an illuminating and rich description</b> of the British view of the people and lands, in the context of post-emancipation labor shortages and the life of the blacks in slavery! <b>Poignant pictures</b>! </p><p align="center"><i><b>"A well written book!"</b> — Mala Hall</i></p><p align="center"><i><b>"Vivid and entertaining!"</b> — Dan Brown</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_On_the_Incarnation_of_the_Word.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">On the Incarnation of the Word<br><i>St. Athanasius</i></span>




                    <br>
                    <p>With <b>consummate ease and efficacy</b>, St. Athanasius in <i>On the Incarnation of the Word</i>, presents fundamental, rational arguments for the <b>necessity, aptness and value of the Incarnation</b>! Strongly grounded in historical context, it still retains its <b>theological and intellectual luster</b>! A great definitive statement of orthodox Trinitarianism, his <b>mystical prose</b>, portraying Christ’s dual nature of being wholly God and yet limiting Himself in His humanity, irresistibly draws you closer to Him! Using logical, reasoned proof to <b>demolish heresies</b>, St. Athanasius reveals the continuing relevance of Christ! <b>Awesome</b>!</p><p align="center"><i><b>"A masterpiece!"</b> — C. S. Lewis </i></p><p align="center"><i><b>"Epic and foundational!"</b> —Alex  </i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Spirit_of_Christmas1.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Spirit of Christmas<br><i>Henry Van Dyke</i></span>




                    <br>
                    <p><b>Memorable</b>! Henry Van Dyke’s <i>The Spirit of Christmas </i>includes <b>simple, short stories</b> with profound insights on compassion, consistently reminding us of the <b>source of all blessings</b> and the eternal promise of the hope of <b>reaping the rewards</b> of a life lived with love, gratitude and appreciation for the Creator. Peppered with <b>lovely poetry</b>, this thoughtful collection of sermons, reflections, prayers and dreams revives old memories of good will and good cheer, the essence of the <b>spirit of Christmas</b>! Subtly questioning the skewed values of the current concepts of Christmas! <b>Inspiring</b>! </p><p align="center"><i><b>"Great Read!"</b> — mike walworth</i></p><p align="center"><i><b>"Makes me want to be a better person!"</b> — mary</i></p><p align="center"><i><b>"Charming, beautifully written and recommended to all!"</b> — Linda K</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Life_of_Christ.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Life of Christ<br><i>J. Gresham Machen</i></span>




                    <br>
                    <p><b>Thoroughly engaging</b>! J. Gresham Machen, the last of the Great Princeton Theologians, reveals <i>The Life of Christ</i> couched in his <b>compelling prose</b>. Relentless and clear, his voice resounds from nearly a century ago, <b>comprehensively answering essential questions</b>. From the historic scenario of Roman governance prepared to usher in Christ’s birth, Machen paints Christ’s family background, His baptism, ministries and growing popularity, ending with Christ’s own prediction of the cross. Calvary did not overtake Christ unawares. Christ went deliberately to His death that sinful man may <b>escape eternal death</b>. <b>Beautiful</b>!</p><p align="center"><i><b>"A delightful read!"</b> — Rudolph P. Boshoff</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_All_Saints_Day_and_Other_Sermons.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">All Saints Day and Other Sermons <br><i>Charles Kingsley</i></span>




                    <br>
                    <p><b>Very appealing! </b>Kingsley, in<i> All Saints Day and Other Sermons </i>offers a mellifluous combination of <b>Biblical doctrine</b> and the <b>Church Seasons</b> sprinkled with practical subjects <b>applicable even today</b>. While explaining the Biblical basis for All Saints’ Day and the preparation required for Advent, he emphasizes the <b>purifying hope</b> and joy set before us in Christ. Including some insights on the Lord’s parables, lessons from the reformation and teachings of national import and the troubles of a distracted mind, his last and fortieth sermon culminates in the <b>Lesson of Life</b>! <b>Great</b>!</p><p align="center"><i><b>"Interesting!"</b>— love it! </i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Sermons_of_John_Newton.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Sermons of John Newton<br><i>John Newton</i></span>




                    <br>
                    <p><b>Stirring</b>! <i>Sermons of John Newton </i>a collection of sermons by John Newton is a treasure-store of <b>scriptural insight</b>. Dramatically saved from virtual destruction of body and soul, Newton’s <b>spiritual zeal</b> blended with benevolence and humility are truly beyond belief. Well-known as an evangelical minister, and better known for his amazing hymns, his work continues to speak right into the hearts of the readers as it did to his listeners during his lifetime. <b>Explore the legacy</b> of these 18th-century sermons and appreciate afresh <b>God’s great redemptive work</b>! </p><p align="center"><i><b>"A memorable and powerful portrait!"</b> — R. Kent Hughes</i></p><p align="center"><i><b>"Few write with more simplicity, piety, and force!"</b> — Charles Spurgeon</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Meditations_on_the_Bible.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Meditations on the Bible <br><i>J.R. Miller</i></span>




                    <br>
                    <p><b>Well-seasoned and comforting</b>, <i>Devotional Hours with the Bible Vol. 3 </i>by J.R. Miller <b>flows on</b> delightful and smooth, with <b>quiet but fresh inspiration</b> and <b>joyful optimism</b>! Draw practical lessons to tackle the daily grind of the common life. Neither exegetical nor expository, Miller simply discusses certain principal and representative portions of the Bible!  Although the Bible is an ancient book, it is <b>very relevant</b> today bringing us face to face with God, and guiding us through each new day. <b>Receive impulses</b> each day for improving conduct, duty, service and devotion. <i></i></p><p align="center"><i><i><b>"His insights are spiritual diamonds!"</b> — Pastor Bill Shishko</i></i></p><i>
                </i></td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Christian_Love.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Christian Love<br><i>John Angell James </i></span>




                    <br>
                    <p><b>Incisive and indelible</b>, John Angell James’ exhortation on I Cor. 13 in <i>Christian, Love, or the Influence of Religion upon Temper</i> is <b>unforgettable</b>. A prolific writer, he underlines <b>Self-Examination</b> as every Christian’s duty, not only to ascertain the <b>genuineness of his faith</b> but more to check if it is ‘operative’.  His timely warning is against self-love and the deceitfulness of our hearts which invariably hides our sinful infirmities from view lulling us into a state of false peace! <b>Memorable</b>!</p><p align="center"><i><b>"Stays with you!"</b> — A Reviewer</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Gospel_of_God.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Gospel of God<br><i>Charles Kingsley</i></span>




                    <br>
                    <p><b>Glorious truth</b>! <i>The Good News of God </i>by Charles Kingsley opens up the ways God deals with people with a beatific vision, <b>the glory of the cross</b>! Discussing the life of God, the love of God as being its own reward, self-respect and self-righteousness and the the measure of the cross, Kingsley enables you to <b>plumb the great depths</b> and <b>drink deeply</b> of these fundament al truths. The good news of salvation through belief in Christ alone is the <b>unbroken thread</b> running through these wonderful <b>thirty-nine chapters! Enjoyable</b>!</p><p align="center"><i><b>"Good Book!"</b> — Doug</i></p><p align="center"><i><b>"Wow! This guy gets it!"</b> — Cavefalls</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Westminster_Sermons.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Westminster Sermons <br><i>Charles Kingsley</i></span>




                    <br>
                    <p><b>Interesting</b>! <i>Westminster Sermons </i>by Charles Kingsley includes <b>27 intriguing subjects</b>, exploring the mystery of the cross, perfect love, prayer, miracles and others. With a sympathetic leaning towards the concept of evolution Kingsley tries to reconcile the teachings of Scripture which categorically state that God created everything. Claiming that the Bible does not clearly define creation, either its means or it manner of operation, he believes that organized beings were produced, each according to their kind but with intermediate variations.  <b>Of historic value</b>!</p><p align="center"><i><b>"Remarkable!"</b> — A Reviewer</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_Bible_and_Life.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The Bible and Life <br><i>Edwin Holt Hughes</i></span>




                    <br>
                    <p><b>Refreshing</b>! Edwin Holt Hughes in <i>The Bible and Life </i>reveals <b>man in relation to himself</b>, his <b>home</b>, <b>education</b>, <b>work</b>, <b>wealth</b>, <b>pleasure</b> and <b>sorrow</b> as well as the way the <b>Bible influences</b> them. Undeniably, the <b>Bible is a book of power</b>, despite its diminutive size, long existence, narrow geography and remarkable oriental flavor! The Bible retains its <b>supremacy</b> because it appeals to life which implies it must have been born of Life itself. <b>Developed from, tested by and climaxing in Life,</b> who is Christ Himself, the Bible emanates <b>transforming power</b>! </p><p align="center"><i><b>"Easy-to-read with practical applications!"</b> — A reviewer</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_The_All_Sufficiency_of_Christ.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">The All Sufficiency of Christ<br><i>C.H. Mackintosh</i></span>




                    <br>
                    <p><b>Irresistibly heartwarming</b>! <i>The All Sufficiency of Christ </i>by C.H. Mackintosh presses home the point that a believer in Christ needs <b>only Christ</b>! Mackintosh argues for the <b>highest Christology</b> possible reiterating that because Christ is all-sufficient, the traditions of men, religion or higher criticism have no stranglehold on anyone. Only Christ, as the scriptures reveal, the <b>Sinless One</b> who became Sin for man, dealt with it so thoroughly that the sinner who trusts in Him is totally free. <b>Revel in the freedom</b> that His finished work on the cross offers. <b>Astounding</b>!</p><p align="center"><i><b>"Beautiful book!"</b> — Christopher</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="9" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="104" valign="top">


                    <img src="/pictures/bk_CSGU_Men_Called_Him_Master.jpg" hspace="5">



                </td>
                <td width="384" valign="top" class="proddescr">
                    <span class="prodtitle">Men Called Him Master <br><i>Elwyn Allen Smith</i></span>




                    <br>
                    <p>A <b>memorable trek</b> backwards in time, Smith in <i>Men called Him Master</i> brilliantly recreates the period, times and geography besides the history and the social milieu prevalent during Christ’s lifetime! Portraying <b>Christ’s humanity</b>, Smith’s bracing, Biblical account of Christ and His dialogues with His disciples highlight their human frailties and His spotless humanity and divinity! <b>Thought provoking</b> and <b>reverent</b>, backed by Scripture references for each event, Smith’s scholarship and interpretation are <b>impeccable</b>! Appreciate the cost entailed to dare follow Christ then, and what it means to do the same today!</p><p align="center"><i><b>"A once-in-a-lifetime masterpiece!"</b> — Stephen M. Zielinski</i></p>
                </td>
            </tr>


            <tr>
                <td width="488" valign="top" height="21" colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td width="488" valign="top" height="21" colspan="2">&nbsp;
                </td>
            </tr>
            <tr>
                <td width="488" valign="top" height="1" colspan="2">

                    <!-- THIS IS COMMENTED OUT BECAUSE IT WOULD NOT LIST THE RIGHT VOLUMES ON BARNES (LISTS AS 1 INSTEAD OF 11) AND ALSO WOULD NOT LIST THE DISCOUNTED SALE PRICE JUST THE NORMAL PRICE (SO WHEN ON SALE IT WOULD SAY THE SALE DISCOUNTED PRICE ABOVE, BUT THE NORMAL PRICE HERE)

       -->
                    <!--added by sam -->


                    <p align="center">
                        <a href="/cart/viewcartmodify.asp?library=259">
                            <img border="0" src="../img/addtocart.jpg" alt="Add to cart" width="128" height="13"></a>&nbsp;&nbsp;&nbsp;&nbsp;
                        <a href="/cart"><img border="0" src="../img/btn_viewcart.gif" alt="View cart" width="81" height="14"></a>&nbsp;&nbsp;&nbsp;
                        <a href="/myaccount/lookup"><img border="0" src="../img/btn_checkout.gif" alt="Checkout" width="81" height="14"></a>

                    </p></td>
            </tr>
            <tr>
                <td width="488" valign="top" height="21" colspan="2">&nbsp;
                </td>
            </tr>
            <tr>
                <td width="488" valign="top" height="6" colspan="2">
                    <p align="center"><b>
                        <a href="#top"><img border="0" src="/img/top.gif"></a></b>
                        <a href="#top" style="COLOR: #000000 ; TEXT-DECORATION: none"><font size="2">
                            <b>Top</b></font></a>&nbsp;</p></td>
            </tr>
            </tbody></table>

        <br/>
    </div>
</div>


</body>
</HTML>
