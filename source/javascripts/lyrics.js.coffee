window.Lyrics =
  chordRegexp: ///
    (\[)      # first bracket
    ([\w|#]*) # chord
    (\])      # closing bracket
    ///g

  render: (text) ->
    if text
      @withChords(
        (for block in @blocksIn(text)
          @wrapBlock @blockWithLineBreaks(block)).join "")
    else ""

  wrapBlock: (block) ->
    if block.match(@chordRegexp)
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

  withChords: (block) ->
    block.replace @chordRegexp, "<span class='lyric__chord'>$2</span>"


$ ->
  $(".js-lyric").each ->
    $el = $ this
    $el.html Lyrics.render $el.text()
