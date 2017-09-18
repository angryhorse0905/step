var SidebarView = Backbone.View.extend({
    initialize: function () {
        //hide the help
        step.util.showOrHideTutorial(true);

        _.bindAll(this);

        //create tab container
        var container = this.$el.find(">div");
        this.sidebarButton = $(".navbar-brand .showStats");
        this.sidebarButtonIcon = this.sidebarButton.find(".glyphicon");
        this.tabContainer = this._createBaseTabs();
        this.tabHeaders = this._createTabHeadersContainer();
        this.$el.append(this.tabHeaders);
        this.$el.append(this.tabContainer);

        this.$el.on("show.bs.tab", this.changeMode);
        this.listenTo(this.model, "change", this.activate);
        this.listenTo(this.model, "toggleOpen", this.toggleOpen);
        this.listenTo(this.model, "forceOpen", this.openSidebar);

        this.createXReference();
        this.createHelp();
        this.createCopy();
        this.activate();
        this.$el.find('a[data-toggle="tab"]').on("shown.bs.tab", this._notifyTabPanes);
    },
    _notifyTabPanes: function(ev) {
        ev.stopPropagation();
        this.$el.find(".tab-pane").trigger("tab-change", { newTab: ev.target });
    },
    changeMode: function (e) {
        var mode = null;
        var targetTab = $(e.target);
        var data = targetTab.data("target");
        if (data == '#lexicon') {
            mode = 'lexicon';
        } else if (data == '#analysis') {
            mode = 'analysis';
        } else if (data == '#history') {
            mode = 'history';
        } else if (data == '#help') {
            mode = 'help';
        }

        this.model.save({
            mode: mode
        });
    },
    createHelp: function () {
        var examplesContainer = $(".examplesContainer");
        examplesContainer.attr("id", "help").addClass("tab-pane");
        $(".tab-content").append(examplesContainer);

        if ($("#help").html().length == 0) {
            $("#help").html("<div style='padding:4px;'><h6>Help Guide coming soon</h6></div>");
        }

    },
    activate: function () {
        var self = this;
        //make sidebar visible
        this.openSidebar();

        //show the correct tab
        this.$el.find("[data-target='#" + this.model.get("mode") + "']").tab("show");

        if (this.model.get("mode") == 'xreference') {
            self.createXReference();
        } else if (this.model.get("mode") == 'lexicon') {
            //load content
            var requestTime = new Date().getTime();
            $.getSafe(MODULE_GET_INFO, [this.model.get("version"), this.model.get("ref"), this.model.get("strong"), this.model.get("morph")], function (data) {
                step.util.trackAnalyticsTime("lexicon", "loaded", new Date().getTime() - requestTime);
                step.util.trackAnalytics("lexicon", "strong", self.model.get("strong"));
                self.createDefinition(data);
            });
        } else if (this.model.get("mode") == 'analysis') {
            self.createAnalysis();
        } else if (this.model.get("mode") == 'history') {
            self.createHistory();
        } else if (this.model.get("mode") == 'help') {
            self.createHelp();
        } else if (this.model.get("mode") == 'copy') {
            self.createCopy();
        } else {
            self.createHelp();
        }
    },
    _createBaseTabs: function () {
        var tabContent = $("<div class='tab-content'></div>");

        this.xreference = $("<div id='xreference' class='tab-pane'></div>");
        this.lexicon = $("<div id='lexicon' class='tab-pane'></div>");
        this.analysis = $("<div id='analysis' class='tab-pane'></div>");
        this.history = $("<div id='history' class='tab-pane'></div>");
        this.help = $("<div id='help' class='tab-pane'></div>");
        this.copy = $("<div id='copy' class='tab-pane'></div>");
        tabContent.append(this.xreference);
        tabContent.append(this.lexicon);
        tabContent.append(this.analysis);
        tabContent.append(this.history);
        tabContent.append(this.help);
        tabContent.append(this.copy);
        this.$el.append(tabContent);
        return tabContent;
    },
    createHistory: function () {
        if (!this.historyView) {
            this.historyView = new ViewHistory({
                el: this.history
            });
        } else {
            this.historyView.refresh();
        }
    },
    createXReference: function () {
        if ($("#xreference").html().length == 0) {
            $("#xreference").html("<div class=''>" + $('.notesPane').html() + "</div>");
        }
    },
    createCopy: function () {
        if ($("#copy").html().length == 0) {
            $("#copy").html("<div style='padding:4px;'><h6>Copy feature coming soon</h6></div>");
        }
    },
    createAnalysis: function () {
        if (!this.analysisView) {
            this.analysisView = new ViewLexiconWordle({
                el: this.analysis
            });
        } else {
            this.analysisView.refresh();
        }
    },
    createDefinition: function (data) {
        //get definition tab
        this.lexicon.detach();
        this.lexicon.empty();

        var alternativeEntries = $("<div id='vocabEntries'>");
        this.lexicon.append(alternativeEntries);
        this.lexicon.append($("<h1>").append(__s.lexicon_vocab));

        if (data.vocabInfos.length == 0) {
            return;
        }

        if (data.vocabInfos.length > 1) {
            //multiple entries
            var panelGroup = $('<div class="panel-group" id="collapsedLexicon"></div>');
            var openDef = _.min(data.vocabInfos, function (def) {
                return def.count;
            });
            for (var i = 0; i < data.vocabInfos.length; i++) {
                var item = data.vocabInfos[i];
                var hebrew = data.vocabInfos[i].strongNumber == 'H';
                var panelId = "lexicon-" + data.vocabInfos[i].strongNumber;
                var panelTitle = item.stepGloss + " (<span class='transliteration'>" + item.stepTransliteration + "</span> - " + '<span class="' + (hebrew ? 'hbFontSmall' : 'unicodeFont') + '">' + item.accentedUnicode + "</span>)";
                var panelContentContainer = $('<div class="panel-collapse collapse">').attr("id", panelId);
                var panelBody = $('<div class="panel-body"></div>');
                panelContentContainer.append(panelBody);

                if (openDef == data.vocabInfos[i]) {
                    panelContentContainer.addClass("in");
                }

                this._createBriefWordPanel(panelBody, item);
                if(i < data.morphInfos.length) {
                    this._createBriefMorphInfo(panelBody, data.morphInfos[i]);
                }
                this._createWordPanel(panelBody, item);
                if(i < data.morphInfos.length) {
                    this._createMorphInfo(panelBody, data.morphInfos[i]);
                }

                var panelHeading = '<div class="panel-heading"><h4 class="panel-title" data-toggle="collapse" data-parent="#collapsedLexicon" data-target="#' + panelId + '"><a>' +
                    panelTitle + '</a></h4></div>';

                var panel = $('<div class="panel panel-default"></div>').append(panelHeading).append(panelContentContainer);
                panelGroup.append(panel);
            }
            this.lexicon.append(panelGroup);

        } else {
            this._createBriefWordPanel(this.lexicon, data.vocabInfos[0]);
            if (data.morphInfos.length > 0) {
                this._createBriefMorphInfo(this.lexicon, data.morphInfos[0]);
            }
            this._createWordPanel(this.lexicon, data.vocabInfos[0]);
            if (data.morphInfos.length > 0) {
                this._createMorphInfo(this.lexicon, data.morphInfos[0]);
            }
        }
        this.tabContainer.append(this.lexicon);
    },
    _createBriefWordPanel: function (panel, mainWord) {
        panel.append(
            $("<div>").append($("<span>").addClass(mainWord.strongNumber[0] == 'H' ? "hbFontSmall" : "unicodeFont")
                .append(mainWord.accentedUnicode))
                .append(" (")
                .append("<span class='transliteration'>" + mainWord.stepTransliteration + "</span>")
                .append(") “")
                .append(mainWord.stepGloss)
                .append("” ")
                .append($(" <span title='" + __s.strong_number + "'>").append(" (" + mainWord.strongNumber + ")").addClass("strongNumberTagLine"))
        );
    },

        _createWordPanel: function (panel, mainWord) {
            panel.append(
                $("<div>").append(mainWord.shortDef || "")
            );

        panel.append("<br />")
            .append($("<a></a>").attr("href", "javascript:void(0)").data("strongNumber", mainWord.strongNumber).append(__s.lexicon_search_for_this_word).click(function () {
                var strongNumber = $(this).data("strongNumber");
                var args = "strong=" + encodeURIComponent(strongNumber);
                step.util.activePassage().save({ strongHighlights: strongNumber }, {silent: true});
                step.router.navigatePreserveVersions(args);
            }));
        if(mainWord.count) {
            panel.append('<span class="strongCount"> (' + sprintf(__s.stats_occurs, mainWord.count) + ')</span>').append('<br />');
        }

        // append the meanings
        if (mainWord.mediumDef) {
            panel.append($("<h2>").append(__s.lexicon_meaning));
            panel.append(mainWord.mediumDef);
        }

        //longer definitions
        if (mainWord.lsjDefs ) {
            panel.append($("<h2>").append(mainWord.strongNumber[0].toLowerCase() == 'g' ? __s.lexicon_lsj_definition : __s.lexicon_bdb_definition));
            panel.append(mainWord.lsjDefs);
        }

        if (mainWord.relatedNos) {
            panel.append($("<h2>").append(__s.lexicon_related_words));
            var ul = $('<ul>');
            var matchingExpression = "";
            for (var i = 0; i < mainWord.relatedNos.length; i++) {
                if(mainWord.relatedNos[i].strongNumber != mainWord.strongNumber) {
                    var li = $("<li></li>").append($('<a href="javascript:void(0)">')
                        .append(mainWord.relatedNos[i].gloss)
                        .append(" (")
                        .append("<span class='transliteration'>" + mainWord.relatedNos[i].stepTransliteration + "</span>")
                        .append(" - ")
                        .append(mainWord.relatedNos[i].matchingForm)
                        .append(")")
                        .data("strongNumber", mainWord.relatedNos[i].strongNumber));
                    ul.append(li);

                    matchingExpression += mainWord.relatedNos[i].strongNumber + " ";
                }
            }
                step.passage.highlightStrong(null, matchingExpression, "lexiconRelatedFocus");
            panel.append(ul);
            panel.find("a").click(function () {
                step.util.ui.showDef($(this).data("strongNumber"));
            });
        }
    },
    // for one-line morphology
    _createBriefMorphInfo: function (panel, info) {
        panel.append("( ");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_suffix, "suffix");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_function, "function");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_person, "person");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_gender, "gender");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_number, "number");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_case, "wordCase");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_tense, "tense");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_mood, "mood");
        this.renderBriefMorphItem(panel, info, __s.lexicon_grammar_voice, "voice");
        panel.append(")<br />");
    },
    renderBriefMorphItem: function (panel, info, title, param) {
        if(info && param && info[param]) {
            var value = $("<span>" + this.replaceEmphasis(info[param]) + "</span>");
            panel.append(value);
            panel.append(" ");
        }

    },
    _createMorphInfo: function (panel, info) {
        panel.append($("<h2>").append(__s.display_grammar));
        this.renderMorphItem(panel, info, "function");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_function, "function");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_person, "person");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_gender, "gender");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_number, "number");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_case, "wordCase");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_tense, "tense");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_mood, "mood");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_voice, "voice");
        this.renderMorphItem(panel, info, __s.lexicon_grammar_suffix, "suffix");
        panel.append("<br />");


        panel.append($("<h3>").append(__s.lexicon_ie)).append(this.replaceEmphasis(info["explanation"]));
        panel.append("<br />");
        panel.append($("<h3>").append(__s.lexicon_eg)).append(this.replaceEmphasis(info["description"]));
    },
    renderMorphItem: function (panel, info, title, param) {
        if(info && param && info[param]) {
            var value = $("<span>" + this.replaceEmphasis(info[param]) + "</span>");
            panel.append($("<h3>").append(title)).append(value);

            if(info[param + "Explained"] || param == 'wordCase' && info["caseExplained"]) {
                var explanation = info[param + "Explained"] || param == 'wordCase' && info["caseExplained"];
                value.attr("title", this.stripEmphasis(explanation));
            }
            panel.append("<br />");
        }
    },
    replaceEmphasis: function(str) {
        return (str || "").replace(/_([^_]*)_/g, "<em>$1</em>");
    },
    stripEmphasis: function(str) {
        return (str || "").replace(/_([^_]*)_/g, "");
    },
    _createTabHeadersContainer: function () {
        var template = '<ul class="nav nav-tabs">' +
            '<li class="active"><a href="javascript:void(0)" title="<%= __s.xreference %>" data-toggle="tab" data-target="#xreference"><b>R</b></a></li>' +
            '<li><a href="javascript:void(0)" class="" title="<%= __s.original_word %>" data-toggle="tab" data-target="#lexicon"><b>א</b></a></li>' +
            '<li><a href="javascript:void(0)" class="glyphicon glyphicon-stats" title="<%= __s.passage_stats %>" data-toggle="tab" data-target="#analysis"></li>' +
            '<li><a href="javascript:void(0)" class="glyphicon glyphicon-bookmark" title="<%= __s.bookmarks_and_recent_texts %>" data-toggle="tab" data-target="#history"></li>' +
            '<li><a href="javascript:void(0)" class="stepglyph-help" title="<%= __s.quick_tutorial %>" data-toggle="tab" data-target="#help"><b>?</b></li>' +
            '<li><a href="javascript:void(0)" class="stepglyph-help" title="<%= __s.quick_tutorial %>" data-toggle="tab" data-target="#copy"><b>C</b></li>' +
            '</ul>';

        var tabContainer = $(_.template(template)());

        //add close button
        tabContainer.append(
            $("<li class='closeSidebar'><a class='glyphicon glyphicon-remove' /></li>")
                .click(this.closeSidebar));

        return tabContainer;
    },
    toggleOpen: function () {
        if (!this.$el.closest('.row-offcanvas').hasClass("active")) {
            this.openSidebar();
        } else {
            this.closeSidebar();
        }
    },
    openSidebar: function () {
        this.sidebarButtonIcon.addClass("active");
        this.$el.closest('.row-offcanvas').addClass("active");
    },
    closeSidebar: function () {
        this.sidebarButtonIcon.removeClass("active");
        this.$el.closest('.row-offcanvas').removeClass('active');
    }
});
