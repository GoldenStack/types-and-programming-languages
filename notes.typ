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

= Introduction

== Types in Computer Science

Formal methods vary from powerful but cumbersome (Hoare logic, denotational semantics) to modest yet lightweight (type systems). The textbook focuses more on the latter variation, type systems. Type systems are generally either more practical or more abstract; once again, the textbook focuses on the more pragmatic aspect, practical type systems.

The definition of a 'type system' is rather hard to pin down. An example:

#align(center, box(
  width: 60%,
)[_A type system is a tractable syntactic method for proving the absence of certain program behaviors by classifying phrases according to the kinds of values they compute._])

Type systems are typically used to _statically_ prove information about a program (see: #link("https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence")[Curry-Howard Correspondence]). As with any system involving proofs, it is inherent to the system that some true statements cannot be proven. In the case of type systems, this is called being _conservative_ and is represented by the type system rejecting an nonzero number of programs that do _not_ display the "certain program behaviours".

The conservativity of a type system can generally be reduced by allowing more specific types, typically with a more general type system, so that certain structures and relationships can be represented more accurately. Likewise, a type system can only detect certain classes of errors; thes classes can only be expanded by allowing more generality in the type system. #footnote[Generality is not always the best term to describe this behaviour. For example, supporting the access of private data emitting an error requires arguably a more specific type system, to handle an invented feature.] As type systems grow to support more extended static checking methods, they approach being a proof checker.

#pagebreak()

#set heading(numbering: none)

= Select References

References from _Types and Programming Languages_ that seem interesting on an initial look.

- _Essentials of Programming Languages_ by Friedman, Wand, and Haynes (2001)
- _Programming Language Pragmatics_ by Scott (1999)
