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

hi def link nftHL_BlockDelimitersTable  Delimiter
hi def link nftHL_BlockDelimitersChain  Delimiter
hi def link nftHL_BlockDelimitersSet    Delimiter
hi def link nftHL_BlockDelimitersMap    Delimiter
hi def link nftHL_BlockDelimitersFlowTable    Delimiter
hi def link nftHL_BlockDelimitersCounter Delimiter
hi def link nftHL_BlockDelimitersQuota  Delimiter
hi def link nftHL_BlockDelimitersCT     Delimiter
hi def link nftHL_BlockDelimitersLimit  Delimiter
hi def link nftHL_BlockDelimitersSecMark Delimiter
hi def link nftHL_BlockDelimitersSynProxy Delimiter
hi def link nftHL_BlockDelimitersMeter  Delimiter
hi def link nftHL_BlockDelimitersDevices Delimiter

if exists('g:nft_colorscheme')
hi nftHL_BlockDelimitersTable  ctermfg=LightRed ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersChain  ctermfg=LightGreen ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersSet  ctermfg=LightBlue ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersMap  ctermfg=LightCyan ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersFlowTable  ctermfg=LightMagenta ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersCounter  ctermfg=LightYellow ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersQuota  ctermfg=DarkGrey ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersCT  ctermfg=Red ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersLimit  ctermfg=Red ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersSecMark  ctermfg=Red ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersSynProxy  ctermfg=Red ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersMeter  ctermfg=Red ctermbg=Black cterm=NONE
hi nftHL_BlockDelimitersDevices  ctermfg=Blue ctermbg=Black cterm=NONE
endif

