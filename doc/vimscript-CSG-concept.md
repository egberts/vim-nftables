
I needed to systemically create syntax highlighters files based off of 
GNU Bison (Linux [nftables for Vim/NeoVim](https://github.com/egberts/vim-nftables))
and from EBNF specifications ([ISC Bind9 for Vim/NeoVim](https://github.com/egberts/vim-syntax-bind-named)).

If I could made the same tool that generates vimscript files from its EBNF 
spec, then the massive work for two becomes a single point of work and 
quickly extensible to many other file formats for this Vim/Neovim editor family:

In layman terms, my mission:

* read a EBNF, write this transformer, and generate syntax files (vimscript now, later TreeSitter, textMate, and Intelli).

Chomskey-speakingly, my mission:

* read a CSL file of a CFG, translate CSL into a new (but meta) CFG, 
  generate CST, read a DSL using this new CST, transform DSL.

In short, this is my continuing education forum for DSL, CSL, CFG, CST, PEG, CST, to 
complement my large AST, compiling and parsing skillset.

CONCEPT
======
A grammar is a set of production rules which are used to generate strings of a language.

A parse tree, also known as a syntax tree, is a tree-like representation 
of a string’s semantics according to a grammar. The root is the 
start symbol and the leaves are terminals. It is used to validate 
nested data structure in JSON format, and used verify the syntax of 
the source code.

For our first domain-specific notation, the template shall be rooted 
in EBNF notations.  This means EBNF for everything we have under the sun.

For our second domain-specific notation, the template shall be inherited
from the first domain-specific notation: this means a CST shall be
constructed for the Python/C/nftables grammar language (no code nor command yet). 

With the CST from the second domain-specific notation, we can then navigate
the tree of programming syntax and make production outputs based on its
symbol, keywords, delimiters, block notations.

ARGUMENTS
=========
TreeSitter's JSON approach is well-established, very diverse but practically
useless for an immediate and new creation of highlighter for a 
relatively new grammer due to its verbosity of detail specifications 
for each keywords; many data scientists work with new file formats every day.

TextMate's ease of use requires intensive reading of documentations, placement
of target grammar file, and careful setup of its platform; this tool is a 
single Python script taking in most variants of EBNF.

textX XML format, its tag, its attributes and largeness are not pleasant 
to work with without a dedicated XML editor.  End-user provides a simple EBNF 
and run this Python script.

Vimscript syntax complexity defies CSG notations, this tool will bi-parse and 
generate, which is the goal of this article.

Data scientists have their numerous file formats and want their own quick and 
ready syntax highlighting for their favorite editors, loggers, or any buffer-based
viewers.

Seed idea is to leverage EBNF for its initial grammer specification file for all, we
are only talking about highlighting syntaxes and auto-completion, not much needed
for any of the more advanced Chomskey form of parsers.

Input a semantic file of how EBNF works, construct a concrete syntactic tree;
then input a semantic file of how its grammar aspect of Linux nftables commands are structured
(also written in EBNF grammar), using the second CST tree, generate the syntax highlighter file
for its target (Vimscript/textMate/


Arguably, this design approach minimizes use of regular expressions due to its
CFG (Chomskey Type-1) approach, by a lot; should be definitely faster than TreeSitter.


Production
==========
Some basic set of production rules are:

    T → R
    T → aTc
    R → T
    R → RbR

A context free grammar (CFG) is in Chomsky Normal Form (CNF) if all production rules satisfy one of the following conditions:

    A non-terminal generating a terminal (e.g.; X->x)
    A non-terminal generating two non-terminals (e.g.; X->YZ)
    Start symbol generating ε. (e.g.; S-> ε)

Consider the following grammars,

    G1 = {S->a, S->AZ, A->a, Z->z} 
    G2 = {S->a, S->aZ, Z->a}

The grammar G1 is in CNF as production rules satisfy the rules specified for 
CNF. However, the grammar G2 is not in CNF as the production rule `S -> aZ`
contains terminal followed by non-terminal which does not satisfy the 
rules specified for CNF.

How to convert CFG to CNF?

Step 1. Eliminate start symbol from RHS.
If start symbol S is at the RHS of any production in the grammar, create a new production as:
S0->S
where S0 is the new start symbol.

Step 2. Eliminate null, unit and useless productions.
If CFG contains null, unit or useless production rules, eliminate them. You can refer the this article to eliminate these types of production rules.

Step 3. Eliminate terminals from RHS if they exist with other terminals or non-terminals. e.g,; production rule X->xY can be decomposed as:

    X->ZY
    Z->x

Step 4. Eliminate RHS with more than two non-terminals.
e.g,; production rule `X -> XYZ` can be decomposed as:

    X->PZ
    P->XY

Example – Let us take an example to convert CFG to CNF. Consider the given grammar G1:

    S → ASB
    A → aAS|a|ε 
    B → SbS|A|bb

Step 1. As start symbol S appears on the RHS, we will create a new production rule S0->S. Therefore, the grammar will become:

    S0->S
    S → ASB
    A → aAS|a|ε 
    B → SbS|A|bb

Step 2. As grammar contains null production A-> ε, its removal from the grammar yields:

    S0->S
    S → ASB|SB
    A → aAS|aS|a 
    B → SbS| A|ε|bb

Now, it creates null production B→ ε, its removal from the grammar yields:

    S0->S
    S → AS|ASB| SB| S
    A → aAS|aS|a 
    B → SbS| A|bb

Now, it creates unit production B->A, its removal from the grammar yields:

    S0->S
    S → AS|ASB| SB| S
    A → aAS|aS|a 
    B → SbS|bb|aAS|aS|a

Also, removal of unit production S0->S from grammar yields:

    S0-> AS|ASB| SB| S
    S → AS|ASB| SB| S
    A → aAS|aS|a 
    B → SbS|bb|aAS|aS|a

Also, removal of unit production S->S and S0->S from grammar yields:

    S0-> AS|ASB| SB
    S → AS|ASB| SB
    A → aAS|aS|a 
    B → SbS|bb|aAS|aS|a

Step 3. In production rule A->aAS |aS and B-> SbS|aAS|aS, terminals a and b exist on RHS with non-terminates. Removing them from RHS:

    S0-> AS|ASB| SB
    S → AS|ASB| SB
    A → XAS|XS|a
    B → SYS|bb|XAS|XS|a
    X →a
    Y→b

Also, B->bb can’t be part of CNF, removing it from grammar yields:

    S0-> AS|ASB| SB
    S → AS|ASB| SB
    A → XAS|XS|a
    B → SYS|VV|XAS|XS|a
    X → a
    Y → b
    V → b

Step 4: In production rule S0->ASB, RHS has more than two symbols, removing it from grammar yields:

    S0-> AS|PB| SB
    S → AS|ASB| SB
    A → XAS|XS|a
    B → SYS|VV|XAS|XS|a
    X → a
    Y → b
    V → b
    P → AS

Similarly, S->ASB has more than two symbols, removing it from grammar yields:

    S0-> AS|PB| SB
    S → AS|QB| SB
    A → XAS|XS|a
    B → SYS|VV|XAS|XS|a
    X → a
    Y → b
    V → b
    P → AS
    Q → AS

Similarly, A->XAS has more than two symbols, removing it from grammar yields:

    S0-> AS|PB| SB
    S → AS|QB| SB
    A → RS|XS|a
    B → SYS|VV|XAS|XS|a
    X → a
    Y → b
    V → b
    P → AS
    Q → AS
    R → XA

Similarly, B->SYS has more than two symbols, removing it from grammar yields:

    S0 -> AS|PB| SB
    S → AS|QB| SB
    A → RS|XS|a
    B → TS|VV|XAS|XS|a
    X → a
    Y → b
    V → b
    P → AS
    Q → AS
    R → XA
    T → SY

Similarly, B->XAX has more than two symbols, removing it from grammar yields:

    S0-> AS|PB| SB
    S → AS|QB| SB
    A → RS|XS|a
    B → TS|VV|US|XS|a
    X → a
    Y → b
    V → b
    P → AS
    Q → AS
    R → XA
    T → SY
    U → XA

So this is the required CNF for given grammar.


So far, there is no need to be converting Context Free Grammar to 
Greibach Normal Form (GNF).  No need to break apart symbolic (non-terminal) 
nodes because Vimscript can support non-terminal to non-terminal 
linkage.  Chomskey Normal Form is required to comply with Vimscript syntax.

There will be some simplification steps performed in achieving a 
CNF-compliant tree, but no need for a GNF-tree.

We require the refactorization of lambda ('`?`') and null (epsilon char) 
production to achieve a CNF-compliant tree.

There is no concept of "useless" unit production needing to be 
broken apart, reduced, and optimized away for dealing with Vimscript syntax.

No need for CYK algorithm either with ths CNF/CFG.

REFERENCE
======
* [Automatic syntax highlighter generation](https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/autohighlight/final-paper.pdf), Allen, S. T.; Williams, S. R., December 9, 2005
* [Simplifying Context Free Grammar](https://www.geeksforgeeks.org/simplifying-context-free-grammars/)
