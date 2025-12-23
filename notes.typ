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

Type systems are typically used to _statically_ prove information about a program (see #link("https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence")[Curry-Howard Correspondence]). As with any system involving proofs, it is inherent to the system that some true statements cannot be proven. In the case of type systems, this is called being _conservative_ and is represented by the type system rejecting an nonzero number of programs that do _not_ display the "certain program behaviours".

The conservativity of a type system can generally be reduced by allowing more specific types, typically with a more general type system, so that certain structures and relationships can be represented more accurately. Likewise, a type system can only detect certain classes of errors; thes classes can only be expanded by allowing more generality in the type system. #footnote[Generality is not always the best term to describe this behaviour. For example, supporting the access of private data emitting an error requires arguably a more specific type system, to handle an invented feature.] As type systems grow to support more extended static checking methods, they approach being a proof checker.

== What Type Systems Are Good For

*Detecting errors*: A proof system running automatically on your code allows for many errors to be detected automatically, hastening correctness.
// Rich type checking can sometimes even catch the majority of issues that occur, resulting in a surprising level of correctness. Type checkers also help detect changing definitions, as type-level inconsistencies caused by a far-away change can be automatically enumerated.

*Abstraction*: Type systems can represent contracts that must be upheld, allowing more modularity by virtue of relying on contracts (types), not definitions.

*Documentation*: Types also act as a form of documentation in that they desribe an abstracted form of your code; importantly, your code and its types cannot become desynchronized.

*Safety*: Although safety is hard to define, a language is often considered 'safe' if it protects its own abstractions well with some sort of static or dynamic type safety. Several definitions of safety:
- Protecting its own abstractions (if the program is unsafe, it may violate its abstractions)
- Preventing untrapped errors at runtime (if the program is unsafe, errors may propagate)
- Completely defined by the manual (i.e. no undefined behaviour)
// pointer provenance, stack thread-exclusivity

// Around this point in the textbook, a table is provided, which provides values for every $(statically checked, dynamically checked) x (safe, unsafe)$. As follows:
// Safe, statically checked: ML, Haskell, Java
// Unsafe, staticaly checked: C, C++
// Safe, dynamically checked: Lisp, Scheme, Perl
// Unsafe, dynamically checked: none
// It is noted that the last entry is empty. Imagine a language that fulfills this. In fact, there are many, but they are usually considered abstract machines. Nonetheless, it would be funny.

*Efficiency*: Type checkers provide more compile-time guarantees, allowing for more optimizations, such as which instructions are used or which runtime checks can be omitted. #footnote[I do take issue with this statement. The point at which one has the most information about program functionality and tendencies is at runtime; thus, there is a higher performance ceiling when concerned with runtime checks (see #link("https://en.wikipedia.org/wiki/Itanium")[Itanium] as a prominent pro-runtime/pro-JIT example). Furthermore, a sufficiently intelligent compiler can hypothetically determine all information that a type-checker would be able to---it is simply much more difficult to write a compiler as such. In a way, efficiency _does_ apply here---just as compiler development efficiency instead of program runtime efficiency. I digress.]

Other uses:

*Security*: Unsafe languages can be leveraged in ways that harm security (see #link("https://www.microsoft.com/en-us/msrc/blog/2019/07/we-need-a-safer-systems-programming-language")[Microsoft on memory safety]). Type systems that prevent this can help increase the security of programs.

// Hear me out: theorem prover type system that tries to make proofs about your code as optimization. For example, the compiler's built-in theorem prover would try to prove "this address will always be in-bounds" given the logical statements that your program corresponds to. Sounds cool but also insane.

*Data storage*: Types are on a rise in database or data storage systems, with JSON schemas and `.xsd` files as just two examples. They help structure data, and have all the same benefits types do normally.

== Type Systems and Language Design

Type systems, like any other feature, should not be bolted on to an existing language. It is best when all features are designed hand-in-hand. This is exemplified for type systems specifically as they are often core features of a language, around which syntax, semantics, and functionality are defined.

Note that the importance of a type system to any particular language is unrelated to the two separate problems of:
- Having dynamic (Python, etc.) versus static typing (C, etc.).
- Having implicit (ML, etc.) versus explicit type annotations (Java, etc.).

#pagebreak()

#set heading(numbering: none)

= Select References

References from _Types and Programming Languages_ that seem interesting on an initial look.

- _Essentials of Programming Languages_ by Friedman, Wand, and Haynes (2001)
- _Programming Language Pragmatics_ by Scott (1999)
