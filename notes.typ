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

== Capsule History

In the early to mid 1950s, type systems were first used to distinguish between integer types and floating-point types. In the late 1950s and early 1960s, this was extended to include basic structured data (such as arrays of records) and higher order functions. Later, in the 1970s, these were expanded into richer concepts like abstract data types, modules, subtypes, and parametric polymorphism. Around this time, computer scientists began to draw parallels between these type systems and more formal mathematical logic.

The original textbook has an extended timeline. A few select choices #footnote("Many important advancements have been removed. This is a select choice based on personal views."):
- 1900s: #link("https://en.wikipedia.org/wiki/Principia_Mathematica")[Formalization of mathematics]
- 1930s: #link("https://en.wikipedia.org/wiki/Lambda_calculus")[Untyped lambda calculus]
- 1960s: #link("https://en.wikipedia.org/wiki/Curry%E2%80%93Howard_correspondence")[Curry-Howard Correspondence]
- 1970s: #link("https://en.wikipedia.org/wiki/Intuitionistic_type_theory")[Intuitionistic type theory], #link("https://en.wikipedia.org/wiki/ML_(programming_language)")[ML], and #link("https://en.wikipedia.org/wiki/Algebraic_data_type")[ADTs]
- 1980s: #link("https://en.wikipedia.org/wiki/Linear_logic")[Linear logic], the #link("https://en.wikipedia.org/wiki/Calculus_of_constructions")[calculus of constructions], #link("https://en.wikipedia.org/wiki/Dependent_type")[dependent types], and #link("https://en.wikipedia.org/wiki/Effect_system")[effect systems].
- 1990s: #link("https://en.wikipedia.org/wiki/Typed_assembly_language")[Typed assembly]

The textbook was produced in 2002 and thus has nothing past the 1990s.

== Related reading

- _Foundations for Programming Languages_ by Mitchell (1996)
- _Theories of Programming Languages_ by Reynolds (1998)
- _The Structure of Typed Programming Languages_ by Schimdt (1994)
- _Basic Simple Type Theory_ by Hindley (1997)
- _Basic Category Theory for Computer Scientists_ by Pierce (1991)
 - More category theory: Jacobs (1999), Asperti and Longo (1991), Crole (1994)
- _Proofs and Types_ by Girard, Lafont, and Taylor (1989)
- _Computation and Deduction_ by Pfenning (2001)
- _Type Theory and Functional Programming_ by Thompson (1991)
- _Constructive Foundations for Functional Languages_ by Turner (1991)

#pagebreak()

= Mathematical Preliminaries

Common notation and mathematical facts required for the textbook.

== Sets, Relations, and Functions

