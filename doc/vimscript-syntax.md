
I needed to systemically create syntax highlighters files based off of 
GNU Bison (Linux [nftables for Vim/NeoVim](https://github.com/egberts/vim-nftables))
and from EBNF specifications ([ISC Bind9 for Vim/NeoVim](https://github.com/egberts/vim-syntax-bind-named)).

If I could made the same tool that generates vimscript files from its EBNF 
spec, then the massive work for two becomes a single point of work and 
quickly extensible to many other file formats for this Vim/Neovim editor family:

In layman terms, my mission:

* read a EBNF, write this transformer, and generate syntax files (here, vimscript, later textMate/Intelli).

Chomskey-speaking, my mission:

* read a CSL file of a CFG, translate CSL into a new (but meta) CFG, 
  generate CST, read a DSL using this new CST, transform DSL.


We cover this article's topics in the following semantic:

1.  Everything about Vim syntax
2.  Desired End-Result
3.  End-Stage Engine Required for End-Result
4.  Front-Stage Engine Required for that End-Stage Engine
5.  Conclusion


Vimscript
=========
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
blocks are restricted to on a context-free grammar (CFG) constraint, comprising:

     group-name (identifier, node),
     literal (constant, identifier, regex, set-of-characters)
     nextgroup (jump, edge)

DSL experts: vimscript `syntax` is definitely not a CNF (Chomsky Normal Form).

Since there is no support for mathematical expression in vimscript syntax, 
PEG approach would not be generally required for our need and yet a specific 
Packrat PEG mechanism would be called back to support the required CST of
vimscript syntax.

CST is a Concrete Syntax Tree consists of an ordered, rooted tree that
represents the syntactic structure of a string according to some 
context-free grammar (CFG).

Also, vimscript syntax cannot handle a circular/acyclic pathway, as 
in a graph form of the context-sensitive (CSG) is not supported: 
Vimscript syntax only supports a tree-form of context syntax tree (CST).  

One glaring but hidden limitation of vimscript syntax:

    Any reuse of a destination groupname (node) that are NOT explicitly
    `contained` after the `syntax` command WILL CAUSE a CFG edge 
    breakage due to reuse of other edge(s); vimscript syntax 
    must be strictly a CST, and not CSG.  This means that using 
    vimscript syntax, there must be support for duplicative but
    identical (yet `contained`) syntax subtrees throughout its CST
    of vimscript syntax statements.

In short, no subtree optimization, for our needed transformation here.


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

Using `match`, `region`, `cluster`, and `keyword`, the `syntax` builds 
around a concrete syntax graph, using the concept of 
a (node, edge \[, node(s)\]) declaration statement as its primary 
form of inter-nodal aspect of syntax building block in vimscript.

Declaration
------------
The simplistic declaration of CSL is the empty set:

    A -> empty

and is declared by vimscript syntax statement of:

    syntax cluster A contains=

`contains=` without a parameter value is almost never used 
but written here as a guide for subsequential CSL building blocks:

Static
----
Next is the non-terminal to terminal declaration:

    A -> 'a'

and is declared by

    syntax match 'a' skipwhite contained nextgroup=

Symbolic Linking
----
Next is the linking of non-terminal to non-terminal.

    A -> B
    B -> 'b'

and is declared by

    syntax cluster A contains=B
    syntax match B 'b' 

Concatentation
----
Most of the time, concatentation of terminal nodes is optimized out 
into a larger terminal node by smarter parsers.  

    A -> B C
    B -> 'b'
    C -> 'c'

and is denoted as:

    syntax cluster A nextgroup=B
    syntax match B 'b' nextgroup=C
    syntax match C 'c'

Notice that this linearization is occurring by the daisy-chaining `syntax`
commands together to form a symbolic concatentation (hereby known 
as catentation).

Choices
----
Then we start having choices, its DSL content could be a having 'b' 
content or a 'c' content, but one must appear:

    A -> B | C
    B -> 'b'
    C -> 'c'

written for an 'A' being a non-terminal (symbolically-linked):

    syntax cluster A contains=B,C
    syntax match B 'b'
    syntax match C 'c'

or written for an 'A' being a terminal (constructor):

    syntax match A 'something-something' nextgroup=B,C
    syntax match B 'b'
    syntax match C 'c'

This above logic depends on whether the previous parent node has a pattern 
being matched or not.

My vision cloud of joy is started to get cloudy but this first-stage parser 
will assist with this transformation complexity rather neatly.


Optional
-----
Starting with repetition class of syntax, we have optional; either it has 
it or it doesn't.

    A -> D?
    D -> 'd'

also in vimscript command:

    syntax cluster A contains=D
    syntax match D 'd'

Keep in mind, optional '?' (along with not '~') operator is discourage here 
due to CSL constraint; sometimes the (EBNF) grammar file needs to 
refactorized by removing this optional '?' operation and introducing 'choices' 
approach in its place.

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
content for easiest analytical work.

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
NOPs and unharmful codes.

DSL File Format
===============
Many DSL-based (2 or more) parsers have 2 or more CSL files and each use 
their own but different CSL (ie., EBNF, Python, XML) specification.

DSL grammar files have been identified but not exclusively as:

* BNF
* PEG
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
For DHParser, we need two files; a symbol table file and an EBNF grammar file.

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
4.  Longest-length pattern as first alternative; shortest-length pattern as last alternative

#### Ambiguous into Unambiguous
A grammar contains rules that can generate more than one tree for the same CSG.
Expansion of rules is often required to minimize permutation of 
duplicative grammar subtrees.  An example of duplicative subtrees:

    E -> E + E | E * E | Num

would be rewritten as:

    E -> E + T | T
    T -> T * F | F
    F = Num

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


REFERENCE
=====
* [Learn from LL(1) to PEG parser the hard way](https://www.youtube.com/watch?v=rlULA4PthKw)
* [Recursive descent parser](https://en.wikipedia.org/wiki/Recursive_descent_parser)
* [Parsing Expression Grammar](https://en.wikipedia.org/wiki/Parsing_expression_grammar)
* [Chomsky Normal Form](https://en.wikipedia.org/wiki/Chomsky_normal_form)
