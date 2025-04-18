" Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     1.1
" Initial Date: 2020-04-24
" Last Change:  2025-01-19
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
"
"  WARNING:  Do not add online comments using a double-quote, it ALTERS patterns
"
"
"  ~/.vimrc flags used:
"
"      g:nftables_syntax_disabled, if exist then entirety of this file gets skipped
"      g:nftables_debug, extra outputs
"      g:nftables_colorscheme, if exist, then 'nftables.vim' colorscheme is used
""
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

if exists('nft_debug') && nft_debug == 1
  echomsg "syntax/nftables-new.vim: called."
  echomsg printf("&background: '%s'", &background)
  echomsg printf("colorscheme: '%s'", execute(':colorscheme')[1:])
endif

"if exists('g:loaded_syntax_nftables')
"    finish
"endif
"let g:loaded_syntax_nftables = 1

" quit if terminal is a black and white
if &t_Co <= 1
  finish
endif

" .vimrc variable to disable html highlighting
if exists('g:nftables_syntax_disabled')
  finish
endif

" This syntax does not change background setting
" BUT it may later ASSUME a specific background setting

if exists('g:nft_debug') && g:nft_debug == 1
  echo "Use `:messages` for log details"
endif

" experiment with loading companion colorscheme
if exists('nft_colorscheme') && g:nft_colorscheme == 1
  try
    if exists('g:nft_debug') && g:nft_debug == 1
      echomsg "Loaded 'nftables' colorscheme."
    endif
    colorscheme nftables
  catch /^Vim\%((\a\+)\)\=:E185/
    echomsg "WARNING: nftables colorscheme is missing"
    " deal with it
  endtry
else
  if exists('g:nft_debug') && nft_debug == 1
    echomsg "No nftables colorscheme loaded."
  endif
endif


if !exists('&background') || empty(&background)
  " if you want to get value of background, use `&background ==# dark` example
  let nft_obtained_background = 'no'
else
  let nft_obtained_background = 'yes'
endif

let nft_truecolor = "no"
if !empty($TERM)
  if $TERM == "xterm-256color" || $TERM == "xterm+256color"
    if !empty($COLORTERM)
      if $COLORTERM == "truecolor" || $COLORTERM == "24bit"
        let nft_truecolor = "yes"
        if exists('g:nft_debug') && g:nft_debug == v:true
          echomsg "\$COLORTERM is 'truecolor'"
        endif
      else
        if exists('g:nft_debug') && g:nft_debug == v:true
          echomsg "\$COLORTERM is not 'truecolor'"
        endif
      endif
    else
      if exists('g:nft_debug') && g:nft_debug == v:true
        echomsg "\$COLORTERM is empty"
      endif
    endif
  else
    if exists('g:nft_debug') && nft_debug == v:true
      echomsg "\$TERM does not have xterm-256color"
    endif
  endif
else
  echomsg \$TERM is empty
endif

if exists(&background)
  let nft_obtained_background=execute(':set &background')
endif

" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
   " Quit when a (custom) syntax file was already loaded
    finish
  endif
  let main_syntax = 'nftables'
endif

if exists('nft_debug') && nft_debug == 1
  echomsg printf('nft_obtained_background: %s', nft_obtained_background)
  echomsg printf('nft_truecolor: %s', nft_truecolor)
  if exists('g:saved_nft_t_Co')
    echomsg printf('saved t_Co %d', g:saved_nft_t_Co)
  else
    echomsg printf('t_Co %d', &t_Co)
  endif
"  if has('termguicolors')
"    if &termguicolors == v:true
"      echom('Using guifg= and guibg=')
"    else
"      echom('Using ctermfg= and ctermbg=')
"    endif
"  endif
endif

syn case match

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_nftables_syn_inits")
  if version < 508
    let did_nftables_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink nftHL_Type         Type
  HiLink nftHL_Command      Command
  HiLink nftHL_Statement    Statement
  HiLink nftHL_Number       Number
  HiLink nftHL_Comment      Comment
  HiLink nftHL_String       String
  HiLink nftHL_Label        Label
  HiLink nftHL_Keyword      Keyword
  HiLink nftHL_Boolean      Boolean
  HiLink nftHL_Float        Float
  HiLink nftHL_Identifier   Identifier
  HiLink nftHL_Constant     Constant
  HiLink nftHL_SpecialComment SpecialComment
  HiLink nftHL_Error        Error
endif


" iskeyword severly impacts '\<' and '\>' atoms
" setlocal iskeyword=.,48-58,A-Z,a-z,\_,\/,-
setlocal isident=.,48-58,A-Z,a-z,\_,\/,-

let s:cpo_save = &cpo
set cpo&vim  " Line continuation '\' at EOL is used here
set cpoptions-=C

syn sync clear
syn sync maxlines=1000
syn sync match nftablesSync grouphere NONE \"^(rule|add {1,15}rule|table|chain|set)\"
" syn sync fromstart "^(monitor|table|set)"
" syn sync fromstart


hi link Variable              String
hi link Command               Statement

hi def link nftHL_String      String
hi def link nftHL_Variable    Variable
hi def link nftHL_Comment     Uncomment

hi def link nftHL_Include     Include
hi def link nftHL_ToDo        Todo
hi def link nftHL_Identifier  Identifier
hi def link nftHL_Number      Number
hi def link nftHL_Option      Label     " could use a 2nd color here
hi def link nftHL_Operator    Conditional
hi def link nftHL_Underlined  Underlined
hi def link nftHL_Error       Error
hi def link nftHL_Constant    Constant

hi def link nftHL_Command     Command
hi def link nftHL_Statement   Statement
hi def link nftHL_Expression  Conditional
hi def link nftHL_Type        Type

hi def link nftHL_Family      Underlined   " doesn't work, stuck on dark cyan
hi def link nftHL_Table       Identifier
hi def link nftHL_Chain       Identifier
hi def link nftHL_Rule        Identifier
hi def link nftHL_Map         Identifier
hi def link nftHL_Set         Identifier
hi def link nftHL_Element     Identifier
hi def link nftHL_Quota       Identifier
hi def link nftHL_Position    Number
hi def link nftHL_Limit       Number
hi def link nftHL_Handle      Number
hi def link nftHL_Flowtable   Identifier
hi def link nftHL_Device      Identifier
hi def link nftHL_Member      Identifier