""""""""""
hi link nft_ToDo nftHL_ToDo
syn keyword nft_ToDo xxx contained XXX FIXME TODO TODO: FIXME: TBS TBD TBA
\ containedby=nft_InlineComment

hi link nft_InlineComment nftHL_Comment
syn match nft_InlineComment "\v\# " skipwhite contained

hi link nft_EOS nftHL_Error
syn match nft_EOS /\v[^ \t]{1,6}[\n\r\#]{1,3}/ skipempty skipnl skipwhite contained

hi link nft_UnexpectedSemicolon nftHL_Error
syn match nft_UnexpectedSemicolon "\v;{1,7}" contained

" stmt_separator (via nft_chain_block, nft_chain_stmt, @nft_c_common_block,
"                     counter_block, ct_expect_block, ct_expect_config,
"                     ct_helper_block, ct_helper_config, ct_timeout_block,
"                     ct_timeout_config, flowtable_block, limit_block,
"                     nft_line, nft_map_block, nft_quota_block,
"                     nft_secmark_block, nft_set_block, nft_synproxy_block,
"                     nft_synproxy_config, table_block )
hi link nft_stmt_separator nftHL_Normal
syn match nft_stmt_separator "\v(\n|;)" skipwhite contained

hi link nft_hash_comment nftHL_Comment
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

hi link nft_UnexpectedEmptyCurlyBraces nftHL_Error
syn match nft_UnexpectedEmptyCurlyBraces "\v\{\s*\}" skipwhite contained " do not use 'keepend' here

hi link nft_UnexpectedEmptyBrackets nftHL_Error
syn match nft_UnexpectedEmptyBrackets "\v\[\s*\]" skipwhite contained " do not use 'keepend' here

hi link nft_UnexpectedIdentifierChar nftHL_Error
"syn match nft_UnexpectedIdentifierChar contained "\v[^a-zA-Z0-9\\\/_\.\n]{1,3}" contained
syn match nft_UnexpectedIdentifierChar contained "\v(^[a-zA-Z0-9\\\/_\.\n]{1,3})" contained

" We'll do error RED highlighting on all statement firstly, then later on
" all the options, then all the clauses.
" Uncomment following two lines for RED highlight of typos (still Beta here)
hi link nft_UnexpectedEOS nftHL_Error
syn match nft_UnexpectedEOS contained "\v[\t ]{0,2}[\#;\n]{1,2}.{0,1}" contained

hi link nft_Error_Always nftHL_Error
syn match nft_Error_Always /[^(\n|\r)\.]\{1,15}/ skipwhite contained

hi link nft_Error nftHL_Error
syn match nft_Error /[\s\wa-zA-Z0-9_./]\{1,64}/ skipwhite contained  " uncontained, on purpose

" expected end-of-line (iterator capped for speed)
syn match nft_EOL /[\n\r]\{1,16}/ skipwhite contained

hi link nft_Semicolon nftHL_Normal
syn match nft_Semicolon contained /\v\s{0,8}[;]{1,15}/  skipwhite contained

hi link nft_comment_inline nftHL_Comment
syn match nft_comment_inline "\#.*$" skipwhite contained

hi link nft_identifier_exact nftHL_Identifier
syn match nft_identifier_exact "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link nft_identifier nftHL_Identifier
syn match nft_identifier "\v\w{0,63}" skipwhite contained
\ contains=
\    nft_identifier_exact,
\    nft_Error

hi link nft_variable_identifier nftHL_Variable
syn match nft_variable_identifier "\v[a-zA-Z][a-zA-Z0-9\/\\/_\.]{0,63}" skipwhite contained

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
syn match nft_base_cmd_rule_position_table_spec_wildcard "\v^[A-Za-z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec,
\    nft_UnexpectedEOS

" identifier->table_spec->chain_spec->rule_position->add_cmd->'add'->base_cmd
hi link   nft_base_cmd_add_cmd_rule_position_table_spec_wildcard nftHL_Identifier
syn match nft_base_cmd_add_cmd_rule_position_table_spec_wildcard "\v[A-Za-z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec,
\    nft_UnexpectedEOS


hi link nft_string_unquoted nftHL_String
"syn match nft_string_unquoted "\v[a-zA-Z0-9\/\\\[\]\$]{1,64}" skipwhite keepend contained

hi link nft_string_sans_double_quote nftHL_String
syn match nft_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link nft_string_sans_single_quote nftHL_String
syn match nft_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link    nft_string_single nftHL_String
syn region nft_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=nft_string_sans_single_quote

hi link    nft_string_double nftHL_String
syn region nft_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=nft_string_sans_double_quote

syn cluster nft_c_quoted_string
\ contains=
\    nft_string_single,
\    nft_string_double

hi link    nft_asterisk_string nftHL_String
syn region nft_asterisk_string start="\*" skip="\\\*" end="\*" keepend oneline contained
\ contains=nft_string_unquoted

hi link nft_c_string nftHL_String
syn cluster nft_c_string
\ contains=
\    nft_asterisk_string,
\    @nft_c_quoted_string,
\    nft_string_unquoted

" nft_identifier_last (via identifer)
hi link  nft_identifier_last nftHL_Command
syn match nft_identifier_last "\vlast" skipwhite contained

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
"  All fields are in output order of bgnault's Railroad

" exthdr_key
hi link nft_exthdr_key_hbh nftHL_Action
syn match nft_exthdr_key_hbh "hbh" contained skipwhite

hi link nft_exthdr_key_rt nftHL_Action
syn match nft_exthdr_key_rt "rt" contained skipwhite

hi link nft_exthdr_key_frag nftHL_Action
syn match nft_exthdr_key_frag "frag" contained skipwhite

hi link nft_exthdr_key_dst nftHL_Action
syn match nft_exthdr_key_dst "dst" contained skipwhite

hi link nft_exthdr_key_mh nftHL_Action
syn match nft_exthdr_key_mh "mh" contained skipwhite

hi link nft_exthdr_key_ah nftHL_Action
syn match nft_exthdr_key_ah "ah" contained skipwhite

syn cluster nft_c_exthdr_key
\ contains=
\    nft_exthdr_key_hbh,
\    nft_exthdr_key_rt,
\    nft_exthdr_key_frag,
\    nft_exthdr_key_dst,
\    nft_exthdr_key_mh,
\    nft_exthdr_key_ah

" exthdr_exists_expr (via nft_c_primary_expr)
hi link nft_exthdr_exists_expr nftHL_Statement
syn match nft_exthdr_exists_expr "\vexthdr" skipwhite contained
\ nextgroup=@nft_c_exthdr_key


" mh_hdr_field
hi link nft_mh_hdr_field_nexthdr nftHL_Action
syn match nft_mh_hdr_field_nexthdr "\vnexthdr" contained skipwhite

hi link nft_mh_hdr_field_hdrlength nftHL_Action
syn match nft_mh_hdr_field_hdrlength "\vhdrlength" contained skipwhite

hi link nft_mh_hdr_field_type nftHL_Action
syn match nft_mh_hdr_field_type "\vtype" contained skipwhite

hi link nft_mh_hdr_field_reserved nftHL_Action
syn match nft_mh_hdr_field_reserved "\vreserved" contained skipwhite

hi link nft_mh_hdr_field_checksum nftHL_Action
syn match nft_mh_hdr_field_checksum "\vchecksum" contained skipwhite

syn cluster nft_c_mh_hdr_field
\ contains=
\    nft_mh_hdr_field_nexthdr,
\    nft_mh_hdr_field_hdrlength,
\    nft_mh_hdr_field_type,
\    nft_mh_hdr_field_reserved,
\    nft_mh_hdr_field_checksum,

" mh_hdr_expr
hi link nft_mh_hdr_expr nftHL_Statement
syn match nft_mh_hdr_expr "\vmh" skipwhite contained
\ nextgroup=@nft_c_mh_hdr_field


" dst_hdr_field
hi link nft_dst_hdr_field_nexthdr nftHL_Action
syn match nft_dst_hdr_field_nexthdr "\vnexthdr" contained skipwhite

hi link nft_dst_hdr_field_hdrlength nftHL_Action
syn match nft_dst_hdr_field_hdrlength "\vhdrlength" contained skipwhite

syn cluster nft_c_dst_hdr_field
\ contains=
\    nft_dst_hdr_field_nexthdr,
\    nft_dst_hdr_field_hdrlength

hi link nft_dst_hdr_expr nftHL_Statement
syn match nft_dst_hdr_expr "\vdst" skipwhite contained
\ nextgroup=@nft_c_dst_hdr_field


" frag_hdr_field
hi link nft_frag_hdr_field_nexthdr nftHL_Action
syn match nft_frag_hdr_field_nexthdr "\vnexthdr" skipwhite contained

hi link nft_frag_hdr_field_reserved nftHL_Action
syn match nft_frag_hdr_field_reserved "\vreserved" skipwhite contained

hi link nft_frag_hdr_field_frag_off nftHL_Action
syn match nft_frag_hdr_field_frag_off "\vfrag\\-off" skipwhite contained

hi link nft_frag_hdr_field_reserved2 nftHL_Action
syn match nft_frag_hdr_field_reserved2 "\vreserved2" skipwhite contained

hi link nft_frag_hdr_field_more_fragments nftHL_Action
syn match nft_frag_hdr_field_more_fragments "\vmore\-fragments" skipwhite contained

hi link nft_frag_hdr_field_id nftHL_Action
syn match nft_frag_hdr_field_id "\vid" skipwhite contained
syn cluster nft_c_frag_hdr_field
\ contains=
\    nft_frag_hdr_field_nexthdr,
\    nft_frag_hdr_field_reserved,
\    nft_frag_hdr_field_frag_off,
\    nft_frag_hdr_field_reserved2,
\    nft_frag_hdr_field_more_fragments,
\    nft_frag_hdr_field_id

" frag_hdr_expr
hi link nft_frag_hdr_expr nftHL_Statement
syn match nft_frag_hdr_expr "\vfrag" skipwhite contained
\ nextgroup=@nft_c_frag_hdr_field


" rt4_hdr_field
hi link nft_rt4_hdr_field_last_ent nftHL_Action
syn match nft_rt4_hdr_field_last_ent "\vlast\-entry" contained skipwhite

hi link nft_rt4_hdr_field_flags nftHL_Action
syn match nft_rt4_hdr_field_flags "\vflags" contained skipwhite

hi link nft_rt4_hdr_field_tag nftHL_Action
syn match nft_rt4_hdr_field_tag "\vtag" contained skipwhite

hi link nft_rt4_hdr_field_sid_num nftHL_Action
syn match nft_rt4_hdr_field_sid_num "\v[0-9]+" contained skipwhite

hi link nft_rt4_hdr_field_sid_num_block nftHL_Command
syn match nft_rt4_hdr_field_sid_num_block "\v\[\s*\d\s*\]" contained

hi link nft_rt4_hdr_field_sid nftHL_Action
syn match nft_rt4_hdr_field_sid "\vsid" contained skipwhite
\ nextgroup=nft_rt4_hdr_field_sid_num_block

syn cluster nft_c_rt4_hdr_field
\ contains=
\    nft_rt4_hdr_field_last_ent,
\    nft_rt4_hdr_field_flags,
\    nft_rt4_hdr_field_tag,
\    nft_rt4_hdr_field_sid

" rt4_hdr_expr (via exthdr_expr)
hi link nft_rt4_hdr_expr nftHL_Statement
syn match nft_rt4_hdr_expr "rt4" skipwhite contained
\ nextgroup=@nft_c_rt4_hdr_field


" rt2_hdr_field (via rt2_hdr_expr)
hi link nft_rt2_hdr_field_addr nftHL_Action
syn match nft_rt2_hdr_field_addr "addr" skipwhite contained
syn cluster nft_c_rt2_hdr_field
\ contains=
\    nft_rt2_hdr_field_addr

" rt2_hdr_expr (via exthdr_expr)
hi link nft_rt2_hdr_expr nftHL_Statement
syn match nft_rt2_hdr_expr "rt2" skipwhite contained
\ nextgroup=@nft_c_rt2_hdr_field

hi link nft_rt0_hdr_field_addr_num_block nftHL_Identifier
" keepend because brackets should be on same line
syn match nft_rt0_hdr_field_addr_num_block "\v\[\s*[0-9]+\s*\]\s*" contained keepend
" Tough to highlight certain number inside a regex'd block, instead of a syntax region block"

hi link nft_rt0_hdr_field nftHL_Action
syn match nft_rt0_hdr_field "addr" skipwhite contained
\ nextgroup=
\    nft_rt0_hdr_field_addr_num_block,
\    nft_UnexpectedEmptyBrackets

" rt0_hdr_expr (via exthdr_expr)
hi link nft_rt0_hdr_expr nftHL_Statement
syn match nft_rt0_hdr_expr "rt0" skipwhite contained
\ nextgroup=
\    nft_rt0_hdr_field

" rt_hdr_field (via rt_hdr_expr)
hi link nft_rt_hdr_field nftHL_Action
syn match nft_rt_hdr_field "\v(nexthdr|hdrlength|type|seg\-left)" skipwhite contained
\ nextgroup=
\    nft_rt_hdr_field_nexthdr,
\    nft_rt_hdr_field_hdrlength,
\    nft_rt_hdr_field_type,
\    nft_rt_hdr_field_seg_left

syn cluster nft_c_rt_hdr_expr_keywords
\ contains=nft_rt_hdr_field
" \v(nexthdr|hdrlength|type|seg_left)" skipwhite contained
" syn match nft_rt_hdr_expr_keywords "\v(nexthdr|hdrlength|type|seg\-left)" skipwhite contained

" rt_hdr_expr (via exthdr_expr)
hi link nft_rt_hdr_expr nftHL_Statement
syn match nft_rt_hdr_expr "rt " skipwhite contained
\ nextgroup=@nft_c_rt_hdr_expr_keywords

" hdh_hdr_field (via hbh_hdr_expr)
hi link nft_hbh_hdr_field_nexthdr nftHL_Action
syn match nft_hbh_hdr_field_nexthdr "\vnexthdr" contained skipwhite

hi link nft_hbh_hdr_field_hdrlength nftHL_Action
syn match nft_hbh_hdr_field_hdrlength "\vhdrlength" contained skipwhite

syn cluster nft_c_hbh_hdr_field
\ contains=
\    nft_hbh_hdr_field_nexthdr,
\    nft_hbh_hdr_field_hdrlength

" hbh_hdr_expr (via exthdr_expr)
hi link nft_hbh_hdr_expr nftHL_Statement
syn match nft_hbh_hdr_expr "\vhbh" skipwhite contained
\ nextgroup=@nft_c_hbh_hdr_field

" exthdr_expr (via primary_expr)
syn cluster nft_c_exthdr_expr
\ contains=
\    nft_hbh_hdr_expr,
\    nft_rt0_hdr_expr,
\    nft_rt2_hdr_expr,
\    nft_rt4_hdr_expr,
\    nft_rt_hdr_expr,
\    nft_frag_hdr_expr,
\    nft_dst_hdr_expr,
\    nft_mh_hdr_expr

" th_hdr_field (via th_hdr_expr)
hi link nft_th_hdr_field_sport nftHL_Action
syn match nft_th_hdr_field_sport "\vsport" skipwhite contained

hi link nft_th_hdr_field_dport nftHL_Action
syn match nft_th_hdr_field_dport "\vdport" skipwhite contained

syn cluster nft_c_th_hdr_field
\ contains=
\    nft_th_hdr_field_sport,
\    nft_th_hdr_field_dport

" th_hdr_expr (via payload_expr, inner_inet_expr)
hi link nft_th_hdr_expr nftHL_Statement
syn match nft_th_hdr_expr "[ \t]\zsth" skipwhite contained
\ nextgroup=@nft_c_th_hdr_field


" sctp_hdr_field (via sctp_hdr_expr)
hi link nft_sctp_hdr_field_sport nftHL_Action
syn match nft_sctp_hdr_field_sport "\vsport" contained skipwhite

hi link nft_sctp_hdr_field_dport nftHL_Action
syn match nft_sctp_hdr_field_dport "\vdport" contained skipwhite

hi link nft_sctp_hdr_field_vtag nftHL_Action
syn match nft_sctp_hdr_field_vtag "\vvtag" contained skipwhite

hi link nft_sctp_hdr_field_checksum nftHL_Action
syn match nft_sctp_hdr_field_checksum "\vchecksum" contained skipwhite

" sctp_hdr_expr (via inner_inet_expr, payload_expr)
" sctp_hdr_field (via sctp_hdr_expr)
syn cluster nft_c_sctp_hdr_field
\ contains=
\    nft_sctp_hdr_field_sport,
\    nft_sctp_hdr_field_dport,
\    nft_sctp_hdr_field_vtag,
\    nft_sctp_hdr_field_checksum


" 'type'->sctp_chunk_common_field->sctp_chunk_allow->sctp_hdr_expr
hi link nft_sctp_chunk_common_field_type nftHL_Action
syn match nft_sctp_chunk_common_field_type "type" skipwhite contained
\ nextgroup=nft_EOS

" 'flags'->sctp_chunk_common_field->sctp_chunk_allow->sctp_hdr_expr
hi link nft_sctp_chunk_common_field_flags nftHL_Action
syn match nft_sctp_chunk_common_field_flags "flags" skipwhite contained
\ nextgroup=nft_EOS

" 'length'->sctp_chunk_common_field->sctp_chunk_allow->sctp_hdr_expr
hi link nft_sctp_chunk_common_field_length nftHL_Action
syn match nft_sctp_chunk_common_field_length "length" skipwhite contained
\ nextgroup=nft_EOS

" sctp_chunk_common_field->sctp_chunk_allow->sctp_hdr_expr
syn cluster nft_c_sctp_chunk_common_field
\ contains=
\    nft_sctp_chunk_common_field_type,
\    nft_sctp_chunk_common_field_flags,
\    nft_sctp_chunk_common_field_length,
\    nft_EOS

" 'sctp' 'chunk' 'data' ('init-tag'|'a-rwnd'|'num-outbound-streams'|'num-inbound-streams'|'initial-tsn'|'type'|'flags'|'length')
" ('cum-tsn-ack'|'a-rwnd'|'num-gap-ack-block'|'num-dup-tsns')->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_data_field nftHL_Action
syn match nft_sctp_chunk_data_field "\v(tsn|stream|ssn|ppid)" skipwhite contained

" 'sctp' 'chunk' 'data'
" 'data'->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_alloc_keyword_data nftHL_Action
syn match nft_sctp_chunk_alloc_keyword_data "data" skipwhite contained
\ nextgroup=
\     @nft_c_sctp_chunk_common_field,
\     nft_sctp_chunk_data_field,
\     nft_EOS

" 'sctp' 'chunk' 'init' ('init-tag'|'a-rwnd'|'num-outbound-streams'|'num-inbound-streams'|'initial-tsn')
" ('cum-tsn-ack'|'a-rwnd'|'num-gap-ack-block'|'num-dup-tsns')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_init_field nftHL_Action
syn match nft_sctp_chunk_alloc_sctp_chunk_init_field "\v(init\-tag|a\-rwnd|num\-(outbound|inbound)\-streams|initial\-tsn)" skipwhite contained
\ nextgroup=nft_EOS

" 'sctp' 'chunk' 'init'
" ('cum-tsn-ack'|'a-rwnd'|'num-gap-ack-block'|'num-dup-tsns')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_init_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_init_et_al "\v(init\-ack|init)" skipwhite contained
\ nextgroup=
\     nft_sctp_chunk_alloc_sctp_chunk_init_field,
\     @nft_c_sctp_chunk_common_field

" 'sctp' 'chunk' 'sack' (via sctp_hdr_expr)
" ('cum-tsn-ack'|'a-rwnd'|'num-gap-ack-block'|'num-dup-tsns')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_sack_field nftHL_Action
syn match nft_sctp_chunk_alloc_sctp_chunk_sack_field "\v(cum\-tsn\-ack|a\-rwnd|num\-gap\-ack\-blocks|num\-dup\-tsns)" skipwhite contained

" 'sctp' 'chunk' 'sack'
" 'sack'->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_sack nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_sack "sack" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_sctp_chunk_sack_field,
\    nft_EOS

" 'heartbeat'->sctp_chunk_type->sctp_chunk_alloc->sctp_hdr_expr
" 'heartbeat-ack'->sctp_chunk_type->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_alloc_sctp_chunk_type_keyword_heartbeat_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_heartbeat_et_al "\vheartbeat(\-ack)?" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'abort'->sctp_chunk_type->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_alloc_sctp_chunk_type_keyword_abort nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_abort "abort" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' 'shutdown ('cum-tsn-ack'|'type'|'flags'|'length')
" 'cum-tsn-ack'->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_alloc_shutdown_field nftHL_Action
syn match nft_sctp_chunk_alloc_shutdown_field "\vcum\-tsn\-ack" skipwhite contained
\ nextgroup=
\    nftHL_EOS

" 'sctp' 'chunk' 'shutdown ('cum-tsn-ack'|'type'|'flags'|'length')
" 'shutdown'->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_shutdown nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_shutdown "shutdown" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_shutdown_field,
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' ('shutdown-ack'|'shutdown-complete') ('type'|'flags'|'length')
" ('shutdown-ack'|'shutdown-complete')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_shutdown_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_shutdown_et_al "\vshutdown\-(ack|complete)" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' 'error' ('type'|'flags'|'length')
" 'error'->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_type_keyword_error nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_error "error" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' ('cookie-echo'|'cookie-ack')
" ('cookie-echo'|'cookie-ack')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_type_keyword_cookie_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_cookie_et_al "\vcookie\-(echo|ack)" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' ( 'ecne'|'cwr') 'lowest-tsn'
" 'lowest-tsn'->sctp_chunk_alloc->sctp_hdr_expr
hi link nft_sctp_chunk_alloc_ecne_cwr_field nftHL_Action
syn match nft_sctp_chunk_alloc_ecne_cwr_field "lowest\-tsn" skipwhite contained
\ nextgroup=nft_EOS

" 'sctp' 'chunk' ('ecne'|'cwr')
" ('ecne'|'cwr')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_ecne_cwr nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_ecne_cwr "\v(ecne|cwr)" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_ecne_cwr_field,
\    nft_EOS

" sctp_chunk_alloc_asconf_ack 'seqno' (via sctp_hdr_expr)
hi link nft_sctp_chunk_alloc_asconf_ack_field nftHL_Action
syn match nft_sctp_chunk_alloc_asconf_ack_field "\vseqno" skipwhite contained

" sctp_chunk_alloc_asconf_ack
hi link   nft_sctp_chunk_alloc_keyword_asconf_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_asconf_et_al "\vasconf(\-ack)?" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_asconf_ack_field,
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" sctp_chunk_alloc_forward_tsn
hi link nft_sctp_chunk_alloc_forward_tsn_field nftHL_Action
syn match nft_sctp_chunk_alloc_forward_tsn_field "new\-cum\-tsn" skipwhite contained

" sctp_chunk_alloc_forward_tsn
hi link nft_sctp_chunk_alloc_keyword_forward_tsn nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_forward_tsn "\vforward\-tsn" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_forward_tsn_field,
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS


" sctp_chunk_alloc (via sctp_hdr_expr)
hi link nft_sctp_hdr_expr_chunk nftHL_Statement
syn match nft_sctp_hdr_expr_chunk "chunk" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_keyword_data,
\    nft_sctp_chunk_alloc_keyword_init_et_al,
\    nft_sctp_chunk_alloc_keyword_sack,
\    nft_sctp_chunk_alloc_sctp_chunk_type_keyword_heartbeat_et_al,
\    nft_sctp_chunk_alloc_sctp_chunk_type_keyword_abort,
\    nft_sctp_chunk_alloc_keyword_shutdown_et_al,
\    nft_sctp_chunk_alloc_keyword_shutdown,
\    nft_sctp_chunk_alloc_sctp_chunk_type_keyword_error,
\    nft_sctp_chunk_alloc_sctp_chunk_type_keyword_cookie_et_al,
\    nft_sctp_chunk_alloc_keyword_ecne_cwr,
\    nft_sctp_chunk_alloc_keyword_asconf_et_al,
\    nft_sctp_chunk_alloc_keyword_forward_tsn,

" sctp_hdr_expr (via inner_inet_expr, payload_expr)
" sctp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" sctp_hdr_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
hi link   nft_sctp_hdr_expr nftHL_Command
syn match nft_sctp_hdr_expr "sctp" skipwhite contained
\ nextgroup=
\    nft_sctp_hdr_expr_chunk,
\    @nft_c_sctp_hdr_field,

" dccp_hdr_field (via nft_dccp_hdr_expr)
hi link nft_dccp_hdr_field nftHL_Action
syn match nft_dccp_hdr_field "\v(sport|dport|type)" skipwhite contained
\ nextgroup=nft_EOS

" nft_dccp_hdr_expr 'option' <NUM> (via nft_dccp_hdr_expr)
hi link nft_dccp_hdr_expr_option_num nftHL_Number
syn match nft_dccp_hdr_expr_option_num "\v\d{1,11}" skipwhite contained
\ nextgroup=nft_EOS

" nft_dccp_hdr_expr 'option num' (via nft_dccp_hdr_expr)
hi link nft_dccp_hdr_expr_option nftHL_Action
syn match nft_dccp_hdr_expr_option "option" skipwhite contained
\ nextgroup=
\    nft_dccp_hdr_expr_option_num

" dccp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" dccp_hdr_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
hi link nft_dccp_hdr_expr nftHL_Statement
syn match nft_dccp_hdr_expr "\vdccp" skipwhite contained
\ nextgroup=
\    nft_dccp_hdr_field,
\    nft_dccp_hdr_expr_option

" nft_tcpopt_field_mptcp (via_tcp_hdr_option_kind_and_field)
hi link nft_tcpopt_field_mptcp nftHL_Action
syn match nft_tcpopt_field_mptcp "\vsubtype" skipwhite contained

" tcpopt_field_maxseg (via_tcp_hdr_option_kind_and_field)
hi link nft_tcpopt_field_maxseg nftHL_Action
syn match nft_tcpopt_field_maxseg "\vsize" skipwhite contained

" tcpopt_field_tsopt (via_tcp_hdr_option_kind_and_field)
hi link nft_tcpopt_field_tsopt nftHL_Action
syn match nft_tcpopt_field_tsopt "\v(tsval|tsecr)" skipwhite contained

" tcpopt_field_window (via_tcp_hdr_option_kind_and_field)
hi link nft_tcpopt_field_window nftHL_Action
syn match nft_tcpopt_field_window "\v(count)" skipwhite contained

" tcpopt_field_sack (via tcp_hdr_option_kind_and_field)
hi link nft_tcpopt_field_sack nftHL_Action
syn match nft_tcpopt_field_sack "\v(left|right)" skipwhite contained

" tcp_hdr_option_sack (via tcp_hdr_option_kind_and_field, *tcp_hdr_option_type*)
hi link nft_tcp_hdr_option_sack nftHL_Action
syn match nft_tcp_hdr_option_sack "\v(sack\-permitted|sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcpopt_field_sack

" tcp_hdr_option_type (via optstrip_stmt, tcp_hdr_expr, tcp_hdr_option)
hi link   nft_tcp_hdr_option_types nftHL_Action
syn match nft_tcp_hdr_option_types "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained

syn cluster nft_c_tcp_hdr_option_type
\ contains=
\    nft_tcp_hdr_option_types,
\    nft_tcp_hdr_option_sack
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

hi link nft_optstrip_stmt_type nftHL_Action
syn match nft_optstrip_stmt_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

hi link nft_tcp_hdr_expr_type nftHL_Action  " nft_tcp_hdr_option_kind_and_field
syn match nft_tcp_hdr_expr_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

" tcp_hdr_option_kind_and_field 'mss' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_kaf_mss nftHL_Action
syn match nft_tcp_hdr_option_kaf_mss "\vmss" skipwhite contained
\ nextgroup=nft_tcpopt_field_maxseg

" tcp_hdr_option_kind_and_field "sack" (via *tcp_hdr_option_kind_and_field*, tcp_hdr_option_type)
hi link nft_tcp_hdr_option_sack_kaf nftHL_Action
syn match nft_tcp_hdr_option_sack_kaf "\v(sack0|sack1|sack2|sack3|sack\-permitted|sack)" skipwhite contained
\ nextgroup=nft_tcpopt_field_sack

" tcp_hdr_option_kind_and_field 'window' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_kaf_window nftHL_Action
syn match nft_tcp_hdr_option_kaf_window "\vwindow" skipwhite contained
\ nextgroup=nft_tcpopt_field_window

" tcp_hdr_option_kind_and_field 'timestamp' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_kaf_timestamp nftHL_Action
syn match nft_tcp_hdr_option_kaf_timestamp "\vtimestamp" skipwhite contained
\ nextgroup=nft_tcpopt_field_tsopt

" tcp_hdr_option_type (via tcp_hdr_option_kind_and_field)
hi link nft_tcp_hdr_option_type_kaf nftHL_Action
syn match nft_tcp_hdr_option_type_kaf "\v(sack\-permitted|sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcp_hdr_option_kaf_length

" tcp_hdr_option 'mptcp' (via tcp_hdr_option_kind_and_field)
hi link nft_tcp_hdr_option_mptcp nftHL_Action
syn match nft_tcp_hdr_option_mptcp "\v(sack\-permitted|sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcpopt_field_mptcp

syn cluster nft_c_tcp_hdr_option_kind_and_field
\ contains=
\    nft_tcp_hdr_option_kaf_mss,
\    nft_tcp_hdr_option_sack_kaf,
\    nft_tcp_hdr_option_kaf_window,
\    nft_tcp_hdr_option_kaf_timestamp,
\    nft_tcp_hdr_option_type_kaf,
\    nft_tcp_hdr_option_kaf_mptcp

" 'tcp' '.*' [ 'accept' / 'drop' ]
hi link nft_tcp_hdr_field_keyword_action nftHL_Action
syn match nft_tcp_hdr_field_keyword_action "\v(accept|drop)" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'tcp' 'sport' 'vmap' '{'
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
" tcp_hdr_field->tcp_hdr_expr->'tcp'->[payload_expr|inner_inet_expr]
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_num_or_numrange_5digit nftHL_Number
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_num_or_numrange_5digit "\v[0-9]{1,5}(\-[0-9]{1,5})?" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_expression_comma,
\    nft_EOS

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit nftHL_Number
syn match nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit "\v[0-9]{1,5}(\-[0-9]{1,5})?" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_block_expression_comma

" 'tcp' 'sport' 'vmap' '{' '!='
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_operator_negative nftHL_Operator
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_operator_negative "\v\!\=" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_service_name,
\    nft_Error

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_operator_negative nftHL_Operator
syn match nft_tcp_hdr_field_keywords_ports_operator_negative "\v\!\=" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_service_name,
\    nft_Error

" 'tcp' 'sport' 'vmap' '{' service_name ','
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_expression_comma nftHL_Element
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_expression_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_num_or_numrange_5digit,
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_operator_negative,
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_service_name

" 'tcp' 'sport' '{' service_name ','
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_block_expression_comma nftHL_Element
syn match nft_tcp_hdr_field_keywords_ports_block_expression_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_ports_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_ports_keywords_ports_operator_negative,
\    nft_tcp_hdr_field_ports_keywords_ports_service_name

" 'tcp' 'sport' vmap '{' <NUM>
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_service_name nftHL_Identifier
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_service_name "\v[a-z]{1,17}" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_block_expression_comma

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_service_name nftHL_Identifier
syn match nft_tcp_hdr_field_keywords_ports_service_name "\v[a-z]{1,17}" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_block_expression_comma

" 'tcp' 'sport' '{' <NUM> ',' <NUM> '}'
hi link    nft_tcp_hdr_field_keywords_ports_block_delimiter nftHL_BlockDelimitersSet
syn region nft_tcp_hdr_field_keywords_ports_block_delimiter start='{' end='}' skipwhite contained
\ contains=
\    nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_operator_negative,
\    nft_tcp_hdr_field_keywords_ports_service_name

" 'tcp' 'sport' 'vmap' '{'
hi link    nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_delimiter nftHL_BlockDelimitersLimit
syn region nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_delimiter start='{' end='}' skipwhite contained
\ contains=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_operator_negative,
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_service_name

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap nftHL_Action
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap "vmap" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_delimiter

syn cluster nft_c_tcp_hdr_field_keywords_ports_block
\ contains=
\    nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_operator_negative,
\    nft_tcp_hdr_field_keywords_ports_block_delimiter,
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap,
\    nft_tcp_hdr_field_keywords_ports_service_name

" 'tcp' 'dport'
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link nft_tcp_hdr_field_keywords nftHL_Action
syn match nft_tcp_hdr_field_keywords "dport" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field_keywords_ports_block,
\    nft_EOS,
\    nft_Error

" 'tcp' 'sport'
" tcp_hdr_field (via tcp_hdr_expr) (outside of Bison/Yacc)
hi link nft_tcp_hdr_field_keywords nftHL_Action
syn match nft_tcp_hdr_field_keywords "sport" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field_keywords_ports_block,
\    nft_EOS,
\    nft_Error

" tcp_hdr_field (via tcp_hdr_expr)
syn cluster nft_c_tcp_hdr_field
\ contains=
\    nft_tcp_hdr_field_keywords,
\    nft_Error

" optstrip_stmt (via stmt)
hi link nft_optstrip_stmt nftHL_Action
syn match nft_optstrip_stmt "\vreset\s+tcp\s+option" skipwhite contained
\ nextgroup=@nft_c_tcp_hdr_option_type

" gre_hdr_field (via gre_hdr_expr)
hi link nft_gre_hdr_field nftHL_Action
syn match nft_gre_hdr_field "\v(version|flags|protocol)" skipwhite contained

" gre_hdr_expr
hi link nft_gre_hdr_expr nftHL_Statement
syn match nft_gre_hdr_expr " \zsgre\ze " skipwhite contained
\ nextgroup=
\    nft_gre_hdr_field,
\    nft_inner_inet_expr

" nft_gretap_hdr_expr is defined AFTER nft_gre_hdr_expr
hi link nft_gretap_hdr_expr nftHL_Statement
syn match nft_gretap_hdr_expr "\vgretap" skipwhite contained
\ nextgroup=@nft_c_inner_expr

" geneve_hdr_field (via geneve_hdr_expr)
hi link nft_geneve_hdr_field nftHL_Action
syn match nft_geneve_hdr_field "\v(vni|type)" skipwhite contained

" geneve_hdr_expr (via payload_expr)
hi link nft_geneve_hdr_expr nftHL_Statement
syn match nft_geneve_hdr_expr "\vgeneve" skipwhite contained
\ nextgroup=
\    nft_geneve_hdr_field,
\    @nft_c_inner_expr

" vxlan_hdr_field (via vxlan_hdr_expr)
hi link nft_vxlan_hdr_field nftHL_Action
syn match nft_vxlan_hdr_field "\v(vni|flags)" skipwhite contained

" vxlan_hdr_expr 'vxlan' (via payload_expr)
hi link nft_vxlan_hdr_expr nftHL_Statement
syn match nft_vxlan_hdr_expr "\vvxlan" skipwhite contained
\ nextgroup=
\    nft_vxlan_hdr_field,
\    @nft_c_inner_expr

" inner_expr (via geneve_hdr_expr, gretap_hdr_expr, vxlan_hdr_expr)
syn cluster nft_c_inner_expr
\ contains=
\    @nft_c_inner_eth_expr,
\    @nft_c_inner_inet_expr

" inner_eth_expr (via inner_expr)
syn cluster nft_c_inner_eth_expr
\ contains=
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_eth_hdr_expr

" inner_inet_expr (via gre_hdr_expr, inner_expr)
syn cluster nft_c_inner_inet_expr
\ contains=
\    nft_ip_hdr_expr,
\    nft_icmp_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr

" ETHER ETHER ETHER ETHER
" eth_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" eth_hdr_field 'saddr'/'daddr' (via eth_hdr_field)
hi link  nft_eth_hdr_field_addrs nftHL_Action
syn match nft_eth_hdr_field_addrs "\v(saddr|daddr)" skipwhite contained

" eth_hdr_field 'type' (via eth_hdr_field)
hi link  nft_eth_hdr_field_type nftHL_Action
syn match nft_eth_hdr_field_type "\v(type)" skipwhite contained

" eth_hdr_field (via eth_hdr_expr)
hi link  nft_c_eth_hdr_field nftHL_Action
syn cluster nft_c_eth_hdr_field
\  contains=
\    nft_eth_hdr_field_addrs,
\    nft_eth_hdr_field_type

" eth_hdr_expr (via inner_eth_expr, payload_expr)
hi link nft_eth_hdr_expr nftHL_Statement
syn match nft_eth_hdr_expr "ether" skipwhite contained
\  nextgroup=@nft_c_eth_hdr_field

" vlan_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" vlan_hdr_field 'type' (via vlan_hdr_field)
hi link nft_vlan_hdr_field_type nftHL_Action
syn match nft_vlan_hdr_field_type "type" skipwhite contained

" vlan_hdr_field keywords (via vlan_hdr_field)
hi link nft_vlan_hdr_field_keywords nftHL_Action
syn match nft_vlan_hdr_field_keywords "\v(id|cfi|dei|pcp)" skipwhite contained

" vlan_hdr_field (via vlan_hdr_expr)
syn cluster nft_c_vlan_hdr_field
\ contains=
\    nft_vlan_hdr_field_keywords,
\    nft_vlan_hdr_field_type

" vlan_hdr_expr (via inner_eth_expr, payload_expr)
hi link nft_vlan_hdr_expr nftHL_Statement
syn match nft_vlan_hdr_expr "vlan" skipwhite contained
\ nextgroup=@nft_c_vlan_hdr_field

" arp_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" arp_hdr_field_addr_ether (via arp_hdr_field)
hi link   nft_arp_hdr_field_addr_ether nftHL_Action
syn match nft_arp_hdr_field_addr_ether "ether" skipwhite contained

" arp_hdr_field_ip_ether (via arp_hdr_field)
hi link   nft_arp_hdr_field_addr_ip nftHL_Action
syn match nft_arp_hdr_field_addr_ip "ip" skipwhite contained

" arp_hdr_field_addrs 'saddr'/'daddr' (via arp_hdr_field)
hi link nft_arp_hdr_field_addrs nftHL_Action
syn match nft_arp_hdr_field_addrs "\v(saddr|daddr)" skipwhite contained
\ nextgroup=
\    nft_arp_hdr_field_addr_ether,
\    nft_arp_hdr_field_addr_ip

" arp_hdr_field_keywords (via arp_hdr_field)
hi link nft_arp_hdr_field_keywords nftHL_Action
syn match nft_arp_hdr_field_keywords "\v(htype|ptype|hlen|plen|operation)" skipwhite contained

" arp_hdr_field (via arp_hdr_expr)
syn cluster nft_c_arp_hdr_field
\ contains=
\    nft_arp_hdr_field_keywords,
\    nft_arp_hdr_field_addrs

" arp_hdr_expr 'arp' (via inner_eth_expr, payload_expr)
hi link nft_arp_hdr_expr nftHL_Statement
syn match nft_arp_hdr_expr "\varp" skipwhite contained
\ nextgroup=@nft_c_arp_hdr_field

" INET INET INET INET
" gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)

" ip_option_field (via ip_hdr_expr_option)
" ip_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" ip_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_ip_option_field nftHL_Statement
syn match nft_ip_option_field "\v(type|length|value|ptr|addr)" skipwhite contained

" ip_option_type (via ip_hdr_expr_option)
hi link nft_ip_option_type nftHL_Action
syn match nft_ip_option_type "\v(lsrr|rr|ssrr|ra)" skipwhite contained
\ nextgroup=
\    nft_ip_option_field,
\    nft_Semicolon

" ip_hdr_expr_option (via ip_hdr_expr)
hi link nft_ip_hdr_expr_option nftHL_Statement
syn match nft_ip_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=nft_ip_option_type

" 'ip' 'daddr'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "daddr" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_daddr_ipaddr

" 'ip' 'saddr'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "saddr" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_saddr_ipaddr

" 'ip' 'checksum'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "checksum" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_checksum_value

" 'ip' 'protocol'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "protocol" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_protocol_num

" 'ip' 'ttl'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "ttl" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_ttl_count

" 'ip' 'fra_off'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "frag\-off" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_fra_off_count

" 'ip' 'id'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "id" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_id_num

" 'ip' 'length'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "length" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_length_num

" 'ip' 'ecn'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "ecn" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_ecn_id

" 'ip' 'dscp' <NUM>
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field_keyword_dscp_id_number nftHL_Number
syn match nft_ip_hdr_field_keyword_dscp_id_number "\v[0-9]{1,3}" skipwhite contained
\ nextgroup=nft_EOS
syn match nft_ip_hdr_field_keyword_dscp_id_number "\v0x[0-9]{1,2}" skipwhite contained
\ nextgroup=nft_EOS
hi link   nft_ip_hdr_field_keyword_dscp_id_label nftHL_Label
syn match nft_ip_hdr_field_keyword_dscp_id_label "\v(ef|cs[0-7]|af[1-4][1-3])" skipwhite contained
\ nextgroup=nft_EOS
hi link   nft_ip_hdr_field_keyword_dscp_operator_negation nftHL_Operator
syn match nft_ip_hdr_field_keyword_dscp_operator_negation "\v\!\=" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_dscp_id_number,
\    nft_ip_hdr_field_keyword_dscp_id_label

hi link   nft_ip_hdr_field_keyword_dscp_set_comma nftHL_Element
syn match nft_ip_hdr_field_keyword_dscp_set_comma "," skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_dscp_set_number,
\    nft_ip_hdr_field_keyword_dscp_set_label

hi link   nft_ip_hdr_field_keyword_dscp_set_number nftHL_Number
syn match nft_ip_hdr_field_keyword_dscp_set_number "\v[0-9]{1,3}" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_dscp_set_comma
syn match nft_ip_hdr_field_keyword_dscp_set_number "\v0x[0-9]{1,2}" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_dscp_set_comma
hi link   nft_ip_hdr_field_keyword_dscp_set_label nftHL_Label
syn match nft_ip_hdr_field_keyword_dscp_set_label "\v(df|be|lephb|va|ef|cs[0-7]|af[1-4][1-3])" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_dscp_set_comma

syn region nft_ip_hdr_field_keyword_dscp_block_delimiter start="{" end="}" skipwhite contained
\ contains=
\    nft_ip_hdr_field_keyword_dscp_set_number,
\    nft_ip_hdr_field_keyword_dscp_set_label

" 'ip' 'dscp'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "dscp" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr
"\    nft_ip_hdr_field_keyword_dscp_block_delimiter,
"\    nft_ip_hdr_field_keyword_dscp_operator_negation,
"\    nft_ip_hdr_field_keyword_dscp_id_label,
"\    nft_ip_hdr_field_keyword_dscp_id_number

" 'ip' 'hdrlength'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "hdrlength" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_hdrlength_num

" 'ip' 'version'
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "version" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_version_num

" 'ip'
" ip_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_ip_hdr_expr nftHL_Statement
syn match nft_ip_hdr_expr "\vip" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field,
\    nft_ip_hdr_expr_option

" icmp_hdr_field (via icmp_hdr_expr)
hi link nft_icmp_hdr_field nftHL_Action
syn match nft_icmp_hdr_field "\v(type|code|checksum|id|seq|gateway|mtu)" skipwhite contained

" icmp_hdr_expr (via inner_inet_expr, payload_expr)
" icmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_icmp_hdr_expr nftHL_Statement
syn match nft_icmp_hdr_expr "\vicmp" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_field

" igmp_hdr_field (via igmp_hdr_expr)
hi link nft_igmp_hdr_field nftHL_Action
syn match nft_igmp_hdr_field "\v(type|checksum|mrt|group)" skipwhite contained

" igmp_hdr_expr (via inner_inet_expr, payload_expr)
" igmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" igmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_igmp_hdr_expr nftHL_Statement
syn match nft_igmp_hdr_expr "\vigmp" skipwhite contained
\ nextgroup=
\    nft_igmp_hdr_field

" ip6_hdr_field (via ip6_hdr_expr)
hi link nft_ip6_hdr_field nftHL_Action
syn match nft_ip6_hdr_field "\v(version|dscp|ecn|flowlabel|length|nexthdr|hoplimit|saddr|daddr)" skipwhite contained

" ip6_hdr_expr (via inner_inet_expr, payload_expr)
" ip6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" ip6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_ip6_hdr_expr nftHL_Statement
syn match nft_ip6_hdr_expr "\vip6" skipwhite contained
\ nextgroup=
\    nft_ip6_hdr_field

" icmp6_hdr_field (via icmp6_hdr_expr)
hi link nft_icmp6_hdr_field nftHL_Action
syn match nft_icmp6_hdr_field "\v(type|code|checksum|param\-problem|mtu|id|seq|max\-delay|taddr|daddr)" skipwhite contained

" icmp6_hdr_expr (via inner_inet_expr, payload_expr)
" icmp6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_icmp6_hdr_expr nftHL_Statement
syn match nft_icmp6_hdr_expr "\vicmpv6" skipwhite contained
\ nextgroup=
\    nft_icmp6_hdr_field

" auth_hdr_field (via auth_hdr_expr)
hi link nft_auth_hdr_field nftHL_Action
syn match nft_auth_hdr_field "\v(nexthdr|hdrlength|reserved|spi|seq)" skipwhite contained

" auth_hdr_expr (via inner_inet_expr, payload_expr)
" auth_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" auth_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_auth_hdr_expr nftHL_Statement
syn match nft_auth_hdr_expr "\vauth" skipwhite contained
\ nextgroup=
\    nft_auth_hdr_field

" esp_hdr_field (via esp_hdr_expr)
hi link nft_esp_hdr_field nftHL_Action
syn match nft_esp_hdr_field "\v(spi|seq)" skipwhite contained

" esp_hdr_expr (via inner_inet_expr, payload_expr)
" esp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" esp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_esp_hdr_expr nftHL_Statement
syn match nft_esp_hdr_expr "\vesp" skipwhite contained
\ nextgroup=
\    nft_esp_hdr_field

" comp_hdr_field (via comp_hdr_expr)
hi link nft_comp_hdr_field nftHL_Action
syn match nft_comp_hdr_field "\v(nexthdr|flags|cpi)" skipwhite contained

" comp_hdr_expr (via inner_inet_expr, payload_expr)
" comp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" comp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_comp_hdr_expr nftHL_Statement
syn match nft_comp_hdr_expr "\vcomp" skipwhite contained
\ nextgroup=
\    nft_comp_hdr_field

" udplite_hdr_field (via udplite_hdr_expr)
hi link nft_udplite_hdr_field nftHL_Action
syn match nft_udplite_hdr_field "\v(sport|dport|csumcov|checksum)" skipwhite contained

" udp_hdr_field (via udp_hdr_expr)
hi link nft_udp_hdr_field nftHL_Action
syn match nft_udp_hdr_field "\v(sport|dport|length|checksum)" skipwhite contained

" udp_hdr_expr (via inner_inet_expr, payload_expr)
" udp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_udp_hdr_expr nftHL_Statement
syn match nft_udp_hdr_expr "\vudp" skipwhite contained
\ nextgroup=
\    nft_udp_hdr_field

" udplite_hdr_expr (via inner_inet_expr, payload_expr)
" udplite_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udplite_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_udplite_hdr_expr nftHL_Statement
syn match nft_udplite_hdr_expr "\vudplite" skipwhite contained
\ nextgroup=
\    nft_udplite_hdr_field

" tcp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM ',' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at_payload_raw_len nftHL_Number
syn match nft_tcp_hdr_option_at_payload_raw_len "\v[0-9]{1,11}" skipwhite contained

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM ',' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at_comma2 nftHL_Expression
syn match nft_tcp_hdr_option_at_comma2 "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_payload_raw_len

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at_num nftHL_Number
syn match nft_tcp_hdr_option_at_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_comma2

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at_comma nftHL_Expression
syn match nft_tcp_hdr_option_at_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_num

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at_tcp_hdr_option_type nftHL_Action
syn match nft_tcp_hdr_option_at_tcp_hdr_option_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_comma
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

" tcp_hdr_expr 'option' 'tcp' 'at' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at nftHL_Command
syn match nft_tcp_hdr_option_at "\vat" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_tcp_hdr_option_type "\vat" skipwhite contained

" tcp_hdr_expr 'option' (via inner_inet_expr, payload_expr)
hi link nft_tcp_hdr_expr_option nftHL_Statement
syn match nft_tcp_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_option_type,
\    nft_tcp_hdr_option_sack,  " tcp_hdr_option 'sack'
\    @nft_c_tcp_hdr_option_kind_and_field,
\    nft_tcp_hdr_option_at

" tcp_hdr_expr (via inner_inet_expr, payload_expr)
" tcp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" tcp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_tcp_hdr_expr nftHL_Statement
syn match nft_tcp_hdr_expr "\vtcp" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field,
\    nft_tcp_hdr_expr_option

hi link nft_payload_raw_len nftHL_Number
syn match nft_payload_raw_len "\v\d+" skipwhite contained
hi link nft_payload_raw_len_via_payload_expr_set nftHL_Number
syn match nft_payload_raw_len_via_payload_expr_set "\v\d+" skipwhite contained

hi link nft_payload_raw_expr_comma2 nftHL_Operator
syn match nft_payload_raw_expr_comma2 "\v," skipwhite contained
\ nextgroup=nft_payload_raw_len
hi link nft_payload_raw_expr_comma2_via_payload_expr_set nftHL_Operator
syn match nft_payload_raw_expr_comma2_via_payload_expr_set "\v," skipwhite contained
\ nextgroup=nft_payload_raw_len

hi link nft_payload_raw_expr_num nftHL_Number
syn match nft_payload_raw_expr_num "\v\d+" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma2
hi link nft_payload_raw_expr_num_via_payload_expr_set nftHL_Number
syn match nft_payload_raw_expr_num_via_payload_expr_set "\v\d+" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma2_via_payload_expr_set

hi link nft_payload_raw_expr_comma1 nftHL_Operator
syn match nft_payload_raw_expr_comma1 "\v," skipwhite contained
\ nextgroup=nft_payload_raw_expr_num

hi link nft_payload_raw_expr_comma1_via_payload_expr_set nftHL_Operator
syn match nft_payload_raw_expr_comma1_via_payload_expr_set "\v," skipwhite contained
\ nextgroup=nft_payload_raw_expr_num_via_payload_expr_set

hi link nft_payload_base_spec_hdrs nftHL_Action
syn match nft_payload_base_spec_hdrs "\vll|nh|th|hdr|string" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1

" payload_base_spec (via payload_raw_expr)
syn cluster nft_c_payload_base_spec
\ contains=
\    nft_payload_base_spec_hdrs

hi link nft_payload_base_spec_via_payload_expr_set nftHL_Action
syn match nft_payload_base_spec_via_payload_expr_set "\vll|nh|th|string" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1_via_payload_expr_set

" payload_raw_expr (via payload_expr)
hi link nft_payload_raw_expr nftHL_Statement
syn match nft_payload_raw_expr "\v \zsat\ze " skipwhite contained
\ nextgroup=@nft_c_payload_base_spec

hi link  nft_payload_raw_expr_via_payload_expr_set nftHL_Action
syn match  nft_payload_raw_expr_via_payload_expr_set "\vat" skipwhite contained
\ nextgroup=nft_payload_base_spec_via_payload_expr_set


" NEED TO DUPLICATE in payload_stmt but without nextgroup='set'
" Add 'nextgroup=nft_payload_stmt_set' toward each here
" payload_expr (via payload_stmt, *primary_expr*, primary_stmt_expr)
syn cluster nft_c_payload_expr_via_primary_expr
\ contains=
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_icmp_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr,
\    nft_vxlan_hdr_expr,
\    nft_geneve_hdr_expr,
\    nft_gre_hdr_expr,
\    nft_gretap_hdr_expr

" nft_payload_expr_basic_stmt_expr
hi link    nft_payload_expr_basic_stmt_expr nftHL_BlockDelimiters
syn region nft_payload_expr_basic_stmt_expr start="(" end=")" skipwhite keepend contained
"\ contains=nft_c_basic_stmt_expr

" NEED TO DUPLICATE in primary_stmt but without nextgroup='set'
" Add 'nextgroup=nft_payload_stmt_set' toward each here
" payload_expr (via payload_stmt, primary_expr, *primary_stmt_expr*)
syn cluster nft_c_payload_expr_via_primary_stmt_expr
\ contains=
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_icmp_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr,
\    nft_vxlan_hdr_expr,
\    nft_geneve_hdr_expr,
\    nft_gre_hdr_expr,
\    nft_gretap_hdr_expr

hi link nft_symbol_stmt_expr_nested_comma namedHL_Type
syn match nft_symbol_stmt_expr_nested_comma /,/ skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_symbol_stmt_expr_recursive,
\    nft_symbol_stmt_expr_nested_commma

" keyword_expr (via primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn match nft_keyword_expr "\v(ether|ip6|ip |vlan|arp|dnat|snat|ecn|reset|destroy|original|reply|label|last)" skipwhite contained

" symbol_stmt_expr (via stmt_expr)
syn cluster nft_c_symbol_stmt_expr
\ contains=
\    nft_keyword_expr,
\    @nft_c_symbol_expr
" nft_c_symbol_expr must be the LAST contains= (via nft_unquoted_string)

" symbol_stmt_expr ',' (via stmt_expr)
hi link nft_symbol_stmt_expr_recursive nftHL_Operator
syn match nft_symbol_stmt_expr_recursive "," skipwhite contained
\ contains=
\    @nft_c_symbol_stmt_expr,
\    nft_symbol_stmt_expr_nested_comma
\ nextgroup=
\    nft_symbol_stmt_expr_nested_comma,
\    nft_symbol_stmt_expr_recursive

" payload_stmt <payload_expr> 'set' (via payload_stmt <payload_expr>)
hi link nft_payload_stmt_before_set nftHL_Statement
syn match nft_payload_stmt_before_set "\vset" skipwhite contained
\ nextgroup=@nft_c_stmt_expr


hi link   nft_icmp_hdr_expr_icmp_hdr_field nftHL_Action
syn match nft_icmp_hdr_expr_icmp_hdr_field "\v(type|code|checksum|id|seq|gateway|mtu)" skipwhite contained

hi link   nft_icmp_hdr_expr_via_payload_expr nftHL_Command
syn match nft_icmp_hdr_expr_via_payload_expr "icmp" skipwhite contained
\ nextgroup=nft_icmp_hdr_expr_icmp_hdr_field

" payload_stmt <payload_expr> (via payload_stmt)
syn cluster nft_c_payload_expr_via_payload_stmt
\ contains=
\    nft_icmp_hdr_expr_via_payload_expr,
\    nft_payload_raw_expr_via_payload_expr_set,
\    nft_eth_hdr_expr_via_payload_expr_set,
\    nft_vlan_hdr_expr_via_payload_expr_set,
\    nft_arp_hdr_expr_via_payload_expr_set,
\    nft_ip_hdr_expr_via_payload_expr_set,
\    nft_igmp_hdr_expr_via_payload_expr_set,
\    nft_ip6_hdr_expr_via_payload_expr_set,
\    nft_icmp6_hdr_expr_via_payload_expr_set,
\    nft_auth_hdr_expr_via_payload_expr_set,
\    nft_esp_hdr_expr_via_payload_expr_set,
\    nft_comp_hdr_expr_via_payload_expr_set,
\    nft_udp_hdr_expr_via_payload_expr_set,
\    nft_udplite_hdr_expr_via_payload_expr_set,
\    nft_tcp_hdr_expr_via_payload_expr_set,
\    nft_dccp_hdr_expr_via_payload_expr_set,
\    nft_sctp_hdr_expr_via_payload_expr_set,
\    nft_th_hdr_expr_via_payload_expr_set,
\    nft_vxlan_hdr_expr_via_payload_expr_set,
\    nft_geneve_hdr_expr_via_payload_expr_set,
\    nft_gre_hdr_expr_via_payload_expr_set,
\    nft_gretap_hdr_expr_via_payload_expr_set

" payload_stmt <payload_expr> (via payload_stmt)
syn cluster nft_c_payload_stmt
\ contains=
\    nft_icmp_hdr_expr,
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr,
\    nft_vxlan_hdr_expr,
\    nft_geneve_hdr_expr,
\    nft_gre_hdr_expr,
\    nft_gretap_hdr_expr

" 'set'->(ct_key|ct_key_dir|ct_stmt)
hi link nft_ct_key_dir_ct_stmt_keyword_set nftHL_Command
syn match nft_ct_key_dir_ct_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'set'->(ct_key|ct_key_dir|ct_stmt)
hi link nft_ct_key_ct_stmt_keyword_set nftHL_Command
syn match nft_ct_key_ct_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" symbol_stmt_expr->stmt_expr
syn cluster nft_symbol_stmt_expr
\ contains=nft_symbol_stmt_expr_nested_comma

" ct_key->ct_stmt->stmt
hi link nft_ct_stmt_ct_key nftHL_Action
syn match nft_ct_stmt_ct_key "\v(l3proto|mark|state|direction|status|expiration|helper|saddr|daddr|proto\-src|proto\-dst|label|event|proto|secmark|id)" skipwhite contained

" ct_key_dir_optional->(ct_stmt|ct_key_dir|ct_key)
hi link nft_ct_stmt_ct_key_dir_optional nftHL_Action
syn match nft_ct_stmt_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_stmt_keyword_set

" ct_stmt->stmt
hi link nft_ct_stmt nftHL_Command
syn match nft_ct_stmt "ct" skipwhite contained
\ nextgroup=
\    nft_ct_stmt_ct_key_dir_optional,
\    nft_ct_stmt_ct_dir,
\    nft_ct_stmt_ct_key,
\    nft_UnexpectedEOS

" '(saddr|daddr)->ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link nft_ct_expr_ct_key_proto_field_keyword_addrs nftHL_Action
syn match nft_ct_expr_ct_key_proto_field_keyword_addrs "\v(saddr|daddr)" skipwhite contained

" ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link nft_ct_expr_ct_key_proto_field_keyword_ip_ip6 nftHL_Command
syn match nft_ct_expr_ct_key_proto_field_keyword_ip_ip6 "\vip[6]" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key_proto_field_keyword_addrs

" ct_key_dir->ct_expr->(primary_expr|primary_stmt_expr)
hi link nft_ct_expr_ct_key_dir nftHL_Action
syn match nft_ct_expr_ct_key_dir "\v(saddr|daddr|l3proto|proto\-(src|dst))" skipwhite contained

" ct_key_dir_optional->(ct_stmt|ct_key_dir|ct_key)
hi link nft_ct_expr_ct_key_dir_optional nftHL_Action
syn match nft_ct_expr_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_expr_keyword_set

" ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link nft_ct_expr_ct_dir nftHL_Action
syn match nft_ct_expr_ct_dir "\v(original|reply)" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key_dir_optional,
\    nft_ct_expr_ct_key_dir

" ct_key->ct_expr->(payload_expr|payload_stmt_expr)
hi link nft_ct_expr_ct_key nftHL_Action
syn match nft_ct_expr_ct_key "\v(l3proto|mark|state|direction|status|expiration|helper|saddr|daddr|proto\-src|proto\-dst|label|event|proto|secmark|id)" skipwhite contained

" ct_expr->(primary_expr|primary_stmt_expr)
hi link nft_ct_expr nftHL_Command
syn match nft_ct_expr "ct" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key,
\    nft_ct_expr_ct_key_dir_optional,
\    nft_ct_expr_ct_dir,
\    nft_ct_expr_ct_key_proto_field_keyword_ip_ip6

hi link nft_rt_key nftHL_Command
syn match nft_rt_key "\v(classid|nexthop|mtu|ipsec)" skipwhite contained

hi link nft_nf_key_proto nftHL_Command
syn match nft_nf_key_proto "\vip[6]" skipwhite contained
\ nextgroup=
\    nft_rt_key

hi link nft_rt_expr nftHL_Command
syn match nft_rt_expr "rt\ze " skipwhite contained
\ nextgroup=
\    nft_nf_key_proto,
\    nft_rt_key

hi link nft_hash_expr_jhash_expr nftHL_Command
syn cluster nft_c_hash_expr_jhash_expr
\ contains=
\    @nft_c_concat_expr,
\    nft_set_expr,
\    nft_map_expr

" 'jhash' hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
hi link nft_hash_expr_jhash nftHL_Command
syn match nft_hash_expr_jhash "jhash" skipwhite contained
\ nextgroup=
\    nft_hash_expr_jhash_expr

" 'symhash' hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
hi link nft_hash_expr_symhash nftHL_Command
syn match nft_hash_expr_symhash "symhash" skipwhite contained
\ nextgroup=
\    nft_hash_expr_symhash_mod

" hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
syn cluster nft_c_hash_expr
\ contains=
\    nft_hash_expr_jhash,
\    nft_hash_expr_symhash

" xfrm_state_proto_key->xfrm_expr->primary_expr
hi link nft_xfrm_state_proto_key nftHL_Action
syn match nft_xfrm_state_proto_key "\v(s|d)addr" skipwhite contained

" nf_key_protoxfrm_state_proto_key->xfrm_expr->primary_expr
hi link nft_nf_key_proto nftHL_Action
syn match nft_nf_key_proto "\v(ip[6])" skipwhite contained
\ nextgroup=
\    nft_xfrm_state_proto_key

" xfrm_state_key->xfrm_expr->primary_expr
hi link nft_xfrm_state_key nftHL_Number
syn match nft_xfrm_state_key "\v(spi|reqid)" skipwhite contained

" xfrm_spnum_num->xfrm_spnum->xfrm_expr->primary_expr
hi link nft_xfrm_num nftHL_Number
syn match nft_xfrm_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_xfrm_state_key,
\    nft_nf_key_protoxfrm_state_proto_key

" xfrm_spnum->xfrm_expr->primary_expr
hi link nft_xfrm_spnum nftHL_Command
syn match nft_xfrm_spnum "spnum" skipwhite contained
\ nextgroup=
\    nft_xfrm_spnum_num

" xfrm_dir->xfrm_expr->primary_expr
hi link nft_xfrm_dir nftHL_Action
syn match nft_xfrm_dir "\v(in|out)" skipwhite contained
\ nextgroup=
\    nft_xfrm_spnum,
\    nft_xfrm_state_key,
\    nft_nf_key_proto

" xfrm_expr ->primary_expr
hi link nft_xfrm_expr_keyword nftHL_Command
syn match nft_xfrm_expr_keyword "ipsec" skipwhite contained
\ nextgroup=
\    nft_xfrm_dir

" <num>->offset_opt->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_offset_num nftHL_Number
syn match nft_offset_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_num

" offset_opt->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_offset_opt nftHL_Command
syn match nft_offset_opt "offset" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_num

" <num>->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_numgen_num nftHL_Number
syn match nft_numgen_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_opt

" 'mod'->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_numgen_mod_keyword nftHL_Action
syn match nft_numgen_mod_keyword "mod" skipwhite contained
\ nextgroup=
\    nft_numgen_num

" numgen_type->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_numgen_type nftHL_Action
syn match nft_numgen_type "\v(inc|random)" skipwhite contained
\ nextgroup=
\    nft_numgen_mod_keyword

" numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link nft_numgen_expr nftHL_Command
syn match nft_numgen_expr "numgen" skipwhite contained
\ nextgroup=
\    nft_numgen_type

" socket_key->socket_expr->(primary_expr|primary_stmt_expr)
hi link nft_socket_expr_socket_key nftHL_Action
syn match nft_socket_expr_socket_key "\v(transparent|mark|wildcard)" skipwhite contained

" 'cgroupv2' <num>->socket_expr->(primary_expr|primary_stmt_expr)
hi link nft_socket_expr_cgroupv2_num nftHL_Action
syn match nft_socket_expr_cgroupv2_num "\v[0-9]{1,11}" skipwhite contained

" 'level'->socket_expr->(primary_expr|primary_stmt_expr)
hi link nft_socket_expr_cgroupv2_level nftHL_Action
syn match nft_socket_expr_cgroupv2_level "level" skipwhite contained
\ nextgroup=
\    nft_socket_expr_cgroupv2_num

" 'cgroupv2'->socket_expr->(primary_expr|primary_stmt_expr)
hi link nft_socket_expr_cgroupv2 nftHL_Command
syn match nft_socket_expr_cgroupv2 "cgroupv2" skipwhite contained
\ nextgroup=
\    nft_socket_expr_level

" socket_expr->(primary_expr|primary_stmt_expr)
hi link nft_socket_expr nftHL_Action
syn match nft_socket_expr "socket" skipwhite contained
\ nextgroup=
\    nft_socket_expr_socket_key,
\    nft_socket_expr_socket_cgroupv2

" 'set'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_set nftHL_Command
syn match nft_meta_stmt_set "set" skipwhite contained
\ nextgroup=
\    nft_stmt_expr

" <string>->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_meta_string nftHL_Command
syn match nft_meta_stmt_meta_string "\v[a-zA-Z0-9\\\/_\.]{1,65}" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_set

" meta_key_unqualified->(meta_stmt|meta_key|meta_stmt)
" meta_key_unqualified->meta_key
hi link nft_meta_key_meta_key_unqualified nftHL_Command
syn match nft_meta_key_meta_key_unqualified "\v(mark|iif(|name|type|group)|oif(|name|type|group)|skuid|skgid|nftrace|rtclassid|ibriport|obriport|ibridgename|obridgename|pkttype|cpu|cgroup|ipsec|time|day|hour)" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_meta_key_unqualified_set

" meta_key_qualified->meta_key->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_meta_key_qualified nftHL_Command
syn match nft_meta_stmt_meta_key_qualified "\v(length|protocol|priority|random|secmark)" skipwhite contained

" meta_key->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
syn cluster nft_c_meta_stmt_meta_key
\ contains=
\    nft_meta_stmt_meta_key_qualified,
\    nft_meta_stmt_meta_key_unqualified

" 'meta'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_meta nftHL_Command
syn match nft_meta_stmt_meta "meta" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_meta_string,
\    nft_meta_stmt_meta_key

" 'set'->meta_key_unqualified->(meta_stmt|meta_key|meta_stmt)
hi link nft_meta_stmt_meta_key_unqualified_set nftHL_Command
syn match nft_meta_stmt_meta_key_unqualified_set "set" skipwhite contained
\ nextgroup=
\    nft_stmt_expr

" 'notrack'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_notrack nftHL_Command
syn match nft_meta_stmt_notrack "notrack" skipwhite contained

hi link nft_meta_stmt_at_string_unquoted nftHL_String
syn match nft_meta_stmt_at_string_unquoted "\v[a-zA-Z0-9\/\\\[\]\$]{1,64}" skipwhite keepend contained

hi link nft_meta_stmt_at_string_sans_double_quote nftHL_String
syn match nft_meta_stmt_at_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link nft_meta_stmt_at_string_sans_single_quote nftHL_String
syn match nft_meta_stmt_at_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link nft_meta_stmt_at_string_single nftHL_String
syn region nft_meta_stmt_at_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=nft_meta_stmt_at_string_sans_single_quote

hi link nft_meta_stmt_at_string_double nftHL_String
syn region nft_meta_stmt_at_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=nft_meta_stmt_at_string_sans_double_quote

syn cluster nft_c_meta_stmt_at_quoted_string
\ contains=
\    nft_meta_stmt_at_string_single,
\    nft_meta_stmt_at_string_double

" <string>->'at'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_c_meta_stmt_at_string nftHL_String
syn cluster nft_c_meta_stmt_at_string
\ contains=
\    @nft_c_meta_stmt_at_quoted_string,
\    nft_meta_stmt_at_string_unquoted

" 'at'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_at nftHL_Command
syn match nft_meta_stmt_at "at" skipwhite contained
\ nextgroup=
\    @nft_c_meta_stmt_at_string

" 'add'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_add nftHL_Command
syn match nft_meta_stmt_add "add" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_at

" 'offload'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_offload nftHL_Command
syn match nft_meta_stmt_offload "offload" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_at

" 'flow'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link nft_meta_stmt_flow nftHL_Command
syn match nft_meta_stmt_flow "flow" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_offload,
\    nft_meta_stmt_add

" meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
syn cluster nft_c_meta_stmt
\ contains=
\    nft_meta_stmt_meta,
\    nft_meta_stmt_meta_key_unqualified,
\    nft_meta_notrack,
\    nft_meta_stmt_flow

" variable_expr->chain_expr->verdict_expr
hi link nft_chain_expr_variable_expr nftHL_Variable
syn match nft_chain_expr_variable_expr "\v\$[a-zA-Z0-9\/\\_\.]{1,65}" skipwhite contained
\ nextgroup=nft_EOS

" 'last'->identifier->chain_expr->verdict_expr
hi link nft_chain_expr_identifier_last nftHL_Action
syn match nft_chain_expr_identifier_last "last" skipwhite contained
\ nextgroup=nft_EOS

" <string>->identifier->chain_expr->verdict_expr
hi link nft_chain_expr_identifier_string nftHL_Action
syn match nft_chain_expr_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,65}" skipwhite contained
\ nextgroup=nft_EOS

" chain_expr->verdict_expr
syn cluster nft_c_chain_expr
\ contains=
\    nft_chain_expr_identifier_last,
\    nft_chain_expr_variable_expr,
\    nft_chain_expr_identifier_string
" nft_chain_expr_identifier_string has wildcard and must be last in contains=

" ('jump'|'goto')->verdict_expr->(verdict_stmt|set_rhs_expr)
hi link nft_verdict_expr_keywords_chain_expr nftHL_Command
syn match nft_verdict_expr_keywords_chain_expr "\v(jump|goto)" skipwhite contained
\ nextgroup=
\    @nft_c_chain_expr

" ('accept'|'drop'|'continue'|'return')->verdict_expr->(verdict_stmt|set_rhs_expr)
hi link nft_verdict_expr_keywords_unchained nftHL_Command
syn match nft_verdict_expr_keywords_unchained "\v(accept|drop|continue|return)" skipwhite contained
\ nextgroup=nft_EOS

" verdict_expr->(verdict_stmt|set_rhs_expr)
syn cluster nft_c_verdict_expr
\ contains=
\    nft_verdict_expr_keywords_unchained,
\    nft_verdict_expr_keywords_chain_expr,

" relational_op->relational-expr
hi link nft_relational_op nftHL_Operator
syn match nft_relational_op "\v(eq|neq|lt[e]|gt[e]|not)" skipwhite contained
\ nextgroup=
\    nft_list_rhs_expr,
\    @nft_c_rhs_expr,
\    @nft_c_basic_rhs_expr
" basic_rhs_expr must be the last 'contains=' entry
"     as its exclusive_or_rhs_expr->and_rhs_expr->shift_rhs_expr->primary_rhs_expr->symbol_expr
"     uses <string> which is a (wildcard)

" primary_rhs_expr_block->primary_rhs_expr->(basic_expr|shift_rhs_expr)
hi link nft_primary_rhs_expr_block nftHL_BlockDelimiters
syn region nft_primary_rhs_expr_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_basic_rhs_expr

" keyword_expr->(primary_rhs_expr|primary_stmt_expr|symbol_stmt_expr)
hi link nft_primary_rhs_expr_keywords nftHL_Command
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

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_lhs_expr concat_rhs_expr '}'
" concat_rhs->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_concat_rhs_expr
\ contains=
\    @nft_c_basic_rhs_expr,
\    @nft_c_multition_rhs_expr

" '<<'->shift_rhs_expr->(and_rhs_expr|basic_expr)
hi link nft_shift_rhs_expr_bi_shifts nftHL_Operator
syn match nft_shift_rhs_expr_bi_shifts "\v(<<|>>)" skipwhite contained
\ nextgroup=
\    @nft_c_shift_rhs_expr

" '&'->and_rhs_expr->(basic_expr|exclusive_or_rhs_expr)
hi link nft_and_rhs_expr_ampersand nftHL_Operator
syn match nft_and_rhs_expr_ampersand "&" skipwhite contained
\ nextgroup=
\    nft_c_and_rhs_expr

" shift_rhs_expr->(basic_expr|and_rhs_expr)
syn cluster nft_c_shift_rhs_expr
\ contains=
\   nft_primary_rhs_expr

" '~'->exclusive_or_rhs_expr->(concat_rhs_expr|list_rhs_expr|prefix_rhs_expr|primary_rhs_expr|range_rhs_expr|relational_expr)
hi link nft_exclusive_or_rhs_expr_caret nftHL_Operator
syn match nft_exclusive_or_rhs_expr_caret "\~" skipwhite contained
\ nextgroup=
\    @nft_c_exclusive_or_rhs_expr

" and_rhs_expr->(basic_expr|exclusive_or_rhs_expr)
syn cluster nft_c_and_rhs_expr
\ contains=
\   nft_c_shift_rhs_expr

" '|'->basic_rhs_expr->(concat_rhs_expr|list_rhs_expr|prefix_rhs_expr|primary_rhs_expr|range_rhs_expr|relational_expr)
hi link nft_basic_rhs_expr_again nftHL_Operator
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
hi link nft_boolean_keys nftHL_Action
syn match nft_boolean_keys "\v(exists|missing)" skipwhite contained

" boolean_expr->(primary_rhs_expr|primary_stmt_expr)
syn cluster nft_c_boolean_expr
\ contains=
\    nft_boolean_keys

syn cluster nft_c_rhs_expr
\ contains=
\    @nft_c_set_expr,
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

" limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config nftHL_Command
syn match nft_limit_config "rate" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_mode,
\    nft_limit_config_limit_rate_pktsbytes_num

hi link nft_ct_expect_config_ct_l4protoname nftHL_Type
syn match nft_ct_expect_config_ct_l4protoname "\v(udp|tcp)" skipwhite contained

" 'protocol'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_keyword_protocol nftHL_Action
syn match nft_ct_expect_config_keyword_protocol "protocol" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_ct_l4protoname

" <num>->('dport'|'size')->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_num nftHL_Action
syn match nft_ct_expect_config_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'dport'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_keyword_dport nftHL_Action
syn match nft_ct_expect_config_keyword_dport "dport" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_num

" 'size'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_keyword_size nftHL_Action
syn match nft_ct_expect_config_keyword_size "size" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_num

" <time_spec>->'timeout'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_time_spec nftHL_Family
syn match nft_ct_expect_config_time_spec "\w{1,32}" skipwhite contained

" 'timeout'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_keyword_timeout nftHL_Action
syn match nft_ct_expect_config_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_time_spec

" ('ip'|'ip6'|'inet'|'bridge'|'netdev'|'arp')->'l3proto'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_family_spec_explicit nftHL_Family
syn match nft_ct_expect_config_family_spec_explicit "\v(ip[6]|inet|bridge|netdev|arp)" skipwhite contained

" 'l3proto'->ct_expect_config->ct_expect_block
hi link nft_ct_expect_config_keyword_l3proto nftHL_Action
syn match nft_ct_expect_config_keyword_l3proto "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_family_spec_explicit

" ct_expect_config->ct_expect_block
syn cluster nft_c_ct_expect_config
\ contains=
\    nft_ct_expect_config_keyword_protocol,
\    nft_ct_expect_config_keyword_dport,
\    nft_ct_expect_config_keyword_size,
\    nft_ct_expect_config_keyword_timeout,
\    nft_ct_expect_config_keyword_l3proto

" 'protocol'->ct_timeout_config->ct_timeout_block
hi link nft_c_ct_timeout_config_ct_l4protoname nftHL_Command
syn match nft_c_ct_timeout_config_ct_l4protoname "\v(tcp|udp)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'protocol'->ct_timeout_config->ct_timeout_block
hi link nft_c_ct_timeout_config_keyword_protocol nftHL_Command
syn match nft_c_ct_timeout_config_keyword_protocol "protocol" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_ct_l4protoname

" <family_spec_explicit>->'l3proto'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_family_spec_explicit nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_ct_timeout_config_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_Semicolon

" 'l3protocol'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_keyword_l3protocol nftHL_Command
syn match nft_ct_timeout_config_keyword_l3protocol "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_family_spec_explicit

" ','->timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_policy_block_comma nftHL_Element
syn match nft_ct_timeout_config_policy_block_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_ct_timeout_config_policy_block_timeout_states

" time_spec_or_num_s->timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_policy_block_time_spec_or_num_s nftHL_Number
syn match nft_ct_timeout_config_policy_block_time_spec_or_num_s "\v\w{1,32}" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_comma

" timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_policy_block_colon nftHL_Expression
syn match nft_ct_timeout_config_policy_block_colon ":" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_time_spec_or_num_s

" timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_policy_block_timeout_state nftHL_Statement
syn match nft_ct_timeout_config_policy_block_timeout_state "\v\w{1,32}" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_colon

" timeout_states->'{'->'policy'->ct_timeout_config->ct_timeout_block
syn cluster nft_c_ct_timeout_config_policy_block_timeout_states
\ contains=
\    nft_ct_timeout_config_policy_block_timeout_state

" '{'->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_keyword_policy_block nftHL_BlockDelimiters
syn region nft_ct_timeout_config_keyword_policy_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_ct_timeout_config_policy_block_timeout_states
\ nextgroup=
\    nft_Semicolon

" '='->'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_keyword_policy_equal nftHL_Expression
syn match nft_ct_timeout_config_keyword_policy_equal "=" contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block

" 'policy'->ct_timeout_config->ct_timeout_block
hi link nft_ct_timeout_config_keyword_policy nftHL_Command
syn match nft_ct_timeout_config_keyword_policy "policy" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_equal

" ct_timeout_config->ct_timeout_block
syn cluster nft_c_ct_timeout_config
\ contains=
\    nft_ct_timeout_config_protocol,
\    nft_ct_timeout_config_l3protocol,
\    nft_ct_timeout_config_policy

" 'protocol'->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_ct_l4protoname nftHL_Family
syn match nft_ct_helper_config_ct_l4protoname "\v(tcp|udp)" skipwhite contained
\ nextgroup=nft_Semicolon

" 'protocol'->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_protocol nftHL_Command
syn match nft_ct_helper_config_protocol "protocol" skipwhite contained
\ nextgroup=nft_ct_helper_config_ct_l4protoname

" <quoted_string>->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_type_string_quoted nftHL_String
syn region nft_ct_helper_config_type_string_quoted start="\"" skip="\\\"" end="\"" skipwhite oneline contained
\ nextgroup=nft_ct_helper_config_protocol

" 'type'->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_type nftHL_Command
syn match nft_ct_helper_config_type "type" skipwhite contained
\ nextgroup=nft_ct_helper_config_type_string_quoted

" family_spec_explicit->'l3proto'->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_l3protocol_family_spec_explicit nftHL_Family
syn match nft_ct_helper_config_l3protocol_family_spec_explicit "\v(ip(6)?|inet|bridge|netdev|arp)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'l3proto'->ct_helper_config->ct_helper_block
hi link nft_ct_helper_config_l3protocol nftHL_Command
syn match nft_ct_helper_config_l3protocol "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_helper_config_l3protocol_family_spec_explicit

" ct_helper_config->ct_helper_block
syn cluster nft_c_ct_helper_config
\ contains=
\    nft_ct_helper_config_type,
\    nft_ct_helper_config_l3protocol

" skipping ct_l4protoname (via inlining)

" ct_cmd_type->list_cmd
hi link nft_ct_cmd_type nftHL_Type
syn match nft_ct_cmd_type "\v(helpers|timeout|expectation)" skipwhite contained

" ct_obj_type->(delete_cmd|destroy_cmd|list_cmd)
hi link nft_ct_obj_type nftHL_Type
syn match nft_ct_obj_type "\v(helpers|timeout|expectation)" skipwhite contained

" unquoted_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link nft_secmark_config_string_unquoted nftHL_String
syn match nft_secmark_config_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite keepend contained

" double_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link nft_secmark_config_string_sans_double_quote nftHL_String
syn match nft_secmark_config_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

" single_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link nft_secmark_config_string_sans_single_quote nftHL_String
syn match nft_secmark_config_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

" single_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link nft_secmark_config_string_single nftHL_String
syn region nft_secmark_config_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=nft_secmark_config_string_sans_single_quote

" double_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link nft_secmark_config_string_double nftHL_String
syn region nft_secmark_config_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=nft_secmark_config_string_sans_double_quote

" quoted_string->secmark_config->(add_cmd|create_cmd|secmark_block)
syn cluster nft_c_secmark_quoted_string
\ contains=
\    nft_secmark_config_string_single,
\    nft_secmark_config_string_double

" secmark_config->secmark_config->(add_cmd|create_cmd|secmark_block)
syn cluster nft_c_secmark_config
\ contains=
\    @nft_c_secmark_config_quoted_string,
\    nft_secmark_config_string_unquoted

" quota_unit->quota_config->(add_cmd|create_cmd|quota_block)
hi link nft_quota_config_quota_unit nftHL_Number
syn match nft_quota_config_quota_unit "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_quota_config_quota_used

" num->->quota_config->(add_cmd|create_cmd|quota_block)
hi link nft_quota_config_num nftHL_Number
syn match nft_quota_config_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_quota_config_quota_unit

" 'over'->quota_config->(add_cmd|create_cmd|quota_block)
hi link nft_quota_config_quota_mode nftHL_Number
syn match nft_quota_config_quota_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_quota_config_num

" 'until'->quota_config->(add_cmd|create_cmd|quota_block)
" quota_config->(add_cmd|create_cmd|quota_block)
syn cluster nft_c_quota_config
\ contains=
\    nft_quota_config_mode,
\    nft_quota_config_num

" num->'bytes'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_bytes_num nftHL_Number
syn match nft_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" 'bytes'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_bytes nftHL_Action
syn match nft_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_counter_config_bytes_num

" num->'packets'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_packet_num nftHL_Number
syn match nft_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_counter_config_bytes

" 'packets'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config nftHL_Identifier
syn match nft_counter_config "packet" skipwhite contained
\ nextgroup=
\    nft_counter_config_packet_num

" set_rhs_expr->(concat_rhs_expr|set_list_member_expr)
syn cluster nft_c_set_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr,
\    @nft_c_verdict_expr

" set_lhs_expr->set_elem_key_expr
syn cluster nft_c_set_lhs_expr
\ contains=
\    @nft_c_concat_rhs_expr

" time_spec->set_elem_expr_option->set_elem_expr
hi link   nft_set_elem_expr_option_time_spec nftHL_String
syn match nft_set_elem_expr_option_time_spec "\v\s{1,64}" skipwhite contained

" set_elem_expr_option->set_elem_expr
hi link   nft_set_elem_expr_option_expires nftHL_Element
syn match nft_c_set_elem_expr_timeout_expires "\v(timeout|expires)" skipwhite contained
\ nextgroup=
\    nft_set_elem_expr_option_time_spec

" set_elem_expr_option->set_elem_expr
syn cluster nft_c_set_elem_expr_option
\ contains=
\    nft_set_elem_expr_option_timeout_expires,
\    nft_comment_spec

" 'counter' 'packets' <NUM> 'bytes' <NUM>
"nnum->'bytes'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_counter_bytes_num nftHL_Number
syn match nft_set_elem_stmt_counter_bytes_num "\v\d{1,11}" skipwhite contained

" 'counter' 'packets' <NUM> 'bytes'
" 'bytes'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_counter_bytes nftHL_Action
syn match nft_set_elem_stmt_counter_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_bytes_num

" 'counter' 'packets' <NUM>
" num->'packets'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_counter_packets_num nftHL_Number
syn match nft_set_elem_stmt_counter_packets_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_bytes

" 'counter' 'packets'
" 'packets'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_counter_packets nftHL_Action
syn match nft_set_elem_stmt_counter_packets "packets" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_packets_num

" 'counter'
" 'counter'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_counter nftHL_Command
syn match nft_set_elem_stmt_counter "counter" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_packets

" 'rate'->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_rate nftHL_Command
syn match nft_set_elem_stmt_limit_rate "rate" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_limit_mode

" 'limit'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit nftHL_Command
syn match nft_set_elem_stmt_limit "limit" skipwhite contained
\ nextgroup=nft_set_elem_stmt_limit_rate

" 'num'->'ct'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_ct_num nftHL_Number
syn match nft_set_elem_stmt_ct_num "\v[0-9]{1,11}" skipwhite contained

" 'count'->'ct'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_ct_count nftHL_Command
syn match nft_set_elem_stmt_ct "count" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_ct_over,
\    nft_set_elem_stmt_ct_num

" 'ct'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_ct nftHL_Command
syn match nft_set_elem_stmt_ct "ct" skipwhite contained
\ nextgroup=nft_set_elem_stmt_ct_count

" quota_unit->quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_used_unit nftHL_Action
syn match nft_set_elem_stmt_quota_used_unit "\v(bytes|strings)" skipwhite contained

" quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_used_num nftHL_Number
syn match nft_set_elem_stmt_quota_used_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_unit_used

" quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_used nftHL_Action
syn match nft_set_elem_stmt_quota_used "used" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_used_num,
\    nft_Error_Always

" quota_unit->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_unit nftHL_Action
syn match nft_set_elem_stmt_quota_unit "\v(bytes|strings)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_used

" num->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_num nftHL_Number
syn match nft_set_elem_stmt_quota_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_unit

" 'over/under'->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota_mode nftHL_Action
syn match nft_set_elem_stmt_quota_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_num

" 'quota'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_quota nftHL_Command
syn match nft_set_elem_stmt_quota "quota" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_mode,
\    nft_set_elem_stmt_quota_num

" time_spec->'last'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_last_time_spec nftHL_Number
syn match nft_set_elem_stmt_last_time_spec "\v\s{1,16}" skipwhite contained

" 'never'->'last'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_last_never nftHL_Action
syn match nft_set_elem_stmt_last_never "never" skipwhite contained

" 'used'->'last'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_last_used nftHL_Command
syn match nft_set_elem_stmt_last_used "used" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_last_never,
\    nft_set_elem_stmt_last_time_spec

" 'last'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_last nftHL_Command
syn match nft_set_elem_stmt_last "last" skipwhite contained
\ nextgroup=nft_set_elem_stmt_last_used

syn cluster nft_c_set_elem_stmt
\ contains=
\    nft_set_elem_stmt_counter,
\    nft_set_elem_stmt_limit,
\    nft_set_elem_stmt_ct,
\    nft_set_elem_stmt_quota,
\    nft_set_elem_stmt_last

" time_spec->set_elem_option->set_elem_options
hi link nft_set_elem_option_time_spec nftHL_Number
syn match nft_set_elem_option_time_spec "\v\s{1,16}" skipwhite contained

hi link   nft_set_elem_option_timeout_expires nftHL_Action
syn match nft_set_elem_option_timeout_expires "\v(timeout|expires)" skipwhite contained
\ nextgroup=nft_set_elem_option_time_spec

" set_elem_option->set_elem_options
syn cluster nft_c_set_elem_option
\ contains=
\    nft_set_elem_option_timeout_expires,
\    @nft_comment_spec

" set_elem_options->(meter_key_expr|set_elem_expr_stmt)
syn cluster nft_c_set_elem_options
\ contains=
\    @nft_c_set_elem_option

" set_elem_stmt->set_elem_expr_alloc->set_elem_expr
syn cluster nft_c_set_elem_expr_alloc
\ contains=
\    @nft_c_set_elem_key_expr

" set_elem_expr_alloc->set_elem_expr
syn cluster nft_c_set_elem_expr_alloc
\ contains=
\    @nft_c_set_elem_key_expr,
\    @nft_c_set_elem_stmt
" TODO make set_elem_key_expr start firstly before any set_elem_stmt

" '*'->set_elem_key_expr->set_elem_expr_alloc
hi link nft_set_elem_key_expr_asterisk nftHL_Expression
syn match nft_set_elem_key_expr_asterisk "\*" skipwhite contained

" set_elem_key_expr->set_elem_expr_alloc
syn cluster nft_c_set_elem_key_expr
\ contains=
\    nft_set_elem_key_expr_asterisk,
\    @nft_c_set_lhs_expr

" set_elem_expr_option->set_elem_expr->(set_list_member_expr|verdict_map_list_member_expr)
syn cluster nft_c_set_elem_expr_set_elem_expr_alloc
\ contains=
\    @nft_set_elem_expr_set_elem_expr_alloc
" TODO expand dual-logic of set_elem_expr_alloc specifically set_elem_expr_optionsset_elem_stmt_list

" set_elem_expr->(set_list_member_expr|verdict_map_list_member_expr)
syn cluster  nft_c_set_elem_expr
\ contains=
\    @nft_c_set_elem_expr_set_elem_expr_alloc

" meter_key_expr_alloc->meter_key_expr->meter_stmt_alloc
syn cluster nft_c_meter_key_expr_alloc
\ contains=
\    @nft_c_meter_key_expr__concat_expr
"  Probably have to clone nft_c_concat_expr in here for meter_key_expr
"  because of of follow-on 'stmt'
"\ nextgroup=
"\    @nft_c_stmt
"\    @nft_c_meter_key_expr__set_elem_options (whose nextgroup is 'stmt')

" meter_key_expr_alloc->meter_key_expr->meter_stmt_alloc
syn cluster nft_c_meter_key_expr
\ contains=
\    @nft_c_meter_key_expr_alloc

" set_list_member_expr->set-expr
syn cluster nft_c_set_list_member_expr
\ contains=
\    @nft_c_set_expr,
\    @nft_c_set_elem_expr
" TODO expand on set_rhs_expr->set_list_member_expr->set-expr

" set_expr->(expr|map_stmt_expr_set|rhs_expr|set_block_expr|set_list_member_expr)
" set_expr->set_list_member_expr
hi link   nft_set_expr nftHL_BlockDelimitersSet
syn region nft_set_expr start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_set_list_member_expr

" expr->(hash_expr|relational_expr)
syn cluster nft_c_expr
\ contains=
\    @nft_c_concat_expr,
\    @nft_c_set_expr,
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
hi link nft_fib_result nftHL_Action
syn match nft_fib_result "\v(oif|oifname|type)" skipwhite contained

hi link nft_fib_flag_comma nftHL_Expression
syn match nft_fib_flag_comma /,/ skipwhite contained
\ nextgroup=
\    @nft_c_fib_flag

" fib_flag->fib_expr->primary_expr
" (saddr|daddr|mark|iif|oif)
hi link nft_fib_flag nftHL_Action
syn match nft_fib_flag "\v(saddr|daddr|mark|iif|oif)" skipwhite contained
\ nextgroup=
\    nft_fib_flag_comma,
\    nft_fib_result

syn cluster nft_c_fib_flag
\ contains=
\    nft_fib_flag

" fib_expr->primary_expr
" 'fib' fib_flag [ '.' fib_flag ]* fib_result
hi link nft_fib_expr nftHL_Action
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

hi link nft_integer_expr nftHL_Number
syn match nft_integer_expr "\v\d{1,11}" skipwhite contained

hi link   nft_set_ref_symbol_expr_identifier nftHL_Identifier
syn match nft_set_ref_symbol_expr_identifier "\v[a-zA-Z_][a-zA-Z0-9\\\/_\.]{0,31}" skipwhite contained

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
syn match nft_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained

" match_stmt->stmt
syn cluster nft_c_match_stmt
\ contains=
\    nft_c_relational_expr

" meter_key_expr->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> [ 'size' <num> ] '{' meter_key_expr '}'
hi link   nft_meter_stmt_alloc_block nftHL_BlockDelimitersMeter
syn region nft_meter_stmt_alloc_block start='{' end='}' skipwhite contained
\ contains=
\    @nft_c_meter_key_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" NUM->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> 'size' <num>
hi link   nft_meter_stmt_alloc_num nftHL_Number
syn match nft_meter_stmt_alloc_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_block,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" SIZE->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> 'size'
hi link   nft_meter_stmt_alloc_size nftHL_Action
syn match nft_meter_stmt_alloc_size "size" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" <identifier> meter_stmt_alloc->meter_stmt
" meter_stmt_alloc->meter_stmt
" 'meter' <identifier>
hi link nft_meter_stmt_alloc_identifier nftHL_Identifier
syn match nft_meter_stmt_alloc_identifier "\v[A-Za-z][A-Za-z0-9]{0,63}" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_size,
\    nft_meter_stmt_alloc_block,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" meter_stmt_alloc->meter_stmt->stmt
" 'meter'
hi link nft_meter_stmt_alloc nftHL_Statement
syn match nft_meter_stmt_alloc "\vmeter\ze " skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" meter_stmt->stmt
syn cluster nft_c_meter_stmt
\ contains=
\    nft_meter_stmt_alloc

" 'set' 'at' <identifier> '{' set_elem_expr_stmt [ stateful_stmt_list ] ':' set_elem_expr_stmt '}'

" 'set' 'at' <identifier> '{'
hi link nft_map_stmt_block_delimiters nftHL_BlockDelimitersMap
syn region nft_map_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    nft_set_elem_expr_stmt

" 'set' 'at' <identifier>
" identifier->set_ref_symbol_expr->(rhs_expr|set_ref_expr)
hi link   nft_map_stmt_set_ref_symbol_expr_identifier nftHL_Identifier
syn match nft_map_stmt_set_ref_symbol_expr_identifier "\v[a-zA-Z_][a-zA-Z0-9\\\/_\.]{0,31}" skipwhite contained
\ nextgroup=
\    nft_map_stmt_block_delimiters

" 'set' 'at'
" set_ref_symbol_expr->(rhs_expr|set_ref_expr)
hi link   nft_map_stmt_set_ref_symbol_expr nftHL_Statement
syn match nft_map_stmt_set_ref_symbol_expr "at" skipwhite contained
\ nextgroup=
\    nft_map_stmt_set_ref_symbol_expr_identifier

hi link   nft_map_stmt_variable_expr nft_Variable
syn match nft_map_stmt_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained

" set_ref_expr->(map_stmt|set_stmt)"
syn cluster nft_c_map_stmt_set_ref_expr
\ contains=
\    nft_map_stmt_set_ref_symbol_expr,
\    nft_map_stmt_variable_expr
" set_ref_symbol_expr starts with 'at'
" variable_expr starts with '$'

" set_stmt_op->(map_stmt|set_stmt)->stmt
"  'add' | 'update' | 'delete
hi link nft_map_stmt_set_stmt_op nftHL_Command
syn match nft_map_stmt_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=
\    @nft_c_map_stmt_set_ref_expr

" map_stmt->stmt
" 'map'
syn cluster nft_c_map_stmt
\ contains=
\    nft_map_stmt_set_stmt_op


" set_ref_expr->(map_stmt|set_stmt)"
syn cluster nft_c_set_stmt_set_ref_expr
\ contains=
\    nft_set_stmt_set_ref_symbol_expr,
\    nft_set_stmt_variable_expr
" set_ref_symbol_expr starts with 'at'
" variable_expr starts with '$'

" 'set' 'add'|'update'|'delete' set_elem_expr_stmt_alloc [ set_elem_options ] set_ref_expr

" 'set' 'add'|'update'|'delete' set_elem_expr_stmt_alloc
" set_elem_expr_stmt_alloc->set_elem_expr_stmt->set_stmt->stmt
syn cluster nft_c_set_stmt_set_keyword_set_elem_expr_stmt
\ contains=@nft_c_concat_expr

" 'set' 'add'|'update'|'delete' set_elem_expr_stmt
" set_elem_expr_stmt->set_stmt->stmt
syn cluster nft_c_set_stmt_set_keyword_set_elem_expr_stmt
\ contains=nft_c_set_stmt_set_keyword_set_elem_expr_stmt

" 'set' 'add'|'update'|'delete'
" set_stmt_op->set_stmt->stmt
hi link nft_set_stmt_set_keyword_set_stmt_op nftHL_Statement
syn match nft_set_stmt_set_keyword_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=@nft_c_set_stmt_set_keyword_set_elem_expr_stmt

" 'set'
" 'set'->set_stmt->stmt
hi link nft_set_stmt_set_keyword nftHL_Statement
syn match nft_set_stmt_set_keyword "set" skipwhite contained
\ nextgroup=nft_set_stmt_set_keyword_set_stmt_op



" 'add'|'update'|'delete' [ $<identifier> | 'at' ... ] '{' set_elem_expr_stmt [ stateful_stmt_list ] '}'

syn cluster nft_c_set_stmt_block_set_elem_expr_stmt
\ contains=
\    @nft_c_concat_expr,
\    nft_set_elem_options

" '{'->set_stmt->stmt
" 'add'|'update'|'delete' [ $<identifier> | 'at' ... ] '{'
hi link nft_set_stmt_block_delimiters nftHL_BlockDelimitersSet
syn region nft_set_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\   @nft_c_set_stmt_block_set_elem_expr_stmt,
\   @nft_c_stateful_stmt_list

" set_stmt_op->set_stmt->stmt
" 'add'|'update'|'delete'
hi link nft_set_stmt_set_stmt_op nftHL_Statement
syn match nft_set_stmt_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=nft_set_stmt_op_set_ref_expr

" set_stmt->stmt
syn cluster nft_c_set_stmt
\ contains=
\    nft_set_stmt_set_keyword,
\    nft_set_stmt_set_stmt_op

" ( 'bypass' | 'fanout' ) ','
hi link nft_c_queue_stmt_flags_comma nftHL_Operator
syn match nft_queue_stmt_flags_comma "," skipwhite contained
\ nextgroup=@nft_c_queue_stmt_flags

" 'bypass' | 'fanout'
" queue_stmt_flag->queue_stmt_flags
hi link nft_c_queue_stmt_flag nftHL_Action
syn match nft_queue_stmt_flag "\v(bypass|fanout)" skipwhite contained
\ nextgroup=nft_queue_stmt_flags_comma

" ( 'bypass' | 'fanout' ) ',' ( 'bypass' | 'fanout' )
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
syn cluster nft_c_queue_stmt_flags
\ contains=nft_queue_stmt_flag

" 'numgen'
" 'jhash' | 'symhash'
" 'map'
" <NUM>
" $<variable>
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
" <integer> | $<variable>
" 'queue' 'flags' ('bypass'|'fanout') 'num' queue_stmt_expr_simple
syn cluster nft_c_queue_stmt_expr_simple
\ contains=
\    nft_queue_stmt_expr_simple_integer,
\    nft_queue_stmt_expr_simple_variable

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM> [ 'offset' <NUM> ]
" <NUM>->offset_opt->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link nft_queue_stmt_expr_numgen_expr_offset_opt_num nftHL_Number
syn match nft_queue_stmt_expr_numgen_expr_offset_opt_num "\v\d{1,11}" skipwhite contained

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM> [ 'offset' ]
" offset_opt->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_offset_opt nftHL_Action
syn match nft_queue_stmt_expr_numgen_expr_offset_opt "offset" skipwhite contained
\ nextgroup=nft_queue_stmt_expr_numgen_expr_offset_opt_num

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM>
" <NUM>->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_num nftHL_Number
syn match nft_queue_stmt_expr_numgen_expr_num "\v\d{1,11}" skipwhite contained
\ nextgroup=nft_queue_stmt_expr_numgen_expr_offset_opt

" 'numgen' ( 'inc' | 'random' ) 'mod'
" 'mod'->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_mod nftHL_Action
syn match nft_queue_stmt_expr_numgen_expr_mod "mod" skipwhite contained
\ nextgroup=nft_queue_stmt_expr_numgen_expr_num

" 'numgen' ( 'inc' | 'random' )
" numgen_type->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_type nftHL_Statement
syn match nft_queue_stmt_expr_numgen_expr_type "\v(inc|random)" skipwhite contained
\ nextgroup=nft_queue_stmt_expr_numgen_expr_mod

" 'numgen'
" numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr nftHL_Command
syn match nft_queue_stmt_expr_numgen_expr "numgen" skipwhite contained
\ nextgroup=nft_queue_stmt_expr_numgen_expr_type

" 'queue' 'jhash'
" hash_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_hash_expr_jhash nftHL_Command
syn match nft_queue_stmt_expr_hash_expr_jhash "jhash" skipwhite contained
\ nextgroup=nft_hash_expr_jhash_expr

" 'queue' 'symhash'
" 'symhash'->hash_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_hash_expr_symhash nftHL_Command
syn match nft_queue_stmt_expr_hash_expr_symhash "symhash" skipwhite contained

" 'queue'
" 'queue' 'to' queue_stmt_expr
" queue_stmt_expr->queue_stmt->stmt
syn cluster nft_c_queue_stmt_expr
\ contains=
\    nft_queue_stmt_expr_numgen_expr,
\    @nft_c_hash_expr,
\    nft_queue_stmt_expr_map_expr,
\    @nft_c_queue_stmt_expr_simple

" 'queue' ( 'bypass' | 'fanout' ) [ ',' ('bypass'|'fanout') ]
" queue_stmt_flag->queue_stmt_flags->queue_stmt_arg->queue_stmt_compat->queue_stmt->stmt
syn cluster nft_c_queue_stmt_compat_flags
\ contains=
\    @nft_c_queue_stmt_flags

" 'QUEUENUM'->queue_stmt_arg->queue_stmt_compat->queue_stmt->stmt
hi link nft_c_queue_stmt_compat_arg_queuenum nftHL_Statement
syn match nft_c_queue_stmt_compat_arg_queuenum "num" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr_simple

" 'queue' 'to'
" 'to'->'queue'->queue_stmt->stmt
hi link nft_c_queue_stmt_keyword_to nftHL_Statement
syn match nft_c_queue_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr

" ( 'bypass' | 'fanout' ) ','
hi link nft_queue_stmt_keyword_flags_queue_stmt_flags_comma nftHL_Operator
syn match nft_queue_stmt_keyword_flags_queue_stmt_flags_comma "," skipwhite contained
\ nextgroup=@nft_c_queue_stmt_keyword_flags_queue_stmt_flags

" 'queue' 'flags' ('bypass'|'fanout') 'to' queue_stmt_expr
" 'to'->queue_stmt_flag->queue_stmt_flags
hi link nft_queue_stmt_keyword_flags_queue_stmt_keyword_to nftHL_Action
syn match nft_queue_stmt_keyword_flags_queue_stmt_keyword_to "to" skipwhite contained
\ nextgroup=@nft_c_queue_stmt_expr

" 'queue' 'flags' ('bypass'|'fanout') 'num' queue_stmt_expr_simple
" 'num'->queue_stmt->stmt
hi link nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword nftHL_Command
syn match nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword "num" skipwhite contained
\ nextgroup=@nft_c_queue_stmt_expr_simple

" 'bypass' | 'fanout'
" queue_stmt_flag->queue_stmt_flags
hi link nft_queue_stmt_keyword_flags_queue_stmt_flag nftHL_Action
syn match nft_queue_stmt_keyword_flags_queue_stmt_flag "\v(bypass|fanout)" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_keyword_to,
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword,
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_comma

" ( 'bypass' | 'fanout' ) ',' ( 'bypass' | 'fanout' )
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
syn cluster nft_c_queue_stmt_keyword_flags_queue_stmt_flags
\ contains=nft_queue_stmt_keyword_flags_queue_stmt_flag

" 'queue' 'flags'
" 'flags'->'queue'->queue_stmt->stmt
hi link nft_c_queue_stmt_keyword_flags nftHL_Statement
syn match nft_c_queue_stmt_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_keyword_flags_queue_stmt_flags

" 'queue'
" 'queue'->queue_stmt->stmt
hi link nft_queue_stmt nftHL_Command
syn match nft_queue_stmt "queue" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_compat_flags,
\    @nft_c_queue_stmt_compat_arg_queuenum,
\    nft_c_queue_stmt_keyword_to,
\    nft_c_queue_stmt_keyword_flags

syn cluster nft_c_queue_stmt
\ contains=nft_queue_stmt

" ('random'|'fully-random'|'persistent') ','
" ','->nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
hi link nft_nf_nat_flags_comma nftHL_Action
syn match nft_nf_nat_flags_comma "," skipwhite contained
\ contains=
\    nft_nf_nat_flag

" nf_nat_flag
" ('random'|'fully-random'|'persistent')
" ('random'|'fully-random'|'persistent')->nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
hi link nft_nf_nat_flag nftHL_Action
syn match nft_nf_nat_flag "\v(random|fully\-random|persistent)" skipwhite contained
\ nextgroup=
\    nft_nf_nat_flags_comma

" nf_nat_flags
" nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
" nf_key_proto->(fwd_stmt|nat_stmt|rt_expr|tproxy_stmt)
syn cluster nft_c_nf_nat_flags
\ contains=
\    nft_nf_nat_flag

" 'fwd' ('ip'|'ip6') 'to'
" 'to'->fwd_stmt
hi link nft_fwd_stmt_nf_key_proto_keyword_to nftHL_Command
syn match nft_fwd_stmt_nf_key_proto_keyword_to "to" skipwhite contained
\ nextgroup=@nft_c_stmt_expr

" 'fwd' ('ip'|'ip6')
" nf_key_proto->fwd_stmt
hi link nft_fwd_stmt_nf_key_proto nftHL_Command
syn match nft_fwd_stmt_nf_key_proto "\vip[6]?" skipwhite contained
\ nextgroup=
\    nft_fwd_stmt_nf_key_proto_keyword_to

" 'fwd' 'to'
hi link nft_fwd_stmt_keyword_to nftHL_Command
syn match nft_fwd_stmt_keyword_to "to" skipwhite contained
\ nextgroup=@nft_c_stmt_expr

" 'fwd'
" fwd_stmt
hi link nft_fwd_stmt nftHL_Command
syn match nft_fwd_stmt "fwd" skipwhite contained
\ nextgroup=
\    nft_fwd_stmt_keyword_to,
\    nft_fwd_stmt_nf_key_proto

" TODO 'dup 'to' stmt_expr 'device' stmt_expr

" 'dup' 'to'
" 'to'->dup_stmt->stmt
hi link nft_dup_stmt_keyword_to nftHL_Command
syn match nft_dup_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'dup'
" dup_stmt->stmt
hi link nft_dup_stmt nftHL_Command
syn match nft_dup_stmt "dup" skipwhite contained
\ nextgroup=nft_dup_stmt_keyword_to

" 'redirect' 'to' [ ':' ] stmt_expr [ nf_nat_flags ]
" 'to' [ ':' ] stmt_expr
syn cluster nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr
\ contains=
\    @nft_c_stmt_expr

" redir_stmt_arg->redir_stmt
hi link   nft_redir_stmt_redir_stmt_arg_keyword_to_colon nftHL_Operator
syn match nft_redir_stmt_redir_stmt_arg_keyword_to_colon /:/ skipwhite contained
\ nextgroup=nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr

" 'to' nf_nat_flags
" redir_stmt_arg->redir_stmt
hi link   nft_redir_stmt_redir_stmt_arg_keyword_to nftHL_Command
syn match nft_redir_stmt_redir_stmt_arg_keyword_to "to" skipwhite contained
\ nextgroup=
\    nft_redir_stmt_redir_stmt_arg_keyword_to_colon,
\    nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr

" 'redirect'
" redir_stmt_alloc->redir_stmt->stmt
hi link nft_redir_stmt_redir_stmt_alloc_keyword_redir nftHL_Command
syn match nft_redir_stmt_redir_stmt_alloc_keyword_redir "redir" skipwhite contained
\ nextgroup=
\    nft_redir_stmt_redir_stmt_arg_keyword_to,
\    @nft_c_nf_nat_flags

" 'redirect'
" redir_stmt->stmt
syn cluster nft_c_redir_stmt
\ contains=nft_redir_stmt_redir_stmt_alloc_keyword_redir

" masq_stmt_args
" 'masquerade' 'to' ':' stmt_expr [ nf_nat_flags ]
" 'masquerade' nf_nat_flags
hi link nft_masq_stmt_masq_stmt_args_keyword_to nftHL_Command
syn match nft_masq_stmt_masq_stmt_args_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr
" TODO: expand stmt_expr to append nf_nat_flags

" 'masquerade'
" masq_stmt_alloc->masq_stmt->stmt
hi link nft_masq_stmt_masq_stmt_alloc_keyword_masq nftHL_Command
syn match nft_masq_stmt_masq_stmt_alloc_keyword_masq "masq" skipwhite contained
\ nextgroup=
\    nft_masq_stmt_masq_stmt_args_keyword_to,
\    @nft_c_nf_nat_flags

" 'masq'
" masq_stmt->stmt
syn cluster nft_c_masq_stmt
\ contains=nft_masq_keyword_masq

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


" set_expr->map_stmt_expr_set->map_stmt_expr
" set_ref_expr->map_stmt_expr_set->map_stmt_expr

" map_stmt_expr->stmt_expr
syn cluster nft_c_map_stmt_expr
\ contains=
\    @nft_c_concat_stmt_expr

" map_stmt_expr_set"
syn cluster nft_c_map_stmt_expr_set
\ contains=
\    @nft_c_set_expr,
\    @nft_c_set_ref_expr

" map_stmt_expr_set->map_stmt_expr
syn cluster nft_c_map_stmt
\ contains=nft_map

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

" primary_stmt_expr->shift_stmt_expr->and_stmt_expr-> exclusive_or_stmt_expr->basic_stmt_expr
syn cluster nft_c_primary_expr
\ contains=
\    nft_primary_stmt_expr_block_delimiters,
\    @nft_c_symbol_expr,
\    nft_integer_expr,
\    @nft_c_boolean_expr,
\    @nft_c_meta_expr,
\    nft_rt_expr,
\    nft_ct_expr,
\    nft_numgen_expr,
\    @nft_c_hash_expr,
\    payload_expr,
\    nft_keyword_expr,
\    nft_socket_expr,
\    nft_osf_expr,

" 'mss' <NUM> 'wscale' [ 'timestamp' ] [ 'sack-perm' ]
" synproxy_sack->synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link nft_synproxy_config_synproxy_sack nftHL_Statement
syn match nft_synproxy_config_synproxy_sack "sack\-perm" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'mss' <NUM> 'wscale' [ 'timestamp' ]
" synproxy_ts->synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link nft_synproxy_config_synproxy_ts nftHL_Statement
syn match nft_synproxy_config_synproxy_ts "timestamp" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_wscale_num nftHL_Number
syn match nft_synproxy_config_keyword_wscale_num "num" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_ts,
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_wscale nftHL_Action
syn match nft_synproxy_config_keyword_wscale "wscale" skipwhite contained
\ nextgroup=nft_synproxy_config_keyword_wscale_num


hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator nftHL_Command
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator ";" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_ts,
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale_num nftHL_Number
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale_num "num" skipwhite contained
\ nextgroup=nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator

" 'mss' <NUM> 'wscale'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale nftHL_Action
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale "wscale" skipwhite contained
\ nextgroup=nft_synproxy_config_keyword_mss_second_keyword_wscale_num

hi link nft_synproxy_config_keyword_mss_stmt_separator nftHL_Command
syn match nft_synproxy_config_keyword_mss_stmt_separator ";" skipwhite contained
\ nextgroup=nft_synproxy_config_keyword_mss_second_keyword_wscale

" 'mss' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_num nftHL_Number
syn match nft_synproxy_config_keyword_mss_num "num" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_keyword_wscale,
\    nft_synproxy_config_keyword_mss_stmt_separator

" 'mss'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss nftHL_Command
syn match nft_synproxy_config_keyword_mss "mss" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_num

syn cluster nft_synproxy_config
\ contains=
\    nft_synproxy_config_keyword_mss

" synproxy_arg->synproxy_stmt->stmt
hi link nft_synproxy_arg nftHL_Action
syn match nft_synproxy_arg "\v(timestamp|sack\-perm|((mss|wscale)num))" skipwhite contained
\ nextgroup=@nft_c_synproxy_arg

" 'synproxy'
" synproxy_stmt->stmt
syn match nft_synproxy_stmt_alloc "synproxy" skipwhite contained
\ nextgroup=
\    @nft_c_synproxy_arg

" 'synproxy'
" synproxy_stmt->stmt
syn cluster nft_c_synproxy_stmt
\ contains=
\    nft_synproxy_stmt

" 'tproxy' [ 'ip'|'ip6' ] 'to' stmt_expr ':' stmt_expr
syn match nft_tproxy_stmt_keyword_to_colon /:/ skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'tproxy' [ 'ip'|'ip6' ] 'to'
syn match nft_tproxy_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr,
\    nft_tproxy_stmt_keyword_to_colon

" 'tproxy' 'ip'
" 'tproxy' 'ip6'
syn match nft_tproxy_stmt_nf_key_proto "\v(ip[6]?)" skipwhite contained
\ nextgroup=nft_tproxy_stmt_keyword_to

" 'tproxy'
" tproxy_stmt->stmt
syn match nft_tproxy_stmt "tproxy" skipwhite contained
\ nextgroup=
\    nft_tproxy_stmt_keyword_to,
\    nft_tproxy_stmt_nf_key_proto

" ('snat'|'dnat') ('ip'|'ip6')
" 'ip[6]?'->nat_stmt_alloc->nat_stmt->stmt
hi link nft_nat_stmt_nf_key_proto nftHL_Action
syn match nft_nat_stmt_nf_key_proto "\vip[6]?" skipwhite contained

" ('snat'|'dnat') ('interval'|'prefix')
" 'interval'->nat_stmt_alloc->nat_stmt->stmt
hi link nft_nat_stmt_keyword_interval nftHL_Action
syn match nft_nat_stmt_keyword_interval "\v(interval|prefix)" skipwhite contained

" ('snat'|'dnat') 'to' stmt_expr
" stmt_expr->nat_stmt_alloc->nat_stmt->stmt
syn cluster nft_c_nat_stmt_keyword_to_stmt_expr_lone
\ contains=
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to' ':'
" ':'->nat_stmt_alloc->nat_stmt->stmt
syn match nft_c_nat_stmt_keyword_to_colon /:/ skipwhite contained
\ contains=
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to' stmt_expr ':' stmt_expr
" stmt_expr->nat_stmt_alloc->nat_stmt->stmt
syn cluster nft_c_nat_stmt_keyword_to_stmt_expr
\ contains=
\    @nft_c_nat_stmt_keyword_to_colon,
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to'
" 'to'->nat_stmt_alloc->nat_stmt->stmt
hi link nft_nat_stmt_keyword_to nftHL_Action
syn match nft_nat_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_nat_stmt_keyword_to_stmt_expr_lone,
\       nft_nat_stmt_keyword_to_colon,
\    @nft_c_nat_stmt_keyword_to_stmt_expr

" ('snat'|'dnat') ( 'interval' | 'prefix' )
" 'interval'|'prefix'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_keyword_interval nftHL_Action
syn match nft_nat_stmt_keyword_interval "interval" skipwhite contained
\ nextgroup=@nft_c_stmt_expr

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr' '.' 'port'
" 'port'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr_port nftHL_Action
syn match nft_nat_stmt_addr_port "port" skipwhite contained
\ nextgroup=nft_nat_stmt_keyword_to

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr' '.'
" '.'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr_dot nftHL_Action
syn match nft_nat_stmt_addr_dot "\." skipwhite contained
\ nextgroup=nft_nat_stmt_addr_port

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr'
" 'addr'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr nftHL_Action
syn match nft_nat_stmt_addr "addr" skipwhite contained
\ nextgroup=nft_nat_stmt_addr_dot

" ('snat'|'dnat') ( 'ip' | 'ip6' )
" 'ip'|'ip6'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_nf_key_proto nftHL_Action
syn match nft_nat_stmt_nf_key_proto "\v(ip[6]?)" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_keyword_to,
\    nft_nat_stmt_keyword_interval,
\    nft_nat_stmt_addr

" ('snat'|'dnat')
" nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt nftHL_Command
syn match nft_nat_stmt "\v(snat|dnat)" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_keyword_to,
\    nft_nat_stmt_keyword_interval,
\    nft_nat_stmt_nf_key_proto


" 'reject' 'with' 'icmp' 'type'
" 'reject' 'with' 'icmpv6' 'type'
" reject_opts->reject_stmt->stmt

hi link nft_reject_with_expr nftHL_Statement
syn match nft_reject_with_expr "type" skipwhite contained
\ nextgroup=
\    nft_keyword_string,
\    nft_integer_expr

" 'reject' 'with' 'icmp' 'type'
" 'reject' 'with' 'icmpv6' 'type'
" reject_opts->reject_stmt->stmt
hi link nft_reject_opts_keyword_type nftHL_Statement
syn match nft_reject_opts_keyword_type "type" skipwhite contained
\ nextgroup=nft_reject_with_expr

" 'reject' 'with' ('icmp'|'icmpv6')
" reject_opts->reject_stmt->stmt
hi link nft_reject_opts_keyword_icmp nftHL_Action
syn match nft_reject_opts_keyword_icmp "\vicmp[6]?" skipwhite contained
\ nextgroup=
\    nft_reject_opts_icmp_keyword_type,
\    nft_reject_with_expr

" 'reject' 'with' 'icmpx'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_icmpx nftHL_Action
syn match nft_reject_opts_keyword_icmpx "icmpx" skipwhite contained
\ nextgroup=
\    nft_reject_opts_icmp_keyword_type,
\    nft_reject_with_expr

" 'reject' 'with' 'tcp'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_tcp nftHL_Action
syn match nft_reject_opts_keyword_tcp "\vtcp\s{1,15}reset" skipwhite contained

" 'reject' 'with'
" reject_opts->reject_stmt->stmt
hi link nft_reject_opts nftHL_Statement
syn match nft_reject_opts "with" skipwhite contained
\ nextgroup=
\    nft_reject_opts_keyword_icmp,
\    nft_reject_opts_keyword_icmpx,
\    nft_reject_opts_keyword_tcp

hi link   nft_keyword_string nftHL_Command
syn match nft_keyword_string "string" skipwhite contained

" 'reject'
" reject_stmt_alloc->reject_stmt->stmt
hi link   nft_reject_stmt_keyword_reject nftHL_Command
syn match nft_reject_stmt_keyword_reject "reject" skipwhite contained
\ nextgroup=nft_reject_opts

" 'reject'
" reject_stmt->stmt
syn cluster nft_c_reject_stmt
\ contains=
\    nft_reject_stmt_keyword_reject


" limit_burst_pkts
" 'burst' <NUM> 'packets'
" 'packet'->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" 'packet'->limit_burst_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_keyword_packets nftHL_Action
syn match nft_limit_burst_pkts_keyword_packets "packets" skipwhite contained
\ nextgroup=nft_EOS

" 'burst' <NUM>
" num->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" num->limit_burst_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_num nftHL_Number
syn match nft_limit_burst_pkts_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_packets

" 'burst'
" 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" 'burst'->limit_burst_pkts->->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_keyword_burst nftHL_Command
syn match nft_limit_burst_pkts_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_num


" limit_burst_bytes
" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM> ('bytes'|'string')
" 'bytes'->limit_burst_bytes->limit_config
hi link   nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes nftHL_Action
syn match nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes "\v(bytes|string)" skipwhite contained
\ nextgroup=nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM> ('bytes'|'string')
" 'bytes'->limit_burst_bytes->set_elem_stmt->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes nftHL_Action
syn match nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes "\v(bytes|string)" skipwhite contained
\ nextgroup=nft_EOS

" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM>
" num->limit_burst_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_burst_bytes_limit_bytes_num nftHL_Number
syn match nft_limit_config_limit_burst_bytes_limit_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes

" limit_burst_bytes
" 'burst' <NUM>
" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM>
" num->limit_burst_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num nftHL_Number
syn match nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes

" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_burst_bytes_keyword_burst nftHL_Command
syn match nft_limit_config_limit_burst_bytes_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_limit_bytes_num

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_burst_bytes_keyword_burst nftHL_Command
syn match nft_set_elem_stmt_limit_burst_bytes_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num


" time_unit
" 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_pkts_time_unit nftHL_Action
syn match nft_limit_config_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_pkts_time_unit nftHL_Action
syn match nft_limit_stmt_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_pkts_time_unit nftHL_Action
syn match nft_set_elem_stmt_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst

" time_unit
" 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_keyword_burst,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->limit_stmt->stateful_stmt
hi link nft_limit_stmt_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_burst_bytes_keyword_burst,
\    nft_EOS

" time_unit
" 'limit' 'rate' [ 'over'|'until' ] <NUM> ('bytes'|'string') '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_keyword_burst,
\    nft_EOS


" limit_rate_pkts
" 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_limit_config_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_pkts_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->limit_stmt->(add_cmd|create_cmd|limit_block)
hi link nft_limit_stmt_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_limit_stmt_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_pkts_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->set_elem_stmt->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_pkts_time_unit

" limit_rate_bytes
" 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link nft_limit_stmt_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_time_unit


" 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_expression_slash,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_expression_slash,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_expression_slash,
\    nft_EOS


" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->*->limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config_limit_rate_pktsbytes_num nftHL_Number
syn match nft_limit_config_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_keyword_string,
\    nft_limit_config_limit_rate_pkts_expression_slash,
\    nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes

" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->*->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_pktsbytes_num nftHL_Number
syn match nft_limit_stmt_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_keyword_string,
\    nft_limit_stmt_limit_rate_pkts_expression_slash,
\    nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes

" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->limit_rate->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_pktsbytes_num nftHL_Number
syn match nft_set_elem_stmt_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_keyword_string,
\    nft_limit_config_limit_rate_pkts_expression_slash,
\    nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes


" 'quota' <NUM> ('bytes'|'string') [ 'used' <NUM> ('bytes'|'string') ]
" quota_unit->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_quota_unit nftHL_Action
syn match nft_quota_stmt_quota_used_quota_unit "\v(bytes|string)" skipwhite contained
\ nextgroup=nft_EOS

" 'quota' <NUM> ('bytes'|'string') [ 'used' <NUM> ... ]
" <NUM>->quota_used->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_num nftHL_Number
syn match nft_quota_stmt_quota_used_num "\d{1,11}" skipwhite contained
\ nextgroup=nft_quota_stmt_quota_used_quota_unit

" 'quota' <NUM> ('bytes'|'string') [ 'used' ... ]
" 'used'->quota_used->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_keyword_used nftHL_Statement
syn match nft_quota_stmt_quota_used_keyword_used "used" skipwhite contained
\ nextgroup=nft_quota_stmt_quota_used_num

" 'quota' <NUM> ('bytes'|'string')
" quota_unit->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_unit nftHL_Action
syn match nft_quota_stmt_quota_unit "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_used_keyword_used,
\    nft_EOS

" 'quota' <NUM>
" <NUM>->quota_mode->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_num nftHL_Number
syn match nft_quota_stmt_num "\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_unit

" 'quota' quota_mode
" quota_mode->quota_stmt->stateful_stmt
hi link   nft_quota_mode nftHL_Action
syn match nft_quota_mode "\v(over|until)" skipwhite contained
\ nextgroup=nft_quota_stmt_num

" 'quota'
" quota_stmt->stateful_stmt
hi link   nft_quota_mode nftHL_Command
syn match nft_quota_stmt "quota" skipwhite contained
\ nextgroup=
\    nft_quota_mode,
\    nft_quota_stmt_num


" 'rate' [ 'over'|'until' ]
" limit_mode->limit_config->(add_cmd|create_cmd|limit_block)
hi link nft_limit_config_limit_mode nftHL_Action
syn match nft_limit_config_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_pktsbytes_num

" 'limit' 'rate' [ 'over'|'until' ]
" limit_mode->limit_stmt->stateful_stmt
hi link nft_limit_stmt_limit_config_limit_mode nftHL_Action
syn match nft_limit_stmt_limit_config_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_pktsbytes_num

" 'limit' 'rate' [ 'over'|'until' ]
" limit_mode->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link nft_set_elem_stmt_limit_mode nftHL_Action
syn match nft_set_elem_stmt_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_pktsbytes_num

" 'rate'->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_keyword_rate nftHL_Statement
syn match nft_limit_stmt_keyword_rate "rate" skipwhite contained
\ nextgroup=
\    nft_limit_mode


" 'limit'
" 'limit'->limit_stmt->stateful_stmt
hi link   nft_limit_stmt nftHL_Command
syn match nft_limit_stmt "limit" skipwhite contained
\ nextgroup=nft_limit_stmt_keyword_rate


" 'log' 'flags' 'tcp' log_flag_tcp ',' log_flag_tcp
" log_flag_tcp->log_flags->log_arg->log_stmt->stmt
hi link   nft_log_flags_log_flag_keyword_tcp nftHL_Action
syn match nft_log_flags_log_flag_keyword_tcp "\v(seq|options)" skipwhite contained
\ nextgroup=
\    nft_log_flags_log_flags_tcp_expression_comma,
\    nft_EOS

" 'log' 'flags' 'tcp' 'seq'|'options' ','
" ','->log_flag_tcp->log_arg->log_stmt->stmt
hi link   nft_log_flags_log_flags_tcp_expression_comma nftHL_Operator
syn match nft_log_flags_log_flags_tcp_expression_comma /,/ skipwhite contained
\ nextgroup=
\    @nft_c_log_flags_log_flags_tcp,
\    nft_EOS

" 'log' 'flags' 'tcp' ('seq'|'options')
" log_flag_tcp->log_arg->log_stmt->stmt
syn cluster nft_c_log_flags_log_flags_tcp
\ contains=
\    nft_log_flags_log_flag_keyword_tcp

" 'log' 'flags' 'tcp'
" 'tcp'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_tcp nftHL_Action
syn match nft_log_flags_keyword_tcp "tcp" skipwhite contained
\ nextgroup=
\    @nft_c_log_flags_log_flags_tcp,
\    nft_UnexpectedEOS

" 'log' 'flags' 'ip' 'options'
" 'options'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ip_keyword_options nftHL_Action
syn match nft_log_flags_keyword_ip_keyword_options "options" skipwhite contained
\ nextgroup=nft_EOS

" 'log' 'flags' 'ip'
" 'ip'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ip nftHL_Action
syn match nft_log_flags_keyword_ip "ip" skipwhite contained
\ nextgroup=
\    nft_log_flags_keyword_ip_keyword_options,
\    nft_UnexpectedEOS

" 'log' 'flags' 'skuid'
" 'skuid'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_skuid nftHL_Action
syn match nft_log_flags_keyword_skuid "skuid" skipwhite contained
\ nextgroup=nft_EOS

" 'log' 'flags' 'ether'
" 'ether'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ether nftHL_Action
syn match nft_log_flags_keyword_ether "ether" skipwhite contained
\ nextgroup=nft_EOS

" 'log' 'flags' 'all'
" 'all'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_all nftHL_Action
syn match nft_log_flags_keyword_all "all" skipwhite contained
\ nextgroup=nft_EOS

" 'log' 'prefix' <ASTERISK_STRING>
hi link   nft_log_arg_keyword_prefix_string_asterisks nftHL_String
syn region nft_log_arg_keyword_prefix_string_asterisks start="\*" end="\*" skip="\\\*" skipwhite oneline contained
\ nextgroup=nft_EOS

" 'log' 'prefix' <QUOTED_STRING> (single-quoted)
hi link   nft_log_arg_keyword_prefix_string_quoted_singles nftHL_String
syn region nft_log_arg_keyword_prefix_string_quoted_singles start="\'" end="\'" skip="\\\'" skipwhite oneline contained
\ nextgroup=nft_EOS

" 'log' 'prefix' <QUOTED_STRING> (double-quoted)
hi link   nft_log_arg_keyword_prefix_string_quoted_doubles nftHL_String
syn region nft_log_arg_keyword_prefix_string_quoted_doubles start="\"" end="\"" skip="\\\"" skipwhite oneline contained
\ nextgroup=nft_EOS

" 'log' 'prefix' <STRING>  ; unquoted strings (no whitespace)
hi link   nft_log_arg_keyword_prefix_string_unquoted nftHL_String
syn match nft_log_arg_keyword_prefix_string_unquoted "\v[a-zA-Z0-9]{1,64}" skipwhite contained oneline
\ nextgroup=nft_EOS

" 'log' 'level' <STRING>
hi link nft_log_arg_string_level nftHL_String
syn match nft_log_arg_string_level "\v(emerg|alert|crit|err|warn|notice|info|debug|audit|level[0-9])" skipwhite contained
\ nextgroup=nft_EOS

" 'log' 'group' <NUM>
" 'log' 'snaplen' <NUM>
" 'log' 'queue-threshold' <NUM>
hi link   nft_log_arg_num nftHL_Number
syn match nft_log_arg_num "\v\d{1,11}" skipwhite contained
\ nextgroup=nft_EOS

" nft_log_arg_keyword_prefix
hi link   nft_log_arg_keyword_prefix nftHL_Statement
syn match nft_log_arg_keyword_prefix "prefix" skipwhite contained
\ nextgroup=
\    nft_log_arg_keyword_prefix_string_quoted_singles,
\    nft_log_arg_keyword_prefix_string_quoted_doubles,
\    nft_log_arg_keyword_prefix_string_asterisks,
\    nft_log_arg_keyword_prefix_string_unquoted,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_group
hi link   nft_log_arg_keyword_group nftHL_Statement
syn match nft_log_arg_keyword_group "group" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_snaplen
hi link   nft_log_arg_keyword_snaplen nftHL_Statement
syn match nft_log_arg_keyword_snaplen "snaplen" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

"  nft_log_arg_keyword_queue_threshold
hi link   nft_log_arg_keyword_queue_threshold nftHL_Statement
syn match nft_log_arg_keyword_queue_threshold "queue\-threshold" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_level
hi link   nft_log_arg_keyword_level nftHL_Statement
syn match nft_log_arg_keyword_level "level" skipwhite contained
\ nextgroup=
\    nft_log_arg_string_level,
\    nft_UnexpectedEOS

" 'log' 'flags' ('tcp'|'ip'|'skuid'|'ether'|'all')
" log_flags->log_arg->log_stmt->stmt
hi link   nft_log_arg_keyword_flags nftHL_Statement
syn match nft_log_arg_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    nft_log_flags_keyword_tcp,
\    nft_log_flags_keyword_ip,
\    nft_log_flags_keyword_skuid,
\    nft_log_flags_keyword_ether,
\    nft_log_flags_keyword_all,
\    nft_UnexpectedEOS

" 'log' ( log_arg )*
" log_arg->log_stmt->stmt
syn cluster nft_c_log_arg
\ contains=
\    nft_log_arg_keyword_prefix,
\    nft_log_arg_keyword_group,
\    nft_log_arg_keyword_snaplen,
\    nft_log_arg_keyword_queue_threshold,
\    nft_log_arg_keyword_level,
\    nft_log_arg_keyword_flags

" 'log'
" log_stmt->stmt
hi link   nft_log_stmt nftHL_Command
syn match nft_log_stmt "log" skipwhite contained
\ nextgroup=
\    @nft_c_log_arg,
\    nft_EOS
" No `nft_UnexpectedEOS` for nft_log_stmt, `log` alone is permitted.


" 'last' 'used' time_spec
" time_spec->last_stmt->stateful_stmt
hi link   nft_last_stmt_time_spec nftHL_String
syn match nft_last_stmt_time_spec "\v[\s\w]{1,63}" skipwhite contained
\ nextgroup=nft_EOS

" 'last' 'used' 'never'
" 'never'->last_stmt->stateful_stmt
hi link   nft_last_stmt_time_spec nftHL_Action
syn match nft_last_stmt_keyword_never "never" skipwhite contained
\ nextgroup=nft_EOS

" 'last' 'used'
" 'used'->last_stmt->stateful_stmt
hi link   nft_last_stmt_keyword_used nftHL_Statement
syn match nft_last_stmt_keyword_used "used" skipwhite contained
\ nextgroup=
\    nft_last_stmt_keyword_never,
\    nft_last_stmt_time_spec

" 'last'
" last_stmt->stateful_stmt
hi link   nft_last_stmt_keyword_last nftHL_Command
syn match nft_last_stmt_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_last_stmt_keyword_used,
\    nft_EOS

syn cluster nft_c_last_stmt
\ contains=
\    nft_last_stmt_keyword_last


syn cluster nft_c_counter_arg
\ contains=
\    nft_counter_arg

" 'packets'|'bytes' <NUM>
" <NUM>->counter_arg->counter_stmt->stateful_stmt
hi link   nft_counter_arg_num nftHL_Number
syn match nft_counter_arg_num "\v\d{1,11}" skipwhite contained

" 'packets'|'bytes'
" counter_arg->counter_stmt->stateful_stmt
hi link   nft_counter_arg nftHL_Statement
syn match nft_counter_arg "\v(packets|bytes)" skipwhite contained
\ nextgroup=
\    nft_counter_arg_num,
\    nft_Error

" 'counter'
" counter_stmt->stateful_stmt
hi link   nft_counter_stmt nftHL_Command
syn match nft_counter_stmt "counter" skipwhite contained
\ nextgroup=
\    nft_counter_arg,
\    nft_UnexpectedEOS,
\    nft_Error
" TODO NOTE: eventually, one of counter_stmt and add_cmd_counter will have `^` to differentiate between


" 'ct' 'count' [ 'over' ] <NUM>
" <NUM>->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_num nftHL_Number
syn match nft_connlimit_stmt_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'ct' 'count' 'over'
" 'over'->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_keyword_over nftHL_Action
syn match nft_connlimit_stmt_keyword_over "over" skipwhite contained
\ nextgroup=
\    nft_connlimit_stmt_num,
\    nft_Error

" 'ct' 'count'
" 'count'->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_keyword_count nftHL_Command
syn match nft_connlimit_stmt_keyword_count "\vct {1,15}count" skipwhite contained
\ nextgroup=
\    nft_connlimit_stmt_keyword_over,
\    nft_connlimit_stmt_num

" set_elem_stmt->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt
\ contains=
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_counter,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_limit,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_ct,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_quota,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_last,

" '*'->set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn match nft_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_asterisk "\*" skipwhite contained
\ nextgroup=nft_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt

" set_lhs_expr->set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_lhs_expr
\ contains=nft_nothing

" set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr
\ contains=nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_lhs_expr

" set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc
\ contains=nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr

" cannot use nft_c_set_elem_expr here,
" MUST CLONE IT ALL because we continue on with ':'
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_alloc
\ contains=nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc

hi link    nft_verdict_map_expr_block_delimiters nftHL_BlockDelimitersMap
syn region nft_verdict_map_expr_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_verdict_map_list_member_expr

" '{'
" verdict_map_expr->verdict_map_stmt
syn cluster nft_c_verdict_map_expr
\ contains=
\    nft_verdict_map_expr_block_delimiters,
\    @nft_c_set_ref_expr

hi link   nft_verdict_map_expr_keyword_vmap nftHL_Command
syn match nft_verdict_map_expr_keyword_vmap "vmap" skipwhite contained
\ nextgroup=
\    @nft_c_verdict_map_expr

syn cluster nft_c_verdict_map_stmt
\ contains=
\    nft_verdict_map_expr_keyword_vmap
" TODO: need to insert concat_expr into here

" verdict_stmt->stmt
syn cluster nft_c_verdict_stmt
\ contains=
\    @nft_c_verdict_expr,
\    @nft_c_verdict_map_stmt

" 'jump'|'goto' '{' rule '}'
" rule->chain_stmt_type->chain_stmt->stmt
syn cluster nft_c_chain_stmt_block_rule
\ contains=@nft_c_rule
" TODO missing stmt_separator

" 'jump'|'goto' '{' ...
" chain_stmt_type->chain_stmt->stmt
hi link    nft_chain_stmt_block_delimiters nftHL_BlockDelimitersChain
syn region nft_chain_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_chain_stmt_block_rule
\ nextgroup=
\    nft_EOS

" 'jump'|'goto'
" chain_stmt_type->chain_stmt->stmt
hi link   nft_chain_stmt_type nftHL_Statement
syn match nft_chain_stmt_type "\v(jump|goto)" skipwhite contained
\ nextgroup=nft_chain_stmt_block_delimiters

" chain_stmt->stmt
syn cluster nft_c_chain_stmt
\ contains=
\   nft_chain_stmt_type


" 'xt' 'string' <STRING>
" <STRING>->xt_stmt->stmt
hi link   nft_xt_stmt_string nftHL_String
syn match nft_xt_stmt_string "\v[a-zA-Z0-9 ]{1,64}" skipwhite contained
\ nextgroup=nft_EOS

" 'xt' 'string'
" 'string'->xt_stmt->stmt
hi link   nft_xt_stmt_keyword_string nftHL_Statement
syn match nft_xt_stmt_keyword_string "string" skipwhite contained
\ nextgroup=nft_xt_stmt_string

" 'xt'
" xt_stmt->stmt
hi link   nft_xt_stmt nftHL_Command
syn match nft_xt_stmt "xt" skipwhite contained
\ nextgroup=nft_xt_stmt_keyword_string

" stmt->(meter_stmt_alloc|rule_alloc)
syn cluster nft_c_stmt
\ contains=
\    @nft_c_verdict_stmt,
\    @nft_c_chain_stmt,
\    nft_ct_stmt,
\    @nft_c_match_stmt,
\    @nft_c_meter_stmt,
\    @nft_c_payload_stmt,
\    @nft_c_stateful_stmt,
\    @nft_c_reject_stmt,
\    nft_log_stmt,
\    nft_nat_stmt,
\    @nft_c_meta_stmt,
\    nft_masq_stmt,
\    @nft_c_redir_stmt,
\    nft_tproxy_stmt,
\    @nft_c_queue_stmt,
\    nft_dup_stmt,
\    nft_fwd_stmt,
\    @nft_c_set_stmt,
\    @nft_c_map_stmt,
\    nft_optstrip_stmt,
\    nft_xt_stmt,
\    nft_objref_stmt,
\    nft_synproxy_stmt,

" stateful_stmt->(stateful_stmt_list|stmt)
syn cluster nft_c_stateful_stmt
\ contains=
\    @nft_c_last_stmt,
\    nft_counter_stmt,
\    nft_limit_stmt,
\    nft_quota_stmt,
\    nft_connlimit_stmt_keyword_count

" objref_stmt->stmt
syn cluster nft_c_objref_stmt
\ contains=
\    nft_objref_stmt_counter,
\    nft_objref_stmt_limit,
\    nft_objref_stmt_quota,
\    nft_objref_stmt_synproxy,
\    nft_objref_stmt_keyword_ct

" SLE update


" 'ct' ('timeout'|'expectation') 'set'
" 'set'->objref_stmt_ct->objref_stmt->stmt
syn match nft_objref_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'ct' 'timeout'
" 'timeout'->objref_stmt_ct->objref_stmt->stmt
syn match nft_objref_stmt_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_ct_keyword_set

" 'ct' 'expectation'
" 'expectation'->objref_stmt_ct->objref_stmt->stmt
hi link   nft_objref_stmt_keyword_ct_keyword_expectation nftHL_Command
syn match nft_objref_stmt_keyword_ct_keyword_expectation "expectation" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_ct_keyword_set

" 'ct'
" objref_stmt_ct->objref_stmt->stmt
hi link   nft_objref_stmt_keyword_ct nftHL_Command
syn match nft_objref_stmt_keyword_ct "ct" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_keyword_ct_keyword_timeout,
\    nft_objref_stmt_keyword_ct_keyword_expectation

" 'synproxy' 'name'
" 'name'->objref_stmt_synproxy->objref_stmt->stmt
syn match nft_objref_stmt_synproxy_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'synproxy'
" objref_stmt_synproxy->objref_stmt->stmt
syn match nft_objref_stmt_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_synproxy_keyword_name

" 'quota' 'name'
" 'name'->objref_stmt_quota->objref_stmt->stmt
syn match nft_objref_stmt_quota_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'quota'
" objref_stmt_quota->objref_stmt->stmt
syn match nft_objref_stmt_quota "quota" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name

" 'limit' 'name'
" 'name'->objref_stmt_limit->objref_stmt->stmt
syn match nft_objref_stmt_limit_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'limit'
" objref_stmt_limit->objref_stmt->stmt
syn match nft_objref_stmt_limit "limit" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name

" 'counter' 'name'
" 'name'->objref_stmt_counter->objref_stmt->stmt
syn match nft_objref_stmt_counter_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'counter'
" objref_stmt_counter->objref_stmt->stmt
syn match nft_objref_stmt_counter "counter" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name

" stateful_stmt_list->(map_block|map_stmt|set_block|set_stmt)
syn cluster nft_c_stateful_stmt_list
\ contains=
\    @nft_c_stateful_stmt,
\    nft_EOS

syn cluster nft_c_rule_alloc
\ contains=
\    @nft_c_stmt

syn cluster nft_c_rule
\ contains=
\    @nft_c_rule_alloc

syn cluster nft_c_base_cmd_list_cmd_basehook_spec_ruleset_spec
\ contains=
\    nft_base_cmd_list_rule_cmd_keyword_ruleset_spec_family_spec,
\    nft_base_cmd_list_rule_ruleset_spec_id_table

" base_cmd 'reset' 'rule' table_id chain_id
hi link   nft_base_cmd_reset_rule_ruleset_spec_id_chain nftHL_Chain
syn match nft_base_cmd_reset_rule_ruleset_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd 'reset' 'counter'/'quota' family_spec
hi link   nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_family_spec nftHL_Family
syn match nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_id_table

" base_cmd 'reset' 'rule' table_id
hi link   nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_id_table nftHL_Family
syn match nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_id_table "\v[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained
\ nextgroup=nft_base_cmd_reset_rule_ruleset_spec_id_chain

" add_cmd 'table' table_block table_options comment_spec 'comment' string UNQUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_unquoted nftHL_String
syn match nft_add_table_table_options_comment_spec_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]]{0,63}" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_table_table_options_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_table_table_options_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

hi link    nft_add_table_table_options_comment_spec_string_single nftHL_String
syn region nft_add_table_table_options_comment_spec_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=nft_add_table_table_options_comment_spec_string_sans_double_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_double nftHL_String
syn region nft_add_table_table_options_comment_spec_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=nft_add_table_table_options_comment_spec_string_sans_single_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_sans_asterisk_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_asterisk_quote "\v[\'\"\sa-zA-Z0-9\/\\\[\]\']+" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string <ASTERISK_STRING>
hi link    nft_add_table_table_options_comment_spec_string_asterisked nftHL_String
syn region nft_add_table_table_options_comment_spec_string_asterisked start="\*" skip="\\\*" end="\*" excludenl skipnl skipempty skipwhite keepend oneline contained
\ contains=nft_add_table_table_options_comment_spec_string_sans_asterisk_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string
syn cluster nft_c_add_table_table_block_table_options_comment_spec_string
\ contains=
\     nft_add_table_table_options_comment_spec_string_asterisked,
\    nft_add_table_table_options_comment_spec_string_single,
\    nft_add_table_table_options_comment_spec_string_double,
\    nft_add_table_table_options_comment_spec_string_unquoted

" add_cmd 'table' table_block table_options comment_spec 'comment'
hi link   nft_add_table_table_options_comment_spec nftHL_Statement
syn match nft_add_table_table_options_comment_spec "comment" skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_table_options_comment_spec_string

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
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_handle_spec,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd ('delete'|'destroy'|'reset') [ family_spec ] table_identifier
hi link   nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id nftHL_Table
syn match nft_delete_destroy_reset_cmd_ruleid_spec_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
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
" 'insert' 'rule' [ family_spec ] table_id chain_id handle_id handle_idx
" base_cmd insert_cmd rule_position
" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec position_spec_num
hi link   nft_add_cmd_rule_position_chain_spec_position_spec_num nftHL_Number
syn match nft_add_cmd_rule_position_chain_spec_position_spec_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_rule_rule

" [[ 'add' ] 'rule' table_id chain_id ('position'|'handle'|'index') handle_idx
" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec table_spec identifier
hi link   nft_add_cmd_rule_position_chain_spec_table_spec_identifier nftHL_Table
syn match nft_add_cmd_rule_position_chain_spec_table_spec_identifier "\v([a-zA-Z][A-Za-z0-9\/\\_\.]{0,63}){2}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_chain_spec_identifier

" [[ 'add' ] 'rule' table_id chain_id ('position'|'handle'|'index')
" identifier->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_keywords_position_handle_index  nftHL_Command
syn match nft_add_cmd_rule_position_keywords_position_handle_index skipwhite contained
\ "\v(position|handle|index)"
\ nextgroup=nft_add_cmd_rule_position_chain_spec_position_spec_num

" [[ 'add' ] 'rule' [ 'ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp' ] table_id chain_id
" identifier->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_chain_spec nftHL_Identifier
syn match nft_add_cmd_rule_position_chain_spec "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_rule_rule,
\    nft_add_cmd_rule_position_keywords_position_handle_index
" FIXIT (needs loop within nft_c_add_cmd_rule_rule

" [[ 'add' ] 'rule' [ 'ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp' ] table_id
" base_cmd add_cmd [[ 'add' ] 'rule' ] table_spec
" identifier->table_spec->chain_spec->rule_position->'rule'->insert_cmd->'insert'->base_cmd
hi link   nft_add_cmd_rule_position_table_spec nftHL_Identifier
syn match nft_add_cmd_rule_position_table_spec "\v[A-Za-z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
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
hi link nft_table_block_keyword_set_set_keyword_last nftHL_Action
syn match nft_table_block_keyword_set_set_keyword_last "last" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'set' <STRING>
" set_identifier->'set'->table_block->add_cmd->base_cmd->line
hi link nft_table_block_keyword_set_set_identifier nftHL_Set
syn match nft_table_block_keyword_set_set_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

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
syn match nft_table_block_keyword_map_set_keyword_last "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'map' <STRING>
" <STRING>->set_identifier->'map'->table_block->add_cmd->base_cmd->line
hi link   nft_table_block_keyword_map_set_identifier nftHL_Set
syn match nft_table_block_keyword_map_set_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{' 'map' set_identifier
" set_identifier->'map'->table_block->add_cmd->base_cmd->line
syn cluster nft_c_table_block_keyword_map_set_identifier
\ contains=
\    nft_table_block_keyword_map_set_keyword_last,
\    nft_table_block_keyword_map_set_identifier

" 'delete' 'set' table_spec 'handle' <NUM>
" 'destroy' 'set' table_spec 'handle' <NUM>
" setid_spec->'set'->(delete_cmd|destroy_cmd)->('destroy'|'delete')->base_cmd->line
syn cluster nft_delete_destroy_cmd_keyword_set_family_spec
\ contains=
\    nft_delete_destroy_cmd_keyword_set_setid_spec_family_spec,
\    nft_delete_destroy_cmd_keyword_set_setid_spec_table_id

" 'delete' 'set' setid_spec
" 'destroy' 'set' setid_spec
" set_or_id_spec->'set'->(delete_cmd|destroy_cmd)->('destroy'|'delete')->base_cmd->line
syn cluster nft_delete_destroy_cmd_keyword_set_set_or_id_spec_setid_spec
\ contains=
\    nft_delete_destroy_cmd_keyword_set_setid_spec_family_spec,
\    nft_delete_destroy_cmd_keyword_set_setid_spec_table_id


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

" common_block 'undefine' identifier (via common_block 'undefine')
hi link nft_common_block_undefine_identifier nftHL_Identifier
syn match nft_common_block_undefine_identifier '\v[a-zA-Z][A-Za-z0-9\/\\_\.]{0,63}' oneline skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS

" commmon_block 'undefine' (via common_block)
hi link nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine "undefine" oneline skipwhite contained
\ nextgroup=
\    nft_common_block_undefine_identifier,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS



" SLE marker "

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" 'reset' 'set'
" 'reset' 'map'
" set_or_id_spec->'set'->reset_cmd->base_cmd->line
" set_or_id_spec->'map'->reset_cmd->base_cmd->line
"    nft_reset_cmd_keyword_set_set_or_id_spec
"    nft_reset_cmd_keyword_map_set_or_id_spec
"



" base_cmd 'reset' 'rule'
hi link nft_base_cmd_reset_rule nftHL_Action
syn match nft_base_cmd_reset_rule "rule" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_rule_cmd_keyword_ruleset_spec_family_spec,
\    nft_base_cmd_reset_rule_cmd_keyword_ruleset_spec_id_table

" base_cmd 'reset' 'counters'
hi link nft_base_cmd_reset_cmd_keyword_counters nftHL_Action
syn match nft_base_cmd_reset_cmd_keyword_counters "counters" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_base_cmd_reset_counters_quotas_table_keyword

" ***************** BEGIN base_cmd 'limit' ********************
" base_cmd add_cmd 'limit' <table_id> <limit_id>
hi link    nft_add_cmd_limit_obj_spec_limit_identifier nftHL_Identifier
syn match nft_add_cmd_limit_obj_spec_limit_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_limit_block,
\    nft_limit_config
" TODO: limit_block

" base_cmd add_cmd 'limit' table_spec
hi link    nft_add_cmd_limit_obj_spec_table_identifier nftHL_Identifier
syn match nft_add_cmd_limit_obj_spec_table_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_limit_identifier

" base_cmd add_cmd 'limit' ('ip'|'ip6'|'inet'|'arp'|'bridge'|'netdev')
" base_cmd add_cmd 'limit' family_spec
hi link   nft_add_cmd_limit_obj_spec_family_spec nftHL_Family
syn match nft_add_cmd_limit_obj_spec_family_spec "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd add_cmd 'limit' obj_spec
syn cluster nft_c_add_cmd_limit_obj_spec
\ contains=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd 'add' add_cmd 'limit'
hi link   nft_base_cmd_add_cmd_keyword_limit nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_limit "limit" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd add_cmd 'limit'
hi link   nft_base_cmd_keyword_limit nftHL_Command
syn match nft_base_cmd_keyword_limit "\vlimit\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier
" ***************** END base_cmd 'limit' ********************


" markup_format (via monitor_cmd '@nft_c_monitor_object'
hi link nft_markup_format nftHL_Number
syn match nft_markup_format "\v(xml|json|vm\s+json)" skipwhite contained

" monitor_format via monitor_cmd '@nft_c_monitor_object'
syn cluster nft_c_monitor_format
\ contains=
\    nft_markup_format,
\    nft_EOL

" monitor_object via monitor_cmd '@nft_c_monitor_event'
hi link nft_monitor_object nftHL_Expression
syn match nft_monitor_object "\v(tables|chains|sets|rules(et)?|elements|trace)" skipwhite contained
\ nextgroup=
\    nft_markup_format,
\    nft_monitor_format

" monitor_event (via monitor_cmd)
hi link nft_monitor_event_object_format nftHL_Operator
syn match nft_monitor_event_object_format "\v(xml|json|vm\s+json)|((tables|chains|sets|rules(et)?|elements|trace)(\s{1,15}(xml|json|vm\s+json))?)|([a-zA-Z0-9\_\-]+(\s+)?)" skipwhite keepend contained
\ contains=
\    nft_monitor_object,
\    nft_markup_format,
\    nft_identifier
\ nextgroup=
\    nft_monitor_object,
\    nft_markup_format
" nft_identifier must be the LAST contains= (via nft_unquoted_string)

" monitor_cmd monitor_event (via base_cmd)
syn cluster nft_c_monitor_cmd 
\    add=nft_monitor_event_object_format  " NESTING: we do not include nft_monitor_object nor nft_monitor_format here ... yet

" base_cmd 'import' (via base_cmd)
hi link nft_import_cmd nftHL_Operator
syn match nft_import_cmd "\v(ruleset)?(\s+(xml|json|vm\s+json))" skipwhite keepend contained
\ contains=
\    nft_markup_format
\ nextgroup=
\    nft_markup_format


" export_cmd markup_format (via export_cmd)
hi link nft_export_cmd nftHL_Operator
syn match nft_export_cmd "\v(ruleset)?(\s+(xml|json|vm\s+json))" skipwhite keepend contained
\ contains=
\    nft_markup_format
\ nextgroup=
\    nft_markup_format

""""""""" BEGIN OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""
" table_flag (via table_options 'flags')
hi link nft_add_table_options_flag_list_item_comma nftHL_Expression
syn match nft_add_table_options_flag_list_item_comma ',' skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_table_options_table_flag_recursive

