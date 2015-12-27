describe "Render lyric", ->
  it "starts with nothing", ->
    html = render()
    expect(html).toEqual ""

  it "build a paragraph", ->
    html = render("a")
    expect(html).toEqual "<p>a</p>"

  it "builds lines", ->
    html = render("a\nb")
    expect(html).toEqual "<p>a<br/>b</p>"

  it "builds several paragraphs", ->
    html = render("a\n\nb")
    expect(html).toEqual "<p>a</p><p>b</p>"

  it "builds a lot of paragraphs", ->
    html = render("a\n\nb\n\nc\n\nd")
    expect(html).toEqual "<p>a</p><p>b</p><p>c</p><p>d</p>"

  it "detects chords in brackets", ->
    html = render("[C]La cucaracha")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>C</span>La cucaracha</p>"

  it "detects several chords in brackets", ->
    html = render("[C#]La cucaracha [Db]La cucaracha")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>C#</span>La cucaracha <span class='lyric__chord'>Db</span>La cucaracha</p>"

  it "detects several chords in several blocks", ->
    html = render("[G#]La cucaracha\n\n[F#]Había un sapo")
    expect(html).toEqual "<p class='lyric__block--with-chords'><span class='lyric__chord'>G#</span>La cucaracha</p><p class='lyric__block--with-chords'><span class='lyric__chord'>F#</span>Había un sapo</p>"

  it "hide chords", ->
    html = render("[G#]La cucaracha\n\n[F#]Había un sapo", chords: false)
    expect(html).toEqual "<p>La cucaracha</p><p>Había un sapo</p>"

  render = (text, opts) ->
    Lyrics.render(text, opts)
