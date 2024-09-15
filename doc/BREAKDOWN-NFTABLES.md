How I broke down NFTABLES into VimL/vimscript syntax

The VimL/vimscript syntax programming was accomplished by doing the following steps:

1. Converting nftables Yacc (`parser_bison.y`) file into a grammar file.
2. Processing dotgraph file into EBNF-W3C format.
3. Creating Railroad Diagram from EBNF-W3C into `nftables.html`


Converting nftables Bison file into EBNF
=====

Visit the online Grammar Convertor website at https://www.bottlecaps.de/ebnf-convert/ 

Copy entire content of `nftables/src/parser_bison.y` into the "Input Grammar" textbox.

Ensure that all checkboxes and settings for below are:

* Direct recursion elimination: checked
* Factoring: checked
* Inline single-string nonterminals: 	checked
* Keep references to epsilon-only nonterminals: 	checked
* Target format: 	EBNF

Click on "Convert" button.

In the "W3C-style grammar" textbox, copy entire text content into a file (`nftables.ebnf-w3c`).

Converting EBNF to Railroad Diagram
=====

NOTE: This "View Diagram" action takes the browser to another website: https://www.bottlecaps.de/rr/ui

On new website, click "Options" tab on the top navigation panel.  

* Mark the checkbox for "Show EBNF".
* Clear the checkbox for "Keep epsilon nonterminals".

Click on "View Diagram" button on the top navigation panel.

Save entire webpage into an HTML (`nftables.html`) file for later references.

Viewing files
=====
To view the dotgraph file, execute:
```bash
bison --update --graph=nftables.gv -fcaret,fixit -pnft_ -k -v --locations -l parser_bison.y
dot -Tsvg nftables.gv > nftables.svg
firefox nftables.svg
```

