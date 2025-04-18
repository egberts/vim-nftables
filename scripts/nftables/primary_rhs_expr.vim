" Vim syntax file for primary_rhs_expr node of nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     1.0
" Initial Date: 2025-03-14
" Last Change:
" Parent script: syntax/nftables.vim
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables/scripts
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
" Global variables:
"    PRIMARY_RHS_EXPR - groupname to use for this instantiation of primary_rhs_expr
"
"  WARNING:  Do not add online comments using a double-quote, it ALTERS patterns
"
"  This syntax supports both ANSI 256color and ANSI TrueColor (16M colors)
"
"  For ANSI 16M TrueColor:
"  - ensure that `$COLORTERM=truecolor` (or `=24bit`) at command prompt
"  - ensure that `$TERM=xterm-256color` (or `xterm+256color` in macos) at command prompt
"  - ensure that `$TERM=screen-256color` (or `screen+256color` in macos) at command prompt
"  For ANSI 256-color, before starting terminal emulated app (vim/gvim):
"  - ensure that `$TERM=xterm-256color` (or `xterm+256color` in macos) at command prompt
"  - ensure that `$COLORTERM` is set to `color`, empty or undefined
"
" Vimscript Limitation:
" - background setting does not change here, but if left undefined ... it's unchanged.
" - colorscheme setting does not change here, but if left undefined ... it's unchanged.
" - Vim 7+ attempts to guess the `background` based on term-emulation of ASNI OSC52 behavior
" - If background remains indeterminate, we guess 'light' here, unless pre-declared in ~/.vimrc
" - nftables variable name can go to 256 characters,
"       but in vim-nftables here, the variable name however is 64 chars maximum."
" - nftables time_spec have no limit to its string length,
"       but in vim-nftables here, time_spec limit is 11 (should be at least 23)
"       because '365d52w24h60m60s1000ms'.  Might shoot for 32.

" TIPS:
" - always add '\v' to any OR-combo list like '\v(opt1|opt2|opt3)' in `syntax match`
" - always add '\v' to any OR-combo list like '\v[a-zA-Z0-9_]' in `syntax match`
" - place any 'contained' keyword at end of line (EOL)
" - never use '?' in `match` statements
" - 'contains=' ordering MATTERS in `cluster` statements
" - 'region' seems to enjoy the 'keepend' option
" - ordering between 'contains=' and 'nextgroup=' statements, first one wins (but not in region)
" - ordering between 'contains=' statements amongst themselves, first one wins
" - ordering within 'contains=' statements, last one wins
" - ordering within 'nextgroup=' statements, last one wins
" - last comma must not exist on statement betweeen 'contains='/'nextgroup' and vice versa
"
" Developer Notes:
"  - relocate inner_inet_expr to after th_hdr_expr?
"
" syntax/nftables.vim is called before colors/nftables.vim
" syntax/nftables.vim is called before ftdetect/nftables.vim
" syntax/nftables.vim is called before ftplugin/nftables.vim
" syntax/nftables.vim is called before indent/nftables.vim


" relational_op->relational-expr
hi link   nft_relational_op nftHL_Operator
syn match nft_relational_op "\v(eq|neq|lt[e]|gt[e]|not)" skipwhite contained
\ nextgroup=
\    nft_list_rhs_expr,
\    @nft_c_rhs_expr,
\    @nft_c_basic_rhs_expr
" basic_rhs_expr must be the last 'contains=' entry
"     as its exclusive_or_rhs_expr->and_rhs_expr->shift_rhs_expr->primary_rhs_expr->symbol_expr
"     uses <string> which is a (wildcard)

" primary_rhs_expr_block->primary_rhs_expr->(basic_expr|shift_rhs_expr)
hi link   nft_primary_rhs_expr_block nftHL_BlockDelimiters
syn region nft_primary_rhs_expr_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_basic_rhs_expr

" keyword_expr->(primary_rhs_expr|primary_stmt_expr|symbol_stmt_expr)
hi link   nft_primary_rhs_expr_keywords nftHL_Command
syn match nft_primary_rhs_expr_keywords "/v(tcp|udp[lite]|esp|ah|icmp[6]|igmp|gre|comp|dccp|sctp|redirect)" skipwhite contained

" primary_rhs_expr->(basic_expr|shift_rhs_expr)
syn cluster nft_primary_rhs_expr
\ contains=
\    @nft_c_symbol_expr,
\    nft_integer_expr,
\    @nft_c_boolean_expr,
\    nft_keyword_expr,
\    nft_primary_rhs_expr_keywords,
\    nft_primary_rhs_expr_block