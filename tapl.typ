#let apply-formatting(it) = {  
  // Custom heading
  set heading(numbering: "1.1.")

  // Justify all "normal" text
  set par(justify: true)
  show align.where(alignment: center + top): set par(justify: false)

  // Code formatting (currently just font)
  show raw: set text(font: "Cascadia Code")

  // Make links fancy
  show link: it => underline(
    offset: 2pt,
    stroke: 1pt,
    text(fill: blue, weight: "medium", it),
  )

  it
}

// Shorthand for program results
#let program(term, result) = context grid(
  columns: (auto, auto),
  inset: 1pt,
  row-gutter: 0.8em,
  column-gutter: 0.4em,
  
  [], term,
  v(-0.25 * measure(sym.triangle.r.filled).height) + sym.triangle.r.filled, result,
)

#let b(c) = {
  set text(font: "Cascadia Code", size: 0.8em)
  show math.equation: set text(size: 1.2em)
  
  box(fill: luma(200), outset: (
    top: 2pt,
    bottom: 3pt,
  ), inset: (
    top: 1pt,
    bottom: 0pt,
    left: 2pt,
    right: 2pt,
  ), c)
}

// Operational semantics
#let brick(c) = {
  set text(font: "Cascadia Code", size: 0.8em)
  show math.equation: set text(size: 1.2em)
  
  box(fill: luma(200), outset: (
    top: 2pt,
    bottom: 3pt,
  ), inset: (
    top: 1pt,
    bottom: 0pt,
    left: 2pt,
    right: 2pt,
  ), c)
}

#let syntax(..args) = ("syntax", args.named())

#let evaluation(rule, name) = ("evaluation", (rule: rule, name: name))

#let semantics(top-left: none, top-right: none, step-name: none, ..args) = {
  let args = args.pos()

  let syntax-cells = ()
  let evaluation-cells = ()

  for (type, arg) in args {
    if type == "syntax" {
      syntax-cells += ( 
        [#brick(arg.name) ::=], [], emph(arg.desc),
        ..arg.rules.pairs().map(((k, v)) => (
          [], brick(k), emph(v)
        )).flatten(),
        [], [], []
      )
    } else if type == "evaluation" {
      evaluation-cells += (
        brick(arg.rule),
        smallcaps[(#arg.name)]
      )
    }
  }
  
  let syntaxes = [
    _Syntax_

    #grid(
      columns: (auto, 1fr, auto),
      align: (left + horizon, left + horizon, right + horizon),
      gutter: 6pt,

      ..syntax-cells 
    )
  ]
  
  let evaluation = [
    _Evaluation_ #h(1fr) #box(
      stroke: 0.5pt + black,
      outset: 4pt,
      step-name
    )

    #grid(
      columns: (1fr, auto),
      align: (center + horizon, right + horizon),
      gutter: 6pt,

      ..evaluation-cells
    )
  ]

  grid(
  inset: (
    top: 0.2em,
    bottom: 0.2em,
    left: 0.5em,
    right: 0.5em,
  ),
  columns: (1fr, 1fr),
  row-gutter: 4pt,

  grid.cell(align: left, top-left),
  grid.cell(align: right, top-right),

  // Header
  grid.cell(
    colspan: 2,
    stroke: (
      top: 1pt + luma(100),
      left: 1pt + luma(100),
      right: 1pt + luma(100),
    ),
  )[],

  syntaxes,

  grid.vline(
    stroke: 0.5pt + luma(0),
    start: 1,
  ),
  
  evaluation,

  // Footer
  grid.cell(
    colspan: 2,
    stroke: (
      bottom: 1pt + luma(100),
      left: 1pt + luma(100),
      right: 1pt + luma(100),
    ),
  )[],
)

}