- We write exhaustive construction as ${a, b, c, ...}$, and the comprehension definition as ${x in S | ...}$.
- The cardinality (size) of a set $S$ is $|S|$. Its power set (the set of subsets of $S$) is $P(S)$. $|P(S)| = 2^(|S|)$
- The difference between two sets $S \\ T = {s in S | s in.not T}$.
- Cartesian product between two sets $S times T = {s in S, t in T | (s, t)}$
- The empty set (set of $0$ elements) is defined as $emptyset$. The set of natural numbers $NN = {0, 1, 2, ...}$
- $n$-place _relation_ on $(S_1, S_2, ..., S_n)$ is a set $R subset.eq S_1 times S_2 times ... times S_n$. We say any tuple $s in R$ is _related_ by $R$.
- When $n = 1$ (one-place relation), it is called a _predicate_ $P$ on $S$. We often represent $s in P$ as $P(s)$, i.e. $P(s) = s in P$.
- When $n = 2$ (two-place relation), it is called a _binary relation over_ $S$ and $T$. We often represent $(s, t) in R$ as $s" "T" "r$. When $S = U$ and $T = U$ for some $U$, we say $R$ is a binary relation over $U$.
- When $n >= 3$, mixfix syntax is often used for relations with a sequence of symbols that represents the relation, e.g. $Gamma tack s colon T$ for $(Gamma, s, T)$ is in the relation (explained later in the book).
- The domain of a relation $R$ on sets $S$ and $T$ is $"dom"(R) = {s in S | exists t (s" "R" "t)}$.\ The codomain is $"range"(R) = {t in S | exists s (s " "R" "t)}$.
- A relation $R$ over $S, T$ is called a _partial function_ from $S$ to $T$ if $ forall t_1, t_2 exists s in S ((s, t_1) in R and (s, t_2) in R -> t_1 = t_2) $
Alternatively, the contrapostive, which has its own meaning: $ forall (t_1, t_2) in S^2 exists s in S (t_1 eq.not t_2 --> (s, t_1) in.not R or (s, t_2) in.not R) $
- If $"dom"(R) = S$ for a partial function $R$, then $R$ is instead called a _total function_ (or just _function_).
- A partial function $R$ is said to be _defined_ on an argument $s in S$ if $s in "dom"(R)$ (often noted as $R(s) arrow.b$), and undefined if $s in.not "dom"(R)$ (or $R(s) arrow.t$).
- Note that "failure" is still defined, and is actually equivalent to being a function from $S$ to $T union {"fail"}$, where failure returns the $"fail"$ unit value. This is different from divergence, where there is no result at all (i.e. $f(x) arrow.t$).
- A predicate $P$ is said to be _preserved_ by a binary relation $R$ if $forall s, s' ((s, s') in R and P(s) -> P(s'))$.

== Ordered Sets

- A relation $R$ on $S$ is _reflexive_ if $forall s in S ((s, s) in R)$. $R$ is _symmetric_ if $forall s, t ((s, t) in R -> (t, s) in R)$. $R$ is _transitive_ if $forall s, t, u ((s, t) in R and (t, u) in R -> (s, u) in R)$. $R$ is _antisymmetric_ if $ forall s, t ((s, t) in R and (t, s) in R -> s = t) $ Alternatively, the contrapositive: $ forall s, t (s eq.not t -> ((s, t) in.not R or (t, s) in.not R)) $

- A reflexive and transitive relation $R$ over a set $S$ is called a _preorder_ on $S$, often defined with $a <= b$. A preorder that is also antisymmetric is called a _partial order_. A partial order is called a _total order_ if $forall s, t (s <= t xor t <= s)$. #footnote[I also suppose that a partial order $R$ is a total order if $|R| = (|S|(|S|+1))/2$]
- Let $<=$ be a partial order over $S$ and $s, t in S$. Then, $j in S$ is a _join_ (or _least upper bound_) if $s <= j and t <= j$ and $forall  (k in S) (s <= k and t <= k -> j <= k)$. Also, $m in S$ is a _meet_ (or _greatest lower bound_) if $m <= s and m <= t$ and $forall (n in S) (n <= s and n <= t -> n <= m)$. In a total order, these two definitions are represeted as $max(s, t)$ and $min(s, t)$, respectively.
- A reflexive, transitive, and symmetric relation $R$ on a set $S$ is called an _equivalence_ (or _equivalence relation_ on $S$). It can also be said that $R$ _partitions_ $S$.
- The _reflexive closure_ of a binary relation $R$ over $S$ is the smallest (i.e. minimizing $|R'|$) reflexive relation $R'$ such that $R subset.eq R'$. The _transitive closure_ of $R$ is the smallest (again, minimizing $|R'|$) transitive relation $R'$ such that $R subset.eq R'$, often written as $R^+$. The combination is often written $R^*$.
- *Exercise*. Show that $R union {(s, s) | s in S}$ is the reflexive closure of a binary relation $R$ over $S$.\ This is the case as, by definition, the reflexive closure $R'$ of $R$ fulfills ${(s, s) | s in S} subset.eq R$, so once we guarantee this condition is true by adding each of those elements, $R'$ is correctly produced. Removing any element would fail to guarantee it is the transitive closure, and duplicates are not an issue as we are dealing with sets.
- *Exercise*. Given a constructive definition of $R^+$ as the union of every element in the recurrence relation as$ R^+ = union.big_i R_i " over " cases(R_0 = R, R_n = R_(n-1) union ((s, u) | exists t ((s, t) in R and (t, u) in R)), delim: #none, gap: #0.5em) $show that $R^+$ is really the transitive closure of $R$.\ Since the definition of transitivity indicates a relation is not transitive if $ exists (s, t, u in S) ((s, t) in R and (t, u) in R and (s, u) in.not R) $ it is clear that term $R_n$ will ensure all pairs that could indicate the non-transitivity of $R^(n-1)$ are added to $R_n$. As this process is done infinitely, if $R$ is considered a directed graph over $S$, any two nodes with an $n$-length path between them must have a $1$-length path between them by at latest $R_n$, fulfilling the transitivity of $R^+$. #footnote[It seems one could make a more accurate estimate of $ceil(log_2(n))$ steps, but I am unwilling to attempt to prove this at the current moment. Also, I am aware this is far from a proof; I simply explain enough to convince myself.]
- Let $<=$ be a preorder over $S$. A _decreasing chain_ in $<=$ is a sequence $s_1, s_2, ..., s_n$ such that $forall i (s_(i_1) < s_i)$.\ In this case, $S$ is said to be _well-founded_ if there does not exist a decreasing chain of infinite length in $<=$, or sometimes simply that $S$ is well-founded (see the #link("https://en.wikipedia.org/wiki/Well-ordering_principle")[well-ordering_principle]).

== Sequences

- A _sequence_ is an ordered list of elements, separared by comments. Commas are used both as `cons` for adding a single element to either end of a sequence as well as `append` for concatenating sequences. For example, if $a = 1,2,3$ and $b = 4,5,6$, then $0,a = 0,1,2,3$; $a,0 = 1,2,3,0$; and $b,a = 4,5,6,1,2,3$. #footnote[This does also mean that, under these operators, you cannot construct sequences of sequences.]
- The sequence of numbers from $1$ to $n$ is written as $1..n$.
- The length of a sequence $a$ is $|a|$.
- The empty sequence is either $circle.filled.small$ or blank. 
- Two sequences are (mutually) _permutations_ of each other if they contain the same elements when discounting order.

#pagebreak()

#set heading(numbering: none)

= Select References

References from _Types and Programming Languages_ that seem interesting on an initial look.

- _Essentials of Programming Languages_ by Friedman, Wand, and Haynes (2001)
- _Programming Language Pragmatics_ by Scott (1999)