hi def link nftHL_Verdict     Underlined
hi def link nftHL_Hook        Type
hi def link nftHL_Action      Special
hi def link nftHL_BlockDelimiters  Normal

"hi link nftHL_BlockDelimitersTable  Delimiter
"hi link nftHL_BlockDelimitersChain  Delimiter
"hi link nftHL_BlockDelimitersSet    Delimiter
"hi link nftHL_BlockDelimitersMap    Delimiter
"hi link nftHL_BlockDelimitersFlowTable    Delimiter
"hi link nftHL_BlockDelimitersCounter Delimiter
"hi link nftHL_BlockDelimitersQuota  Delimiter
"hi link nftHL_BlockDelimitersCT     Delimiter
"hi link nftHL_BlockDelimitersLimit  Delimiter
"hi link nftHL_BlockDelimitersSecMark Delimiter
"hi link nftHL_BlockDelimitersSynProxy Delimiter
"hi link nftHL_BlockDelimitersMeter  Delimiter
"hi link nftHL_BlockDelimitersDevices Delimiter

if exists('g:nft_colorscheme')
  if exists('g:nft_debug') && g:nft_debug == v:true
    echom "nft_colorscheme detected"
  endif
  hi def nftHL_BlockDelimitersTable  guifg=LightBlue ctermfg=LightRed ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersChain  guifg=LightGreen ctermfg=LightGreen ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersSet  ctermfg=17 guifg=#0087af ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersMap  ctermfg=17 guifg=#2097af ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersFlowTable  ctermfg=LightMagenta guifg=#950000 ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersCounter  ctermfg=LightYellow guifg=#109100 ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersQuota  ctermfg=DarkGrey ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersCT  ctermfg=Red guifg=#c09000 ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersLimit  ctermfg=Red ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersSecMark  ctermfg=Red ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersSynProxy  ctermfg=Red ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersMeter  ctermfg=Red ctermbg=Black cterm=NONE
  hi def nftHL_BlockDelimitersDevices  ctermfg=Blue ctermbg=Black cterm=NONE
endif

