(function() {
  window.Lyrics = {
    renderHtml: function(text, opts) {
      if (text == null) {
        text = "";
      }
      if (opts == null) {
        opts = {
          chords: true
        };
      }
      if (!text) {
        return "";
      }
      return this.renderChords(this.renderBlocks(text, opts), opts);
    },
    hasChords: function(text) {
      if (text == null) {
        text = "";
      }
      return !!(text.match(this.chordRegexp));
    },
    renderBlocks: function(text, opts) {
      var block;
      return ((function() {
        var i, len, ref, results;
        ref = this.blocksIn(text);
        results = [];
        for (i = 0, len = ref.length; i < len; i++) {
          block = ref[i];
          results.push(this.wrapBlock(this.blockWithLineBreaks(block), opts));
        }
        return results;
      }).call(this)).join("");
    },
    chordRegexp: /(\[)([\w|#]*)(\])/g,
    wrapBlock: function(block, opts) {
      if (opts.chords && block.match(this.chordRegexp)) {
        return "<p class='lyric__block--with-chords'>" + block + "</p>";
      } else {
        return "<p>" + block + "</p>";
      }
    },
    blocksIn: function(text) {
      return text.split("\n\n");
    },
    blockWithLineBreaks: function(block) {
      var index, line, lines;
      return ((function() {
        var i, len, ref, results;
        ref = lines = block.split("\n");
        results = [];
        for (index = i = 0, len = ref.length; i < len; index = ++i) {
          line = ref[index];
          results.push(this.addBreak(line, index, lines.length));
        }
        return results;
      }).call(this)).join("");
    },
    addBreak: function(line, index, linesCount) {
      if (index + 1 === linesCount) {
        return line;
      } else {
        return line + "<br/>";
      }
    },
    renderChords: function(block, opts) {
      var replacer;
      replacer = opts.chords ? this.replaceChord : "";
      return block.replace(this.chordRegexp, replacer);
    },
    replaceChord: function(match, _openBracket, chord, _closingBracked, offset, _string) {
      return "<span class='lyric__chord'>" + chord + "</span>";
    }
  };

  window.App = {
    init: function($el, $controls, source) {
      this.$el = $el;
      this.$controls = $controls;
      this.source = source != null ? source : this.$el.text();
    },
    render: function(opts) {
      this.$el.html(Lyrics.renderHtml(this.source, opts));
      if (Lyrics.hasChords(this.source)) {
        this.$controls.removeClass("is-hidden");
        if (opts.chords) {
          this.showControl("hide-chords");
          return this.hideControl("show-chords");
        } else {
          this.showControl("show-chords");
          return this.hideControl("hide-chords");
        }
      }
    },
    showControl: function(control) {
      return this.$controls.find("[data-action='" + control + "']").removeClass("is-hidden");
    },
    hideControl: function(control) {
      return this.$controls.find("[data-action='" + control + "']").addClass("is-hidden");
    },
    onAction: function(name, fun) {
      return $(document).on("click", ".js-lyric-controls [data-action='" + name + "']", fun);
    }
  };

  App.onAction("show-chords", function() {
    return App.render({
      chords: true
    });
  });

  App.onAction("hide-chords", function() {
    return App.render({
      chords: false
    });
  });

  $(function() {
    return $(".js-lyric").each(function() {
      App.init($(this), $(".js-lyric-controls"));
      return App.render({
        chords: false
      });
    });
  });

}).call(this);
