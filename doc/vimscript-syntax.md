
I needed to systemically create syntax highlighters files based off of 
GNU Bison (Linux [nftables for Vim/NeoVim](https://github.com/egberts/vim-nftables))
and from EBNF specifications ([ISC Bind9 for Vim/NeoVim](https://github.com/egberts/vim-syntax-bind-named)).

If I could make a transducer tool that generates vimscript files 
from a EBNF spec for my choice of any file format, then the massive 
manual work that I have done for both massive syntax highlighter 
in that particularl file format/grammar becomes a single point of 
work would also becomes easier to maintain, and quickly extensible to 
many other file formats for this Vim/Neovim editor family:

Ideally, I would think that a Moore-Machine-type transducer tool 
that does syntax-highlight generative output for as many editors 
having such functional attributes like syntax-directed, 
language-based, language-sensitive.  This transducer 
would leverages topological sorting of CST by a partial ordering using 
poset, pattern matching, generic function instantiation, and 
multimethod dispatch using subsumption and a standard topsort algorithm.

In layman terms, my mission:

* read a spec on about many EBNF variants, read a DSL grammar in EBNF spec,
for a C/Python/nftables written in EBNF, write this multi-stage transformer, 
and generate syntax files for a specific editor.

Chomskey-speakingly, my mission:

* read a CSL file of a CFG, translate CSL into a new (but meta) CFG, 
  generate CST, read a DSL using this new CST, transform DSL.

In short, this is my continuing education forum for DSL, CSL, CFG, CST, PEG, CST, to 
complement my large AST, compiling and parsing skillset.

We cover this article's topics in the following outline:

1.  Everything about Vim syntax
2.  Desired End-Result, Vimscript, pluggable for other structured editor or projectional editor.
3.  End-Stage Engine Required for End-Result
4.  Front-Stage Engine Required for that End-Stage Engine
5.  Conclusion

How To Read Notations
===========

No language grammar notation is used here, ie., `L(G)`.
No DFA/NFA notation are used here, thereby no state diagram.
No model grammar is used here, unless your external railroad diagrams display our EBNF files here.
Only regular grammar (not Regex) used here.

Transducer?
====================
For our first-stage parser, a domain-specific notation for Most-Flexible 
EBNF (from DHParser) shall be its grammar engine.  This means that 
the input parser is ready to take other domain-specific grammar using any 
of 11-variants of EBNF notations.  This will hopefully prove to be 
most useful for data scientists and other folks who desire a 
rapid prototype of their many file formats not found nor supported by other 
syntax-sensitive editors.

For our final-stage domain-specific notation, the template shall be inherited
from the first domain-specific notation: this means final-stage CST shall be     
constructed for the Python/C/nftables grammar language (no code nor command yet).

No need to be parsing nor compiling here.  We work ONLY with the final-stage CST.

With the CST from the second domain-specific notation, we can then navigate
the tree of concreate syntax and make production outputs based on its
symbol, keywords, delimiters, block notation, protocol field, and network 
protocols.


Vimscript
=========

In DSL parlance, vimscript syntax is a extended right-regular grammar 
(Type-3 Chomskey): there are no support for left-regular grammar.

Vimscript syntax is also a Pushdown Automata (PDA) with finite stack (aka 
a subset of Finite Automata).

With the help of this program design, it will take us into Linear Bounded
Automata (LBA) with the help of two parser engines and a poset generator
from syntactic parse tree by semantic analysis.

Jumping to the end-result of my desired transformer tool, Vimscript 
`syntax` commands is used to conduct syntax highlighting of the 
text content found in its editor buffer.

Vimscript `syntax` command is part of the Vim/NeoVim scripting language set.

Scripting language within family of Vi editors is actually two families of 
Vi scripting: Vimscript and NeoVim script language.  Many things are found
in both set of languages.  

Here, we focus ONLY on the `syntax` keyword, a subset of vimscript language
that is found in both Vi/Vim and NeoVim.

For this article on about syntax highlighting, the word "vimscript syntax" 
shall refer to this `syntax` subset of vimscript (as found in both 
Vi/Vim and NeoVim). 

Note: There is a language war going on around terminology surrounding Vim 
scripting language but thankfully `syntax` remains largely untouched: 
I shall try and remain agnostic in here.

Vimscript Syntax concept
================
Topically, vimscript `syntax` command is the building block of an editor's
syntax highlighter.

Building up of multiple vimscript syntax statements and its building 
blocks are restricted to within a context-free grammar (CFG) constraint, comprising:

     group-name (identifier, node),
     literal (constant, identifier, regex, set-of-characters)
     nextgroup (jump, edge)

While we are academically taught that the CFG concept is a grammar having the 
following sets of 4 tuples (S, V, T, P):

    S: The starting variable/symbol.
    V: A set of non-terminals.
    T: A set of terminals.
    P: A set of production rules.

We won't be using the Formal Definition of Finite Automata which is 
a { Q, Σ, q, F, δ } 5-tuple approach.

    Q: Finite set of states
    Σ: Set of input symbols
    q: Initial state
    F: Set of final states
    δ: Transition function


Yet, the concept of Vimscript syntax constructors appears to have 
merged `S` and `T` for their set of terminals.

The production '`P`' rule is even more elusive to map between CFG and vimscript 
syntax statement, which shall (hopefully) be intensively documented hereafter.

Vimscript syntax is definitely a Deterministic Finite Automaton (DFA) for
as its exical analysis because it provides a more structured and efficient way 
to process input symbols, making it ideal for scanning and recognizing 
patterns in source code.

Fortunately, there is no support requirement for stack or mathematical expression here,
thus PEG approach would not be generally required for our needs,  yet a specific 
Packrat PEG mechanism would be called back to support the required backtracking
and traversal of a CST: some PEG capabilities, some parser techniques, not all for
this needed transformation.

CST is a Concrete Syntax Tree consists of an ordered, rooted tree that
represents the syntactic structure of a string according to some 
context-free grammar (CFG).

Also, vimscript syntax cannot handle a circular/acyclic pathway, as 
in a graph form of the context-sensitive (CSG) grammar is not supported: 
Vimscript syntax only supports a tree-form of context syntax tree (CST).  
(reverify here).

One glaring but hidden limitation of vimscript syntax:

    Any reuse of a destination groupname (node) that are NOT explicitly
    `contained` after the `syntax` command WILL CAUSE a CFG edge 
    breakage due to reuse of other edge(s); vimscript syntax 
    must be strictly a CST, and not CSG.  This means that using 
    vimscript syntax, there must be support for duplicative but
    identical (yet `contained`) syntax subtrees throughout its CST
    of vimscript syntax statements.

In short, no subtree optimization here, for this needed transformation.


vimscript Syntax command
==============
`syntax` command are entered at the editor command line prompt or executed
from the vimscript file.  

`syntax` command does the following:

* enable/disable (`syntax on`)
* match an identifier and groupname (label) it (`syntax keyword`)
* match a text/word/phrase and groupname (label) it (`syntax match`)
* select a block region and groupname (label) it (`syntax region`)
* symbolically refer to a group of groupnames (`syntax cluster`)
* highlight a groupname to a specific color (`highlight link`)
* starts syntaxing effort at certain types of places within the editor.

For CFG purpose, we only need `match`, `region`, `cluster`, and `keyword`
attrbutes of the `syntax` commands to build around a desired form of 
concrete syntax tree, using the concept of 
a (node, edge \[, node(s)\]) declaration statement as its primary 
form of inter-nodal aspect of syntax building block in vimscript.

Vim syntax cannot distinguish between string pattern from CSG symbol 
identifier, literal, nor regex.

Desired End-Result
==================
In order to output the vimscript syntax, we need to map it
consistently and concisely from a set of CSG notations of string handling
that most parser can be able to understand.

Mapping Vimscript to CSG
========================
We forge ahead and pre-fill the mapping table, then followed by
its detail:

```
CSG notation	RHS	LHS	vimscript command(s)
			
S → ε	terminal	empty	syntax match S “”
A → ‘a’	terminal	literal	syntax match A “a”
B → ‘b’	terminal	literal	syntax match B “b”
A → B	terminal	terminal	syntax match A “a” nextgroup=B
A → c_C	terminal	Non-terminal	syntax match A “a” nextgroup=\@c_C
c_C → X	Non-terminal	terminal	syntax cluster c_C contains=X
c_C → c_F	Non-terminal	Non-terminal	syntax cluster c_C contains=\@F
			
c_C → AB	Non-terminal	catenation	syn cluster c_C contains=A; syn match A /a/ nextgroup=B; syn match B /b/
D → AB	terminal	catenation	syn match D /d/ nextgroup=A; syn match A /a/ nextgroup=B; syn match B /b/
			
c_C → A | B	Non-terminal	union/choices	syn cluster c_C contains=A,B
D → A | B	terminal	union/choices	syn match D /d/ nextgroup=A,B
			
c_C → A|B|C 	Non-terminal	union	syn cluster c_C contains=A,B,C
D → A | B | C	terminal	union/choices	syn match D /d/ nextgroup=A,B,C
			
L → E(E S)*		a list/set/dict	syn cluster c_L contains=E syn match E /e/ nextgroup=S syn match S /,/ nextgroup=E
 → F*		ZeroOrMore	syn match F // nextgroup=F
 → F+		OneOrMore	syn match F // nextgroup=F1; syn match F1 /f/ nextgroup=F

```

Terminal Node
-------------
The basic CSG declaration is a terminal node.   

We use CSG notation to describe the CSL side.

A terminal node may be a static symbol or empty:

    A -> ε        # empty
    B -> 'b'      # static

The detail of their corresponding vimscript syntax is next.

Note: In CSG parlance, we introduce a new but unique 
identifier (e.g., `A`, `B`) if its RHS production is not 
the same as initially mentioned throughout this article: 
resuse of identifier is essential to explain the 
ever-expansive CSG notations.

Empty
-----
The most basic CSG declaration of a terminal node is an empty set:

    A -> ε

and is declared by vimscript syntax statement of:

    syntax cluster A contains=

The `contains=` attribute without any parameter value is 
a vimscript interpreter error. 

Yet it shall be written here merely as a guide for 
subsequential CSG building blocks.

This means, for proper use in vimscript syntax, CSG language specification 
shall be condensed to having all empty statements optimized and removed out.

Literal, Static Pattern
----
Next is the static terminal declaration:

    B -> 'b'

LHS `B` is a label.

RHS `'b'` is a pattern (e.g., a single character, literal, variable name, keyword, or command).

and is declared by its following vimscript statement:

    syntax match B 'b'

In the language of vimscript syntax, `B` is the groupname, 
and  `'b'` is the pattern.

`groupname` is this primary form of node mechanism during the syntax construction.


EDGE (Linking)
==============
Now to connect the nodes together, we introduce linkage.

In DSL, the linkage is called an edge.

In CSL, the linkage is called an state transition.

In vimscript syntax-speak, this linkage is "loosely" represented by
its `contains=`/`nextgroup=` attribute(s) during the syntax construction.

Two nodes makes possible one (or more) link (edge).

Symbolic Node
---------

In CSL, symbolic node has no static content, especially in `Vimscript` language.

In DSL, symbolic node is non-terminal, shown as `C` below:

    C -> N

It may point next to a `N` node, terminal or non-terminal,  but 
`C` remains a non-terminal that has no static pattern.

If the `N` node is a terminal, then `C` shall use a `syntax match/region` statement.

If the `N` node is an non-terminal, then `C` shall use a `syntax cluster` statement.

We will not be using any `syntax keyword` here due to its inability to 
let `syntax match/region`  statement override the `syntax keyword` statement.

Symbolic Linking
----
The linking of non-terminal to specifically a non-terminal 
destination node/groupname.

    A -> B
    B -> 'b'

and is declared by

    syntax cluster A contains=B
    syntax match B 'b' 


Symbolic Node to End-Terminal
-----
Now it is time to introduce the `c_` prefix notation for all 
clustername (cluster-defined groupname) from thereon.

After a symbolic node, its destination node that is a terminal is represented below as:

    C -> B

and coded as:

    syntax cluster c_C contains=B
    syntax match B 'b'

It is written with `cluster` and a `contains=` attribute to its `syntax` statement:


Symbolic Node to Non-Terminal
-----
A destination node that is non-terminal is written as:

    D -> E

    ;;;;

    syntax cluster D contains=@E
    syntax cluster E contains=

A Long Rant on `@` Weirdness
----------------------
Notice the weirdness of vimscript's special handling of groupname made 
by only the `syntax cluster` command?  Vim manual authors still called this, a `groupname`.
I assert they'd be called 'clustername', but alas, no.

All attempts to reference the cluster-form of 
groupname shall have a `@` prefixed 
before its groupname.  (IMHO, it is extraneous and burdensome, like 
prepending a `$` symbol to the variable name to identify all your 
variables in BASIC language, but hey, it is what it is).

That is why I, myself, as a rule, always insert `c_` somewhere in
its groupname identifier name to let me know NOT TO FORGET THAT `@` notation 
when typing to use a cluster-created groupname during syntax construction. 
This is a mental-only real timesaver here that is about to vanish once this 
transformation tool gets completed.

Vimscript does not accurately catches this common human error of 
omitting the `@` prefix for a cluster-created groupname.

I'll probably incorporate that same cluster-like notation into this 
tool, just in case, you know, some poor sap wants to edit our final 
product.  I know of one who uses the `_cf_` notation as for a reference to
"clusterfuck". Aye, it's that bad.

With using `@` prefix ... like ... always for using a cluster-created groupname 
(after its initial declaration), we move on.  Please, don't forget this.
vimscript interpreter error is notoriously unforgiven about this omission
of this '@' prefix for using a cluster-created groupname: they are SILENT!

Wish I could mandate the use of a term 'clustername' instead.  
If I did accidentially use it, you know what I'd be referring 
to (and not by a `groupname`).

Concatentation
----
Most parsers encountering the concatentation of terminal nodes will optimize out 
into a single but larger terminal node by smarter parsers.  But for this design
need, we keep the original CFG constructs in an unoptimized, original manner.

    H -> F G
    F -> 'f'
    G -> 'g'

and is denoted as:

    syntax cluster H contains=F
    syntax match F 'f' nextgroup=G
    syntax match G 'g'

Notice that this linearization is occurring by the daisy-chaining `syntax`
commands together to form a symbolic concatentation (hereby known 
as catentation).

This daisy-chaining makes it possible to provide for an AND-series operation and
just like any multi-AND, left-side is evaluated ... firstly, then the next
and so on.

If a particular left-most alternative of the AND-series has failed, then 
subsequential groupname(s) shall not be evaluated (as in remaining syntax 
highlighters shall not be used).

Choices
----
Then we start having choices, its DSL content could be a having 'f' 
content or a 'b' content, but one must appear.

Written for destination node '`B`' and '`F`' being a terminal (string constructor):

    J -> B | F


    syntax cluster J contains=B,F
    syntax match F 'f'  ...
    syntax match B 'b' ...

Written for destination node 'F' being an non-terminal (symbolically-linked):

    J -> B | F

    syntax cluster J contains=B,@F
    syntax cluster F  ...
    syntax match B 'b' ...

My vision of joy is started to get cloudy but later realization will
show that a first-stage parser will assist with this complexity part of 
our desired transformation rather neatly.

Optional
-----
Starting with repetition class of syntax, we have "optional"; either it has 
it or it doesn't.

    K -> L?
    L -> 'l'

also in vimscript command:

    syntax cluster K contains=L
    syntax match L 'l'

`contains=` is an OR-series operator, one-item series means 
an optional '`?`' operator.

Keep in mind, use of this optional '?' (along with not '~') operator is 
discouraged on any complete LHS of an expression here due to CSL constraint; 
sometimes the (EBNF) grammar file needs to further refactorized by removing 
this optional '?' operation and introducing a more static 'choices' 
approach in its place.

symbolic node to symbolic node
--------------------------------

XXXX
====

nftables may require a recursive descent parser or at
least an LL(2) parser.

Bind9 named.conf may require a recursive descent parser or at
least an LL(1) parser.

But vimscript syntax must be written with root groupname/node at the end 
of the vimscript file as each production appears during parsing and the 
smallest groupname/node at the beginning all by using the LR(0).

Coupling these two disparate yet disjoint CST together for our desired
transformation is the key here.

Recursive descent parser makes reuses of subtrees in a CST.   

Two variants of recursive descent parsers are:

1.  Predictive parser which does not require backtracking and only works 
with context-free grammar (CFG). Most evident when CST has all their 
symbols (both terminal and non-terminal) on the right side of each node.
2. Works with LL(k) but not guaranteed to terminate as exponential 
production occurs.

Hence, to ensure no clobbering of CST pathways required by vimscript syntax, 
memoization of all pathway invocations of mutual recursion for a
vimscript supported CST would require this Packrat PEG approach.

That said, most PEG parsers require PEG-format file for its needed 
grammar breakdown.

Very few PEG parsers can accept any EBNF-variant grammar file; 
however, DHParser shines in taking a wide variety of EBNF variants, 
including PEG.  We go with DHParser here.

DHParser is a top-down parser type.

Domain Structure Language
===
Domain Structure Language (DSL) is essentially the act of using two (or more) 
different parsers, one applied after another.

1. To translate the context-sensitive language (EBNF) of a parser-specific 
context-sensitive (DHparse-supported) language so that its CSL can 
construct a CST for use with another parsing/transformation/compiling.
2. To translate a domain-specific (also a CSL; ie., EBNF of C/Python/nftables) 
language file into an AST for use with compiling the final domain-specific 
content for easiest analytical work of multi-stage transformation.

This way, we can leverage the use of EBNF as a standard transformer template 
for all domain-specific (ie., nftables, C, ISC Bind9 named.conf, Python, textMate) 
things, start compiling any and all domain-specific content as dictated 
by its domain-specific structure (written in EBNF format).

A perfect example of DSL would be to breakdown an English sentence into 
parts of the sentences (verb, subject, predicate, noun) then compile
a novel into those identified components of the English grammar.

Instead of parts of the English sentence, computer programming languages and 
network protocols need their structure broken down (1st parser) and made 
directly referencable by other programs via a 2nd parser.

This second parser becomes useful when certain actions needs be codified 
across multiple languages: A snippet of malicious code can be found before its 
execution through a well-known pattern detection of an unlinked object file or 
an un-interpreted (Davlok, Java, JS, Python) bytecode, so that its badness can be 
detected before it could be made harmful for computers to execute.  

First parser would deal with the format of bytecode or unlinked object of 
intermediate representation (IR) code.  A second parser is would tease out the
NOPs and unharmful code logics.

DSL File Format
===============
Many DSL-based (2 or more) parsers have 2 or more CSL files and each use 
their own but different CSL (ie., EBNF, Python, XML) specification.

DSL grammar files have been identified but not exclusively as:

* BNF
* EBNF
* Bison 
* PEG, Ford \[2004\] 
* Marpa:R2 SLIF-DSL
* JANET
* Pointlander GO PEG
* Python PEG
* Arepeggio PEG
* textX
* DHParser DSL
* bncf
* textMate (e.g., JetBrain platform, macos editor)

I wrote one tool to help the identification of a [DSL grammar file](https://github.com/egberts/filetype-ebnf-grammars).

There are lots of EBNF variants out there, but ABNF remains not a practical constructor.


Vimscript SCOPING
=======
Through the use of vimscript `contains=` attribute of its `syntax` declarator, scoping of grammars can be enforced.

APPROACHES
====

Now, the real question is figuring out which DSL to leverage in the 2nd stage of 4-stage parser:

1.  DSL Specification
2.  CST generation
3.  compiling DSL text using DSL AST

AST is a tree structured of the abstract syntactic structure of a DSL text (often a 
source code written in a programming language).

Should the CST tree be EBNF-based, or nftables-based?  The answer depends on the robust support of 
"hook" support for user-definable functions to be called on a per-node basis AND in which stage of parsing.


Grammar/Symbol Preparation
=====
For DHParser, we need two files; a lexical symbol table file containing lexical keywords, and an EBNF grammar file.

When taking in the `parser_bison.y` created by Unix Yacc (Yet Another Compiler Compiler) for GNU Bison
to process and create a parser in C language, parser_bison.y contains the symbol definitions.

Yacc file have three sections:

* Definition - `%{` and `%}` - where the symbol tables can be found.
* Rules - `%%` and `%%` - where the EBNF can be had from Bison output file: `bison --output=<file>`
* User Code - after the last `%%`

And DHParser has five sections:

* Symbols
* Scanner
* Parser (do not change/gets overwritten)
* AST
* Compiler

Symbol Table file
----
In `nftables`, its terminal node (symbol) can be extracted from `parser_bison.y` to make a symbol table that 
can be included by `DHParser()`.

Symbol definitions in a Yacc file are declared by a `%token` keyword.  An example portion of a Yacc file
containing `%token` declarations:

```yacc
    %token SSRR                     "ssrr"
    %token STATE                    "state"
    %token STATUS                   "status"
    %token STREAM                   "stream"
    %token <string> ASTERISK_STRING "string with a trailing asterisk"
    %token <string> QUOTED_STRING   "quoted string"
    %token <string> STRING          "string"
    %token SUBTYPE                  "subtype"
    %token SYMHASH                  "symhash"
    %token SYNPROXYS                "synproxys"
```

Symbol aliases can be permuted out to several additional string patterns, into:

* Terminal node (often, constant string)
* Non-terminal node (reference to another node)

Alias name is denoted by surrounding '<' and '>' symbols and are non-terminal (can reference other node(s)).

Some symbols require additional processing such as "ASTERISK_STRING" or name of Yacc `%type` 
that begins with `close_scope_*`, that are found in the main section of a Yacc file.

nftables EBNF
-------------------
Bison is rather limited in being able to create EBNF.

```shell
   bison -fcaret,fixit -o nftables.output -v nftables/src/parser_bison.y
```

With the `nftables.output` file, one can extract the EBNF semantic statements
and save as an EBNF `nftables.ebnf` file.

Mass `sed`/`vim` cleanup must occur for `nftables.output`:

1. Cut the header lines from line 1 to '`^Grammar`'.
2. Replacing '`:`' with '`=`' using sed/vi '`s/\(\w*\)\(:)/\1=/g`' file
3. Cut the large footer lines starting from line '`^Terminals, with rules`' to EOF
4. Columnarly cut the first 5-char columns for entire file (Use Ctrl-V, and HJKL navigation key followed by ENTER)

Save the result of the edit session into `nftables.ebnf` filename.

### nftables EBNF Rearrangement

Additional steps is required to recondition the `nftables.ebnf` output file into a working EBNF file.

1.  Ambiguous into Unambiguous
2.  Nondeterministic into Deterministic
3.  Left recursion into No Left Recursion
4.  Longest-length pattern as first alternative; shortest-length pattern as last alternative.
5.   Wildcard must be lstly and broken apart from any grammar construct.

#### Ambiguous into Unambiguous
A grammar contains rules that can generate more than one tree for the same CSG.
Expansion of rules is often required to minimize permutation of 
duplicative grammar subtrees.  An working example of duplicative subtrees here is:

    E -> E + E | E * E | Num

would be rewritten as:

    E -> E + T | T
    T -> T * F | F
    F = Num

See [Removal of Ambiguity Converting An Ambiguous Grammar into Unambiguous Grammar](https://www.geeksforgeeks.org/removal-of-ambiguity-converting-an-ambiguos-grammar-into-unambiguos-grammar/?ref=oin_asr4) for additional details.

#### Nondeterministics into Deterministics

Any rules having a common prefix should be broken up.

    A ->  ab | ac

subdividing up A rule into A and A' rules into this

    A -> aA'
    A' -> b | c

A non-deterministic rule can be rewritten into  more than one
deterministic rules.

#### Left recursion into No Left Recursion

In the case of a grammar containing direct (or indirect) left(-side) recursion.

    E -> E + T | T
    T -> T * F | F
    F = Num

E rule would be subdivided into E and E', samething for T rule and would be rewritten as:

    E -> TE'
    E' -> +TE' | None
    T -> FT'
    T' -> *FT' | None
    F -> Num

How to convert CFG to CNF?
--------------------------

Step 1. Eliminate start symbol from RHS.
If start symbol S is at the RHS of any production in the grammar, create a new production as:

    S0->S

where S0 is the new start symbol.

Step 2. Eliminate null, unit and useless productions.
If CFG contains null, unit or useless production rules, eliminate them. You can refer the this article to eliminate these types of production rules.

Step 3. Eliminate terminals from RHS if they exist with other terminals or non-terminals. e.g,; production rule `X -> xY` can be decomposed as:

    X -> ZY
    Z -> x

Step 4. Eliminate RHS with more than two non-terminals.
e.g,; production rule `X -> XYZ` can be decomposed as:

    X -> PZ
    P -> XY 


CONCLUSION
=====

DSL experts: I am asserting (now) that vimscript `syntax` constructor is 100%
CNF (Chomsky Normal Form) due to its production rules being forced not to have 
any terminal followed by a non-terminal. (TODO: rewrite)

When making a CST for use with navigating vimscript syntax tree, gotta 
refactor any input CSG to exclude this terminal\*non-terminal concatenation 
production rule format or no syntax highlighting will be supported.


Such transformation of production rules required of our design entails mostly of:

* backtracking by 1 node (needed by `syntax cluster`)
* predictive lookahead by 1 node (needed by `syntax cluster`)
* little bit of multiline coalesence, and
* upward node traversal, (needed by `vimscript ordering of syntax statements`)
* crosslinkage of nodes?

REFERENCE
=====
* [Learn from LL(1) to PEG parser the hard way](https://www.youtube.com/watch?v=rlULA4PthKw)
* [Recursive descent parser](https://en.wikipedia.org/wiki/Recursive_descent_parser)
* [Parsing Expression Grammar](https://en.wikipedia.org/wiki/Parsing_expression_grammar)
* [Chomsky Normal Form](https://en.wikipedia.org/wiki/Chomsky_normal_form)
* [Context-Sensitive Grammar (CSG) and Language (CSL)](https://www.geeksforgeeks.org/context-sensitive-grammar-csg-and-language-csl/)
* [Relationship between Grammar and Language](https://www.geeksforgeeks.org/relationship-between-grammar-and-language/?ref=oin_asr12)
* [Peter Jenk's BNF variants](https://www.cs.man.ac.uk/~pjj/bnf/ebnf.html) comparison list
* [Removal of Ambiguity Converting An Ambiguous Grammar into Unambiguous Grammar](https://www.geeksforgeeks.org/removal-of-ambiguity-converting-an-ambiguos-grammar-into-unambiguos-grammar/?ref=oin_asr4)
* [Applications of Various Automata](https://www.geeksforgeeks.org/applications-of-various-automata/)
* [Automatic syntax highlighter generation](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/autohighlight/final-paper.pdf), Allen, S. T.; Williams, S. R., December 9, 2005