hi link nft_add_table_options_flag_list_item nftHL_Identifier
syn match nft_add_table_options_flag_list_item "\v[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,64}" skipwhite contained
\ nextgroup=
\    nft_add_table_options_flag_list_item_comma,
\    nft_Semicolon

" add_cmd 'table' table_block table_options 'flags' table_flag
syn cluster nft_c_add_table_table_block_table_options_table_flag_recursive
\ contains=
\    nft_add_table_options_flag_list_item

" add_cmd 'table' table_block table_options 'flags'
hi link   nft_add_table_table_options_table_flag_keyword nftHL_Statement
syn match nft_add_table_table_options_table_flag_keyword "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_table_block_table_options_table_flag_recursive,
\    nft_Semicolon


""""" BEGIN OF 'add table' <identifier> { chain
""""" BEGIN of table <identifier> { chain <identifier> {"
" add 'table' table_block chain_block hook_spec
" add_cmd 'table' table_block 'chain' chain_block ';'
hi link   nft_add_table_table_block_chain_chain_block_separator nftHL_Normal
syn match nft_add_table_table_block_chain_chain_block_separator ';' skipwhite contained
\ nextgroup=
\    nft_comment_inline

" cmd_add 'table' table_block chain_block hook_spec 'type' prio_spec number
hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid nftHL_Number
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid "\v[0-9\-]{1,5}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block_separator

hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec_number nftHL_Table
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec_number "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ contains=nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid

hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec_variable nftHL_Variable
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" cmd_add 'table' table_block chain_block hook_spec 'type' prio_spec 'priority'
hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec nftHL_Command
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec 'priority' skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec_variable,
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid,
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec_number,

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device' string
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_string nftHL_Device
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_string  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,64}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_prio_spec

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device' variable_expr
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr nftHL_Variable
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr "\v\$[a-zA-Z0-9\_\-]{1,64}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_prio_spec

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device'
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec_device_variable_expr_or_string
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_string

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device'
hi link   nft_add_table_table_block_chain_block_hook_spec_device nftHL_Statement
syn match nft_add_table_table_block_chain_block_hook_spec_device "device" skipwhite contained
\ nextgroup=@nft_c_add_table_block_chain_block_hook_spec_dev_spec_device_variable_expr_or_string

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices' flowtable_expr variable_expr
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr nftHL_Variable
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr "\v\$[a-zA-Z0-9\_\-]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec


" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr <string> ','
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma nftHL_Element
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma "," skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string


" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr <string>
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string nftHL_String
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string "\v[a-zA-Z0-9 \t]{1,64}" skipwhite oneline contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr "'" <string> "'"
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles nftHL_String
syn region nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles start="\'" end="\'" skip="\\\'" skipwhite oneline contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr '"' <string> '"'
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles nftHL_String
syn region nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles start="\"" end="\"" skip="\\\"" skipwhite oneline contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable nftHL_Variable
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr flowtable_block
hi link    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block nftHL_BlockDelimitersFlowTable
syn region nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block skipwhite contained
\ start="{" end="}"
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec_flowtable_expr
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block,
\    nft_MissingDeviceVariable,
\    nft_UnexpectedEOS

" add 'table' table_block chain_block hook_spec dev_spec devices '='
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_equal nftHL_Operator
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_equal "=" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec_flowtable_expr,
\    nft_UnexpectedEOS

" dev_spec 'devices ='
hi link   nft_add_table_table_block_chain_block_hook_spec_devices nftHL_Statement
syn match nft_add_table_table_block_chain_block_hook_spec_devices "devices" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_equal,
\    nft_UnexpectedEOS

" dev_spec (via hook_spec)
hi link     nft_c_add_table_block_chain_block_hook_spec_dev_spec nftHL_Identifier
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec 
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_devices,
\    nft_add_table_table_block_chain_block_hook_spec_device

hi link   nft_add_table_table_block_chain_block_hook_spec_hooks nftHL_Hook
syn match nft_add_table_table_block_chain_block_hook_spec_hooks "\v(ingress|prerouting|input|forward|output|postrouting)" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec,
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec,
\    nft_UnexpectedEOS

hi link   nft_add_table_table_block_chain_block_hook_spec_keyword_hook nftHL_Command
syn match nft_add_table_table_block_chain_block_hook_spec_keyword_hook 'hook' skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_hooks

hi link   nft_add_table_table_block_chain_block_hook_spec_types nftHL_Type
syn match nft_add_table_table_block_chain_block_hook_spec_types "\v(filter|route|nat)" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_keyword_hook,
\    nft_Semicolon,
\    nft_UnexpectedEOS

" hook_spec (via chain_block)
hi link   nft_add_table_table_block_chain_block_hook_spec_keyword_type nftHL_Statement
syn match nft_add_table_table_block_chain_block_hook_spec_keyword_type "type" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_types

" add_cmd 'table' table_block 'chain' chain_block policy_spec 'policy' variable_expr
hi link   nft_add_table_table_block_chain_chain_policy_spec_policy_expr_variable_expr_variable nftHL_Variable
syn match nft_add_table_table_block_chain_chain_policy_spec_policy_expr_variable_expr_variable skipwhite contained
\ "\v\$[A-Za-z0-9\/\\_\.]{1,64}"
\ nextgroup=nft_Semicolon

" add_cmd 'table' table_block 'chain' chain_block policy_spec 'policy' chain_policy
hi link   nft_add_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy nftHL_Action
syn match nft_add_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy "\v(accept|drop|ACCEPT|DROP)" skipwhite contained
\ nextgroup=nft_Semicolon

" add_cmd 'table' table_block 'chain' chain_block policy_spec 'policy' policy_expr
syn cluster nft_c_add_table_table_block_chain_chain_policy_spec_policy_expr
\ contains=
\    nft_add_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy,
\    nft_add_table_table_block_chain_chain_policy_spec_policy_expr_variable_expr_variable

" add_cmd 'table' table_block 'chain' chain_block policy_spec 'policy'
hi link   nft_add_table_table_block_chain_chain_block_policy_spec_keyword_policy nftHL_Command
syn match nft_add_table_table_block_chain_chain_block_policy_spec_keyword_policy "policy" skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_chain_chain_policy_spec_policy_expr
\ nextgroup=nft_Semicolon

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'offload' ';'
hi link   nft_add_table_table_block_chain_chain_flags_spec_separator nftHL_BlockDelimitersChain
syn match nft_add_table_table_block_chain_chain_flags_spec_separator ";" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_hash_comment

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'offload'
hi link   nft_add_table_table_block_chain_chain_block_flags_spec_offload nftHL_Action
syn match nft_add_table_table_block_chain_chain_block_flags_spec_offload "\voffload" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_flags_spec_separator,
\    nft_Error

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'flags'
hi link   nft_add_table_table_block_chain_chain_block_flags_spec_flags nftHL_Statement
syn match nft_add_table_table_block_chain_chain_block_flags_spec_flags "\vflags" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_flags_spec_offload,
\    nft_Error
" TODO: Add negatation of 'tcp' in 'tcp flags' or add to nextgroup=BUT in chain_block


" add_cmd 'table' table_block 'chain' chain_block comment_spec 'comment' string
hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]]{0,63}" keepend contained

hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_string_single nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_string_single start="'" skip="\\'" end="'" keepend oneline contained
\ contains=nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_string_double nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote

syn cluster nft_c_add_table_table_block_chain_chain_block_comment_spec_quoted_string
\ contains=
\    nft_add_table_table_block_chain_chain_block_comment_spec_string_single,
\    nft_add_table_table_block_chain_chain_block_comment_spec_string_double

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_asterisk_string nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_asterisk_string start="\*" skip="\\\*" end="\*" keepend oneline contained
\ contains=nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted

hi link     nft_c_add_table_table_block_chain_chain_block_comment_spec_string nftHL_Error
syn cluster nft_c_add_table_table_block_chain_chain_block_comment_spec_string
\ contains=
\    nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted,
\    @nft_c_add_table_table_block_chain_chain_block_comment_spec_quoted_string,
\    nft_add_table_table_block_chain_chain_block_comment_spec_asterisk_string

" add_cmd 'table' table_block 'chain' chain_block comment_spec 'comment'
hi link   nft_add_table_table_block_chain_chain_block_comment_spec nftHL_Statement
syn match nft_add_table_table_block_chain_chain_block_comment_spec "comment" skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_chain_chain_block_comment_spec_string



" add_cmd 'table' table_block 'chain' chain_block rule 'rule' comment_spec
"    re-using nft_add_table_table_block_chain_chain_block_comment_spec

