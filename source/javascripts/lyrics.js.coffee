window.Lyrics =
  render: (text, opts = {chords: true}) ->
    return "" unless text
    @renderChords @renderBlocks(text, opts), opts

  renderBlocks: (text, opts) ->
    (for block in @blocksIn(text)
      @wrapBlock(@blockWithLineBreaks(block), opts)).join ""

  chordRegexp: ///
    (\[)      # first bracket
    ([\w|#]*) # chord
    (\])      # closing bracket
    ///g

  wrapBlock: (block, opts) ->
    if opts.chords and block.match(@chordRegexp)
      "<p class='lyric__block--with-chords'>#{block}</p>"
    else
      "<p>#{block}</p>"

  blocksIn: (text) ->
    text.split "\n\n"

  blockWithLineBreaks: (block) ->
    (for line, index in lines = block.split "\n"
      @addBreak(line, index, lines.length)).join ""

  addBreak: (line, index, linesCount) ->
    if index + 1 is linesCount then line else "#{line}<br/>"

  renderChords: (block, opts) ->
    replacer = if opts.chords then @replaceChord else ""
    block.replace @chordRegexp, replacer

  replaceChord: (match, _openBracket, chord, _closingBracked, offset, _string) ->
    "<span class='lyric__chord'>#{chord}</span>"

$ ->
  $(".js-lyric").each ->
    $el = $ this
    $el.html Lyrics.render $el.text(), chords: false