""""""""""
hi link   nft_ToDo nftHL_ToDo
syn keyword nft_ToDo xxx contained XXX FIXME TODO TODO: FIXME: TBS TBD TBA
\ containedby=nft_InlineComment

hi link   nft_InlineComment nftHL_Comment
syn match nft_InlineComment "\v\# " skipwhite contained

hi link   nft_EOS nftHL_Error
syn match nft_EOS /\v[^ \t]{1,6}[\n\r\#]{1,3}/ skipempty skipnl skipwhite contained

hi link   nft_UnexpectedSemicolon nftHL_Error
syn match nft_UnexpectedSemicolon "\v;{1,7}" contained

" stmt_separator (via nft_chain_block, nft_chain_stmt, @nft_c_common_block,
"                     counter_block, ct_expect_block, ct_expect_config,
"                     ct_helper_block, ct_helper_config, ct_timeout_block,
"                     ct_timeout_config, flowtable_block, limit_block,
"                     nft_line, nft_map_block, nft_quota_block,
"                     nft_secmark_block, nft_set_block, nft_synproxy_block,
"                     nft_synproxy_config, table_block )
hi link   nft_stmt_separator nftHL_Normal
syn match nft_stmt_separator "\v(\n|;)" skipwhite contained

hi link   nft_hash_comment nftHL_Comment
syn match nft_hash_comment "\v#.{1,65}$" skipwhite contained

" syn match nft_Set contained /{.*}/ contains=nft_SetEntry contained
" syn match nft_SetEntry contained /[a-zA-Z0-9]\+/ contained
" hi def link nft_Set nftHL_Keyword
" hi def link nft_SetEntry nftHL_Operator

"syn match nft_Number "\<[0-9A-Fa-f./:]\+\>" contained contains=nft_Mask,nft_Delimiter
" syn match nft_Hex "\<0x[0-9A-Fa-f]\+\>" contained
" syn match nft_Delimiter "[./:]" contained
" syn match nft_Mask "/[0-9.]\+" contains=nft_Delimiter contained
" hi def link nft_Number nftHL_Number
" hi def link nft_Hex nftHL_Number
" hi def link nft_Delimiter nftHL_Operator
" hi def link nft_Mask nftHL_Operator

" Uncontained, unrestricted statement goes here
"
hi link   nft_MissingDeviceVariable nftHL_Error
syn match nft_MissingDeviceVariable "\v[^ \t\$\{]{1,5}" skipwhite contained " do not use 'keepend' here

hi link   nft_MissingCurlyBrace nftHL_Error
syn match nft_MissingCurlyBrace "\v[ \t]\ze[^\{]{1,1}" skipwhite contained " do not use 'keepend' here

hi link   nft_UnexpectedCurlyBrace nftHL_Error
syn match nft_UnexpectedCurlyBrace "\v\s{0,7}\{" contained " do not use 'keepend' here

hi link   nft_UnexpectedEmptyCurlyBraces nftHL_Error
syn match nft_UnexpectedEmptyCurlyBraces "\v\{\s*\}" skipwhite contained " do not use 'keepend' here

hi link   nft_UnexpectedEmptyBrackets nftHL_Error
syn match nft_UnexpectedEmptyBrackets "\v\[\s*\]" skipwhite contained " do not use 'keepend' here

hi link   nft_UnexpectedIdentifierChar nftHL_Error
"syn match nft_UnexpectedIdentifierChar contained "\v[^a-zA-Z0-9\\\/_\.\n]{1,3}" contained
syn match nft_UnexpectedIdentifierChar contained "\v(^[a-zA-Z0-9\\\/_\.\n]{1,3})" contained

" We'll do error RED highlighting on all statement firstly, then later on
" all the options, then all the clauses.
" Uncomment following two lines for RED highlight of typos (still Beta here)
hi link   nft_UnexpectedEOS nftHL_Error
syn match nft_UnexpectedEOS contained "\v[\t ]{0,2}[\#;\n]{1,2}.{0,1}" contained

hi link   nft_Error_Always nftHL_Error
syn match nft_Error_Always /[^(\n|\r)\.]\{1,15}/ skipwhite contained

hi link   nft_Error nftHL_Error
syn match nft_Error /[\s\wa-zA-Z0-9_./]\{1,64}/ skipwhite contained  " uncontained, on purpose

" expected end-of-line (iterator capped for speed)
syn match nft_EOL /[\n\r]\{1,16}/ skipwhite contained

hi link   nft_Semicolon nftHL_Operator
syn match nft_Semicolon contained /\v\s{0,8}[;]{1,15}/  skipwhite contained

hi link   nft_comment_inline nftHL_Comment
syn match nft_comment_inline "\#.*$" skipwhite contained

hi link   nft_identifier_exact nftHL_Identifier
syn match nft_identifier_exact "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_identifier nftHL_Identifier
syn match nft_identifier "\v\w{0,63}" skipwhite contained
\ contains=
\    nft_identifier_exact,
\    nft_Error

hi link   nft_variable_identifier nftHL_Variable
syn match nft_variable_identifier "\v[a-zA-Z][a-zA-Z0-9\/\\/_\.\-]{0,63}" skipwhite contained

" variable_expr (via chain_expr, dev_spec, extended_prio_spec, flowtable_expr,
"                    flowtable_member_expr, policy_expr, queue_expr,
"                    queue_stmt_expr_simple, set_block_expr, set_ref_expr
"                    symbol_expr

" Trickest REGEX of all, how to get wild-cardy 'table identifier' at the beginning of a
" line but without hitting a reserve TOP command (i.e., `add`, `list`, `table`), place this
" `syntax match nft_base_cmd_rule_position_table_spec_wildcard` near the beginning of this file.
" (otherwise, you would have to figure a multi-char Regex of all top-level reserve commands
" coupled with `^` begin of line.)

"
" table_id
" identifier->table_spec->chain_spec->rule_position->add_cmd->base_cmd
hi link   nft_base_cmd_rule_position_table_spec_wildcard nftHL_Identifier
syn match nft_base_cmd_rule_position_table_spec_wildcard "\v^[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec,
\    nft_UnexpectedEOS

" identifier->table_spec->chain_spec->rule_position->add_cmd->'add'->base_cmd
hi link   nft_base_cmd_add_cmd_rule_position_table_spec_wildcard nftHL_Identifier
syn match nft_base_cmd_add_cmd_rule_position_table_spec_wildcard "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec,
\    nft_UnexpectedEOS


hi link   nft_string_unquoted nftHL_String
"syn match nft_string_unquoted "\v[a-zA-Z0-9\/\\\[\]\$]{1,64}" skipwhite keepend contained

hi link   nft_string_sans_double_quote nftHL_String
syn match nft_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link   nft_string_sans_single_quote nftHL_String
syn match nft_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link    nft_string_single nftHL_String
syn region nft_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=
\    nft_string_sans_single_quote

hi link    nft_string_double nftHL_String
syn region nft_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=
\    nft_string_sans_double_quote

syn cluster nft_c_quoted_string
\ contains=
\    nft_string_single,
\    nft_string_double

hi link    nft_asterisk_string nftHL_String
syn region nft_asterisk_string start="\*" skip="\\\*" end="\*" keepend oneline contained
\ contains=
\    nft_string_unquoted

syn cluster nft_c_string
\ contains=
\    nft_asterisk_string,
\    @nft_c_quoted_string,
\    nft_string_unquoted

" nft_identifier_last (via identifer)
hi link  nft_identifier_last nftHL_Command
syn match nft_identifier_last "last" skipwhite contained

" identifier
syn cluster nft_identifier
\ contains=
\    nft_identifier_last,
\    @nft_c_string
" nft_c_string must be the LAST contains= (via nft_unquoted_string)

" 'add' 'table' <table_identifier>
" identifier->table_spec->chain_spec->rule_position->add_cmd
hi link   nft_add_cmd_keyword_rule_rule_position_table_spec_end nftHL_Identifier
syn match nft_add_cmd_keyword_rule_rule_position_table_spec_end "\v\i{1,63}" skipwhite contained
\ nextgroup= nft_add_cmd_rule_position_chain_spec

" nft_add_cmd_keyword_rule_rule_position_table_spec_end must be the first keyword
" of any keyword from the starting column 1

hi link   nft_common_block_stmt_separator Normal
syn match nft_common_block_stmt_separator ";" skipwhite contained
\ nextgroup=
\    nft_comment_inline


"""""""""""""""" NEW WORK BEGINS HERE """""""""""""""""""""""""""""""

source ../scripts/nftables/optstrip_stmt.vim

source ../scripts/nftables/gretap_hdr_expr.vim
source ../scripts/nftables/gre_hdr_expr.vim

source ../scripts/nftables/inner_expr.vim

hi link   nft_payload_base_spec_via_payload_expr_set nftHL_Action
syn match nft_payload_base_spec_via_payload_expr_set "\v(ll|nh|th|string)" skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_comma1_via_payload_expr_set





source ../scripts/nftables/payload_expr.vim

" nft_payload_expr_basic_stmt_expr
hi link    nft_payload_expr_basic_stmt_expr nftHL_BlockDelimiters
syn region nft_payload_expr_basic_stmt_expr start="(" end=")" skipwhite keepend contained
"\ contains=
"\    nft_c_basic_stmt_expr


source ../scripts/nftables/symbol_stmt_expr.vim

source ../scripts/nftables/payload_stmt.vim


source ../scripts/nftables/ct_stmt.vim
source ../scripts/nftables/ct_expr.vim
source ../scripts/nftables/rt_expr.vim
source ../scripts/nftables/hash_expr.vim
source ../scripts/nftables/xfrm_expr.vim
source ../scripts/nftables/numgen_expr.vim
source ../scripts/nftables/socket_expr.vim

source ../scripts/nftables/meta_stmt.vim

source ../scripts/nftables/chain_expr.vim
source ../scripts/nftables/verdict_expr.vim

source ../scripts/nftables/primary_rhs_expr.vim