" add_cmd 'table' table_block 'chain' chain_block rule 'rule' rule_alloc
" short-circuiting to chain_block comment_spec
syn cluster nft_c_add_table_table_block_chain_chain_block_rule_rule_alloc
\ contains=@nft_c_stmt

" add_cmd 'table' table_block 'chain' chain_block rule 'rule'
hi link   nft_add_table_table_block_chain_chain_block_rule nftHL_Statement
syn match nft_add_table_table_block_chain_chain_block_rule "rule" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_table_block_chain_chain_block_rule_rule_alloc,
\    nft_add_table_table_block_chain_chain_block_rule_comment_spec


" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '$'identifier
" '$'identifier->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr nftHL_Variable
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_stmt_separator

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_member ','
" ','->flowtable_expr_member->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma nftHL_Operator
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma "," skipwhite contained
\ containedin=nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block
\ nextgroup=
\    @nft_c_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' <STRING>
" <STRING>->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string nftHL_String
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' '$'identifier
" '$'identifier->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr nftHL_Variable
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_EOS,
\    nftHL_Error

syn match nft_CurlyBraceAheadSilent "\v\ze\}" skipwhite contained

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' <QUOTED_STRING>
" <QUOTED_STRING>->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string nftHL_String
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string "\v\"[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}\"" keepend skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_EOS,
\    nftHL_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_member
" flowtable_expr_member->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
syn cluster nft_c_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member
\ contains=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string

