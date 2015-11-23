describe "User writes lyric", ->
  it "starts with nothing", ->
    html = preview()
    expect(html).toEqual ""

  it "build a paragraph", ->
    html = preview("a")
    expect(html).toEqual "<p>a</p>"

  it "builds lines", ->
    html = preview("a\nb")
    expect(html).toEqual "<p>a<br/>b</p>"

  it "builds several paragraphs", ->
    html = preview("a\n\nb")
    expect(html).toEqual "<p>a</p><p>b</p>"

  it "builds a lot of paragraphs", ->
    html = preview("a\n\nb\n\nc\n\nd")
    expect(html).toEqual "<p>a</p><p>b</p><p>c</p><p>d</p>"

  it "detects chords in brackets", ->
    html = preview("[C]La cucaracha")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>C</span>La cucaracha</p>"

  it "detects several chords in brackets", ->
    html = preview("[C#]La cucaracha [Db]La cucaracha")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>C#</span>La cucaracha <span class='lyric__chord'>Db</span>La cucaracha</p>"

  it "detects several chords in several blocks", ->
    html = preview("[G#]La cucaracha\n\n[F#]Había un sapo")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>G#</span>La cucaracha</p><p class='lyric__block--with-chords'><span class='lyric__chord'>F#</span>Había un sapo</p>"

  preview = (text) ->
    Lyrics.render(text)
