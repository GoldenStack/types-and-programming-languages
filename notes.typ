#import "@preview/problemst:0.1.2": pset
#import "@preview/curryst:0.6.0": rule, prooftree, rule-set

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

// Shorthand for program results
#let program(term, result) = context grid(
  columns: (auto, auto),
  inset: 1pt,
  row-gutter: 0.8em,
  column-gutter: 0.4em,
  
  [], term,
  v(-0.25 * measure(sym.triangle.r.filled).height) + sym.triangle.r.filled, result,
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

== Induction

*Weak induction* (also known as _ordinary induction_):
- For a predicate $P subset.eq NN$, if $P(0)$ and $forall i (P(i) -> P(i+1))$, then $forall n (P(n))$.

*Strong induction* (also known as _complete induction_):
- For a predicate $P subset.eq NN$, if $forall i (forall j (j < i -> P(j)) -> P(i))$, then $forall n (P(n))$.

_Lexicographic order_: order on pairs of natural numbers such that $ (m, n) <= (m', n') <--> ((m < m') or (m = m' and n <= n')) $

*Lexicographic induction*:
- For a predicate $P subset.eq NN^2$, if $forall (m, n, m', n') (((m', n') <= (m, n) -> P(m', n')) -> P(m, n))$, then $forall (m, n) P(m, n)$.
- Lexicographic induction is the basis for _nested induction_ proofs.

_Structural induction_ will be introduced in the future.

== Background Reading

- Induction: Winskel (1993)
- Ordered sets: Davey and Priestley (1990)
- Basic set theory: Halmos (1987)

#pagebreak()

= Untyped Arithmetic Expressions

We start with basic program semantics which we can be more clear about. We consider a simple language over numbers and booleans, which is basic but necessary before addressing other fundamental concepts.

== Introduction

We consider a few basic operations: booleans, conditionals, $0$, predecessor/successor, and `iszero`.

// This almost worked well, but it was just a little too janky.
// $t ::= & && "terms:" \
// & #`true` && "constant true" \
// & #`false` && "constant false" \
// & #`if t then t else t` && "conditional" \
// & #`0` && "constant zero" \
// & #`succ t` && "successor" \
// & #`pred t` && "predecessor" \
// & #`iszero t` && "zero test" \
// & #h(15em) && $

#box(width: 50%, grid(
  columns: (auto, 1fr, auto),
  align: (left + horizon, left + horizon, right + horizon),
  gutter: 0.5em,
  $t ::= $, $$, emph[terms:],
  $$, `true`, emph[constant true],
  $$, `false`, emph[constant false],
  $$, `if t then t else t`, emph[conditional],
  $$, `0`, emph[constant zero],
  $$, `succ t`, emph[successor],
  $$, `pred t`, emph[predecessor],
  $$, `iszero t`, emph[zero test],
))

This resembles BNF from Aho, Sethi, and Ullman (1986). This syntax declares a set of _terms_, with $t$ ranging over terms (any $t$ in the grammar indicates that any term may be substituted in its place), and each line declaring a _form_ of valid term. The terms on the right are comments.

$t$,#footnote[$t$, nearby letters like $s$, $u$, $r$, and variants such as $t_1$ and $s'$ are also used as terms of the relevant object language.] here, is a _metavariable_--a "variable" as it is a placeholder for a term, and "meta" because it is a variable in the _metalanguage_ that is being used to describe the present _object language_. #footnote[Also, the term _metatheory_ refers to the collection of true statements about some logical system, so "metatheory of subtyping" refers to "the formal study of the properties of systems with subtyping".]

A _term_ is an expression representing some sort of computation, while an _expression_ is a general phrase, such as a term, type, or kind expression.

A _program_ is a term built from the forms given by a grammar. Notably, they all must be based around `true`, `false`, or `0`, as those are the only forms that do not depend on other terms. #footnote[Disregarding infinitely recursive terms.]

An example program:

#program(`if false then 0 else 1`, `1`)

#program(`iszero (pred (succ 0))`, `true`)

