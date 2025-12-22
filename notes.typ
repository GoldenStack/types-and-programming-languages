#import "@preview/problemst:0.1.2": pset

#show: pset.with(
  class: "Types and Programming Languages",
  student: "goldenstack",
  title: "Notes",
  date: datetime.today(),
)

#outline()

#pagebreak()

// Custom heading
#set heading(numbering: "1.1.")

// Justify all "normal" text
#set par(justify: true)
#show align.where(alignment: center + top): set par(justify: false)

// Code formatting (currently just font)
#show raw: set text(font: "Cascadia Code")
// #show raw.where(block: false): set text(size: 1.1em)

// Make links fancy
#show link: it => underline(
  offset: 2pt,
  stroke: 1pt,
  text(fill: blue, weight: "medium", it),
)

#pagebreak()

#set heading(numbering: none)

= Select References

References from _Types and Programming Languages_ that seem interesting on an initial look.

- _Essentials of Programming Languages_ by Friedman, Wand, and Haynes (2001)
- _Programming Language Pragmatics_ by Scott (1999)