hi link   nft_MissingDeviceVariable2 nftHL_Error
syn match nft_MissingDeviceVariable2 "\v[^\$\{\}]{1,5}" skipwhite contained " do not use 'keepend' here

syn cluster nft_c_add_table_table_block_chain_chain_block_devices_flowtable_expr_block
\ contains=@nft_c_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_block
" flowtable_expr_block->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block nftHL_BlockDelimitersFlowTable
syn region nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block start=/{/ end=/}/ skipwhite contained
\ contains=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_stmt_separator,

" 'table' identifier '{' 'chain' identifier '{' 'devices' '='
" '='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices_equal nftHL_Operator
syn match nft_add_table_table_block_chain_chain_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block,
\    nft_UnexpectedSemicolon,
\    nft_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices'
" 'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_table_table_block_chain_chain_block_devices nftHL_Statement
syn match nft_add_table_table_block_chain_chain_block_devices "devices" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_equal

hi link nft_chainError nftHL_Error
syn match nft_chainError /"v[a-zA-Z0-9\\\/_\.;:]{1,64}/ skipwhite contained

" common_block is contains=lastly due to 'comment' in chain_block & chain_block/rule
" 'table' identifier '{' 'chain' identifier '{' chain_block
" 'chain_block->'chain'->table_block->'table'->add_cmd
hi link    nft_add_table_table_block_chain_chain_block nftHL_BlockDelimitersChain
syn region nft_add_table_table_block_chain_chain_block start="{" end="}" skipwhite contained
\ contains=
\    nft_comment_inline,
\    nft_add_table_table_block_chain_block_hook_spec_keyword_type,
\    nft_add_table_table_block_chain_chain_block_policy_spec_keyword_policy,
\    nft_add_table_table_block_chain_chain_block_flags_spec_flags,
\    nft_add_table_table_block_chain_chain_block_devices,
\    nft_add_table_table_block_chain_chain_block_comment_spec,
\    @nft_c_add_table_table_block_chain_chain_block_rule_rule_alloc
\ nextgroup=
\    nft_comment_inline,
\    nft_hash_comment
"\ contains=
"\ nextgroup=
"\    nft_add_table_table_block_chain_flags_spec,
"\    nft_add_table_table_block_chain_rule_spec,
"\    nft_add_table_table_block_chain_device_keyword
" \ contains=ALLBUT,
" \    nft_add_table_options_flag_keyword,
" \    nft_add_table_options_comment_spec,
" \    nft_add_table_table_block_chain_keyword

" 'table' 'T' '{' 'chain' 'C' '{' ';'
" ';'->stmt_separator->chain_block->'chain'->table_block->'table'->add_cmd->base_cmd
hi link   nft_add_table_table_block_chain_chain_block_stmt_separator nftHL_BlockDelimitersChain
syn match nft_add_table_table_block_chain_chain_block_stmt_separator contained /\v\s{0,8}[\n;]{1,15}/  skipwhite contained
\ nextgroup=
\    nft_comment_inline

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_unquoted nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_sans_double_quote nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote "\v[a-zA_Z][a-zA-Z0-9\\\/_\.]{0,63}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link    nft_add_table_table_block_chain_chain_identifier_string_single nftHL_Chain
syn region nft_add_table_table_block_chain_chain_identifier_string_single start="'" skip="\\\'" end="'" keepend skipwhite oneline contained
\ contains=nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' <DOUBLE_STRING>
hi link    nft_add_table_table_block_chain_chain_identifier_string_double nftHL_Chain
syn region nft_add_table_table_block_chain_chain_identifier_string_double start="\"" skip="\\\"" end="\"" keepend skipwhite oneline contained
\ contains=nft_add_table_table_block_chain_chain_identifier_string_sans_double_quote
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' 'last'
hi link  nft_add_table_table_block_chain_chain_identifier_last nftHL_Action
syn match nft_add_table_table_block_chain_chain_identifier_last "\vlast" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' 
hi link   nft_add_table_table_block_chain_keyword nftHL_Command
syn match nft_add_table_table_block_chain_keyword "chain" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_identifier_string_single,
\    nft_add_table_table_block_chain_chain_identifier_string_double,
\    nft_add_table_table_block_chain_chain_identifier_last,
\    nft_add_table_table_block_chain_chain_identifier_string_unquoted
""""" END OF table <identifier> { chain

""""" BEGIN OF add_cmd_/'counter'/obj_spec """""
hi link nft_add_cmd_keyword_counter_block_stmt_separator nftHL_Normal
syn match nft_add_cmd_keyword_counter_block_stmt_separator "\v(\n|;)" skipwhite contained

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes' <integer>
hi link   nft_add_cmd_keyword_counter_counter_config_bytes_num nftHL_Number
syn match nft_add_cmd_keyword_counter_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOL

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes'
hi link   nft_add_cmd_keyword_counter_counter_config_bytes nftHL_Action
syn match nft_add_cmd_keyword_counter_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_bytes_num

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num>
hi link   nft_add_cmd_keyword_counter_counter_config_packet_num nftHL_Number
syn match nft_add_cmd_keyword_counter_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_bytes

hi link nft_add_cmd_counter_Error_Always nftHL_Error
syn match nft_add_cmd_counter_Error_Always "\v\i{1,15}" skipwhite contained

" add_cmd 'counter' obj_spec counter_config 'last' 'packet'
hi link   nft_add_cmd_keyword_counter_counter_config_last_packet nftHL_Identifier
syn match nft_add_cmd_keyword_counter_counter_config_last_packet "packet" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_packet_num

" add_cmd 'counter' obj_spec counter_config obj_id 'packet'
hi link   nft_add_cmd_keyword_counter_counter_config nftHL_Action
syn match nft_add_cmd_keyword_counter_counter_config "\vpacket\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_packet_num

" add_cmd 'counter' obj_spec '{' counter_block '}'
hi link    nft_add_cmd_keyword_counter_counter_block nftHL_BlockDelimitersCounter
syn region nft_add_cmd_keyword_counter_counter_block start="{" end="}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator
\ contains=
\    nft_add_cmd_keyword_counter_counter_config,
\    @nft_c_common_block,
\    nft_comment_spec,
\    nft_add_cmd_keyword_counter_block_stmt_separator

" add_cmd 'counter' table_identifier [ obj_id | 'last' ]
hi link   nft_add_cmd_counter_obj_spec_obj_id nftHL_Identifier
syn match nft_add_cmd_counter_obj_spec_obj_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config,
\    nft_add_cmd_keyword_counter_counter_block,
\    nft_line_stmt_separator,
\    nft_Error

hi link nft_add_cmd_counter_Semicolon nftHL_Normal
syn match nft_add_cmd_counter_Semicolon contained "\v\s{0,8};" skipwhite contained
\ nextgroup=
\    nft_EOL,
\    nft_comment_inline

hi link nft_add_cmd_counter_last_Error_Always nftHL_Error
syn match nft_add_cmd_counter_last_Error_Always "\v\i{1,15}" skipwhite contained

syn cluster nft_c_add_cmd_keyword_counter_obj_spec_obj_last
\ contains=
\    nft_add_cmd_keyword_counter_counter_block,
\    nft_add_cmd_keyword_counter_counter_config_last_packet,
\    nft_line_stmt_separator

hi link   nft_add_cmd_counter_obj_spec_obj_last nftHL_Action
syn match nft_add_cmd_counter_obj_spec_obj_last "last" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec_obj_last

" add_cmd 'counter' obj_spec obj_id table_spec table_id
hi link   nft_add_cmd_counter_obj_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_counter_obj_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_obj_spec_obj_last,
\    nft_add_cmd_counter_obj_spec_obj_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_obj_spec_table_spec_table_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon

" base_cmd add_cmd 'counter' obj_spec
syn cluster nft_c_add_cmd_keyword_counter_obj_spec
\ contains=
\    nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_counter_obj_spec_table_spec_table_id

""""" END OF add_cmd_/'counter'/obj_spec """""

""""" BEGIN OF add_cmd_/'chain'/chain_spec """""
" add_cmd 'chain' table_identifier [ chain_identifier | 'last' ]
hi link   nft_add_cmd_chain_spec_chain_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup= nft_add_table_table_block_chain_chain_block
" nft_add_cmd_chain_chain_block

hi link   nft_add_cmd_chain_spec_chain_last nftHL_Command
syn match nft_add_cmd_chain_spec_chain_last "last" skipwhite contained
\ nextgroup= nft_add_table_table_block_chain_chain_block
"\ nextgroup=nft_add_cmd_chain_chain_block

" add_cmd 'chain' chain_spec table_identifier
hi link   nft_add_cmd_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ contains=nft_keyword_last
\ nextgroup=
\    nft_add_cmd_chain_spec_chain_last,
\    nft_add_cmd_chain_spec_chain_id
" This is really interesting, reusing a chain_block may work after all TODO"

" base_cmd 'add chain'/'chain' (via base_cmd)
" add_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_add_chain_spec_family_spec_explicit_valid nftHL_Family
syn match nft_add_chain_spec_family_spec_explicit_valid "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_cmd_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_chain_spec_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_cmd_chain_spec_table_spec_table_id

" base_cmd add_cmd 'chain' chain_spec
syn cluster nft_c_add_cmd_chain_spec
\ contains=
\    nft_add_cmd_chain_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_chain_spec_table_spec_table_id

""""" END OF add_cmd_/'chain'/chain_spec """""


" base_cmd add_cmd 'table' table_block table_options ';'
hi link nft_add_table_table_block_table_options_semicolon nftHL_Normal
syn match nft_add_table_table_block_table_options_semicolon ";" skipwhite contained

" base_cmd_add_cmd 'table'  table_blocktable_options
syn cluster nft_c_add_table_table_block_table_options
\ contains=
\    nft_add_table_table_options_comment_spec,
\    nft_add_table_table_options_table_flag_keyword,
\    nft_add_table_table_block_table_options_semicolon  " this makes it unique apart from nft_add_chain
\    nft_UnexpectedEOS

" table_block 'chain' (via table_block)
" hi link   nft_chain_identifier_keyword nftHL_Command
" syn match nft_chain_identifier_keyword ^\vchain skipnl skipwhite contained

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_chain_spec_family_spec_explicit nftHL_Family
syn match nft_add_chain_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_chain_table_spec_identifier

" add_cmd 'table' table_block ';'
hi link   nft_add_table_separator nftHL_Normal
syn match nft_add_table_separator "\v\s{1,16};\s{1,16}" skipwhite contained
\ nextgroup=nft_comment_inline

" [ [ 'add' ] 'table' ] table_id '{' ';'
" ';'->stmt_separator->table_block->'table'->add_cmd->'add'->base_cmd->line
hi link   nft_table_block_stmt_separator nftHL_BlockDelimitersTable
syn match nft_table_block_stmt_separator "\v(\n|;)" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{'
" table_block->add_cmd->base_cmd->line
" table_block->'table'->add_cmd->'add'->base_cmd->line
hi link    nft_add_table_table_block nftHL_BlockDelimitersTable
syn region nft_add_table_table_block start="{" end="}" keepend skipnl skipempty skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_add_table_table_block_chain_keyword,
\    nft_hash_comment
\ contains=
\    @nft_c_add_table_table_block_table_options,
\    nft_add_table_table_block_chain_keyword,
\    nft_table_block_stmt_separator,
\    @nft_c_common_block,

""""""""" END OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""

" base_cmd add_cmd 'table' table_spec family_spec identifier
hi link nft_add_table_spec_identifier nftHL_Identifier
syn match nft_add_table_spec_identifier "\v[a-zA-Z][A-Za-z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block,
\    nft_Semicolon,
\    nft_comment_inline,
\    nft_EOS,

" base_cmd add_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_add_table_spec_family_spec_valid nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_add_table_spec_family_spec_valid "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_table_spec_identifier,
\    nft_UnexpectedEOS

" base_cmd add_cmd 'table' table_spec
syn cluster nft_c_add_table_spec
\ contains=
\    nft_add_table_spec_family_spec_valid,
\    nft_add_table_spec_identifier


hi link nft_add_cmd_keyword_set_set_spec_set_block_separator nftHL_Normal
syn match nft_add_cmd_keyword_set_set_spec_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr skipwhite contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,23}" contained  " do not use 'skipwhite' here
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof,
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma nftHL_Operator
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma "," skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_keyword_set_set_spec_set_block_time_spec nftHL_Number
syn match nft_add_cmd_keyword_set_set_spec_set_block_time_spec "\v[a-zA-Z0-9\\\/_\.\:]{1,31}" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_timeout nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_timeout "timeout" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'gc-interval'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_gc_interval nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_time_spec


" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '=' set_block_expr
" set_expr->set_block_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block_expr_set_expr nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_elements_block_items
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator

hi link  nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon nftHL_Operator
syn match nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon /;/ skipwhite contained

hi link    nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_elements_block_items
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '='
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements_equal nftHL_Normal
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements_equal /=/ skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_elements_equal

" base_cmd add_cmd 'set' set_spec '{' set_block 'automerge'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_automerge nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_automerge "auto\-merge" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size' <interval>
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value nftHL_Number
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator,nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value


" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'memory'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator,nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'performance'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory,
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_set_mechanism
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size,
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_comment_string
\ contains=
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_spec nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_spec "comment" skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_set_set_spec_set_block_comment_string

" base_cmd add_cmd 'set' set_spec '{' set_block '}'
hi link    nft_add_cmd_keyword_set_set_spec_set_block nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_stateful_stmt,
\    nft_add_cmd_keyword_set_set_spec_set_block_automerge,
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr,
\    nft_add_cmd_keyword_set_set_spec_set_block_flags,
\    nft_add_cmd_keyword_set_set_spec_set_block_timeout,
\    nft_add_cmd_keyword_set_set_spec_set_block_gc_interval,
\    undefined_set_mechanism,
\    nft_add_cmd_keyword_set_set_spec_set_block_comment_spec,
\    nft_add_cmd_keyword_set_set_spec_set_block_elements,
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_set_mechanism,
\    @nft_c_common_block,
\    nft_add_cmd_keyword_set_set_spec_set_block_separator
\ nextgroup=
\    nft_comment_inline,
\    nft_line_stmt_separator

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link   nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr nftHL_Position
syn match nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,31}" contained
\ nextgroup=
\    nft_Semicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'set' set_spec set_identifier
" set_identifier->'set'->add_cmd->base_cmd->line
hi link   nft_add_cmd_keyword_set_set_spec_set_id nftHL_Set
syn match nft_add_cmd_keyword_set_set_spec_set_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block,
\    nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr,
\    nft_MissingCurlyBrace,


" base_cmd add_cmd 'set' set_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id nftHL_Table
syn match nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedEOS,

" base_cmd add_cmd 'set' set_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedEOS,

" base_cmd [ 'add' ] 'set' set_spec table_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec_table_spec
\ contains=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id

" base_cmd [ 'add' ] 'set' set_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec
\ contains=@nft_c_add_cmd_keyword_set_set_spec_table_spec


hi link nft_add_cmd_map_map_spec_map_block_separator nftHL_Normal
syn match nft_add_cmd_map_map_spec_map_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]\{0,63}" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}(\.[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}){0,5}" contained  " do not use 'skipwhite' here
\ nextgroup=nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=@nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr
syn cluster nft_c_add_cmd_map_mamappec_map_block_typeof_key_expr
\ contains=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof,
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type


" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag ','
hi link   nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma nftHL_Operator
syn match nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma "," skipwhite contained
\ nextgroup=@nft_c_add_cmd_map_map_spec_map_block_map_flag_list

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag
hi link   nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list
syn cluster nft_c_add_cmd_map_map_spec_map_block_map_flag_list
\ contains=
\    nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags'
hi link   nft_add_cmd_map_map_spec_map_block_flags nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_add_cmd_map_map_spec_map_block_map_flag_list


" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_map_map_spec_map_block_time_spec nftHL_Number
syn match nft_add_cmd_map_map_spec_map_block_time_spec "\v[A-Za-z0-9\-\_\:]{1,32}" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_separator
" TODO clarify <time_spec>

" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'
hi link   nft_add_cmd_map_map_spec_map_block_timeout nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_timeout "timeout" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_time_spec

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements'
hi link   nft_add_cmd_map_map_spec_map_block_elements nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_time_spec

" base_cmd add_cmd 'map' map_spec '{' map_block 'gc-interval'
hi link   nft_add_cmd_map_map_spec_map_block_gc_interval nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_time_spec



" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '=' '{' map_block_item
hi link    nft_add_cmd_map_map_spec_map_block_elements_block_items nftHL_BlockDelimitersMap
syn match nft_add_cmd_map_map_spec_map_block_elements_block_items "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]" skipwhite contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '=' '{' map_block_expr
hi link    nft_add_cmd_map_map_spec_map_block_elements_map_block_expr nftHL_BlockDelimitersMap
syn region nft_add_cmd_map_map_spec_map_block_elements_map_block_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_element_map_block_elements_block_items
\ nextgroup=
\    nft_Semicolon,
\    nft_EOS,
\    nft_Error

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '='
hi link   nft_add_cmd_map_map_spec_map_block_elements_equal nftHL_Operator
syn match nft_add_cmd_map_map_spec_map_block_elements_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_elements_map_block_expr

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements'
hi link   nft_add_cmd_map_map_spec_map_block_elements nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_elements_equal

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size' <interval>
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value nftHL_Number
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_separator,nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_size nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value


" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'memory'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_separator,nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'performance'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_separator

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory,
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism
syn cluster nft_c_add_cmd_map_map_spec_map_block_map_mechanism
\ contains=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_size,
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec
syn cluster nft_c_add_cmd_map_map_spec_map_block_comment_string
\ contains=
\   nft_add_cmd_map_map_spec_map_block_comment_string_asterisk,
\   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single,
\   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double,
\   nft_add_cmd_map_map_spec_map_block_comment_string_string

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment'
hi link   nft_add_cmd_map_map_spec_map_block_comment_spec nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_comment_spec "comment" skipwhite contained
\ nextgroup=@nft_c_add_cmd_map_map_spec_map_block_comment_string

" base_cmd add_cmd 'map' map_spec '{' map_block '}'
hi link    nft_add_cmd_map_map_spec_map_block nftHL_BlockDelimitersMap
syn region nft_add_cmd_map_map_spec_map_block start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_timeout,
\    nft_add_cmd_map_map_spec_map_block_gc_interval,
\    nft_add_cmd_map_map_spec_map_block_flags,
\    @nft_c_stateful_stmt,
\    nft_add_cmd_map_map_spec_map_block_comment_spec,
\    @nft_c_add_cmd_map_map_spec_map_block_map_mechanism,
\    @nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr,
\    undefined_map_map_spec_map_block_type_datatype,
\    nft_add_cmd_map_map_spec_map_block_elements,
\    @nft_c_common_block,
\    nft_add_cmd_map_map_spec_map_block_separator
\ nextgroup=nft_comment_inline,nft_Semicolon

" base_cmd add_cmd 'map' map_spec set_identifier (chain)
hi link   nft_add_cmd_map_map_spec_identifier_set nftHL_Chain
syn match nft_add_cmd_map_map_spec_identifier_set "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block

" base_cmd add_cmd 'map' map_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_identifier_set

" base_cmd add_cmd 'map' map_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec table_spec
syn cluster nft_c_add_cmd_map_map_spec_table_spec
\ contains=
\    nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec
syn cluster nft_c_add_cmd_map_map_spec
\ contains=@nft_c_add_cmd_map_map_spec_table_spec

" ***************** BEGIN 'add' 'flowtable' ***************
hi link   nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_int nftHL_Number
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_int "\v\-?[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_var nftHL_Variable
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_var "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_c_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_sign nftHL_Expression
syn match nft_c_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_sign "\v[-+]" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_int

hi link   nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_name nftHL_Action
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_name "\v[a-zA-Z][a-zA-Z]{1,16}"
\ nextgroup=
\     nft_c_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_sign

hi link   nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended nftHL_String
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority "\v[a-zA-Z0-9]{1,64}" skipwhite contained

syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_int,
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_var,
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended_name

hi link   nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority nftHL_String
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority "priority" skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority_extended

hi link    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_double nftHL_String
syn region nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_double start='"' end='"' skip="\\\"" skipwhite skipnl skipempty contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority

hi link    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_single nftHL_String
syn region nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_single start="'" end="'" skip="\\\'" skipwhite skipnl skipempty contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority

hi link    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_unquoted nftHL_String
syn match nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_unquoted "\v[a-zA-Z0-9]{1,64}" skipwhite skipnl skipempty contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_block_hook_keyword_priority

syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_hook_string
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_double,
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_quoted_single,
\    nft_add_cmd_keyword_flowtable_flowtable_block_hook_string_unquoted

hi link   nft_add_cmd_keyword_flowtable_flowtable_block_stmt_separator nftHL_BlockDelimitersFlowTable
syn match nft_add_cmd_keyword_flowtable_flowtable_block_stmt_separator ";" skipwhite contained

" base_cmd_add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_hook nftHL_Statement
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_hook "\v[{ ;]\zshook\ze[;} ]" skipwhite skipnl skipempty keepend contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_hook_string

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list flowtable_flag
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag nftHL_Action
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag skipwhite contained
\ "\v(offload)"
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list
syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flowtable_flag_list
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags'
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags nftHL_Statement
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flowtable_flag_list

" TODO: [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '=' flowtable_expr
" flowtable_block_expr->'='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'counter'
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_counter nftHL_Statement
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_counter "counter" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_Error

hi link    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_flowtable_block_expr nftHL_BlockDelimitersDevices
syn region nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_flowtable_block_expr start="{" end="}" skipwhite contained

hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_expr_variable nftHL_Variable
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_expr_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '='
" '='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_equal nftHL_Operator
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_flowtable_block_expr,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_expr_variable

" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices'
" 'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices nftHL_Statement
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices "devices" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices_equal

" [ 'add' ] 'flowtable' table_id flow_id '{' flowtable_block
" flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block nftHL_BlockDelimitersFlowTable
syn region nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block start="{" end="}" skipwhite contained
\ nextgroup=nft_comment_inline,nft_Semicolon
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_counter,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_devices,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_flags,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block_hook,
\    @nft_c_common_block,
\    nft_add_cmd_keyword_flowtable_flowtable_block_stmt_separator

" base_cmd add_cmd 'flowtable' flowtable_spec identifier (chain)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable nftHL_Chain
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block

" base_cmd add_cmd 'flowtable' flowtable_spec identifier (chain)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_chain nftHL_Chain
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd [ 'add' ] 'flowtable' flowtable_spec table_spec
syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec_table_spec
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table,

" base_cmd [ 'add' ] 'flowtable' flowtable_spec
syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec
\ contains=@nft_c_add_cmd_keyword_flowtable_flowtable_spec_table_spec
" ***************** END 'add' 'flowtable' ***************

syn cluster nft_c_add_cmd_rule_rule_alloc_again
\ contains=@nft_c_add_cmd_rule_rule_alloc_alloc

" base_cmd [ 'add' ] 'rule' rule_alloc comment_spec
hi link   nft_add_cmd_rule_comment_spec_string nftHL_Comment
syn match nft_add_cmd_rule_comment_spec_string "\v[A-Za-z0-9 ]{1,64}" skipwhite contained
" TODO A BUG? What is a 'space' doing in comment?"

hi link   nft_add_cmd_rule_comment_spec_comment nftHL_Comment
syn match nft_add_cmd_rule_comment_spec_comment "comment" skipwhite contained
\ nextgroup=nft_add_cmd_rule_comment_spec_string

" base_cmd [ 'add' ] 'rule' rule
syn cluster nft_c_add_cmd_rule_rule_alloc
\ contains=
\    @nft_c_stmt
" \    nft_add_cmd_rule_comment_spec_comment,

" base_cmd [ 'add' ] 'rule' rule
syn cluster nft_c_add_cmd_rule_rule
\ contains=
\    @nft_c_add_cmd_rule_rule_alloc


" base_cmd 'ct' 'expectation' obj_spec table_spec
hi link   nft_base_cmd_add_ct_expectation_obj_spec_table_spec nftHL_Command
syn match nft_base_cmd_add_ct_expectation_obj_spec_table_spec "\v(ip[6]|inet|netdev|bridge|arp)" skipwhite contained

" base_cmd 'ct' 'expectation' obj_spec
syn cluster nft_c_base_cmd_add_ct_expectation_obj_spec
\ contains=@nft_base_cmd_add_ct_expectation_obj_spec_table_spec

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
hi link   nft_base_cmd_add_ct_keyword_expectation nftHL_Command
syn match nft_base_cmd_add_ct_keyword_expectation "expectation" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_ct_expectation_obj_spec

" base_cmd 'ct' 'timeout' obj_spec table_spec
hi link   nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit "\v(ip[6]|inet|netdev|bridge|arp)" skipwhite contained
" TODO: missing table_spec

" base_cmd 'ct' 'timeout' obj_spec
syn cluster nft_c_base_cmd_add_ct_timeout_obj_spec
\ contains=nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit
" TODO: missing table_spec

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
" base_cmd 'ct' 'timeout' obj_spec table_spec
hi link   nft_base_cmd_add_ct_keyword_timeout nftHL_Command
syn match nft_base_cmd_add_ct_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_add_ct_timeout_obj_spec

" base_cmd 'ct' 'helper' obj_spec table_spec
hi link   nft_base_cmd_add_ct_helper_obj_spec_table_spec nftHL_Family
syn match nft_base_cmd_add_ct_helper_obj_spec_table_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
" TODO: missing table_spec

" base_cmd 'ct' 'helper' obj_spec
syn cluster nft_c_base_cmd_add_ct_keyword_helper_obj_spec
\ contains=nft_base_cmd_add_ct_helper_obj_spec_table_spec

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
hi link   nft_base_cmd_add_ct_keyword_helper nftHL_Command
syn match nft_base_cmd_add_ct_keyword_helper "helper" skipwhite contained
\ nextgroup=
\    nft_base_cmd_add_ct_helper_obj_spec_table_spec
"@nft_c_base_cmd_add_ct_keyword_helper_obj_spec

syn cluster nft_c_cmd_add_ct_keywords
\ contains=
\    nft_base_cmd_add_ct_keyword_helper,
\    nft_base_cmd_add_ct_keyword_timeout,
\    nft_base_cmd_add_ct_keyword_expectation


""""" BEGIN OF add_cmd/'reset' """""
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '{' ... '}'
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set nftHL_BlockDelimitersSet
syn region nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set start="{" end="}" skipwhite skipnl contained
\ nextgroup=
\    nft_EOL

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable "\$\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id 'handle' handle_identifier
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id nftHL_Number
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id "\v[0-9]{1,7}" skipwhite contained

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id 'handle'
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec nftHL_Handle
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec "handle" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id nftHL_Set
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set

" base_cmd 'reset' [ 'set' | 'map' ] table_id
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id

" base_cmd 'reset' [ 'set' | 'map' ] family_spec table_id
hi link nft_base_cmd_reset_set_or_map_family_spec nftHL_Family
syn match nft_base_cmd_reset_set_or_map_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id

" base_cmd 'reset' [ 'set' | 'map' ]
hi link nft_base_cmd_reset_set_or_map nftHL_Action
syn match nft_base_cmd_reset_set_or_map "\v(set|map)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id


" base_cmd 'reset' 'element' table_id spec_id '{' ... '}'
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id_set nftHL_BlockDelimitersSet
syn region nft_base_cmd_reset_element_family_spec_table_id_spec_id_set start="{" end="}" skipwhite skipnl contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" base_cmd 'reset' 'element' table_id spec_id $variable
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id

" base_cmd 'reset' 'element' table_id spec_id
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id nftHL_Set
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_set

" base_cmd 'reset' 'element' table_id
hi link nft_base_cmd_reset_element_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_element_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id

" base_cmd 'reset' 'element'
hi link nft_base_cmd_reset_element_family_spec nftHL_Family
syn match nft_base_cmd_reset_element_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=nft_base_cmd_reset_element_family_spec_table_id

" base_cmd 'reset' 'element'
hi link nft_base_cmd_reset_element nftHL_Action
syn match nft_base_cmd_reset_element "element" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec,
\    nft_base_cmd_reset_element_family_spec_table_id


" base_cmd 'reset' 'rules' 'chain' <table_identifier> <chain_identifier>
hi link   nft_reset_cmd_keyword_rules_chain_spec_identifier_string nftHL_Chain
syn match nft_reset_cmd_keyword_rules_chain_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_EOS,
\    nft_Semicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' <table_identifier> 'last'
hi link   nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last nftHL_Chain
syn match nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_EOS,
\    nft_Semicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' <table_identifier>
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string nftHL_Table
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' 'last'
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last nftHL_Table
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' family_spec_explicit
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain'
hi link   nft_reset_cmd_keyword_rules_keyword_chain nftHL_Action
syn match nft_reset_cmd_keyword_rules_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Error

hi link   nft_reset_cmd_keyword_rules_table_spec_table_id nftHL_Table
syn match nft_reset_cmd_keyword_rules_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_Error

hi link   nft_reset_cmd_keyword_rules_table_spec_keyword_last nftHL_Variable
syn match nft_reset_cmd_keyword_rules_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOS


hi link   nft_reset_cmd_keyword_rules_table_spec_family_spec nftHL_Family
syn match nft_reset_cmd_keyword_rules_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_reset_cmd_keyword_rules_table_spec_keyword_last,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'table'
hi link   nft_reset_cmd_keyword_rules_keyword_table nftHL_Action
syn match nft_reset_cmd_keyword_rules_keyword_table "table" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_table_spec_family_spec,
\    nft_reset_cmd_keyword_rules_table_spec_keyword_last,
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd 'reset' 'rules' family_spec_explicit <EOS>
hi link   nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_EOS,
\    nft_Error

" base_cmd 'reset' 'rules'
hi link nft_base_cmd_reset_rules nftHL_Statement
syn match nft_base_cmd_reset_rules "rules" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit,
\    nft_reset_cmd_keyword_rules_keyword_table,
\    nft_reset_cmd_keyword_rules_keyword_chain,
\    nft_Error