source ../scripts/nftables/concat_rhs_expr.vim

" '<<'->shift_rhs_expr->(and_rhs_expr|basic_expr)
hi link   nft_shift_rhs_expr_bi_shifts nftHL_Operator
syn match nft_shift_rhs_expr_bi_shifts "\v(<<|>>)" skipwhite contained
\ nextgroup=
\    @nft_c_shift_rhs_expr

" '&'->and_rhs_expr->(basic_expr|exclusive_or_rhs_expr)
hi link   nft_and_rhs_expr_ampersand nftHL_Operator
syn match nft_and_rhs_expr_ampersand "&" skipwhite contained
\ nextgroup=
\    nft_c_and_rhs_expr
" TODO: Unused nft_add_rhs_expr_ampersand

" shift_rhs_expr->(basic_expr|and_rhs_expr)
syn cluster nft_c_shift_rhs_expr
\ contains=
\   nft_primary_rhs_expr

" '~'->exclusive_or_rhs_expr->(concat_rhs_expr|list_rhs_expr|prefix_rhs_expr|primary_rhs_expr|range_rhs_expr|relational_expr)
hi link   nft_exclusive_or_rhs_expr_caret nftHL_Operator
syn match nft_exclusive_or_rhs_expr_caret "\~" skipwhite contained
\ nextgroup=
\    @nft_c_exclusive_or_rhs_expr

" and_rhs_expr->(basic_expr|exclusive_or_rhs_expr)
syn cluster nft_c_and_rhs_expr
\ contains=
\   nft_c_shift_rhs_expr

" '|'->basic_rhs_expr->(concat_rhs_expr|list_rhs_expr|prefix_rhs_expr|primary_rhs_expr|range_rhs_expr|relational_expr)
hi link   nft_basic_rhs_expr_again nftHL_Operator
syn match nft_basic_rhs_expr_again "|" skipwhite contained
\ nextgroup=
\    @nft_c_basic_rhs_expr

" exclusive_or_rhs_expr->(basic_rhs_expr|basic_expr)
syn cluster nft_c_exclusive_or_rhs_expr
\ contains=
\    nft_c_and_rhs_expr

" basic_rhs_expr->(concat_rhs_expr|list_rhs_expr|prefix_rhs_expr|primary_rhs_expr|range_rhs_expr|relational_expr)
syn cluster nft_c_basic_rhs_expr
\ contains=
\    nft_c_exclusive_or_rhs_expr

" boolean_keys->boolean_expr->(primary_rhs_expr|primary_stmt_expr)
hi link   nft_boolean_keys nftHL_Action
syn match nft_boolean_keys "\v(exists|missing)" skipwhite contained

" boolean_expr->(primary_rhs_expr|primary_stmt_expr)
syn cluster nft_c_boolean_expr
\ contains=
\    nft_boolean_keys

syn cluster nft_c_rhs_expr
\ contains=
\    nft_set_expr,
\    nft_set_ref_symbol_expr,
\    @nft_c_concat_rhs_expr
" set_expr starts with '{'
" set_ref_symbol_expr starts with 'at'
" concat_rhs_expr must be the last 'contains=' entry
"     as its symbol->primary_rhs_expr uses <string> (wildcard)


" list_rhs_expr->(initializer_expr|relational_expr)
syn cluster nft_c_list_rhs_expr
\ contains=
\    @nft_c_basic_rhs_expr
" TODO probably duplicate this basic_rhs_expr into a list_rhs_expr-basic_rhs_expr
" so we can add a <',' basic_rhs_expr> iterator

" TODO relational_expr
" relational-expr->match_stmt
syn cluster nft_c_relational_expr
\ contains=
\     @nft_c_expr

source ../scripts/nftables/ct_cmd.vim

source ../scripts/nftables/secmark_config.vim
source ../scripts/nftables/quota_config.vim
source ../scripts/nftables/counter_config.vim


" set_rhs_expr->(concat_rhs_expr|set_list_member_expr)
syn cluster nft_c_set_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr,
\    @nft_c_verdict_expr

source ../scripts/nftables/set_elem_expr.vim
source ../scripts/nftables/meter_key_expr.vim


" set_list_member_expr->set-expr
syn cluster nft_c_set_list_member_expr
\ contains=
\    @nft_c_set_elem_expr,
\    nft_set_expr
" TODO expand on set_rhs_expr->set_list_member_expr->set-expr

" set_expr->(expr|map_stmt_expr_set|rhs_expr|set_block_expr|set_list_member_expr)
" set_expr->set_list_member_expr
hi link    nft_set_expr nftHL_BlockDelimitersSet
syn region nft_set_expr start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_set_list_member_expr

" expr->(hash_expr|relational_expr)
syn cluster nft_c_expr
\ contains=
\    @nft_c_concat_expr,
\    nft_set_expr,
\    @nft_c_map_expr

" concat_expr 'map' rhs_expr
" concat_expr 'map'
" TODO expand 'concat_expr' into map_expr_concat_expr

" concat_expr
" concat_expr->(expr|queue_stmt_expr)
syn cluster nft_c_map_expr
\ contains=
\    @nft_c_map_expr_concat_expr

" (set|verdict)
" prefix_rhs_expr->multiton_rhs-expr->concat_rhs_expr->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr_TODO

" (set|verdict)
" prefix_rhs_expr->multiton_rhs-expr->concat_rhs_expr->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_multiton_rhs_expr_prefix_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr

" (set|verdict)
" concat_rhs_expr multiton_rhs_expr range_rhs_expr
" range_rhs_expr->multiton_rhs-expr->concat_rhs_expr->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_multiton_rhs_expr_range_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_range_rhs_expr_TODO

" (set|verdict)
" concat_rhs_expr multiton_rhs_expr
" multiton_rhs-expr->concat_rhs_expr->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_multiton_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_prefix_rhs_expr,
\    @nft_c_multiton_rhs_expr_range_rhs_expr

" (set|verdict)
" concat_expr basic_expr
" concat_expr->(expr|map_expr|meter_key_expr_alloc|set_elem_expr_stmt_alloc|verdict_map_stmt)
syn cluster nft_c_concat_expr
\ contains=
\    @nft_c_basic_expr

