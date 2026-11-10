
#set page(
  paper: "a4",
  margin: (left: 2.4cm, right: 2.4cm, top: 0.4cm, bottom: 2.3cm),
  numbering: none,
)
#set text(lang: "de", size: 12pt)
#set par(first-line-indent: 0pt)

#align(center)[
  #set text(font: "Arial Black", size: 1.8em,)
  commscube
  #box(move(dx: 0pt, dy: 22pt ,image("logo.svg", width: 21%)))
  
  #text(size: 11pt, style: "italic")[NotKubi, Tessa, bananacube]
]

#set heading(numbering: "1.1", )
#show heading: it => {
  set align(center)
  set block(above: 4em, below: 1em)
  it
}

#title([Sprint 1 Ablaufplan])

hihi