" base_cmd 'reset' 'counter' obj_spec
" base_cmd 'reset' 'counter'/'quota' table_id chain_id
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_chain nftHL_Chain
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOS,

" base_cmd 'reset' 'counter'/'quota' 'table' identifier
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_table nftHL_Table
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_obj_spec_id_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counter'/'quota' family_spec
hi link   nft_base_cmd_reset_counter_quota_family_spec nftHL_Family
syn match nft_base_cmd_reset_counter_quota_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'quota'
hi link nft_base_cmd_reset_quota nftHL_Action
syn match nft_base_cmd_reset_quota "quota" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table

" base_cmd 'reset' 'counter'
hi link nft_base_cmd_reset_keyword_counter nftHL_Statement
syn match nft_base_cmd_reset_keyword_counter "counter" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier identifier
hi link nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier
hi link nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain

" base_cmd 'reset' 'counters'/'quotas' ruleset_spec
hi link   nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec nftHL_Family
syn match nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table

" base_cmd 'reset' 'counters'/'quotas' 'table' table_spec
hi link   nft_base_cmd_reset_counters_quotas_table_keyword nftHL_Element
syn match nft_base_cmd_reset_counters_quotas_table_keyword "table" skipwhite contained
\ nextgroup=
\     nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\     nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table

" base_cmd 'reset' 'quotas'
hi link nft_base_cmd_reset_quotas nftHL_Action
syn match nft_base_cmd_reset_quotas "quotas" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_base_cmd_reset_counters_quotas_table_keyword


" base_cmd [ 'set' ]
""""" END OF add_cmd/'reset' """""

"""""""""""""""""" rename_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd 'rename' 'chain' chain_spec identifier
" base_cmd 'rename' 'chain' [ family_spec ] table_id chain_id [ 'last' | <string> ]

hi link   nft_base_cmd_rename_chain_spec_table_spec_identifier nftHL_String
syn match nft_base_cmd_rename_chain_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipempty skipnl skipwhite contained
\ nextgroup=nft_EOL

hi link   nft_base_cmd_rename_chain_spec_table_spec_chain_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\     nft_base_cmd_rename_chain_spec_table_spec_identifier

hi link   nft_base_cmd_rename_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\     nft_base_cmd_rename_chain_spec_table_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained

hi link   nft_base_cmd_rename_chain_spec_table_spec_family_spec nftHL_Family
syn match nft_base_cmd_rename_chain_spec_table_spec_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_spec_table_spec_table_id

syn cluster nft_c_base_cmd_rename_chain_spec_table_spec
\ contains=
\    nft_base_cmd_rename_chain_spec_table_spec_family_spec,
\    nft_base_cmd_rename_chain_spec_table_spec_table_id

" base_cmd 'rename' 'chain' chain_spec
syn cluster nft_c_base_cmd_rename_chain_spec
\ contains=
\    @nft_c_base_cmd_rename_chain_spec_table_spec

" base_cmd 'rename' 'chain'
hi link   nft_base_cmd_rename_chain_keyword nftHL_Statement
syn match nft_base_cmd_rename_chain_keyword "chain" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_rename_chain_spec

"""""""""""""""""" rename_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" get_cmd BEGIN """"""""""""""""""""""""""""""""""
hi link nft_get_cmd_set_block_separator nftHL_Normal
syn match nft_get_cmd_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}"
" do not use 'skipwhite' here

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_get_cmd_set_block_typeof_key_expr_type nftHL_Command
syn match nft_get_cmd_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,5}" contained  " do not use 'skipwhite' here
\ nextgroup=nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_get_cmd_set_spec_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof nftHL_Command
syn match nft_get_cmd_set_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=@nft_c_get_cmd_set_spec_set_block_typeof_key_expr_typeof_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_get_cmd_set_spec_set_block_typeof_key_expr
\ contains=
\    nft_get_cmd_set_block_typeof_key_expr_typeof,
\    nft_get_cmd_set_block_typeof_key_expr_type

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_get_cmd_set_block_flags_set_flag_list_comma nftHL_Operator
syn match nft_get_cmd_set_block_flags_set_flag_list_comma "," skipwhite contained
\ nextgroup=@nft_c_get_cmd_set_spec_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_get_cmd_set_block_flags_set_flag_list_set_flag nftHL_Action
syn match nft_get_cmd_set_block_flags_set_flag_list_set_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=nft_get_cmd_set_block_flags_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_get_cmd_set_spec_set_block_set_flag_list
\ contains=
\    nft_get_cmd_set_block_flags_set_flag_list_set_flag

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_get_cmd_set_block_flags nftHL_Command
syn match nft_get_cmd_set_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_get_cmd_set_spec_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_get_cmd_set_block_time_spec nftHL_Number
syn match nft_get_cmd_set_block_time_spec "\v[A-Za-z0-9\-\_\:]{1,32}" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_separator
" TODO clarify <time_spec>

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_get_cmd_set_block_timeout nftHL_Command
syn match nft_get_cmd_set_block_timeout "timeout" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_time_spec

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'tcp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'udp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'udplite' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'esp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'ah' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'icmp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'icmpv6' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'igmp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'gre' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'comp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'dccp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'sctp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'redirect' '}'
hi link   nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords nftHL_Expression
syn match nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords skipwhite contained
\ "\v(tcp|udplite|udp|esp|ah|icmpv6|icmp|igmp|gre|comp|dccp|sctp|direct)"

hi link    nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block nftHL_Normal
syn region nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block start="(" end=")" skipwhite contained

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
\ contains=
\    nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords,
\    nft_primary_rhs_expr_block,
\    nft_integer_expr,
\    @nft_c_boolean_expr,
\    nft_keyword_expr
"\ nextgroup=
"\    nft_concat_rhs_expr_basic_rhs_expr_lshift,
"\    nft_concat_rhs_expr_basic_rhs_expr_rshift


" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr
\ contains=
\          @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_ampersand

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_shift_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_caret

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_bar

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr
\ contains=
\    @nft_c_nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr '.' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr multiton_rhs_expr '.' '}'
hi link   nft_get_cmd_set_block_expr_concat_rhs_expr_dot nftHL_Operator
syn match nft_get_cmd_set_block_expr_concat_rhs_expr_dot /./ skipwhite contained
\ nextgroup=
\    @nft_c_concat_rhs_expr_basic_rhs_expr,
\    @nft_c_concat_rhs_expr_multiton_rhs_expr



" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_key_expr set_lhs_expr '}'
syn cluster nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr
\ contains=
\    @nft_c_concat_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_key_expr '*' '}'
hi link   nft_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk nftHL_Verdict
syn match nft_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk "\*" skipwhite contained
\ nextgroup=
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_elem_stmt_m,
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc_set_elem_expr_option,
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc_set_elem_expr_options

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_expr_alloc set_elem_key_expr '}'
syn cluster nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr
\ contains=
\    nft_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk,
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr,
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_expr set_elem_expr_alloc '}'
syn cluster nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc
\ contains=
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_list_member_expr set_elem_expr '}'
syn cluster nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr
\ contains=
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc

hi link   nft_get_cmd_set_block_expr_set_expr_comma nftHL_Command
syn match nft_get_cmd_set_block_expr_set_expr_comma /,/ skipwhite contained
\ nextgroup=@nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_list_member_expr '}'
syn cluster nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr
\ contains=
\    nft_get_cmd_set_block_expr_set_expr,
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr
"\ nextgroup=
"\     nft_c_get_cmd_set_block_expr_set_expr_comma

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' ... '}'
hi link    nft_get_cmd_set_block_expr_set_expr nftHL_BlockDelimitersSet
syn region nft_get_cmd_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOL

" base_cmd 'get' 'element' table_id spec_id '$'identifier
hi link   nft_Error_get_cmd_set_block_expr_variable_expr nftHL_Error
syn match nft_Error_get_cmd_set_block_expr_variable_expr /[^\;\s\wa-zA-Z0-9_./]{1,64}/   " uncontained, on purpose
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_Error,


hi link   nft_get_cmd_set_block_expr_variable_expr nftHL_Variable
syn match nft_get_cmd_set_block_expr_variable_expr "\$\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_Error,
\    nft_Error_get_cmd_block_expr_variable_expr,

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id set_block_expr
syn cluster nft_c_get_cmd_set_block_expr
\ contains=
\    nft_get_cmd_set_block_expr_variable_expr,
\    nft_get_cmd_set_block_expr_set_expr

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_cmd_set_spec_identifier nftHL_Set
syn match nft_get_cmd_set_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_block_expr_variable_expr,
\    nft_get_cmd_set_block_expr_set_expr

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_cmd_set_spec_table_spec_identifier nftHL_Table
syn match nft_get_cmd_set_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\/\\_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_spec_identifier

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_cmd_set_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_get_cmd_set_spec_table_spec_family_spec_explicit "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_spec_table_spec_identifier

" base_cmd 'get' 'element' set_spec
syn cluster nft_c_get_cmd_set_spec
\ contains=
\    nft_get_cmd_set_spec_table_spec_family_spec_explicit,
\    nft_get_cmd_set_spec_table_spec_identifier

" 'element'->get_cmd->'get'->base_cmd->line
hi link   nft_get_cmd_keyword_element nftHL_Statement
syn match nft_get_cmd_keyword_element "element" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_spec_table_spec_family_spec_explicit,
\    nft_get_cmd_set_spec_table_spec_identifier

"""""""""""""""""" get_cmd END """"""""""""""""""""""""""""""""""


"""""""""""""""""" list_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd list_cmd 'table' table_spec family_spec identifier
hi link   nft_list_table_spec_identifier_string nftHL_Identifier
syn match nft_list_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd list_cmd 'table' table_spec family_spec 'last'
hi link   nft_list_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_table_spec_identifier_keyword_last "last" skipwhite contained

" base_cmd list_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_list_table_spec_family_spec_valid nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_list_table_spec_family_spec_valid "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_list_table_spec_identifier_keyword_last,
\    nft_list_table_spec_identifier_string

" base_cmd [ 'list' ] [ 'table' ] table_spec
syn cluster nft_c_list_table_spec_end
\ contains=
\    nft_list_table_spec_family_spec_valid,
\    nft_list_table_spec_identifier_keyword_last,
\    nft_list_table_spec_identifier_string

" base_cmd list_cmd 'table'
hi link   nft_base_cmd_list_keyword_table_end nftHL_Command
syn match nft_base_cmd_list_keyword_table_end "table" skipwhite contained
\ nextgroup=
\    @nft_c_list_table_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link nft_list_cmd_tables_chains_ruleset_meters_flowtables_maps_ruleset_spec nftHL_Family
syn match nft_list_cmd_tables_chains_ruleset_meters_flowtables_maps_ruleset_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained

" base_cmd list_cmd 'table'
hi link   nft_base_cmd_list_keywords_tables_chains_ruleset_meters_flowtables_maps_end nftHL_Command
syn match nft_base_cmd_list_keywords_tables_chains_ruleset_meters_flowtables_maps_end "\v(tables|chains|ruleset|meters|flowtables|maps)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_tables_chains_ruleset_meters_flowtables_maps_ruleset_spec,
\    nft_Error

" base_cmd list_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_list_chain_spec_identifier_string nftHL_Identifier
syn match nft_list_chain_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_list_chain_spec_identifier_keyword_last nftHL_Action
syn match nft_list_chain_spec_identifier_keyword_last "last" skipwhite contained

" base_cmd list_cmd 'chain' [ family_spec ] table_spec
hi link   nft_list_chain_table_spec_identifier_string nftHL_Identifier
syn match nft_list_chain_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_list_chain_spec_identifier_keyword_last,
\    nft_list_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_chain_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_chain_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_list_chain_spec_identifier_keyword_last,
\    nft_list_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" list_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_list_chain_spec_family_spec_explicit nftHL_Family
syn match nft_list_chain_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_list_chain_table_spec_identifier_keyword_last,
\    nft_list_chain_table_spec_identifier_string,

" base_cmd list_cmd 'chain' chain_spec
syn cluster nft_c_list_cmd_chain_spec_end
\ contains=
\    nft_list_chain_table_spec_identifier_keyword_last,
\    nft_list_chain_spec_family_spec_explicit,
\    nft_list_chain_table_spec_identifier_string

" base_cmd list_cmd 'chain'
" base_cmd [ 'list' ] [ 'chain' ] chain_spec
hi link   nft_base_cmd_list_keyword_chain_end nftHL_Command
syn match nft_base_cmd_list_keyword_chain_end "\vchain\ze " skipwhite contained
\ nextgroup=
\    @nft_c_list_cmd_chain_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_cmd_keywords_sets_et_al_ruleset_spec nftHL_Family
syn match nft_list_cmd_keywords_sets_et_al_ruleset_spec  "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained

" 'list' ('sets'|'counters'|'quotas'|'limits'|'secmarks'|'synproxys')
hi link   nft_list_cmd_keywords_sets_et_al_table_spec_identifier_string_table nftHL_Table
syn match nft_list_cmd_keywords_sets_et_al_table_spec_identifier_string_table  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_cmd_keywords_sets_et_al_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_cmd_keywords_sets_et_al_table_spec_identifier_keyword_last  "last" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_cmd_keywords_sets_et_al_table_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keywords_sets_et_al_table_spec_family_spec_explicit  "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keywords_sets_et_al_table_spec_identifier_keyword_last,
\    nft_list_cmd_keywords_sets_et_al_table_spec_identifier_string_table

hi link   nft_list_cmd_keywords_sets_et_al_keyword_table nftHL_Statement
syn match nft_list_cmd_keywords_sets_et_al_keyword_table "table" skipwhite contained
\ nextgroup=
\     nft_list_cmd_keywords_sets_et_al_table_spec_family_spec_explicit,
\     nft_list_cmd_keywords_sets_et_al_table_spec_identifier_keyword_last,
\     nft_list_cmd_keywords_sets_et_al_table_spec_identifier_string_table

" 'list' ('sets'|'counters'|'quotas'|'limits'|'secmarks'|'synproxys')
hi link   nft_base_cmd_list_keywords_sets_et_al_end nftHL_Statement
syn match nft_base_cmd_list_keywords_sets_et_al_end "\v(sets|counters|quotas|limits|secmarks|synproxys)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keywords_sets_et_al_ruleset_spec,
\    nft_list_cmd_keywords_sets_et_al_keyword_table

" base_cmd list_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_list_set_chain_spec_identifier_string nftHL_Identifier
syn match nft_list_set_chain_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOS,
\    nft_Error

hi link   nft_list_set_chain_spec_identifier_keyword_last nftHL_Action
syn match nft_list_set_chain_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOS,
\    nft_Error

" list_cmd 'set' set_spec family_spec family_spec_explicit
hi link   nft_list_set_table_spec_identifier_string nftHL_Identifier
syn match nft_list_set_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_list_set_chain_spec_identifier_keyword_last,
\    nft_list_set_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_set_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_set_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_list_set_chain_spec_identifier_keyword_last,
\    nft_list_set_chain_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_set_spec_family_spec_explicit nftHL_Family
syn match nft_list_set_spec_family_spec_explicit "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_list_set_table_spec_identifier_keyword_last,
\    nft_list_set_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd list_cmd 'set' set_spec
syn cluster nft_c_list_cmd_set_spec_end
\ contains=
\    nft_list_set_table_spec_identifier_keyword_last,
\    nft_list_set_table_spec_identifier_string,
\    nft_list_set_spec_family_spec_explicit

" 'list' ('counter'|'quota'|'limit'|'secmark'|'synproxy') obj_spec
hi link nft_list_cmd_keywords_counter_et_al_obj_spec nftHL_Statement
syn match nft_list_cmd_keywords_counter_et_al_obj_spec "\v(counter|quota|limit|secmark|synproxy)\ze " skipwhite contained
\ nextgroup=
\    @nft_c_list_cmd_set_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error


" base_cmd [ 'list' ] [ 'set' ] set_spec
" base_cmd [ 'list' ] [ 'map' ] set_spec
" base_cmd [ 'list' ] [ 'meter' ] set_spec
hi link   nft_base_cmd_list_set_map_meter_end nftHL_Command
syn match nft_base_cmd_list_set_map_meter_end "\v(set|map|meter)\ze " skipwhite contained
\ nextgroup=
\    @nft_c_list_cmd_set_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd [ 'list' ] [ 'flowtable' ] set_spec

" base_cmd list_cmd 'flowtables' [ family_spec ] table_spec chain_spec
" base_cmd list_cmd 'flow' 'tables' [ family_spec ] table_spec chain_spec
hi link   nft_list_flowtables_ruleset_chain_spec_identifier nftHL_Identifier
syn match nft_list_flowtables_ruleset_chain_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" list_cmd 'flowtables' ruleset_spefc family_spec family_spec_explicit
hi link   nft_list_flowtable_ruleset_table_spec_identifier nftHL_Identifier
syn match nft_list_flowtable_ruleset_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_list_flowtable_ruleset_chain_spec_identifier,
\    nft_list_flowtable_spec_family_spec_explicit,
\    nft_list_flowtable_spec_family_spec_explicit_unsupported,
\    nft_list_flowtable_ruleset_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_flowtable_ruleset_table_spec_identifier_keyword_last nftHL_Identifier
syn match nft_list_flowtable_ruleset_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_list_flowtable_ruleset_chain_spec_identifier_keyword_last,
\    nft_list_flowtable_ruleset_chain_spec_identifier_string,
\    nft_list_flowtable_spec_family_spec_explicit,
\    nft_list_flowtable_spec_family_spec_explicit_unsupported,
\    nft_list_flowtable_ruleset_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_flowtable_spec_family_spec_explicit nftHL_Family
syn match nft_list_flowtable_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_flowtable_ruleset_table_spec_identifier_keyword_last,
\    nft_list_flowtable_ruleset_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_flowtable_spec_family_spec_explicit_unsupported nftHL_Error
syn match nft_list_flowtable_spec_family_spec_explicit_unsupported "\v(netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_flowtables_ruleset_table_spec_identifier_keyword_last,
\    nft_list_flowtables_ruleset_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported nftHL_Error
syn match nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported "\v(netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd [ 'list' ] [ 'flow' ] [ 'tables' ] ruleset_spec
" ruleset_spec->'tables'->list_cmd->'list'->line
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_family_spec_identifier_string nftHL_Identifier
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_family_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd [ 'list' ] [ 'flow' ] [ 'tables' ] ruleset_spec
" ruleset_spec->'table'->list_cmd->'list'->line
hi link   nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_identifier_string

" *************** BEGIN 'list flow[s]/flowtable[s]' **************
" *************** BEGIN 'list flow table' **************
" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ] set_spec identifier
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_string nftHL_Identifier
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ] set_spec identifier
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_keyword_last nftHL_Action
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_keyword_last "last" skipwhite contained

" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ] set_spec
" string->identifier->table_spec->set_spec->'table'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_string

" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ] set_spec
" 'last'->identifier->table_spec->set_spec->'table'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_identifier_string

" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ] set_spec
" family_spec_explicit->family_spec->table_spec->set_spec->'table'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_string,

" family_spec_explicit->family_spec->table_spec->set_spec->'table'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit_unsupported nftHL_Error
syn match nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit_unsupported "\v(netdev|bridge|arp)" skipwhite contained

" base_cmd [ 'list' ] [ 'flow' ] [ 'table' ]
" set_spec->'table'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_table nftHL_Statement
syn match nft_list_cmd_keyword_flow_keyword_table "\vtable\ze " skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_family_spec_explicit_unsupported,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_table_set_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" *************** END 'list flow table' **************

" *************** BEGIN 'list flow tables' **************
" base_cmd [ 'list' ] [ 'flow' ] [ 'tables' ] ruleset_spec
" family_spec_explicit->ruleset_spec->'tables'->'flow'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_identifier_string,

" family_spec_explicit->ruleset_spec->'tables'->'flow'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported nftHL_Error
syn match nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported "\v(netdev|bridge|arp)" skipwhite contained

" base_cmd [ 'list' ] [ 'flow' ] [ 'tables' ]
" 'tables'->'flow'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flow_keyword_tables nftHL_Statement
syn match nft_list_cmd_keyword_flow_keyword_tables "tables" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported,
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" *************** END 'list flow tables' **************

" base_cmd [ 'list' ] [ 'flow' ]
" 'flow'->list_cmd->'list'->base_cmd->line
hi link   nft_base_cmd_list_keyword_flow nftHL_Command
syn match nft_base_cmd_list_keyword_flow "\vflow\ze " skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_tables,
\    nft_list_cmd_keyword_flow_keyword_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" *************** END 'list flow' **************


" *************** BEGIN 'list flowtables' **************
" base_cmd [ 'list' ] [ 'flowtables' ] ruleset_spec
" ruleset_spec->'flowtables'->list_cmd->'list'->base_cmd->line
hi link   nft_base_cmd_list_keyword_flowtables nftHL_Command
syn match nft_base_cmd_list_keyword_flowtables "flowtables" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit,
\    nft_list_cmd_keyword_flow_keyword_tables_ruleset_spec_family_spec_explicit_unsupported,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" *************** END 'list flowtables' **************

" *************** BEGIN 'list flowtable' **************
" base_cmd [ 'list' ] [ 'flowtable' ] flowtable_spec
" family_spec_explicit->family_spec->table_spec->flowtable_spec->'flowtable'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_identifier_string,

" family_spec_explicit->family_spec->table_spec->flowtable_spec->'flowtable'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit_unsupported nftHL_Error
syn match nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit_unsupported "\v(netdev|bridge|arp)" skipwhite contained

" base_cmd list_cmd 'flowtable' flowtable_spec
syn cluster nft_c_list_cmd_keyword_flowtable_flowtable_spec_end
\ contains=
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit,
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_explicit_unsupported,
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_flowtable_flowtable_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd [ 'list' ] [ 'flowtable' ] flowtable_spec
" flowtable_spec->'flowtable'->list_cmd->'list'->base_cmd->line
hi link   nft_base_cmd_list_keyword_flowtable nftHL_Command
syn match nft_base_cmd_list_keyword_flowtable "\vflowtable\ze " skipwhite contained
\ nextgroup=
\    @nft_c_list_cmd_keyword_flowtable_flowtable_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" *************** END 'list flowtable' **************
" *************** END 'list flow[s]/flowtable[s]' **************

" base_cmd 'list' 'ruleset' ruleset_spec
hi link   nft_list_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_ruleset_spec_family_spec_explicit "\v(ip(6)?|inet)" skipwhite contained
\ nextgroup=nft_list_set_table_spec_identifier

" base_cmd 'list' 'ruleset' set_spec
hi link   nft_base_cmd_list_ruleset_end nftHL_Command
syn match nft_base_cmd_list_ruleset_end "ruleset" skipwhite contained
\ nextgroup=
\    nft_list_ruleset_spec_family_spec_explicit,
\    nft_Error

"""""""""""""""""" list_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" flush_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd 'flush' 'ruleset' ruleset_spec
hi link   nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" base_cmd 'flush' 'ruleset' set_spec
" family_spec_explicit->ruleset_spec->'ruleset'->flush_cmd-'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_ruleset_end nftHL_Command
syn match nft_flush_cmd_keyword_ruleset_end "ruleset" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit,
\    nft_UnexpectedSemicolon,
\    nft_EOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
" identifier->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_chain_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_set_et_al_chain_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" flush_cmd 'set' set_spec family_spec family_spec_explicit
" identifier->table_spec->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_set_et_al_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_set_et_al_chain_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" family_spec_explicit->table_spec->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_set_et_al_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'set' set_spec
syn cluster nft_c_flush_cmd_keyword_set_et_al_set_spec_end
\ contains=
\    nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_set_et_al_table_spec_identifier

" base_cmd [ 'flush' ] [ 'set' ] set_spec
" base_cmd [ 'flush' ] [ 'flow' ] [ 'table' ] set_spec
" base_cmd [ 'flush' ] [ 'meter' ] set_spec
hi link   nft_flush_cmd_keyword_set_map_flow_meter_end nftHL_Command
syn match nft_flush_cmd_keyword_set_map_flow_meter_end "\v(set|map|meter|flow table)" skipwhite contained
\ nextgroup=
\    @nft_c_flush_cmd_keyword_set_et_al_set_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_flush_cmd_keyword_chain_chain_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_chain_chain_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec
hi link   nft_flush_cmd_keyword_chain_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_chain_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_chain_chain_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" flush_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_chain_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'chain' chain_spec
syn cluster nft_c_flush_cmd_keyword_chain_end
\ contains=
\    nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_chain_table_spec_identifier

" base_cmd flush_cmd 'chain'
" base_cmd [ 'flush' ] [ 'chain' ] chain_spec
hi link   nft_flush_cmd_keyword_chain nftHL_Command
syn match nft_flush_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    @nft_c_flush_cmd_keyword_chain_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'table' table_spec family_spec identifier
hi link   nft_flush_cmd_keyword_flush_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_flush_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_Error

" base_cmd flush_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_flush_cmd_keyword_flush_table_spec_identifier

" base_cmd [ 'flush' ] [ 'table' ] table_spec
" table_spec->'table'->flush_cmd->'flush'->base_cmd->line
syn cluster nft_c_flush_cmd_keyword_flush_table_spec_end
\ contains=
\    nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_flush_table_spec_identifier

" base_cmd flush_cmd 'table'
" 'table'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_table nftHL_Command
syn match nft_flush_cmd_keyword_table "table" skipwhite contained
\ nextgroup=@nft_c_flush_cmd_keyword_flush_table_spec_end

"""""""""""""""""" flush_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" replace_cmd BEGIN """"""""""""""""""""""""""""""""""

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier rule
syn cluster nft_c_base_cmd_replace_rule_alloc_stmt
\ contains=
\    @nft_c_payload_stmt,
\    @nft_c_stmt,
\    @nft_c_base_cmd_replace_rule_alloc_stmt

syn cluster nft_c_base_cmd_replace_rule_alloc
\ contains=
\    @nft_c_base_cmd_replace_rule_alloc_stmt,
\    @nft_comment_spec

syn cluster nft_c_base_cmd_replace_rule
\ contains=
\    @nft_c_base_cmd_replace_rule_alloc

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id nftHL_Handle
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id "\v[0-9]{1,9}" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_replace_rule,
\    nft_Semicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index nftHL_Action
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index "\v(position|index|handle)\s" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id nftHL_Chain
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id "\v[a-zA-Z0-9\\\/_\.]{1,64}\s+" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index,
\    @nft_c_payload_stmt
"\    nft_ip_hdr_expr via @nft_c_payload_stmt
"\    @nft_c_rule

" base_cmd 'replace' [ family_spec ] table_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id nftHL_Table
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id "\v[a-zA-Z0-9\\\/_\.]{1,64}\s+" contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id,

" base_cmd 'replace' family_spec
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family nftHL_Family
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family "\v(ip6|ip|inet|bridge|netdev|arp)\s+" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id,
\    nft_UnexpectedIdentifierChar,

" base_cmd 'replace' [ family_spec ]
syn cluster nft_c_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec
\ contains=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family,
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id

" base_cmd 'replace' 'rule'
hi link   nft_replace_cmd_keyword_rule nftHL_Statement
syn match nft_replace_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    @nft_c_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

"""""""""""""""""" replace_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" add_cmd BEGIN """"""""""""""""""""""""""""""""""
" 'add'

" 'table'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_table nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_spec

" 'table'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_table nftHL_Command
syn match nft_base_cmd_keyword_table "\v(^|table[ ]+)\zstable\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_table_spec

" 'chain'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_chain nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=@nft_c_add_cmd_chain_spec

" 'chain'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_chain nftHL_Command
syn match nft_base_cmd_keyword_chain "\vchain\ze " skipwhite contained
\ nextgroup=@nft_c_add_cmd_chain_spec

" 'rule'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_rule nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_add_cmd_keyword_rule_rule_position_table_spec_end,


" 'rule'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_rule nftHL_Command
syn match nft_base_cmd_keyword_rule "\vrule\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_add_cmd_keyword_rule_rule_position_table_spec_end,

" 'set'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_set nftHL_Command
syn match nft_base_cmd_keyword_set "\vset\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon

" do not add ^ regex to nft_base_cmd_add_cmd_keyword_set, already done by nft_line
" 'set'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_set nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_set "set" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon
" do not add ^ regex to nft_base_cmd_add_cmd_keyword_set, already done by nft_line

" 'map'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_map nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_map "map" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec

hi link   nft_base_cmd_keyword_map nftHL_Command
syn match nft_base_cmd_keyword_map "\vmap\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec
" do not add ^ regex to nft_base_cmd_map, already done by nft_line

" ***************** BEGIN base_cmd 'flowtable' *****************
" 'flowtable'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_flowtable nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_flowtable "flowtable" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_flowtable_flowtable_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'flowtable'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_flowtable nftHL_Command
syn match nft_base_cmd_keyword_flowtable "\vflowtable\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_flowtable_flowtable_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" ***************** END base_cmd 'flowtable' *****************

" ***************** BEGIN base_cmd 'element' *****************
" 'element'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_element nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_element "\velement\ze[ ]" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon

" 'element'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_element nftHL_Command
syn match nft_base_cmd_keyword_element "\velement\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon
" ***************** END base_cmd 'element' *****************

" ***************** BEGIN base_cmd 'counter' *****************
" 'counter'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_counter nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_counter "counter" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'counter'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_counter nftHL_Command
syn match nft_base_cmd_keyword_counter "\vcounter\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ***************** END base_cmd 'counter' *****************

" ******************* BEGIN base_cmd 'add quota' *************
hi link   nft_add_cmd_quota_cmd_obj_spec_identifier_string nft_Identifier
syn match nft_add_cmd_quota_cmd_obj_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_add_cmd_quota_cmd_obj_spec_identifier_string_unknown nftHL_Error
syn match nft_add_cmd_quota_cmd_obj_spec_identifier_string_unknown "\v[a-zA-Z][-a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last "last" skipwhite contained

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string_unknown nftHL_Error
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string_unknown "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_identifier_string,
\    nft_add_cmd_quota_cmd_obj_spec_identifier_string_unknown,

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_quota_add_cmd_cmd_obj_spec_identifier_keyword_last,
\    nft_quota_add_cmd_cmd_obj_spec_identifier_string,

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string_unknown,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string,

" 'quota'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_quota nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_quota "quota" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string_unknown,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string,
" ******************* END base_cmd 'add quota' *************

" ******************* BEGIN base_cmd 'quota' *************
hi link   nft_quota_cmd_obj_spec_identifier_string nft_Identifier
syn match nft_quota_cmd_obj_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_quota_cmd_obj_spec_identifier_keyword_last nftHL_Action
syn match nft_quota_cmd_obj_spec_identifier_keyword_last "last" skipwhite contained

hi link   nft_quota_cmd_obj_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_quota_cmd_obj_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_quota_cmd_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_quota_cmd_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'quota'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_quota nftHL_Command
syn match nft_base_cmd_keyword_quota "quota" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_quota_cmd_obj_spec_table_spec_family_spec_explicit,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
" ******************* END base_cmd 'quota' *************

" ******************* BEGIN base_cmd 'secmark' *************
" 'secmark'
hi link   nft_add_cmd_keyword_secmark_obj_spec_table_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_secmark_obj_spec_table_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_add_cmd_keyword_secmark_obj_spec_table_spec_keyword_last nftHL_Action
syn match nft_add_cmd_keyword_secmark_obj_spec_table_spec_keyword_last "last" skipwhite contained

hi link   nft_add_cmd_keyword_secmark_obj_spec_identifier_secmark nftHL_Identifier
syn match nft_add_cmd_keyword_secmark_obj_spec_identifier_secmark "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

syn cluster nft_c_add_cmd_keyword_secmark_obj_spec_table_spec
\ contains=
\    nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_counter_obj_spec_table_spec_table_id

" 'secmark'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_secmark nftHL_Command
syn match nft_base_cmd_keyword_secmark "\vsecmark\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_secmark_obj_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'add' 'secmark'
" 'secmark'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_secmark nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_secmark "secmark" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_secmark_obj_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ******************* END base_cmd 'secmark' *************

" ******************* BEGIN base_cmd 'secmark' *************
" 'synproxy'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_synproxy nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_synproxy_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'synproxy'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_synproxy nftHL_Command
syn match nft_base_cmd_keyword_synproxy "\vsynproxy\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_synproxy_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ******************* END base_cmd 'secmark' *************