syn cluster nft_c_basic_expr
\ contains=
\    @nft_c_primary_expr

" 'osf' 'ttl' <string> ('version'|'name')
" osf_ttl->osf_expr->(primary_expr|primary_stmt_expr)
hi link   nft_osf_expr_hdrversion_or_name nftHL_String
syn match nft_osf_expr_hdrversion_or_name "\v(version|name)" skipwhite contained

" 'osf' 'ttl' <string>
" osf_ttl->osf_expr->(primary_expr|primary_stmt_expr)
hi link   nft_osf_expr_osf_ttl_string nftHL_String
syn match nft_osf_expr_osf_ttl_string "\v[\w\s]{1,63}" skipwhite contained
\ nextgroup=
\    nft_osp_expr_hdrversion_or_name

" 'osf' 'ttl'
" osf_ttl->osf_expr->(primary_expr|primary_stmt_expr)
hi link   nft_osf_expr_osf_ttl nftHL_Statement
syn match nft_osf_expr_osf_ttl "ttl" skipwhite contained
\ nextgroup=
\    nft_osf_expr_osf_ttl_string

" 'osf'
" osf_expr->(primary_expr|primary_stmt_expr)
hi link   nft_osf_expr nftHL_Command
syn match nft_osf_expr "osf" skipwhite contained
\ nextgroup=
\    nft_osf_expr_osf_ttl

" fib_result->fib_expr->primary_expr
" (oif|oifname|type)
hi link   nft_fib_result nftHL_Action
syn match nft_fib_result "\v(oif|oifname|type)" skipwhite contained

hi link   nft_fib_flag_comma nftHL_Expression
syn match nft_fib_flag_comma /,/ skipwhite contained
\ nextgroup=
\    @nft_c_fib_flag

" fib_flag->fib_expr->primary_expr
" (saddr|daddr|mark|iif|oif)
hi link   nft_fib_flag nftHL_Action
syn match nft_fib_flag "\v(saddr|daddr|mark|iif|oif)" skipwhite contained
\ nextgroup=
\    nft_fib_flag_comma,
\    nft_fib_result

syn cluster nft_c_fib_flag
\ contains=
\    nft_fib_flag

" fib_expr->primary_expr
" 'fib' fib_flag [ '.' fib_flag ]* fib_result
hi link   nft_fib_expr nftHL_Action
syn match nft_fib_expr "fib" skipwhite contained
\ nextgroup=
\    @nft_c_fib_flag

" primary_expr (via primary_stmt, primary_expr, primary_stmt_expr)
syn cluster nft_c_primary_expr
\ contains=
\    nft_integer_expr,
\    @nft_c_payload_expr_via_primary_expr,
\    @nft_c_exthdr_expr,
\    @nft_c_meta_expr,
\    nft_exthdr_exists_expr,
\    nft_ct_expr,
\    nft_rt_expr,
\    @nft_c_hash_expr,
\    @nft_c_basic_expr,
\    @nft_c_symbol_expr
" nft_c_symbol_expr must be the LAST contains= (via nft_unquoted_string)
"\    nft_socket_expr,
"\    nft_numgen_expr,
"\    nft_fib_expr,
"\    nft_osf_expr,
"\    nft_xfrm_expr,

hi link   nft_integer_expr nftHL_Number
syn match nft_integer_expr "\v\d{1,11}" skipwhite contained

hi link   nft_set_ref_symbol_expr_identifier nftHL_Identifier
syn match nft_set_ref_symbol_expr_identifier "\v[a-zA-Z_][a-zA-Z0-9\\\/_\.\-]{0,31}" skipwhite contained

" set_ref_symbol_expr->(rhs_expr|set_ref_expr)
hi link   nft_set_ref_symbol_expr nftHL_Statement
syn match nft_set_ref_symbol_expr "at" skipwhite contained
\ nextgroup=
\    nft_set_ref_symbol_expr_identifier,
\    nft_UnexpectedEOS

" set_ref_expr->(map_stmt|map_stmt_expr_set|set_stmt|verdict_map_)"
syn cluster nft_c_set_ref_expr
\ contains=
\    nft_set_ref_symbol_expr,
\    nft_variable_expr

