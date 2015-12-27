(function() {
  window.Lyrics = {
    render: function(text, opts) {
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

  $(function() {
    return $(".js-lyric").each(function() {
      var $el;
      $el = $(this);
      return $el.html(Lyrics.render($el.text(), {
        chords: false
      }));
    });
  });

}).call(this);