" add_cmd-.'add'->base_cmd->line
" nft_c_base_cmd_add_cmd ordering DO matters: see `test/ct.nft` test file
syn cluster nft_c_base_cmd_add_cmd
\ contains=
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_base_cmd_add_cmd_keyword_flowtable,
\    nft_base_cmd_add_cmd_keyword_synproxy,
\    nft_base_cmd_add_cmd_keyword_counter,
\    nft_base_cmd_add_cmd_keyword_element,
\    nft_base_cmd_add_cmd_keyword_secmark,
\    nft_base_cmd_add_cmd_keyword_quota,
\    nft_base_cmd_add_cmd_keyword_limit,
\    nft_base_cmd_add_cmd_keyword_table,
\    nft_base_cmd_add_cmd_keyword_chain,
\    nft_base_cmd_add_cmd_keyword_rule,
\    nft_base_cmd_add_cmd_keyword_map,
\    nft_base_cmd_add_cmd_keyword_set,
\    nft_base_cmd_add_cmd_keyword_ct,
\    nft_base_cmd_add_cmd_rule_position_table_spec_wildcard,
"\    nft_UnexpectedSemicolon,
"\    nft_UnexpectedEOS
" '', 'rule', 'add rule' forces nft_base_cmd_add_rule_position_table_spec to be the last 'contains=' entry!!!
"""""""""""""""""" add_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" base_cmd BEGIN """""""""""""""""""""""""""""""""""""""""""""""""
" 'add'->base_cmd->line
hi link   nft_base_cmd_keyword_add nftHL_Command
syn match nft_base_cmd_keyword_add "\vadd\ze " skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_add_cmd,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'replace'->base_cmd->line
hi link   nft_base_cmd_keyword_replace nftHL_Command
syn match nft_base_cmd_keyword_replace "replace" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" *************** BEGIN create_cmd *******************

hi link   nft_create_cmd_keyword_table_identifier_chain nftHL_Table
syn match nft_create_cmd_keyword_table_identifier_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_c_add_table_spec,
\    nft_EOS

hi link   nft_create_cmd_keyword_table_identifier_table nftHL_Table
syn match nft_create_cmd_keyword_table_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_table_identifier_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_create_cmd_keyword_table_absolute_family_spec nftHL_Family
syn match nft_create_cmd_keyword_table_absolute_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_table_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_create_cmd_keyword_table nftHL_Statement
syn match nft_create_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_table_absolute_family_spec,
\    nft_create_cmd_keyword_table_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" **************** END 'create' 'table' *********************

" **************** BEGIN 'create' 'secmark' *********************

hi link   nft_create_cmd_keyword_secmark_secmark_config_string_unquoted nftHL_String
syn match nft_create_cmd_keyword_secmark_secmark_config_string_unquoted "\v[a-zA-Z0-9\\\/_\-\.\[\]\(\) ]{2,45}" skipwhite contained

hi link    nft_create_cmd_keyword_secmark_secmark_config_string_quoted_single nftHL_String
syn region nft_create_cmd_keyword_secmark_secmark_config_string_quoted_single start="\'" end="\'" skip="\\\'" skipwhite contained

hi link    nft_create_cmd_keyword_secmark_secmark_config_string_quoted_double nftHL_String
syn region nft_create_cmd_keyword_secmark_secmark_config_string_quoted_double start="\"" end="\"" skip="\\\"" oneline skipwhite contained


hi link   nft_create_cmd_keyword_secmark_obj_spec_identifier_secmark nftHL_Identifier
syn match nft_create_cmd_keyword_secmark_obj_spec_identifier_secmark "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_secmark_secmark_config_string_quoted_single,
\    nft_create_cmd_keyword_secmark_secmark_config_string_quoted_double,
\    nft_create_cmd_keyword_secmark_secmark_config_string_unquoted,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_create_cmd_keyword_secmark_obj_spec_table_spec_identifier_table nftHL_Table
syn match nft_create_cmd_keyword_secmark_obj_spec_table_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_secmark_obj_spec_identifier_secmark,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_create_cmd_keyword_secmark_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_create_cmd_keyword_secmark_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_secmark_obj_spec_table_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_create_cmd_keyword_secmark nftHL_Command
syn match nft_create_cmd_keyword_secmark "secmark" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_secmark_obj_spec_table_spec_family_spec_explicit,
\    nft_create_cmd_keyword_secmark_obj_spec_table_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" **************** END 'create' 'secmark' *********************
" **************** BEGIN 'create' 'synproxy' *********************
hi link   nft_create_cmd_keyword_synproxy nftHL_Command
syn match nft_create_cmd_keyword_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    nft_create_cmd_keyword_secmark_obj_spec_table_spec_family_spec_explicit,
\    nft_create_cmd_keyword_secmark_obj_spec_table_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" **************** END 'create' 'synproxy' *********************

" 'create'->base_cmd->line
hi link   nft_base_cmd_keyword_create nftHL_Command
syn match nft_base_cmd_keyword_create "create" skipwhite contained
\ nextgroup=
\    nft_base_cmd_add_cmd_keyword_set,
\    nft_base_cmd_add_cmd_keyword_table,
\    nft_base_cmd_add_cmd_keyword_chain,
\    nft_base_cmd_add_cmd_keyword_map,
\    nft_base_cmd_add_cmd_keyword_flowtable,
\    nft_base_cmd_add_cmd_keyword_element,
\    nft_base_cmd_add_cmd_keyword_counter,
\    nft_base_cmd_add_cmd_keyword_quota,
\    nft_base_cmd_add_cmd_keyword_limit,
\    nft_create_cmd_keyword_secmark,
\    nft_base_cmd_add_cmd_keyword_ct,
\    nft_create_cmd_keyword_synproxy,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" *************** END create_cmd *******************
" *************** BEGIN insert_cmd *******************
hi link   nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num nftHL_Number
syn match nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec "\v(position|handle|index)" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain nftHL_Chain
syn match nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table nftHL_Identifier
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain,
\    nft_Error,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'rule'->insert_cmd->'insert'->base_cmd->line
hi link   nft_base_cmd_keyword_insert_keyword_rule nftHL_Command
syn match nft_base_cmd_keyword_insert_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'insert'->base_cmd->line
hi link   nft_base_cmd_keyword_insert nftHL_Command
syn match nft_base_cmd_keyword_insert "insert" skipwhite contained
\ nextgroup=
\    nft_base_cmd_keyword_insert_keyword_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" *************** END insert_cmd *******************

" ****************** BEGIN delete_cmd ***********************
" 'delete' 'table' [ ip|ip6|inet|netdev|bridge|arp ] identifier
" 'last'->identifier->table_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier nftHL_Identifier
syn match nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedIdentifierChar,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table' [ ip|ip6|inet|netdev|bridge|arp ] 'last'
" 'last'->identifier->table_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table' 'handle' <NUM>
" <NUM>->'handle'->'table'->delete_cmd->'delete'->base_cmd->line
" <NUM>->tableid_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num nftHL_Number
syn match nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num "\v[0-9]{1,11}" skipwhite contained

" 'delete' 'table' 'handle'
" 'handle'>tableid_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_table_table_or_id_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_table_table_or_id_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier,  " last match entry"
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table'
" 'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table nftHL_Statement
syn match nft_delete_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_family_spec,
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier,  " last match entry"
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain_chainid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_chain_chainid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain nftHL_Table
syn match nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain_chain_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_chain_chain_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_chain_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_chain_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_delete_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_delete_cmd_keyword_chain_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_chain_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_delete_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_delete_cmd_keyword_chain_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_chain_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_table_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain nftHL_Statement
syn match nft_delete_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_table_spec_family_spec,
\    nft_delete_cmd_keyword_chain_table_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num nftHL_Number
syn match nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain nftHL_Chain
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule nftHL_Statement
syn match nft_delete_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_set_setid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_set_setid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_set_set_spec_identifier_string_set nftHL_Table
syn match nft_delete_cmd_keyword_set_set_spec_identifier_string_set "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_set_setid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_set_setid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_num

hi link   nft_delete_cmd_keyword_set_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_set_set_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_set_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_set_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_keyword_handle,
\    nft_delete_cmd_keyword_set_set_spec_keyword_last,
\    nft_delete_cmd_keyword_set_set_spec_identifier_string_set
hi link   nft_delete_cmd_keyword_set_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_set_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_keyword_handle,
\    nft_delete_cmd_keyword_set_set_spec_keyword_last,
\    nft_delete_cmd_keyword_set_set_spec_identifier_string_set
hi link   nft_delete_cmd_keyword_set_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_set_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_table_spec_keyword_last,
\    nft_delete_cmd_keyword_set_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_set nftHL_Statement
syn match nft_delete_cmd_keyword_set "set" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_table_spec_family_spec,
\    nft_delete_cmd_keyword_set_table_spec_keyword_last,
\    nft_delete_cmd_keyword_set_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_map_spec_identifier_string_map nftHL_Table
syn match nft_delete_cmd_keyword_map_map_spec_identifier_string_map "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_map_map_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_map_map_spec_keyword_last "last" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_map_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_map_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_map_spec_keyword_last,
\    nft_delete_cmd_keyword_map_map_spec_identifier_string_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_map_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_map_spec_keyword_last,
\    nft_delete_cmd_keyword_map_map_spec_identifier_string_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_map_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_table_spec_keyword_last,
\    nft_delete_cmd_keyword_map_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map nftHL_Statement
syn match nft_delete_cmd_keyword_map "map" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_table_spec_family_spec,
\    nft_delete_cmd_keyword_map_table_spec_keyword_last,
\    nft_delete_cmd_keyword_map_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_set_spec_identifier_string_element nftHL_Table
syn match nft_delete_cmd_keyword_element_set_spec_identifier_string_element "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_set_expr

hi link   nft_delete_cmd_keyword_element_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_element_set_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_set_expr

hi link   nft_delete_cmd_keyword_element_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_element_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_set_spec_keyword_last,
\    nft_delete_cmd_keyword_element_set_spec_identifier_string_element,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_element_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_set_spec_keyword_last,
\    nft_delete_cmd_keyword_element_set_spec_identifier_string_element,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_element_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_table_spec_keyword_last,
\    nft_delete_cmd_keyword_element_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element nftHL_Statement
syn match nft_delete_cmd_keyword_element "element" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_table_spec_family_spec,
\    nft_delete_cmd_keyword_element_table_spec_keyword_last,
\    nft_delete_cmd_keyword_element_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" flowtableflowtableflowtable
hi link   nft_delete_cmd_keyword_flowtable_flowtableid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_flowtable_flowtableid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable nftHL_Table
syn match nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block

hi link   nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_num

hi link   nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last "last" skipwhite contained
\ nextgroup=nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block

hi link   nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable,

hi link   nft_delete_cmd_keyword_flowtable_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable

hi link   nft_delete_cmd_keyword_flowtable_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_flowtable_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_table_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_flowtable nftHL_Statement
syn match nft_delete_cmd_keyword_flowtable "flowtable" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_table_spec_family_spec,
\    nft_delete_cmd_keyword_flowtable_table_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" flowtableflowtableflowtable

hi link   nft_delete_cmd_keyword_counter_objid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_counter_objid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter nftHL_Table
syn match nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_counter_objid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_counter_objid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter_obj_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_counter_obj_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_counter_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_counter_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_keyword_handle,
\    nft_delete_cmd_keyword_counter_obj_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_counter_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_keyword_handle,
\    nft_delete_cmd_keyword_counter_obj_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_obj_spec_identifier_string_set

hi link   nft_delete_cmd_keyword_counter_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_counter_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter nftHL_Statement
syn match nft_delete_cmd_keyword_counter "counter" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_quota nftHL_Statement
syn match nft_delete_cmd_keyword_quota "quota" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct nftHL_Table
syn match nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_ct_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_ct_set_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_ct_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_ct_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_set_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct
hi link   nft_delete_cmd_keyword_ct_table_spec_keyword_last nftHL_Action

syn match nft_delete_cmd_keyword_ct_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_set_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct

hi link   nft_delete_cmd_keyword_ct_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_ct_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_table_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct_obj_type_keywords nftHL_Statement
syn match nft_delete_cmd_keyword_ct_obj_type_keywords "\v(expectation|helper|timeout)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_table_spec_family_spec,
\    nft_delete_cmd_keyword_ct_table_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct nftHL_Statement
syn match nft_delete_cmd_keyword_ct "ct" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_obj_type_keywords,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_limit nftHL_Statement
syn match nft_delete_cmd_keyword_limit "limit" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_secmark nftHL_Statement
syn match nft_delete_cmd_keyword_secmark "secmark" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_synproxy nftHL_Statement
syn match nft_delete_cmd_keyword_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete'->base_cmd->line
hi link   nft_base_cmd_keyword_delete nftHL_Command
syn match nft_base_cmd_keyword_delete "delete" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table,
\    nft_delete_cmd_keyword_chain,
\    nft_delete_cmd_keyword_rule,
\    nft_delete_cmd_keyword_set,
\    nft_delete_cmd_keyword_map,
\    nft_delete_cmd_keyword_element,
\    nft_delete_cmd_keyword_flowtable,
\    nft_delete_cmd_keyword_counter,
\    nft_delete_cmd_keyword_quota,
\    nft_delete_cmd_keyword_ct,
\    nft_delete_cmd_keyword_limit,
\    nft_delete_cmd_keyword_secmark,
\    nft_delete_cmd_keyword_synproxy,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" ****************** END delete_cmd ***********************

" 'get'->base_cmd->line
hi link   nft_base_cmd_keyword_get nftHL_Command
syn match nft_base_cmd_keyword_get "get" skipwhite contained
\ nextgroup=
\    nft_get_cmd_keyword_element

" 'list' 'ct' ('helpers'|'timeout'|'expectation') ('ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp') identifier
" identifier->family_spec->table_spec->list_cmd->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_identifier_string nftHL_Table
syn match nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=nft_EOS

" 'list' 'ct' ('helpers'|'timeout'|'expectation') ('ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp') 'last'
" identifier->family_spec->table_spec->list_cmd->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_keyword_last nftHL_Action
syn match nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=nft_EOS

" 'list' 'ct' ('helpers'|'timeout'|'expectation') ('ip'|'ip6'|'inet'|'netdev'|'bridge'|'arp')
" family_spec_explicit->family_spec->table_spec->list_cmd->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_keyword_last,
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_identifier_string,
\    nft_UnexpectedEOS

hi link   nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_string nftHL_Identifier
syn match nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_keyword_last nftHL_Action
syn match nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_keyword_last "last" skipwhite contained

hi link   nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct' ('helpers'|'timeout'|'expectation') ct_cmd_type
" ct_obj_type->list_cmd->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keywords_timeout_expectation_keyword_table nftHL_Action
syn match nft_list_cmd_keyword_ct_keywords_timeout_expectation_keyword_table "\vtable\ze " skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_family_spec_explicit,
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_keyword_last,
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct' 'helper'
" 'helper'->ct_obj_type->'ct'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keyword_helper_obj_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_ct_keyword_helper_obj_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct' ('timeout'|'expectation')
" 'timeout'->'ct'->list_cmd->'list'->base_cmd->line
" 'expectation'->ct_obj_type->'ct'->list_cmd->'list'->base_cmd->line
" 'expectation'->ct_cmd_type->'ct'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keywords_timeout_expectation nftHL_Statement
syn match nft_list_cmd_keyword_ct_keywords_timeout_expectation "\v(timeout|expectation)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_keyword_table,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_family_spec_explicit,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct' 'helper'
" 'helper'->ct_obj_type->'ct'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keyword_helper nftHL_Statement
syn match nft_list_cmd_keyword_ct_keyword_helper "helper" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_family_spec_explicit,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_keyword_last,
\    nft_list_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct' 'helpers' ct_obj_type
" 'helper'->ct_cmd_type->'ct'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_ct_keyword_helpers nftHL_Statement
syn match nft_list_cmd_keyword_ct_keyword_helpers "helpers" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation_keyword_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'ct'
" list_cmd->base_cmd->line
" 'ct'->list_cmd->'list'->base_cmd->line
hi link nft_base_cmd_list_keyword_ct nftHL_Statement
syn match nft_base_cmd_list_keyword_ct "\vct\ze " skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_ct_keyword_helper,
\    nft_list_cmd_keyword_ct_keyword_helpers,
\    nft_list_cmd_keyword_ct_keywords_timeout_expectation,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'list' 'hooks'
" basehook_device_name->basehook_spec->'hooks'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_string nftHL_Device
syn match nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_string "\v[a-zA-Z0-9\-_\.]{1,32}" skipwhite contained

" 'list' 'hooks'
" basehook_device_name->basehook_spec->'hooks'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_keyword_device nftHL_Action
syn match nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_keyword_device "device" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_string

" 'list' 'hooks'
" family_spec_explicit->family_spec->ruleset_spec->basehook_spec->'hooks'->list_cmd->'list'->base_cmd->line
hi link   nft_list_cmd_keyword_hooks_basehook_spec_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_cmd_keyword_hooks_basehook_spec_ruleset_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_hooks_basehook_spec_ruleset_spec_family_spec_explicit,
\    nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name_keyword_device

" 'list' 'hooks'
" 'hooks'->list_cmd->'list'->base_cmd->line
hi link   nft_base_cmd_list_keyword_hooks nftHL_Statement
syn match nft_base_cmd_list_keyword_hooks "hooks" skipwhite contained
\ nextgroup=
\    nft_list_cmd_keyword_hooks_basehook_spec_ruleset_spec_family_spec_explicit,
\    nft_list_cmd_keyword_hooks_basehook_spec_basehook_device_name


" 'list'->base_cmd->line
hi link   nft_base_cmd_keyword_list nftHL_Command
syn match nft_base_cmd_keyword_list "list" skipwhite contained
\ nextgroup=
\    nft_base_cmd_list_keyword_table_end,
\    nft_base_cmd_list_keywords_tables_chains_ruleset_meters_flowtables_maps_end,
\    nft_base_cmd_list_keyword_chain_end,
\    nft_base_cmd_list_keywords_sets_et_al_end,
\    nft_base_cmd_list_set_map_meter_end,
\    nft_list_cmd_keywords_counter_et_al_obj_spec,
\    nft_base_cmd_list_keyword_flowtables,
\    nft_base_cmd_list_keyword_flowtable,
\    nft_base_cmd_list_keyword_flow,
\    nft_base_cmd_list_keyword_ct,
\    nft_base_cmd_list_keyword_hooks,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'reset'->base_cmd->line
hi link   nft_base_cmd_keyword_reset nftHL_Command
syn match nft_base_cmd_keyword_reset "reset" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_cmd_keyword_counters,
\    nft_base_cmd_reset_keyword_counter,
\    nft_base_cmd_reset_quotas,
\    nft_base_cmd_reset_quota,
\    nft_base_cmd_reset_rules,
\    nft_base_cmd_delete_destroy_reset_cmd_keyword_rule,
\    nft_base_cmd_reset_element,
\    nft_base_cmd_reset_set_or_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'flush'->base_cmd->line
hi link   nft_base_cmd_keyword_flush nftHL_Command
syn match nft_base_cmd_keyword_flush "\vflush\ze " skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_table,
\    nft_flush_cmd_keyword_chain,
\    nft_flush_cmd_keyword_set_map_flow_meter_end,
\    nft_flush_cmd_keyword_ruleset_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'rename'->base_cmd->line
hi link   nft_base_cmd_keyword_rename nftHL_Command
syn match nft_base_cmd_keyword_rename "rename" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_keyword

" 'import'->base_cmd->line
hi link   nft_base_cmd_keyword_import nftHL_Command
syn match nft_base_cmd_keyword_import "import" skipwhite contained
\ nextgroup=nft_import_cmd

" 'export'->base_cmd->line
hi link   nft_base_cmd_keyword_export nftHL_Command
syn match nft_base_cmd_keyword_export "export" skipwhite contained
\ nextgroup=nft_export_cmd

" 'monitor'->base_cmd->line
hi link   nft_base_cmd_keyword_monitor nftHL_Command
syn match nft_base_cmd_keyword_monitor "monitor" skipwhite contained
\ nextgroup=
\    @nft_c_monitor_cmd

" 'describe'->base_cmd->line
hi link   nft_base_cmd_keyword_describe nftHL_Command
syn match nft_base_cmd_keyword_describe "describe" skipwhite contained
\ nextgroup=
\    @nft_c_primary_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" **************** BEGIN destroy_cmd ***************
hi link   nft_destroy_cmd_keyword_chain_chainid_spec_num nftHL_Handle
syn match nft_destroy_cmd_keyword_chain_chainid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

hi link   nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain nftHL_Table
syn match nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle nftHL_Action
syn match nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=nft_destroy_cmd_keyword_chain_chainid_spec_num

hi link   nft_destroy_cmd_keyword_chain_chain_spec_keyword_last nftHL_Action
syn match nft_destroy_cmd_keyword_chain_chain_spec_keyword_last "last" skipwhite contained

hi link   nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table nftHL_Table
syn match nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_destroy_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_destroy_cmd_keyword_chain_table_spec_keyword_last nftHL_Action
syn match nft_destroy_cmd_keyword_chain_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_destroy_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_destroy_cmd_keyword_chain_table_spec_family_spec nftHL_Family
syn match nft_destroy_cmd_keyword_chain_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_table_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_destroy_cmd_keyword_chain nftHL_Statement
syn match nft_destroy_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_table_spec_family_spec,
\    nft_destroy_cmd_keyword_chain_table_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'destroy'->base_cmd->line
hi link   nft_base_cmd_keyword_destroy nftHL_Command
syn match nft_base_cmd_keyword_destroy "destroy" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table,
\    nft_destroy_cmd_keyword_chain,
\    nft_delete_cmd_keyword_rule,
\    nft_delete_cmd_keyword_set,
\    nft_delete_cmd_keyword_map,
\    nft_delete_cmd_keyword_element,
\    nft_delete_cmd_keyword_flowtable,
\    nft_delete_cmd_keyword_counter,
\    nft_delete_cmd_keyword_quota,
\    nft_delete_cmd_keyword_ct,
\    nft_delete_cmd_keyword_limit,
\    nft_delete_cmd_keyword_secmark,
\    nft_delete_cmd_keyword_synproxy,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" **************** END destroy_cmd ***************

" **************** BEGIN destroy_cmd ***************
" base_cmd [ 'ct' ]
hi link   nft_base_cmd_add_cmd_keyword_ct nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_ct "\vct\ze " skipwhite contained
\ nextgroup=@nft_c_cmd_add_ct_keywords

" base_cmd [ 'ct' ]
hi link   nft_base_cmd_keyword_ct nftHL_Command
syn match nft_base_cmd_keyword_ct "\vct\ze " skipwhite contained
\ nextgroup=@nft_c_cmd_add_ct_keywords
" **************** END destroy_cmd ***************

" base_cmd->line
syn cluster nft_c_base_cmd
\ contains=
\    nft_base_cmd_keyword_flowtable,
\    nft_base_cmd_keyword_counter,
\    nft_base_cmd_keyword_describe,
\    nft_base_cmd_keyword_replace,
\    nft_base_cmd_keyword_synproxy,
\    nft_base_cmd_keyword_element,
\    nft_base_cmd_keyword_destroy,
\    nft_base_cmd_keyword_monitor,
\    nft_base_cmd_keyword_create,
\    nft_base_cmd_keyword_secmark,
\    nft_base_cmd_keyword_insert,
\    nft_base_cmd_keyword_delete,
\    nft_base_cmd_keyword_rename,
\    nft_base_cmd_keyword_chain,
\    nft_base_cmd_keyword_import,
\    nft_base_cmd_keyword_export,
\    nft_base_cmd_keyword_limit,
\    nft_base_cmd_keyword_flush,
\    nft_base_cmd_keyword_reset,
\    nft_base_cmd_keyword_quota,
\    nft_base_cmd_keyword_table,
\    nft_base_cmd_keyword_list,
\    nft_base_cmd_keyword_rule,
\    nft_base_cmd_keyword_get,
\    nft_base_cmd_keyword_map,
\    nft_base_cmd_keyword_set,
\    nft_base_cmd_keyword_add,
\    nft_base_cmd_keyword_ct,
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_base_cmd_rule_position_table_spec_wildcard,

""""""""""" base_cmd END """""""""""""""""""""""""""""""""""""""""""""""""

hi link   nft_comment_whole_line nftHL_Comment
syn match nft_comment_whole_line "#.*$" keepend contained
" do not use ^ regex, reserved to nft_line

hi link   nft_line_stmt_separator nftHL_Expression
syn match nft_line_stmt_separator  "\v[;\n]{1,16}" skipwhite contained

"""""""""""""""" TOP-LEVEL SYNTAXES """"""""""""""""""""""""""""
" `line` main top-level syntax, do not add 'contained' here.
" `line` is the only syntax match/region line without a 'contained' attribute
syn match nft_line "\v\s{0,16}"
\ nextgroup=
\    nft_comment_whole_line,
\    @nft_c_common_block,
\    @nft_c_base_cmd,
\    nft_line_stmt_separator


" common_block
" common_block (via chain_block, counter_block, ct_expect_block, ct_helper_block,
"                   ct_timeout_block, flowtable_block, limit_block, line, map_block,
"                   quota_block, secmark_block, set_block, synproxy_block, table_block

" common_block 'define'/'redefine identifier <STRING> '=' initializer_expr
" common_block 'define'/'redefine identifier <STRING> '=' rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' list_rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
" common_block 'define'/'redefine identifier <STRING> '=' '-'number
hi link   nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\v\-[0-9]{1,7}" skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine' value (via nft_common_block_define_redefine_equal)
hi link nft_common_block_define_redefine_value nftHL_Number
syn match nft_common_block_define_redefine_value "\v[\'\"\$\{\}:a-zA-Z0-9\_\/\\\.\,\}\{]+\s{0,16}" skipwhite contained
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
hi link    nft_common_block_define_redefine_initializer_expr_empty_set nftHL_Normal
syn region nft_common_block_define_redefine_initializer_expr_empty_set start="{" end="}" skipwhite contained
\ contains=
\    nft_Error
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier <STRING> '=' -number
hi link nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\v\-[0-9]{1,7}" skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr basic_rhs_expr
hi link nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr nftHL_Operator
syn match nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr /|/ skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_initializer_expr_nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_bar,
\    nft_common_block_stmt_separator
" TODO: typo ^^^^

" END OF common_block

" num->initializer_expr->common_block
hi link nft_common_block_define_redefine_keywords_initializer_expr_num nftHL_Integer
syn match nft_common_block_define_redefine_keywords_initializer_expr_num "\v[0-9]{1,11}" skipwhite contained

" '-'->initializer_expr->common_block
hi link nft_common_block_define_redefine_keywords_initializer_expr_dash nftHL_Element
syn match nft_common_block_define_redefine_keywords_initializer_expr_dash /-/ skipwhite contained
\ nextgroup=
\    nft_common_block_define_redefine_keywords_initializer_expr_num

" '{'->initializer_expr->common_block
hi link   nft_common_block_define_redefine_keywords_initializer_expr_block nftHL_Normal
syn region nft_common_block_define_redefine_keywords_initializer_expr_block start="{" end="}" skipwhite contained

" initializer_expr->common_block
syn cluster nft_common_block_define_redefine_keywords_initializer_expr
\ contains=
\    nft_common_block_define_redefine_keywords_initializer_expr_dash,
\    nft_common_block_define_redefine_keywords_initializer_expr_block,
\    @nft_c_rhs_expr,
\    @nft_c_list_rhs_expr
" list_rhs_expr must be the last 'contains=' entry
"     as its basic_rhs_expr->exclusive_or_rhs_expr->and_rhs_expr->shift_rhs_expr->primary_rhs_expr->symbol_expr
"     uses <string> which is a (wildcard)

hi link   nft_common_block_filespec_sans_single_quote nftHL_String
syn match nft_common_block_filespec_sans_single_quote "\v[\"_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\\\(\)\{\}\[\]\<\>(\\\')]+" keepend contained

hi link    nft_common_block_filespec_quoted_single nftHL_String
syn region nft_common_block_filespec_quoted_single start="\'" skip="\\\'" end="\'" skipwhite keepend oneline contained
\ contains=nft_common_block_filespec_sans_single_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator

hi link nft_common_block_filespec_sans_double_quote nftHL_String
syn match nft_common_block_filespec_sans_double_quote "\v[\'_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\(\)\{\}\[\]\<\>(\\\")]+" keepend contained

hi link    nft_common_block_filespec_quoted_double nftHL_String
syn region nft_common_block_filespec_quoted_double start="\"" skip="\\\"" end="\"" skipwhite oneline keepend contained
\ contains=nft_common_block_filespec_sans_double_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator

syn cluster nft_c_common_block_keyword_include_quoted_string
\ contains=
\    nft_common_block_filespec_quoted_single,
\    nft_common_block_filespec_quoted_double

hi link nft_common_block_keyword_include nftHL_Include
syn match nft_common_block_keyword_include "include" skipwhite oneline contained
\ nextgroup=
\    @nft_c_common_block_keyword_include_quoted_string

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_multion_rhs_expr

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_expr
" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_ref_symbol_expr

" common_block 'define'/'redefine identifier '=' rhs_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr_rhs_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_set_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_set_ref_symbol_expr

" common_block 'define'/'redefine identifier '=' initializer_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_empty_set,
\    nft_common_block_define_redefine_initializer_expr_dash_num,
\    @nft_c_common_block_define_redefine_initializer_expr_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_list_rhs_expr

" common_block 'define'/'redefine identifier '='
hi link nft_common_block_define_redefine_equal nftHL_Operator
syn match nft_common_block_define_redefine_equal "=" skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_initializer_expr

" common_block 'define'/'redefine identifier <STRING>
hi link nft_common_block_define_redefine_identifier_string nftHL_Identifier
syn match   nft_common_block_define_redefine_identifier_string '[A-Za-z0-9\-_./]\{1,64}' skipwhite contained
\ nextgroup=nft_common_block_define_redefine_equal

" common_block 'define'/'redefine identifier <STRING>
hi link   nft_common_block_define_redefine_identifier_last nftHL_Action
syn match nft_common_block_define_redefine_identifier_last "last" skipwhite contained
\ nextgroup=nft_common_block_define_redefine_equal

" common_block 'define'/'redefine' identifier (via common_block 'redefine'/'define')
syn cluster nft_c_common_block_define_redefine_identifier
\ contains=
\    nft_common_block_define_redefine_identifier_last,
\    nft_common_block_define_redefine_identifier_string

" 'define' (via "
" commmon_block 'redefine' (via common_block)
hi link nft_common_block_redefine nftHL_Command
syn match nft_common_block_redefine contained "redefine" skipwhite contained
\ nextgroup=@nft_c_common_block_define_redefine_identifier

" common_block 'define' (via common_block)
hi link nft_common_block_define nftHL_Command
syn match nft_common_block_define contained "define" skipwhite contained
\ nextgroup=@nft_c_common_block_define_redefine_identifier

" common_block 'undefine' identifier (via common_block 'undefine')
hi link nft_common_block_undefine_identifier nftHL_Identifier
syn match nft_common_block_undefine_identifier '\v[a-zA-Z][A-Za-z0-9\\\/_\.]{0,63}' oneline skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS

" commmon_block 'undefine' (via common_block)
hi link nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine "undefine" oneline skipwhite contained
\ nextgroup=
\    nft_common_block_undefine_identifier,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS
" commmon_block 'redefine' (via common_block)
" common_block->line
" common_block->table_block
" common_block->chain_block
" common_block->counter_block
" common_block->ct_expect_block
" common_block->ct_helper_block
" common_block->ct_timeout_block
" common_block->flowtable_block
" common_block->limit_block
" common_block->map_block
" common_block->quota_block
" common_block->secmark_block
" common_block->set_block
" common_block->synproxy_block
syn cluster nft_c_common_block
\ contains=
\    nft_common_block_keyword_include,
\    nft_common_block_define,
\    nft_common_block_redefine,
\    nft_common_block_undefine,
\    nft_common_block_stmt_separator,
\    nft_hash_comment,
\    nft_EOL
"\    nft_InlineComment,

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