" symbol_expr (via primary_expr, primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn cluster nft_c_symbol_expr
\ contains=
\    nft_variable_expr,
\    @nft_c_string
""" nft_c_string must be the LAST contains= (via nft_unquoted_string)

hi link   nft_variable_expr nft_Variable
syn match nft_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained

" match_stmt->stmt
syn cluster nft_c_match_stmt
\ contains=
\    nft_c_relational_expr

source ../scripts/nftables/meter_stmt.vim
source ../scripts/nftables/map_stmt.vim
source ../scripts/nftables/set_stmt.vim
source ../scripts/nftables/queue_stmt.vim

source ../scripts/nftables/nf_nat_flags.vim

source ../scripts/nftables/fwd_stmt.vim
source ../scripts/nftables/dup_stmt.vim
source ../scripts/nftables/redir_stmt.vim
source ../scripts/nftables/masq_stmt.vim

" stmt_expr (via ct_stmt, dup_stmt, fwd_stmt, masq_stmt_args, meta_stmt, nat_stmt,
"                objref_stmt_counter, objref_stmt_ct, objref_stmt_limit, objref_stmt_quota,
"                objref_stmt_synproxy, payload_stmt, redir_stmt_arg, tproxy_stmt)
syn cluster nft_c_stmt_expr
\ contains=
\    @nft_c_symbol_stmt_expr,
\    @nft_c_multiton_stmt_expr,
\    @nft_c_map_stmt_expr

" multiton_stmt_expr->stmt_expr
syn cluster nft_c_multiton_stmt_expr
\ contains=
\    nft_c_prefix_stmt_expr,
\    nft_c_range_stmt_expr,

" range_stmt_expr->multiton_stmt_expr->stmt_expr
syn cluster nft_c_range_stmt_expr
\ contains=
\    nft_c_basic_stmt_expr

" prefix_stmt_expr->multiton_stmt_expr->stmt_expr
syn cluster nft_c_prefix_stmt_expr
\ contains=
\    nft_c_basic_stmt_expr

source ../scripts/nftables/map_stmt_expr_set.vim

" concat_stmt_expr
syn cluster nft_c_concat_stmt_expr
\ contains=
\    @nft_c_basic_stmt_expr

" basic_stmt_expr->(concat_stmt_expr|prefix_stmt_expr|primary_stmt_expr|range_stmt_expr)

" exclusive_or_stmt_expr->basic_stmt_expr

" and_stmt_expr-> exclusive_or_stmt_expr->basic_stmt_expr

" shift_stmt_expr->and_stmt_expr-> exclusive_or_stmt_expr->basic_stmt_expr

" primary_stmt_expr '{' basic_stmt_expr '}'
" '{'->primary_stmt_expr->shift_stmt_expr->and_stmt_expr-> exclusive_or_stmt_expr->basic_stmt_expr
hi link    nft_primary_stmt_expr_block_delimiters nftHL_BlockDelimiters
syn region nft_primary_stmt_expr_block_delimiters start="{" end="}" skipwhite contained


source ../scripts/nftables/synproxy_stmt.vim
source ../scripts/nftables/tproxy_stmt.vim
source ../scripts/nftables/nat_stmt.vim
source ../scripts/nftables/reject_stmt.vim
source ../scripts/nftables/limit_burst_bytes.vim
source ../scripts/nftables/limit_burst_pkts.vim
source ../scripts/nftables/limit_rate_bytes.vim
source ../scripts/nftables/limit_rate_pkts.vim
source ../scripts/nftables/quota_stmt.vim
source ../scripts/nftables/limit_config.vim
source ../scripts/nftables/limit_stmt.vim
source ../scripts/nftables/log_stmt.vim
source ../scripts/nftables/counter_stmt.vim
source ../scripts/nftables/connlimit_stmt.vim
source ../scripts/nftables/verdict_stmt.vim
source ../scripts/nftables/chain_stmt.vim
source ../scripts/nftables/xt_stmt.vim
source ../scripts/nftables/stmt.vim
source ../scripts/nftables/stateful_stmt.vim
source ../scripts/nftables/objref_stmt.vim


syn cluster nft_c_base_cmd_list_cmd_basehook_spec_ruleset_spec
\ contains=
\    nft_base_cmd_list_rule_cmd_keyword_ruleset_spec_family_spec,
\    nft_base_cmd_list_rule_ruleset_spec_id_table
" TODO: undefined nft_base_cmd_list_rule_cmd_keyword_ruleset_spec_family_spec
" TODO: undefined nft_base_cmd_list_rule_ruleset_spec_id_table


" add_cmd 'table' table_block table_options comment_spec 'comment' string UNQUOTED_STRING
hi link   nft_add_cmd_keyword_table_table_options_comment_spec_string_unquoted nftHL_String
syn match nft_add_cmd_keyword_table_table_options_comment_spec_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]]{0,63}" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

hi link    nft_add_cmd_keyword_table_table_options_comment_spec_string_single nftHL_String
syn region nft_add_cmd_keyword_table_table_options_comment_spec_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_double_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_cmd_keyword_table_table_options_comment_spec_string_double nftHL_String
syn region nft_add_cmd_keyword_table_table_options_comment_spec_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_single_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_asterisk_quote nftHL_String
syn match nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_asterisk_quote "\v[\'\"\sa-zA-Z0-9\/\\\[\]\']+" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string <ASTERISK_STRING>
hi link    nft_add_cmd_keyword_table_table_options_comment_spec_string_asterisked nftHL_String
syn region nft_add_cmd_keyword_table_table_options_comment_spec_string_asterisked start="\*" skip="\\\*" end="\*" excludenl skipnl skipempty skipwhite keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_sans_asterisk_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string
syn cluster nft_c_add_cmd_keyword_table_table_block_table_options_comment_spec_string
\ contains=
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_asterisked,
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_single,
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_double,
\    nft_add_cmd_keyword_table_table_options_comment_spec_string_unquoted

" add_cmd 'table' table_block table_options comment_spec 'comment'
hi link   nft_add_cmd_keyword_table_table_options_comment_spec nftHL_Statement
syn match nft_add_cmd_keyword_table_table_options_comment_spec "comment" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_table_options_comment_spec_string

" ruleid_spec
" delete_cmd ruleid_spec end
" destroy_cmd ruleid_spec end
" reset_cmd ruleid_spec end
" replace_cmd ruleid_spec rule end   # note the sole 'rule' run-on syntax?

" base_cmd ('delete'|'destroy'|'reset') [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_id nftHL_Handle
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_id "\v[0-9]{1,9}" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" base_cmd ('delete'|'destroy'|'reset') [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_spec nftHL_Action
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_spec "\v(position|index|handle)\s" skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd ('delete'|'destroy'|'reset') [ family_spec ] table_identifier chain_identifier
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_chain_id nftHL_Chain
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_spec,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd ('delete'|'destroy'|'reset') [ family_spec ] table_identifier
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id nftHL_Table
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_chain_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon

" base_cmd ('delete'|'destroy'|'reset') family_spec
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_family_spec_family nftHL_Family
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_family_spec_family "\v(ip6?|ip|inet|bridge|netdev|arp)\ze " skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon

" base_cmd ('delete'|'destroy'|'reset')
hi link   nft_base_cmd_delete_destroy_reset_cmd_keyword_rule nftHL_Statement
syn match nft_base_cmd_delete_destroy_reset_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_family_spec_family,
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon

" [[ 'add' ] 'rule' ] [ family_spec ] table_id chain_id handle_id handle_idx
" [[ 'add' ] 'rule' table_id chain_id ('position'|'handle'|'index') handle_idx
" 'insert' 'rule' [ family_spec ] table_id chain_id handle_id handle_idx
" base_cmd insert_cmd rule_position
" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec position_spec_num
hi link   nft_add_cmd_rule_position_chain_spec_position_spec_num nftHL_Number
syn match nft_add_cmd_rule_position_chain_spec_position_spec_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_rule_rule


" [[ 'add' ] 'rule' table_id chain_id ('position'|'handle'|'index')
" identifier->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_keywords_position_handle_index  nftHL_Command
syn match nft_add_cmd_rule_position_keywords_position_handle_index skipwhite contained
\ "\v(position|handle|index)"
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec_position_spec_num

" [[ 'add' ] 'rule' [ 'ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp' ] table_id chain_id
" identifier->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_chain_spec nftHL_Chain
syn match nft_add_cmd_rule_position_chain_spec "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_rule_rule,
\    nft_add_cmd_rule_position_keywords_position_handle_index
" FIXIT (needs loop within nft_c_add_cmd_rule_rule

" [[ 'add' ] 'rule' [ 'ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp' ] table_id
" base_cmd add_cmd [[ 'add' ] 'rule' ] table_spec
" identifier->table_spec->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_table_spec nftHL_Table
syn match nft_add_cmd_rule_position_table_spec "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec,
\    nft_UnexpectedEOS

" [[ 'add' ] 'rule' ( 'ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp' )
" family_spec_explicit->family_spec->table_spec->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_family_spec_explicit nftHL_Family
syn match nft_add_cmd_rule_position_family_spec_explicit "\v(ip[6]?|arp|inet|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" [[ 'add' ] 'rule' ] rule_position
" rule_position->'rule'->insert_cmd->'insert'->base_cmd
syn cluster nft_c_add_cmd_rule_position
\ contains=
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_add_cmd_rule_position_table_spec

" obj_identifier->'counter'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_counter_obj_identifier
" obj_identifier->'quota'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_quota_obj_identifier
" obj_identifier->'ct helper'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_ct_keyword_helper_obj_identifier
" obj_identifier->'ct timeout'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_ct_keyword_timeout_obj_identifier
" obj_identifier->'ct expectation'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_ct_keyword_expectation_obj_identifier
" obj_identifier->'limit'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_limit_obj_identifier
" obj_identifier->'secmark'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_secmark_obj_identifier
" obj_identifier->'synproxy'->table_block->(add_cmd|create_cmd)
"      nft_add_create_cmd_table_block_keyword_synproxy_obj_identifier

" objid_spec->obj_or_id_spec->'counter'->(delete_cmd|destroy_cmd)
"      nft_delete_destroy_cmd_keyword_counter_obj_or_id_spec_objid_spec
" objid_spec->obj_or_id_spec->'quota'->(delete_cmd|destroy_cmd)
"      nft_delete_destroy_cmd_keyword_quota_obj_or_id_spec_objid_spec
" objid_spec->obj_or_id_spec->'limit'->(delete_cmd|destroy_cmd)
"      nft_delete_destroy_cmd_keyword_Limit_obj_or_id_spec_objid_spec
" objid_spec->obj_or_id_spec->'secmark'->(delete_cmd|destroy_cmd)
"      nft_delete_destroy_cmd_keyword_secmark_obj_or_id_spec_objid_spec
" objid_spec->obj_or_id_spec->'synproxy'->(delete_cmd|destroy_cmd)
"      nft_delete_destroy_cmd_keyword_synproxy_obj_or_id_spec_objid_spec

" obj_spec->'counter'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_counter_obj_spec
" obj_spec->'counter'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_counter_obj_spec
" obj_spec->'counter'->reset_cmd->base_cmd->line
"    nft_reset_cmd_keyword_counter_obj_spec
" obj_spec->'counter'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_counter_obj_spec
" obj_spec->'quota'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_quota_obj_spec
" obj_spec->'quota'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_quota_obj_spec
" obj_spec->'quota'->reset_cmd->base_cmd->line
"    nft_reset_cmd_keyword_quota_obj_spec
" obj_spec->'quota'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_quota_obj_spec
" obj_spec->'ct helper'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_ct_keyword_helper_obj_spec
" obj_spec->'ct helper'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_ct_keyword_helper_obj_spec
" obj_spec->'ct helper'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_ct_keyword_helper_obj_spec
" obj_spec->'ct timeout'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_ct_keyword_timeout_obj_spec
" obj_spec->'ct timeout'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_ct_keyword_timeout_obj_spec
" obj_spec->'ct timeout'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_ct_keyword_timeout_obj_spec
" obj_spec->'ct expectation'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_ct_keyword_expectation_obj_spec
" obj_spec->'ct expectation'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_ct_keyword_expectation_obj_spec
" obj_spec->'ct expectation'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_ct_keyword_expectation_obj_spec
" obj_spec->'limit'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_limit_obj_spec
" obj_spec->'limit'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_limit_obj_spec
" obj_spec->'limit'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_limit_obj_spec
" obj_spec->'secmark'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_secmark_obj_spec
" obj_spec->'secmark'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_secmark_obj_spec
" obj_spec->'secmark'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_secmark_obj_spec
" obj_spec->'synproxy'->add_cmd->base_cmd->line
"    nft_add_cmd_keyword_synproxy_obj_spec
" obj_spec->'synproxy'->create_cmd->base_cmd->line
"    nft_create_cmd_keyword_synproxy_obj_spec
" obj_spec->'synproxy'->list_cmd->base_cmd->line
"    nft_list_cmd_keyword_synproxy_obj_spec

" flowtableid_spec->'flowtable'->destroy_cmd->'destroy'->base_cmd->line
" flowtableid_spec->'flowtable'->delete_cmd->'delete'->base_cmd->line
syn cluster nft_c_delete_destroy_cmd_flowtableid_spec
\ contains=
\   nft_delete_destroy_cmd_flowtableid_spec_table_spec

" flowtable_spec->'flowtable'->(add_cmd|create_cmd)->'add'->base_cmd->line
syn cluster nft_c_add_create_cmd_flowtable_spec
\ contains=
\   nft_add_cmd_create_flowtable_spec_table_spec
" TODO undefined nft_add_cmd_create_flowtable_spec_table_spec

" flowtable_spec->'flowtable'->(delete_cmd|destroy_cmd)->'delete'->base_cmd->line
syn cluster nft_c_delete_destroy_cmd_flowtable_spec
\ contains=
\   nft_delete_destroy_cmd_flowtable_spec_table_spec

" flowtable_spec->'flowtable'->list_cmd->'list'->base_cmd->line
syn cluster nft_c_list_cmd_flowtable_spec
\ contains=
\   nft_list_cmd_flowtable_spec_table_spec

" [ [ 'add' ] 'table' ] table_id '{' 'set' 'last'
" 'last'->'set'->table_block->add_cmd->base_cmd->line
hi link   nft_table_block_keyword_set_set_keyword_last nftHL_Action
syn match nft_table_block_keyword_set_set_keyword_last "last" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'set' <STRING>
" set_identifier->'set'->table_block->add_cmd->base_cmd->line
hi link   nft_table_block_keyword_set_set_identifier nftHL_Set
syn match nft_table_block_keyword_set_set_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'set' set_identifier
" set_identifier->'set'->table_block->add_cmd->base_cmd->line
hi link   nft_c_table_block_keyword_set_set_identifier nftHL_Set
syn cluster nft_c_table_block_keyword_set_set_identifier
\ contains=
\    nft_table_block_keyword_set_keyword_last,
\    nft_table_block_keyword_set_identifier

" [ [ 'add' ] 'table' ] table_id '{' 'map' 'last'
" 'last'->'map'->table_block->add_cmd->base_cmd->line
hi link   nft_table_block_keyword_map_set_keyword_last nftHL_Action
syn match nft_table_block_keyword_map_set_keyword_last "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'map' <STRING>
" <STRING>->set_identifier->'map'->table_block->add_cmd->base_cmd->line
hi link   nft_table_block_keyword_map_set_identifier nftHL_Set
syn match nft_table_block_keyword_map_set_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'map' set_identifier
" set_identifier->'map'->table_block->add_cmd->base_cmd->line
syn cluster nft_c_table_block_keyword_map_set_identifier
\ contains=
\    nft_table_block_keyword_map_set_keyword_last,
\    nft_table_block_keyword_map_set_identifier




" set_spec 'set' ('add'|'clean')
" set_spec 'map' ('add'|'clean')
" set_spec 'element' ('add'|'clean')
" set_spec 'map' ('delete'|'destroy')
" set_spec 'element' ('delete'|'destroy')
" set_spec ('set'|'map'|'flow table'|'meter') 'flush'
" set_spec 'element' 'get'
" set_spec ('set'|'meter'|'map') 'list'
" set_spec 'element' 'reset'
" set_spec set_or_id_spec 'set' ('delete'|'destroy')
" set_spec set_or_id_spec ('set'|'map') 'reset'

" (string|'last') chain_identifier table_block

" chain_or_id_spec 'chain' 'delete'
" chain_or_id_spec 'chain' 'destroy'

" table_or_id_spec 'table' ('delete'|'destroy')

" insert_cmd 'insert' base_cmd line

" create_cmd 'create' base_cmd line

" replace_cmd 'replace' base_cmd line
source ../scripts/nftables/base_cmd_undefine_cmd.vim
source ../scripts/nftables/base_cmd_add_limit_cmd.vim
source ../scripts/nftables/base_cmd_add_counter_cmd.vim
source ../scripts/nftables/base_cmd_add_chain_spec.vim
source ../scripts/nftables/base_cmd_add_table_spec.vim
source ../scripts/nftables/base_cmd_add_set_cmd.vim
source ../scripts/nftables/base_cmd_add_map_cmd.vim
source ../scripts/nftables/base_cmd_add_flowtable_cmd.vim
source ../scripts/nftables/base_cmd_add_rule_cmd.vim
source ../scripts/nftables/base_cmd_add_cmd.vim
source ../scripts/nftables/base_cmd_replace_cmd.vim
source ../scripts/nftables/base_cmd_create_cmd.vim
source ../scripts/nftables/base_cmd_insert_cmd.vim
source ../scripts/nftables/base_cmd_delete_cmd.vim
source ../scripts/nftables/base_cmd_get_cmd.vim
source ../scripts/nftables/base_cmd_list_cmd.vim
source ../scripts/nftables/base_cmd_reset_cmd.vim
source ../scripts/nftables/base_cmd_flush_cmd.vim
source ../scripts/nftables/base_cmd_rename_cmd.vim
source ../scripts/nftables/base_cmd_import_cmd.vim
source ../scripts/nftables/base_cmd_export_cmd.vim
source ../scripts/nftables/base_cmd_monitor_cmd.vim
source ../scripts/nftables/base_cmd_describe_cmd.vim
source ../scripts/nftables/base_cmd_destroy_cmd.vim
source ../scripts/nftables/base_cmd_add_ct_cmd.vim
source ../scripts/nftables/base_cmd_ct_cmd.vim

source ../scripts/nftables/base_cmd.vim

""""""""""" base_cmd END """""""""""""""""""""""""""""""""""""""""""""""""