A few notes: 
- The #sym.triangle.r.filled symbol is used to display the results of expressions, although it is omitted for trivial ones.
- Parentheses are used here for readability, although they are not in the grammar and do not matter for this language due to its unambiguous syntax.
- We use standard arabic numerals for numbers, represented with Peano arithmetic as nested applications of `succ` to `0`.
- Results are always booleans or numbers. These are called _values_. This means values, in this grammar, cannot include forms `if t then t else t`, `pred t`, and `iszero t`.
- Some permitted terms are nonsensical, like `succ true`. Disallowing terms such as these is the point of a type system.

== Syntax

The grammar in the previous section is a compact notation for the following inductive definition:

*Definition*: The set of _terms_ is the smallest set $T$ such that
+ ${#`true`, #`false`, #`0`} subset.eq T$
+ $t_1 in T -> {#`succ` t_1, #`pred` t_1, #`iszero` t_1} subset.eq T$
+ ${t_1, t_2, t_3} subset.eq T -> #`if` t_1 #`then` t_2 #`else` t_3 in T$.

This indicates a set of base terms, defines rules for constructing new terms, and indicates that only terms in this definition are in $T$ (via "smallest"). Once again, this does not specify anything about parentheses; it defines a tree, not a set of strings. Parentheses are uses simply for clarifying or overriding precedence when converting expressions to strings.

It is also possible to define terms with inference rules:

#table(
  columns: (auto, auto, auto),
  stroke: none,
  align: center,
  [`true` $in T$],
  [`false` $in T$],
  [`0` $in T$],
  prooftree(rule(
    [$t_1 in T$],
    [`succ` $T_1 in T$],
  )),
  prooftree(rule(
    [$t_1 in T$],
    [`pred` $T_1 in T$],
  )),
  prooftree(rule(
    [$t_1 in T$],
    [`iszero` $T_1 in T$],
  )),
  table.cell(colspan: 3, prooftree(rule(
    [$t_1 in T$],
    [$t_2 in T$],
    [$t_3 in T$],
    [`if` $t_1$ `then` $t_2$ `else` $t_3$ in T]
  )))
)

This is a similar procedure for _generating_ the elements of $T$; we start with known elements, and then introduce further production rules.

Premises are placed above line, with the conclusions that can be drawn from each premise included below the line. Rules with no premises (the top row) are called _axioms_. An _inference rule_ refers to both axioms and _proper rules_. Inference rules are, in reality, _rule schemas_, since they can be instantiated on any valid _metavariables_ to obtain a _concrete rule_ that can be applied in a real case.

We can also define these inductively:

$
S_0 &= emptyset\
S_(i+1) &= && && {"true", "false", 0} \
& && union && {"succ" t_1, "pred" t_1, "iszero" t_1 | t_1 in S_i} \
& && union && {"if" t_1 "then" t_2 "else" t_3 | t_1, t_2, t_3 in S_i} $
$ S = union.big_i S_1 $

Essentially, we define iterations of rule applications, and collect them all into $S$.

*Exercise.* How many elements does $S_3$ have?

This represents a recurrence relation of:

$r_0 = 0$

$r_(n+1) = 3 + 3 r_n + (r_n)^3$

We sample up to $r_3$:

$r_0 = 0, r_1 = 3, r_2 = 39, r_3 = 59439$

*Exercise.* Show that the sets $S_i$ are _cumulative_---that is, $forall i (S_i subset.eq S_(i+1))$.

Instead of a proof, we provide the explanation that the definition for the next $S_(i+1)$, the iteration operation applies one more layer of indirection from the base value set, also adding the aforementioned set. Thus, it turns ${0}$ into ${0+1} union {0} = {0, 1}$, ${0, 1}$ into ${0+1, 1+1} union {0} = {0, 1, 2}$, et cetera.

Each set $S_i$, then, essentially contains the iterations equal to $ZZ\/i ZZ$, which is a subset of $ZZ\/(i+1)Z$. It's possible to explain this in a much more sound manner, but that's too much work for this question.

The paper proceeds with a proof that $T = S$, which is not necessary here.

== Induction on Terms

For any $t in T$, $t$ must either:
- Be a constant: $t in {"true", "false", 0}$
- Have the form $"succ" t_1$, $"pred" t_1$, or $"iszero" t_1$ for some _smaller_ term $t_1$
- Have the form $"if" t_1 "then" t_2 "else" t_3$ for smaller terms $t_1, t_2, t_3$.
This can be used to give _inductive definitions_ of functions over a set of terms, and to give _inductive proofs_ over terms. For example, we define the number of nodes in the abstract syntax tree of a term $t$:

$ "size"("true") &&=& 1 \
"size"("false") &&=& 1 \
"size"(0) &&=& 1 \
"size"("succ" t_1) &&=& "size"(t_1) + 1 \
"size"("pred" t_1) &&=& "size"(t_1) + 1 \
"size"("iszero" t_1) &&=& "size"(t_1) + 1 \
"size"("if" t_1 "then" t_2 "else" t_3) &&=& "size"(t_1) + "size"(t_2) + "size"(t_3) + 1 $

Taking `depth` to mean the depth of a term as a tree, we define some principles of induction on terms, supposing that $P : T -> "boolean"$:

_Over size_: $forall s (forall r ("size"(r) < "size"(s) and P(r)) -> P(s)) -> P(s)$

_Over depth_: $forall s (forall r ("depth"(r) < "depth"(s) and P(r)) -> P(s)) -> P(s)$

_Structural induction_: $forall s (forall r (r "is an immediate subterm of" s and P(r)) -> P(s)) -> P(s)$

Notice that these examples, converted from the textbook, are partially strong induction (the first two examples) and partially weak induction (the last example).

*Exercise.* Prove the examples above. For brevity, only the last example will be proven.

We take $R(s)$ to equal the set of immediate subterms of $s$.

_Proof:_ We aim to prove that, for any, $P : T -> "boolean"$, structural induction holds for $P$ over $T$ such that, if $forall s (forall r in R(s) (P(r))) -> P(s)$, then $P$ holds for all $s$.

We first note that for terminal terms, there exist no subterms, so $forall (r in "subterms of s") P(r) = forall emptyset P(r) $, which is true.

For the inductive step--We make the inductive assumption that $forall r in R (P(r))$. Per modus ponens, we can use the assumption $forall s (forall r in R(s) (P(r))) -> P(s)$ to prove that $P(s)$. Thus, the given $P(s)$ has been proven. Note that this is analogous to using $k-1$ to prove $k$ instead of using $k$ to prove $k+1$, as it was more convenient for this proof. 

== Semantic Styles

There are three main approaches to formalizing language semantics.

1. _Operational semantics_: behaviour is defined with an _abstract machine_ formed from a _state_ (which can be as simple as a term), defined with a _transition function_. The _meaning_ of a term `t` is the final state the machine reaches when initialized with `t`. Providing multiple abstract machines is often useful for useful as a means of proving that language semantics are correct.

2. _Denotational semantics_: behaviour is abstracted from sequences of machine states to a more general idea of mathematical objects. Terms are mapped with an _interpretation function_ into an element belonging to one of several _semantics domains_, known as _domain theory_. This omits the details of evaluation and makes it easier to reason about programs, such as through defining laws or identifying impossible behaviour.

3. _Axiomatic semantics_: the axiomatic laws themselves are the definition of the language instead of defining program behaviour and deriving laws from that.

Mathematically weak operational semantics were regarded as inferior  to the other two, but proved more viable in the face of nondeterminism and concurrency (for denotational semantics), and procedures (for axiomatic semantics).

#pagebreak()

#set heading(numbering: none)

= Select References

References from _Types and Programming Languages_ that seem interesting on an initial look.

- _Essentials of Programming Languages_ by Friedman, Wand, and Haynes (2001)
- _Programming Language Pragmatics_ by Scott (1999)