hi link   nft_comment_whole_line nftHL_Comment
syn match nft_comment_whole_line "#.*$" keepend contained
" do not use ^ regex, reserved to nft_line

hi link   nft_line_stmt_separator nftHL_Expression
syn match nft_line_stmt_separator  "\v[;\n]{1,16}" skipwhite contained

"""""""""""""""" TOP-LEVEL SYNTAXES """"""""""""""""""""""""""""
" `line` main top-level syntax, do not add 'contained' here.
" `line` is the only syntax match/region line without a 'contained' attribute
hi link   nft_line Normal
syn match nft_line "\v\s{0,16}"
\ nextgroup=
\    nft_comment_whole_line,
\    @nft_c_common_block,
\    @nft_c_base_cmd,
\    nft_line_stmt_separator

source ../scripts/nftables/common_block.vim

" opt_newline (via flowtable_expr, set_expr, set_list_member_expr, verdict_map_expr,
"                  verdict_map_list_member_exp)
syn match nft_opt_newline "\v[\n]*" skipwhite contained

hi Normal guibg=NONE ctermbg=NONE

"""""""""""""""""""""" END OF SYNTAX """"""""""""""""""""""""""""

if version >= 508 || !exists("did_nftables_syn_inits")
  delcommand HiLink
endif

let b:current_syntax = 'nftables'

let &cpoptions = s:cpo_save
unlet s:cpo_save

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" syntax_on is passed only inside Vim's shell command for 2nd Vim to observe current syntax scenarios
let g:syntax_on = 1

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

