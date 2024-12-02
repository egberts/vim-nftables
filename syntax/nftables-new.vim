" Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     1.0
" Initial Date: 2020-04-24
" Last Change:  2024-08-28
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
""
" Developer Notes:
"  - relocate inner_inet_expr to after th_hdr_expr?

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

" quit if terminal is a black and white
if &t_Co <= 1
  finish
endif
" quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif !exists('main_syntax')
  if exists('b:current_syntax')
    finish
  endif
  let main_syntax='nftables'
endif
if version > 580
  hi clear
  if exists("syntax on")
    syntax reset
  endif
endif

syn case match

" iskeyword severly impacts '\<' and '\>' atoms
setlocal iskeyword=.,48-58,A-Z,a-z,\_,\/,-
setlocal isident=.,48-58,A-Z,a-z,\_,\/,-

let s:cpo_save = &cpo
set cpo&vim  " Line continuation '\' at EOL is used here

syn sync clear
syn sync maxlines=1000
" syn sync match nftablesSync grouphere NONE \"^(table|chain|set)\"
" syn sync fromstart "^(monitor|table|set)"
syn sync fromstart

let s:save_cpo = &cpoptions
set cpoptions-=C

let s:vimIdentifierRegex = '[A-Za-z0-9\-_./]\{1,64}'
let s:deviceNameRegex = '[A-Za-z0-9\-_./]\{1,256}'
let s:tableNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'
let s:chainNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'

hi nftHL_Comment     ctermfg=Blue
hi link nftHL_Include     Preproc
hi link nftHL_ToDo        Todo
hi link nftHL_Identifier  Identifier
hi link nftHL_Variable    Variable  " doesn't work, stuck on dark cyan
hi link nftHL_Number      Number
hi link nftHL_String      String
hi link nftHL_Option      Label     " could use a 2nd color here
hi link nftHL_Operator    Operator
hi link nftHL_Underlined  Underlined
hi link nftHL_Error       Error

hi link nftHL_Command     Statement
hi link nftHL_Statement   Statement
hi link nftHL_Expression  Statement
hi link nftHL_Type        Type

hi link nftHL_Family      Underlined   " doesn't work, stuck on dark cyan
hi link nftHL_Table       Identifier
hi link nftHL_Chain       Identifier
hi link nftHL_Rule        Identifier
hi link nftHL_Map         Identifier
hi link nftHL_Set         Identifier
hi link nftHL_Element     Identifier
hi link nftHL_Quota       Identifier
hi link nftHL_Limit       Identifier
hi link nftHL_Handle      Identifier
hi link nftHL_Flowtable   Identifier
hi link nftHL_Device      Identifier
hi link nftHL_Member      Identifier

hi link nftHL_Verdict     Underlined
hi link nftHL_Hook        Type    
hi link nftHL_Action      Special

hi link nft_ToDo nftHL_ToDo
syn keyword nft_ToDo xxx contained XXX FIXME TODO TODO: FIXME: TBS TBD TBA skipwhite
"\ containedby=nft_InlineComment

hi link nft_InlineComment nftHL_Comment
syn match nft_InlineComment "\# " skipwhite contained

hi link nft_EOS nftHL_Error
syn match nft_EOS /\v[^ \t]{1,64}[\n\r\#]{1,8}.{0,16}/ skipempty skipnl skipwhite contained

"""""hi link nft_UnexpectedSemicolon nftHL_Error
"""""syn match nft_UnexpectedSemicolon /;\+/ skipwhite skipempty contained

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
" We'll do error RED highlighting on all statement firstly, then later on
" all the options, then all the clauses.
" Uncomment following two lines for RED highlight of typos (still Beta here)
hi link nft_UnexpectedEOS nftHL_Error
syn match nft_UnexpectedEOS contained skipwhite /\v\s{0,8}[;\n]{1,3}.{1,1}/ contained

hi link nft_Error nftHL_Error
syn match nft_Error /[\s\wa-zA-Z0-9_./]\{1,64}/   " uncontained, on purpose

" expected end-of-line (iterator capped for speed)
syn match nft_EOL /[\n\r]\{1,16}/ skipwhite contained

hi link nft_Semicolon nftHL_Normal
syn match nft_Semicolon contained /\v\s{0,8}[;]{1,15}/  skipwhite contained
\ nextgroup=nft_EOL,nft_comment_inline

hi link nft_comment_inline nftHL_Comment
syn match nft_comment_inline "\#.*$" skipwhite contained

hi link nft_identifier nftHL_Identifier
syn match nft_identifier "\v[a-zA-Z0-9\_\-]{1,64}" skipwhite contained

hi link nft_variable_identifier nftHL_Variable
syn match nft_variable_identifier "\v[a-zA-Z0-9\_\-]{1,64}" skipwhite contained

" variable_expr (via chain_expr, dev_spec, extended_prio_spec, flowtable_expr,
"                    flowtable_member_expr, policy_expr, queue_expr,
"                    queue_stmt_expr_simple, set_block_expr, set_ref_expr
"                    symbol_expr

hi link   nft_variable_expr nft_Variable
syn match nft_variable_expr "\$" contained
\ nextgroup=nft_variable_identifier

hi link nft_string_unquoted nftHL_String
"syn match nft_string_unquoted "\v[a-zA-Z0-9\/\\\[\]\$]{1,64}" skipwhite keepend contained

hi link nft_string_sans_double_quote nftHL_String
syn match nft_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link nft_string_sans_single_quote nftHL_String
syn match nft_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link nft_string_single nftHL_String
syn region nft_string_single start="'" end="'" keepend contained
\ contains=nft_string_sans_single_quote

hi link nft_string_double nftHL_String
syn region nft_string_double start="\"" end="\"" keepend contained
\ contains=nft_string_sans_double_quote

syn cluster nft_c_quoted_string
\ contains=
\    nft_string_single,
\    nft_string_double

hi link nft_asterisk_string nftHL_String
syn region nft_asterisk_string start="\*" end="\*" keepend contained
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
"\    @nft_c_string
" nft_c_string must be the LAST contains= (via nft_unquoted_string)

"hi link nft_common_block_define_redefine_identifier_string_unquoted nftHL_String
"syn match nft_common_block_define_redefine_identifier_string_unquoted "\v[a-zA-Z0-9\_]+" skipwhite contained

" common_block 'define'/'redefine identifier <STRING> '=' initializer_expr
" common_block 'define'/'redefine identifier <STRING> '=' rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' list_rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
" common_block 'define'/'redefine identifier <STRING> '=' '-'number
hi link nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\-[0-9]{1,7}" skipwhite contained

" common_block 'define'/'redefine' value (via nft_common_block_define_redefine_equal)
hi link nft_common_block_define_redefine_value nftHL_Number
syn match nft_common_block_define_redefine_value "\v[\'\"\$\{\}:a-zA-Z0-9\_\/\\\.\,\}\{]+\s{0,16}" skipwhite contained
\ nextgroup=
\    nft_comment_inline,
\    nft_Semicolon

" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
hi link nft_common_block_define_redefine_initializer_expr_empty_set nftHL_Normal
syn match nft_common_block_define_redefine_initializer_expr_empty_set "\v\{\s{0,64}\}" skipwhite contained

" common_block 'define'/'redefine identifier <STRING> '=' -number
hi link nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\v\-[0-9]{1,7}" skipwhite contained

" common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr basic_rhs_expr
hi link nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr nftHL_Operator
syn match nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr
\ nextgroup=@nft_c_common_block_define_redefine_initializer_expr_nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_bar /|/ skipwhite contained

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_multion_rhs_expr

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_expr
" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_ref_symbol_expr

" common_block 'define'/'redefine identifier '=' rhs_expr
hi link nft_common_block_define_redefine_initializer_expr_rhs_expr nftHL_Normal
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
\ nextgroup=@nft_c_common_block_define_redefine_initializer_expr

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
\    nft_common_block_define_redefine_identifier_string,
\    nft_common_block_define_redefine_identifier_last

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
syn match nft_common_block_undefine_identifier '[A-Za-z0-9\-_./]\{1,64}' skipwhite contained

" commmon_block 'undefine' (via common_block)
hi link nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine contained "undefine" skipwhite contained
\ nextgroup=nft_common_block_undefine_identifier
" END OF common_block

hi link nft_filespec_semicolon nftHL_Normal
syn match nft_filespec_semicolon "\v\s{0,16}[\;]\s{0,16}" skipwhite contained
\ nextgroup=
\    nft_comment_inline

hi link nft_filespec_sans_double_quote nftHL_Normal
syn match nft_filespec_sans_double_quote "\v[\'_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\(\)\{\}\[\]\<\>(\\\")]+" keepend contained

hi link nft_filespec_sans_single_quote nftHL_Normal
syn match nft_filespec_sans_single_quote "\v[\"_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\\\(\)\{\}\[\]\<\>(\\\')]+" keepend contained

hi link nft_filespec_quoted_single nftHL_Include
syn region nft_filespec_quoted_single start="[^\\]\'" end="[^\\]\'" skipwhite keepend contained
\ contains=nft_filespec_sans_single_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_filespec_semicolon

hi link nft_filespec_quoted_double nftHL_Include
syn region nft_filespec_quoted_double start="[^\\]\"" end="[^\\]\"" skipwhite keepend contained
\ contains=nft_filespec_sans_double_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_filespec_semicolon

hi link nft_c_filespec_quoted nftHL_Identifier
syn cluster nft_c_filespec_quoted
\ contains=
\    nft_filespec_quoted_single,
\    nft_filespec_quoted_double

hi link nft_include nftHL_Include
syn match nft_include "\v^\s*include" skipwhite keepend contained
\ nextgroup=
\    @nft_c_filespec_quoted

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
syn match nft_frag_hdr_field_frag_off "\vfrag-off" skipwhite contained

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

hi link nft_UnexpectedEmptyCurlyBraces nftHL_Error
syn match nft_UnexpectedEmptyCurlyBraces "\v\{\s*\}" skipwhite contained " do not use 'keepend' here

hi link nft_UnexpectedEmptyBrackets nftHL_Error
syn match nft_UnexpectedEmptyBrackets "\v\[\s*\]" skipwhite contained " do not use 'keepend' here

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
syn match nft_th_hdr_field_sport "\vsport" contained skipwhite

hi link nft_th_hdr_field_dport nftHL_Action
syn match nft_th_hdr_field_dport "\vdport" contained skipwhite

syn cluster nft_c_th_hdr_field
\ contains=
\    nft_th_hdr_field_sport,
\    nft_th_hdr_field_dport

" th_hdr_expr (via payload_expr, inner_inet_expr)
hi link nft_th_hdr_expr nftHL_Statement
syn match nft_th_hdr_expr "\vth" skipwhite contained
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

" sctp_chunk_common_field (via sctp_chunk_common_field)
hi link nft_sctp_chunk_common_field_type nftHL_Action
syn match nft_sctp_chunk_common_field_type "\vtype" skipwhite contained

hi link nft_sctp_chunk_common_field_flags nftHL_Action
syn match nft_sctp_chunk_common_field_flags "\vflags" skipwhite contained

hi link nft_sctp_chunk_common_field_length nftHL_Action
syn match nft_sctp_chunk_common_field_length "\vlength" skipwhite contained

syn cluster nft_c_sctp_chunk_common_field
\ contains=
\    nft_sctp_chunk_common_field_type,
\    nft_sctp_chunk_common_field_flags,
\    nft_sctp_chunk_common_field_length,

" sctp_chunk_type (via sctp_chunk_alloc)
hi link nft_sctp_chunk_type nftHL_Action
syn match nft_chunk_type /(data|init\-ack|init|sack|heartbeat\-ack|heartbeat|abort|shutdown\-complete|shutdown\-ack|error|cookie\-echo|cookie\-ack|ecne|cwr|shutdown|asconf\-ack|forward\-tsn|asconf)/ skipwhite contained
\ nextgroup=
\    @sctp_c_chunk_common_field,
\    nft_EOL

" sctp_chunk_data_field (via sctp_chunk_alloc)
hi link nft_sctp_chunk_data_field nftHL_Action
syn match nft_sctp_chunk_data_field "\v(tsn|stream|ssn|ppid)" skipwhite contained

" sctp_chunk_alloc 'data' (via sctp_hdr_expr)
hi link nft_sctp_chunk_alloc_data_keyword nftHL_Action
syn match nft_sctp_chunk_alloc_data_keyword "\vdata" skipwhite contained
\ nextgroup=@nft_sctp_chunk_alloc_data_field

" sctp_chunk_init_field
syn match nft_c_sctp_chunk_init_field "\v(init\-tag|a\-rwnd|num\-outbound\-stream|num_inbound\-streams|initial\-tsn)" skipwhite contained

" sctp_chunk_alloc 'init' (via sctp_hdr_expr)
syn match nft_sctp_chunk_alloc_init "\v(init_ack|init)" skipwhite contained
\ nextgroup=@nft_c_sctp_chunk_init_field

" sctp_chunk_alloc 'sack' (via sctp_hdr_expr)
hi link nft_c_sctp_chunk_sack_field nftHL_Action
syn match nft_c_sctp_chunk_sack_field "\v(cum\-tsn\-ack|a\-rwnd|num\-gap\-ack\-blocks|num\-dup\-tsns)" skipwhite contained

" sctp_chunk_alloc 'sack' (via sctp_hdr_expr)
hi link nft_sctp_chunk_sack nftHL_Action
syn match nft_sctp_chunk_sack "\vsack" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_sack_field

" sctp_chunk_alloc_shutdown_field (via sctp_chunk_alloc 'shutdown')
hi link nft_sctp_chunk_alloc_shutdown_field nftHL_Action
syn match nft_sctp_chunk_alloc_shutdown_field "\vcum_tsn_ack" skipwhite contained

" sctp_chunk_alloc 'shutdown' (via sctp_hdr_expr)
hi link nft_sctp_chunk_alloc_shutdown nftHL_Action
syn match nft_sctp_chunk_alloc_shutdown "\vshutdown" skipwhite contained
\ nextgroup=
\    @nft_sctp_chunk_alloc_shutdown_field

" sctp_chunk_alloc_ecne_cwr 'cum_tsn_ack' (via sctp_chunk_alloc 'ecne'|'cwr')
hi link nft_sctp_chunk_alloc_shutdown_field nftHL_Action
syn match nft_sctp_chunk_alloc_shutdown_field "\vcum_tsn_ack" skipwhite contained

" sctp_chunk_alloc_ecne_cwr
hi link nft_sctp_chunk_alloc_ecne_cwr nftHL_Action
syn match nft_sctp_chunk_alloc_ecne_cwr "\v(ecne|cwr)" skipwhite contained
\ nextgroup=
\    @nft_sctp_chunk_alloc_ecne_cwr_field

" sctp_chunk_alloc_asconf_ack 'seqno' (via sctp_hdr_expr)
hi link nft_sctp_chunk_alloc_asconf_ack_field nftHL_Action
syn match nft_sctp_chunk_alloc_asconf_ack_field "\vseqno" skipwhite contained

" sctp_chunk_alloc_asconf_ack
hi link nft_sctp_chunk_alloc_asconf_ack nftHL_Action
syn match nft_sctp_chunk_alloc_asconf_ack "\v(asconf_ack|asconf)" skipwhite contained
\ nextgroup=
\    @nft_sctp_chunk_alloc_asconf_ack_field

" sctp_chunk_alloc_forward_tsn
hi link nft_sctp_chunk_alloc_forward_tsn_field nftHL_Action
syn match nft_sctp_chunk_alloc_forward_tsn_field "\vseqno" skipwhite contained

" sctp_chunk_alloc_forward_tsn
hi link nft_sctp_chunk_alloc_forward_tsn nftHL_Action
syn match nft_sctp_chunk_alloc_forward_tsn "\vforward_tsn" skipwhite contained
\ nextgroup=
\    @nft_sctp_chunk_alloc_forward_tsn_field

" sctp_chunk_alloc (via sctp_hdr_expr)
syn cluster nft_c_sctp_chunk_alloc
\ contains=
\    nft_sctp_chunk_type,
\    nft_sctp_chunk_alloc_data,
\    nft_sctp_chunk_alloc_init,
\    nft_sctp_chunk_alloc_sack,
\    nft_sctp_chunk_alloc_shutdown,
\    nft_sctp_chunk_alloc_ecne_cwr,
\    nft_sctp_chunk_alloc_asconf_ack,
\    nft_sctp_chunk_alloc_asconf,
\    nft_sctp_chunk_alloc_forward_tsn

hi link nft_sctp_hdr_expr_chunk nftHL_Action
syn match nft_sctp_hdr_expr_chunk "\vchunk" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_alloc

" sctp_hdr_expr (via inner_inet_expr, payload_expr)
" sctp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" sctp_hdr_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
hi link nft_sctp_hdr_expr nftHL_Statement
syn match nft_sctp_hdr_expr "\vsctp" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_hdr_field,
\    @nft_sctp_hdr_expr_chunk

" dccp_hdr_field (via nft_dccp_hdr_expr)
hi link nft_dccp_hdr_field nftHL_Action
syn match nft_dccp_hdr_field "\v(sport|dport|type)" skipwhite contained

" nft_dccp_hdr_expr 'option num' (via nft_dccp_hdr_expr)
hi link nft_dccp_hdr_expr_option nftHL_Action
syn match nft_dccp_hdr_expr_option "\voption\s+\d+" skipwhite contained

" dccp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" dccp_hdr_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
hi link nft_dccp_hdr_expr nftHL_Action
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
syn match nft_tcp_hdr_option_sack "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained

" tcp_hdr_option_type (via optstrip_stmt, tcp_hdr_expr, tcp_hdr_option)
hi link nft_tcp_hdr_option_types nftHL_Action
syn match nft_tcp_hdr_option_types "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack\-permitted|timestamp|window|num)" skipwhite contained

syn cluster nft_c_tcp_hdr_option_type
\ contains=
\    nft_tcp_hdr_option_sack,
\    nft_tcp_hdr_option_types

hi link nft_optstrip_stmt_type nftHL_Action
syn match nft_optstrip_stmt_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack_perm|timestamp|window|num)" skipwhite contained

hi link nft_tcp_hdr_expr_type nftHL_Action  " nft_tcp_hdr_option_kind_and_field
syn match nft_tcp_hdr_expr_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack_perm|timestamp|window|num)" skipwhite contained

" tcp_hdr_option_kind_and_field 'mss' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_kaf_mss nftHL_Action
syn match nft_tcp_hdr_option_kaf_mss "\vmss" skipwhite contained
\ nextgroup=nft_tcpopt_field_maxseg

" tcp_hdr_option_kind_and_field "sack" (via *tcp_hdr_option_kind_and_field*, tcp_hdr_option_type)
hi link nft_tcp_hdr_option_sack_kaf nftHL_Action
syn match nft_tcp_hdr_option_sack_kaf "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained
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
syn match nft_tcp_hdr_option_type_kaf "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcp_hdr_option_kaf_length

" tcp_hdr_option 'mptcp' (via tcp_hdr_option_kind_and_field)
hi link nft_tcp_hdr_option_mptcp nftHL_Action
syn match nft_tcp_hdr_option_mptcp "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcpopt_field_mptcp

syn cluster nft_c_tcp_hdr_option_kind_and_field
\ contains=
\    nft_tcp_hdr_option_kaf_mss,
\    nft_tcp_hdr_option_sack_kaf,
\    nft_tcp_hdr_option_kaf_window,
\    nft_tcp_hdr_option_kaf_timestamp,
\    nft_tcp_hdr_option_type_kaf,
\    nft_tcp_hdr_option_kaf_mptcp

" tcp_hdr_field (via tcp_hdr_expr)
hi link nft_tcp_hdr_field_keywords nftHL_Action
syn match nft_tcp_hdr_field_keywords "\v(sport|dport|sequence|ackseq|doff|reserved|flags|window|checksum|urgptr)" skipwhite contained

" optstrip_stmt (via stmt)
hi link nft_optstrip_stmt nftHL_Action
syn match nft_optstrip_stmt "\vreset\s+tcp\s+option" skipwhite contained
\ nextgroup=nft_tcp_hdr_option_type

" gretap_hdr_expr (via payload_expr)
hi link nft_gretap_hdr_expr nftHL_Action
syn match nft_gretap_hdr_expr "\vgretap" skipwhite contained
\ nextgroup=@nft_c_inner_expr

" gre_hdr_field (via gre_hdr_expr)
hi link nft_gre_hdr_field nftHL_Action
syn match nft_gre_hdr_field "\v(hdrversion|flags|protocol)" skipwhite contained

" gre_hdr_expr
hi link nft_gre_hdr_expr nftHL_Action
syn match nft_gre_hdr_expr "\vgre" skipwhite contained
\ nextgroup=
\    nft_gre_hdr_field,
\    nft_inner_inet_expr

" geneve_hdr_field (via geneve_hdr_expr)
hi link nft_geneve_hdr_field nftHL_Action
syn match nft_geneve_hdr_field "\v(vni||type)" skipwhite contained

" geneve_hdr_expr (via payload_expr)
hi link nft_geneve_hdr_expr nftHL_Action
syn match nft_geneve_hdr_expr "\vgeneve" skipwhite contained
\ nextgroup=
\    nft_geneve_hdr_field,
\    nft_c_inner_expr

" vxlan_hdr_field (via vxlan_hdr_expr)
hi link nft_vxlan_hdr_field nftHL_Action
syn match nft_vxlan_hdr_field "\v(vni||flags)" skipwhite contained

" vxlan_hdr_expr 'vxlan' (via payload_expr)
hi link nft_vxlan_hdr_expr nftHL_Action
syn match nft_vxlan_hdr_expr "\vvxlan" skipwhite contained
\ nextgroup=
\    nft_vxlan_hdr_field,
\    nft_c_inner_expr

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
hi link nft_eth_hdr_expr nftHL_Action
syn match nft_eth_hdr_expr "\vether" skipwhite contained
\  nextgroup=@nft_c_eth_hdr_field

" vlan_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" vlan_hdr_field 'type' (via vlan_hdr_field)
hi link nft_vlan_hdr_field_type nftHL_Action
syn match nft_vlan_hdr_field_type "\vtype" skipwhite contained

" vlan_hdr_field keywords (via vlan_hdr_field)
hi link nft_vlan_hdr_field_keywords nftHL_Action
syn match nft_vlan_hdr_field_keywords "\v(id|cfi|dei|pcp)" skipwhite contained

" vlan_hdr_field (via vlan_hdr_expr)
syn cluster nft_c_vlan_hdr_field
\ contains=
\    nft_vlan_hdr_field_keywords,
\    nft_vlan_hdr_field_type

" vlan_hdr_expr (via inner_eth_expr, payload_expr)
hi link nft_vlan_hdr_expr nftHL_Action
syn match nft_vlan_hdr_expr "\vvlan" skipwhite contained
\ nextgroup=@nft_c_vlan_hdr_field

" arp_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" arp_hdr_field_addr_ether (via arp_hdr_field)
hi link nft_arp_hdr_field_addr_ether nftHL_Action
syn match nft_arp_hdr_field_addr_ether "\vether" skipwhite contained

" arp_hdr_field_ip_ether (via arp_hdr_field)
hi link nft_arp_hdr_field_ip_ether nftHL_Action
syn match nft_arp_hdr_field_ip_ether "\vip" skipwhite contained

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
hi link nft_arp_hdr_expr nftHL_Action
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
hi link nft_ip_option_type nftHL_Statement
syn match nft_ip_option_type "\v(lsrr|rr|ssrr|ra)" skipwhite contained
\ nextgroup=
\    nft_ip_option_field,
\    nft_Semicolon

" ip_hdr_expr_option (via ip_hdr_expr)
hi link nft_ip_hdr_expr_option nftHL_Statement
syn match nft_ip_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=nft_ip_option_type

" ip_hdr_field (via ip_hdr_expr)
hi link nft_ip_hdr_field nftHL_Statement
syn match nft_ip_hdr_field "\v(hdrversion|hdrlength|dscp|ecn|length|id|fra_off|ttl|protocol|checksum|saddr|daddr)" skipwhite contained

" ip_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_ip_hdr_expr nftHL_Statement
syn match nft_ip_hdr_expr "\vip" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field,
\    nft_ip_hdr_expr_option

" icmp_hdr_field (via icmp_hdr_expr)
hi link nft_icmp_hdr_field nftHL_Statement
syn match nft_icmp_hdr_field "\v(type|code|checksum|id|sequence|gateway|mtu)" skipwhite contained

" icmp_hdr_expr (via inner_inet_expr, payload_expr)
" icmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_icmp_hdr_expr nftHL_Statement
syn match nft_icmp_hdr_expr "\vicmp" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_field

" igmp_hdr_field (via igmp_hdr_expr)
hi link nft_igmp_hdr_field nftHL_Statement
syn match nft_igmp_hdr_field "\v(type|checksum|mrt|group)" skipwhite contained

" igmp_hdr_expr (via inner_inet_expr, payload_expr)
" igmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" igmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_igmp_hdr_expr nftHL_Statement
syn match nft_igmp_hdr_expr "\vigmp" skipwhite contained
\ nextgroup=
\    nft_igmp_hdr_field

" ip6_hdr_field (via ip6_hdr_expr)
hi link nft_ip6_hdr_field nftHL_Statement
syn match nft_ip6_hdr_field "\v(hdrversion|dscp|ecn|flowlabel|length|nexthdr|hoplimit|saddr|daddr)" skipwhite contained

" ip6_hdr_expr (via inner_inet_expr, payload_expr)
" ip6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" ip6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_ip6_hdr_expr nftHL_Statement
syn match nft_ip6_hdr_expr "\vip6" skipwhite contained
\ nextgroup=
\    nft_ip6_hdr_field

" icmp6_hdr_field (via icmp6_hdr_expr)
hi link nft_icmp6_hdr_field nftHL_Statement
syn match nft_icmp6_hdr_field "\v(type|code|checksum|param\-problem|mtu|id|sequence|max\-delay|taddr|daddr)" skipwhite contained

" icmp6_hdr_expr (via inner_inet_expr, payload_expr)
" icmp6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_icmp6_hdr_expr nftHL_Statement
syn match nft_icmp6_hdr_expr "\vicmp6" skipwhite contained
\ nextgroup=
\    nft_icmp6_hdr_field

" auth_hdr_field (via auth_hdr_expr)
hi link nft_auth_hdr_field nftHL_Statement
syn match nft_auth_hdr_field "\v(nexthdr|hdrlength|reserved|spi|sequence)" skipwhite contained

" auth_hdr_expr (via inner_inet_expr, payload_expr)
" auth_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" auth_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_auth_hdr_expr nftHL_Statement
syn match nft_auth_hdr_expr "\vauth" skipwhite contained
\ nextgroup=
\    nft_auth_hdr_field

" esp_hdr_field (via esp_hdr_expr)
hi link nft_esp_hdr_field nftHL_Statement
syn match nft_esp_hdr_field "\v(spi|sequence)" skipwhite contained

" esp_hdr_expr (via inner_inet_expr, payload_expr)
" esp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" esp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_esp_hdr_expr nftHL_Statement
syn match nft_esp_hdr_expr "\vesp" skipwhite contained
\ nextgroup=
\    nft_esp_hdr_field

" comp_hdr_field (via comp_hdr_expr)
hi link nft_comp_hdr_field nftHL_Statement
syn match nft_comp_hdr_field "\v(nexthdr|flags|cpi)" skipwhite contained

" comp_hdr_expr (via inner_inet_expr, payload_expr)
" comp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" comp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_comp_hdr_expr nftHL_Statement
syn match nft_comp_hdr_expr "\vcomp" skipwhite contained
\ nextgroup=
\    nft_comp_hdr_field

" udplite_hdr_field (via udplite_hdr_expr)
hi link nft_udplite_hdr_field nftHL_Statement
syn match nft_udplite_hdr_field "\v(sport|dport|csumcov|checksum)" skipwhite contained

" udplite_hdr_expr (via inner_inet_expr, payload_expr)
" udplite_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udplite_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_udplite_hdr_expr nftHL_Statement
syn match nft_udplite_hdr_expr "\vudplite" skipwhite contained
\ nextgroup=
\    nft_udplite_hdr_field

" udp_hdr_field (via udp_hdr_expr)
hi link nft_udp_hdr_field nftHL_Statement
syn match nft_udp_hdr_field "\v(sport|dport|length|checksum)" skipwhite contained

" udp_hdr_expr (via inner_inet_expr, payload_expr)
" udp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_udp_hdr_expr nftHL_Statement
syn match nft_udp_hdr_expr "\vudp" skipwhite contained
\ nextgroup=
\    nft_udp_hdr_field

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
syn match nft_tcp_hdr_option_at_tcp_hdr_option_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack\-permitted|timestamp|window|num)" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_comma

" tcp_hdr_expr 'option' 'tcp' 'at' (via tcp_hdr_expr)
hi link nft_tcp_hdr_option_at nftHL_Command
syn match nft_tcp_hdr_option_at "\vat" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_tcp_hdr_option_type "\vat" skipwhite contained

" tcp_hdr_expr 'option' (via inner_inet_expr, payload_expr)
hi link nft_tcp_hdr_expr_option nftHL_Action
syn match nft_tcp_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_type,
\    nft_tcp_hdr_option_sack,  " tcp_hdr_option 'sack'
\    @nft_c_tcp_hdr_option_kind_and_field,
\    nft_tcp_hdr_option_at

" tcp_hdr_expr (via inner_inet_expr, payload_expr)
" tcp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" tcp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link nft_tcp_hdr_expr nftHL_Statement
syn match nft_tcp_hdr_expr "\vtcp" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords,
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

" payload_base_spec (via payload_raw_expr)
hi link nft_c_payload_base_spec_string nftHL_String
syn match nft_c_payload_base_spec_string "\vll|nh|th" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1

hi link nft_c_payload_base_spec_hdrs nftHL_Action
syn match nft_c_payload_base_spec_hdrs "\vll|nh|th" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1

" payload_base_spec (via payload_raw_expr)
syn cluster nft_c_payload_base_spec
\ contains=
\    nft_payload_base_spec_hdrs,
\    nft_payload_base_spec_string

hi link nft_payload_base_spec_via_payload_expr_set nftHL_Action
syn match nft_payload_base_spec_via_payload_expr_set "\vll|nh|th|string" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1_via_payload_expr_set

" payload_raw_expr (via payload_expr)
hi link nft_payload_raw_expr nftHL_Action
syn match nft_payload_raw_expr "\vat" skipwhite contained
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
syn region nft_payload_expr_basic_stmt_expr start="(" end=")" skipwhite keepend contained
"\ contains=nft_c_basic_stmt_expr

hi link nft_integer_expr nftHL_Number
syn match nft_integer_expr "\v\d+" skipwhite contained

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
syn match nft_c_keyword_expr "\v(ether|ip6|ip |vlan|arp|dnat|snat|ecn|reset|destroy|original|reply|label|last)" skipwhite contained

" symbol_expr (via primary_expr, primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn cluster nft_c_symbol_expr
\ contains=
\    nft_variable_expr,
\    @nft_c_string
""" nft_c_string must be the LAST contains= (via nft_unquoted_string)

" symbol_stmt_expr (via stmt_expr)
syn cluster nft_c_symbol_stmt_expr
\ contains=
\    @nft_c_keyword_expr,
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

" stmt_expr (via ct_stmt, dup_stmt, fwd_stmt, masq_stmt_args, meta_stmt, nat_stmt,
"                objref_stmt_counter, objref_stmt_ct, objref_stmt_limit, objref_stmt_quota,
"                objref_stmt_synproxy, payload_stmt, redir_stmt_arg, tproxy_stmt)
syn cluster nft_c_stmt_expr
\ contains=
\    @nft_c_symbol_stmt_expr,
\    @nft_c_multiton_stmt_expr,
\    @nft_c_map_stmt_expr
"\    map_stmt_expr,
"\    multiton_stmt_expr,

" primary_expr (via primary_stmt, primary_expr, primary_stmt_expr)
syn cluster nft_c_primary_expr
\ contains=
\    nft_integer_expr,
\    @nft_c_payload_expr_via_primary_expr,
\    @nft_c_exthdr_expr,
\    @nft_c_meta_expr,
\    nft_exthdr_exists_expr,
\    @nft_c_symbol_expr
" nft_c_symbol_expr must be the LAST contains= (via nft_unquoted_string)
"\    nft_socket_expr,
"\    nft_rt_expr,
"\    nft_ct_expr,
"\    nft_umgen_expr,
"\    nft_hash_expr,
"\    nft_fib_expr,
"\    nft_osf_expr,
"\    nft_xfrm_expr,
"\    nft_basic_expr

" payload_stmt <payload_expr> 'set' (via payload_stmt <payload_expr>)
hi link nft_payload_stmt_before_set nftHL_Statement
syn match nft_payload_stmt_before_set "\vset" skipwhite contained
\ nextgroup=@nft_c_stmt_expr


hi link   nft_icmp_hdr_expr_icmp_hdr_field nftHL_Action
syn match nft_icmp_hdr_expr_icmp_hdr_field "\v(type|code|checksum|id|sequence|gateway|mtu)" skipwhite contained

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

syn cluster nft_c_payload_stmt
\ contains=@nft_c_payload_expr_via_payload_stmt

" SLE marker "
" next ct_stmt
" ct_stmt->stmt
hi link nft_ct_stmt nftHL_Command
syn match nft_ct_stmt "\vct" skipwhite contained
\ nextgroup=
\    nft_ct_stmt_ct_key,
\    nft_ct_stmt_ct_dir

" symbol_stmt_expr->stmt_expr
syn cluster nft_symbol_stmt_expr
\ contains=nft_symbol_stmt_expr_nested_comma

" 'set'->(ct_key|ct_key_dir|ct_stmt)
hi link nft_ct_stmt_keyword_set nftHL_Command
syn match nft_ct_stmt_keyword_set "\vset" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr
" ct_key_dir_optional->(ct_key|ct_key_dir|ct_stmt)
hi link nft_ct_key_dir_optional nftHL_Action
syn match nft_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)"
\ nextgroup=
\    nft_ct_stmt_keyword_set

" base_cmd 'describe' (via line)
hi link nft_base_cmd_describe nftHL_Command
syn match nft_base_cmd_describe "\vdescribe" skipwhite contained
\ nextgroup=
\    @nft_c_primary_expr


"
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

" base_cmd 'monitor' (via line)
hi link nft_base_cmd_monitor nftHL_Command
syn match nft_base_cmd_monitor "\vmonitor" skipwhite contained
\ nextgroup=
\    @nft_c_monitor_cmd

" base_cmd 'import' (via base_cmd)
hi link nft_import_cmd nftHL_Operator
syn match nft_import_cmd "\v(ruleset)?(\s+(xml|json|vm\s+json))" skipwhite keepend contained
\ contains=
\    nft_markup_format
\ nextgroup=
\    nft_markup_format

" import_cmd (via base_cmd)
hi link nft_base_cmd_import nftHL_Command
syn match nft_base_cmd_import "\vimport" skipwhite contained
\ nextgroup=nft_import_cmd


" export_cmd markup_format (via export_cmd)
hi link nft_export_cmd nftHL_Operator
syn match nft_export_cmd "\v(ruleset)?(\s+(xml|json|vm\s+json))" skipwhite keepend contained
\ contains=
\    nft_markup_format
\ nextgroup=
\    nft_markup_format

" base_cmd 'export' (via base_cmd)
hi link nft_base_cmd_export nftHL_Command
syn match nft_base_cmd_export "\vexport" skipwhite contained
\ nextgroup=nft_export_cmd

" base_cmd 'create' (via base_cmd0
hi link   nft_base_cmd_create nftHL_Command
syn match nft_base_cmd_create "\vcreate" skipwhite contained
\ nextgroup=
\    nft_base_cmd_create_cmd_table_keyword,
\    nft_base_cmd_create_cmd_chain_keyword,
\    nft_base_cmd_create_cmd_set_keyword,
\    nft_base_cmd_create_cmd_map_keyword,
\    nft_base_cmd_create_cmd_flowtable_keyword,
\    nft_base_cmd_create_cmd_element_keyword,
\    nft_base_cmd_create_cmd_counter_keyword,
\    nft_base_cmd_create_cmd_quota_keyword,
\    nft_base_cmd_create_cmd_ct_keyword,
\    nft_base_cmd_create_cmd_limit_keyword,
\    nft_base_cmd_create_cmd_secmark_keyword,
\    nft_base_cmd_create_cmd_synproxy_keyword

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier rule
syn cluster nft_c_base_cmd_replace_rule_alloc_stmt
\ contains=
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
hi link   nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_id nftHL_Handle
syn match nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_id "\v[0-9]{1,9}" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_replace_rule,
\    nft_Semicolon

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_spec nftHL_Action
syn match nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_spec "\v(position|index|handle)\s" skipwhite contained
\ nextgroup=
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_id

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier
hi link   nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_chain_id nftHL_Chain
syn match nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_chain_id "\v[a-zA-Z0-9\-_]{1,64}\s+" skipwhite contained
\ nextgroup=
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_handle_spec

" base_cmd 'replace' [ family_spec ] table_identifier
hi link   nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_table_id nftHL_Table
syn match nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_table_id "\v[a-zA-Z0-9\-_]{1,64}\s+" contained
\ nextgroup=
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_chain_id

" base_cmd 'replace' family_spec
hi link   nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_family_spec_family nftHL_Family
syn match nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_family_spec_family "\v(ip6|ip|inet|bridge|netdev|arp)\s+" skipwhite contained
\ nextgroup=
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_table_id

" base_cmd 'replace' [ family_spec ]
syn cluster nft_c_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_family_spec
\ contains=
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_family_spec_family,
\    nft_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_table_id

" base_cmd 'replace' 'rule'
hi link   nft_base_cmd_replace nftHL_Command
syn match nft_base_cmd_replace "\vreplace\s{1,64}rule" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_replace_rule_ruleid_spec_chain_spec_table_spec_family_spec

""""""""" BEGIN OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""
" table_flag (via table_options 'flags')
hi link nft_add_table_options_flag_list_item_comma nftHL_Expression
syn match nft_add_table_options_flag_list_item_comma ',' skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_table_options_table_flag_recursive

hi link nft_add_table_options_flag_list_item nftHL_Identifier
syn match nft_add_table_options_flag_list_item "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
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

" add_cmd 'table' table_block table_options comment_spec 'comment' string UNQUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_unquoted nftHL_String
syn match nft_add_table_table_options_comment_spec_string_unquoted "\v[a-zA-Z0-9\/\\\[\]]+" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_table_table_options_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]+" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link   nft_add_table_table_options_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']+" keepend contained

hi link    nft_add_table_table_options_comment_spec_string_single nftHL_String
syn region nft_add_table_table_options_comment_spec_string_single start="'" end="'" keepend contained
\ contains=nft_add_table_table_options_comment_spec_string_sans_double_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_double nftHL_String
syn region nft_add_table_table_options_comment_spec_string_double start="\"" end="\"" keepend contained
\ contains=nft_add_table_table_options_comment_spec_string_sans_single_quote

" add_cmd 'table' table_block table_options comment_spec 'comment' string QUOTED_STRING
hi link nft_add_table_table_options_comment_spec_string_sans_asterisk_quote nftHL_String
syn match nft_add_table_table_options_comment_spec_string_sans_asterisk_quote "\v[\'\"\sa-zA-Z0-9\/\\\[\]\']+" keepend contained

" add_cmd 'table' table_block table_options comment_spec 'comment' string <ASTERISK_STRING>
hi link    nft_add_table_table_options_comment_spec_string_asterisked nftHL_String
syn region nft_add_table_table_options_comment_spec_string_asterisked start="*" end="*" excludenl skipnl skipempty skipwhite keepend contained
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
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid "\v\d{1,3}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block_separator

hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec_number nftHL_Error
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec_number "\v\w" skipwhite contained
\ contains=nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid

" cmd_add 'table' table_block chain_block hook_spec 'type' prio_spec 'priority'
hi link   nft_add_table_table_block_chain_block_hook_spec_prio_spec nftHL_Command
syn match nft_add_table_table_block_chain_block_hook_spec_prio_spec 'priority' skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec_number_valid,
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec_number,

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device' string
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_string nftHL_Device
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_device_string  "\v[a-zA-Z0-9\_\-]{1,64}" skipwhite contained
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

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr
hi link   nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_member_expr nftHL_Identifier
syn match nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_member_expr "\v($)?[a-zA-Z0-9\-\_]{1,64}" skipwhite contained

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr flowtable_block
hi link  nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block nftHL_Normal
syn region nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block
\ start=/{/ end=/}/ keepend skipwhite contained
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_member_expr

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec_flowtable_expr
\ contains=
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr,
\    nft_add_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block,
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

hi link   nft_add_table_table_block_chain_block_hook_spec_hook_id nftHL_Hook
syn match nft_add_table_table_block_chain_block_hook_spec_hook_id "\v(ingress|prerouting|input|forward|output|postrouting)" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec,
\    nft_add_table_table_block_chain_block_hook_spec_prio_spec,
\    nft_UnexpectedEOS

hi link   nft_add_table_table_block_chain_block_hook_spec_hook nftHL_Command
syn match nft_add_table_table_block_chain_block_hook_spec_hook 'hook' skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_hook_id

hi link   nft_add_table_table_block_chain_block_hook_spec_type_id nftHL_Type
syn match nft_add_table_table_block_chain_block_hook_spec_type_id "\v(filter|route|nat)" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_block_hook_spec_hook,
\    nft_Semicolon,
\    nft_UnexpectedEOS

" hook_spec (via chain_block)
hi link    nft_add_table_table_block_chain_block_hook_spec nftHL_Statement
syn match nft_add_table_table_block_chain_block_hook_spec "\stype\s" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_block_hook_spec_type_id

" add_cmd 'table' table_block 'chain' chain_block policy_spec 'policy' variable_expr
hi link   nft_add_table_table_block_chain_chain_policy_spec_policy_expr_variable_expr_variable nftHL_Variable
syn match nft_add_table_table_block_chain_chain_policy_spec_policy_expr_variable_expr_variable skipwhite contained
\ "\v\$[A-Za-z0-9\-\_]{1,64}"
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
hi link   nft_add_table_table_block_chain_chain_block_policy_spec nftHL_Command
syn match nft_add_table_table_block_chain_chain_block_policy_spec "policy" skipwhite contained
\ nextgroup=@nft_c_add_table_table_block_chain_chain_policy_spec_policy_expr
\ nextgroup=nft_Semicolon

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'offload' ';'
hi link   nft_add_table_table_block_chain_chain_flags_spec_separator nftHL_Normal
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
syn match nft_add_table_table_block_chain_chain_block_flags_spec_flags "\v^\s{0,64}flags" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_flags_spec_offload,
\    nft_Error


" add_cmd 'table' table_block 'chain' chain_block comment_spec 'comment' string
hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_unquoted "\v[a-zA-Z0-9\/\\\[\]]{1,64}" keepend contained

hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link   nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_string_single nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_string_single start="'" end="'" keepend contained
\ contains=nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_string_double nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_string_double start="\"" end="\"" keepend contained
\ contains=nft_add_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote

syn cluster nft_c_add_table_table_block_chain_chain_block_comment_spec_quoted_string
\ contains=
\    nft_add_table_table_block_chain_chain_block_comment_spec_string_single,
\    nft_add_table_table_block_chain_chain_block_comment_spec_string_double

hi link    nft_add_table_table_block_chain_chain_block_comment_spec_asterisk_string nftHL_String
syn region nft_add_table_table_block_chain_chain_block_comment_spec_asterisk_string start="\*" end="\*" keepend contained
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



" add_cmd 'table' table_block 'chain' chain_block 'devices' '=' flowtable_expr flowtable_block variable_expr
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr nftHL_Variable
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr "\v\$[a-zA-Z0-9\-\_]{1,64}" skipwhite contained

" add_cmd 'table' table_block 'chain' chain_block 'devices' '=' flowtable_expr '{' flowtable_member_expr '}'
hi link   nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_member_expr nftHL_Identifier
syn match nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_member_expr "\v(\$)?[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
" TODO flowtable_expr_member <QUOTED_STRING> <STRING> variable_expr

" add_cmd 'table' table_block 'chain' chain_block 'devices' '=' flowtable_expr '{' '}'
hi link    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block nftHL_Normal
syn region nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block
\ start=/{/ end=/}/ keepend skipwhite contained
\ contains=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_member_expr
\ nextgroup=nft_UnexpectedEOS
\ nextgroup=nft_Semicolon

" add_cmd 'table' table_block 'chain' chain_block 'devices' '='
hi link   nft_add_table_table_block_chain_chain_block_devices_equal nftHL_Operator
syn match nft_add_table_table_block_chain_chain_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_block,
\    nft_add_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr,

" add_cmd 'table' table_block 'chain' chain_block 'devices'
hi link   nft_add_table_table_block_chain_chain_block_devices nftHL_Statement
syn match nft_add_table_table_block_chain_chain_block_devices "devices" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block_devices_equal
\ nextgroup=nft_add_table_table_block_chain_chain_block_devices_variable_expr

hi link nft_chainError nftHL_Error
syn match nft_chainError /\v[a-zA-Z0-9\_\.\/;:]{1,64}/ skipwhite contained

" add_cmd 'table' table_block 'chain' chain_block
" common_block is contains=lastly due to 'comment' in chain_block & chain_block/rule
hi link    nft_add_table_table_block_chain_chain_block nftHL_Normal
syn region nft_add_table_table_block_chain_chain_block start=/{/ end=/}/ skipnl skipempty keepend contained
\ contains=
\    nft_comment_inline,
\    nft_add_table_table_block_chain_block_hook_spec,
\    nft_add_table_table_block_chain_chain_block_policy_spec,
\    nft_add_table_table_block_chain_chain_block_flags_spec_flags,
\    nft_add_table_table_block_chain_chain_block_rule,
\    nft_add_table_table_block_chain_chain_block_devices,
\    nft_add_table_table_block_chain_chain_block_comment_spec
\ contains=BUT,
\    nft_add_table_table_block_chain_keyword,
\    nft_add_table_options_flag_keyword,
\    nft_add_table_table_block
\ nextgroup=
\    nft_Semicolon,
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

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_unquoted nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_unquoted "\v[a-zA-Z0-9\_\-\/\\\[\]]{1,64}" skipwhite contained
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_sans_double_quote nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote nftHL_Chain
syn match nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link    nft_add_table_table_block_chain_chain_identifier_string_single nftHL_Chain
syn region nft_add_table_table_block_chain_chain_identifier_string_single start="'" end="'" keepend skipwhite contained
\ contains=nft_add_table_table_block_chain_chain_identifier_string_sans_single_quote
\ nextgroup=nft_add_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' <DOUBLE_STRING>
hi link    nft_add_table_table_block_chain_chain_identifier_string_double nftHL_Chain
syn region nft_add_table_table_block_chain_chain_identifier_string_double start="\"" end="\"" keepend skipwhite contained
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
" add_cmd 'counter' obj_spec '{' counter_block '}'
hi link    nft_add_cmd_counter_counter_block nftHL_Normal
syn region nft_add_cmd_counter_counter_block start=/{/ end=/}/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL
\ contains=
\    nft_add_cmd_counter_counter_config,
"\    @nft_comment_spec,
"\    nft_stmt_separator,
"\    @nft_c_common_block

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes' <integer>
hi link   nft_add_cmd_counter_counter_config_bytes_num nftHL_Number
syn match nft_add_cmd_counter_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes'
hi link   nft_add_cmd_counter_counter_config_bytes nftHL_Action
syn match nft_add_cmd_counter_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_counter_config_bytes_num

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num>
hi link   nft_add_cmd_counter_counter_config_packet_num nftHL_Number
syn match nft_add_cmd_counter_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_counter_config_bytes

" add_cmd 'counter' obj_spec counter_config 'packet'
hi link   nft_add_cmd_counter_counter_config nftHL_Identifier
syn match nft_add_cmd_counter_counter_config "packet" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_counter_config_packet_num

" add_cmd 'counter' table_identifier [ obj_identifier | 'last' ]
hi link   nft_add_cmd_counter_obj_spec_obj_id nftHL_Identifier
syn match nft_add_cmd_counter_obj_spec_obj_id "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_counter_block,
\    nft_add_cmd_counter_counter_config

hi link   nft_add_cmd_counter_obj_spec_obj_last nftHL_Action
syn match nft_add_cmd_counter_obj_spec_obj_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_counter_config

" add_cmd 'counter' obj_spec obj_id table_spec table_id
hi link   nft_add_cmd_counter_obj_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_counter_obj_spec_table_spec_table_id "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_counter_obj_spec_obj_last,
\    nft_add_cmd_counter_obj_spec_obj_id

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_cmd_counter_obj_spec_table_spec_table_id

" base_cmd add_cmd 'counter' obj_spec
syn cluster nft_c_add_cmd_counter_obj_spec
\ contains=
\    nft_add_cmd_counter_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_counter_obj_spec_table_spec_table_id

" base_cmd add_cmd 'counter'
hi link   nft_base_cmd_add_counter nftHL_Command
syn match nft_base_cmd_add_counter "\v^\s*(counter|add\s*counter)" skipwhite contained
\ nextgroup=@nft_c_add_cmd_counter_obj_spec
""""" END OF add_cmd_/'counter'/obj_spec """""

""""" BEGIN OF add_cmd_/'chain'/chain_spec """""
" add_cmd 'chain' table_identifier [ chain_identifier | 'last' ]
hi link   nft_add_cmd_chain_spec_chain_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_chain_id "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=nft_add_cmd_chain_chain_block

hi link   nft_add_cmd_chain_spec_chain_last nftHL_Command
syn match nft_add_cmd_chain_spec_chain_last "last" skipwhite contained
\ nextgroup=nft_add_cmd_chain_chain_block

" add_cmd 'chain' chain_spec table_identifier
hi link   nft_add_cmd_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_table_spec_table_id "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
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

" base_cmd add_cmd 'chain'
hi link   nft_base_cmd_add_chain nftHL_Command
syn match nft_base_cmd_add_chain "\v^\s*(chain|add\s*chain)" skipwhite contained
\ nextgroup=@nft_c_add_cmd_chain_spec
""""" END OF add_cmd_/'chain'/chain_spec """""


" base_cmd add_cmd 'table' table_block table_options ';'
hi link nft_add_table_table_block_table_options_semicolon nftHL_Normal
syn match nft_add_table_table_block_table_options_semicolon ";" contained

" base_cmd_add_cmd 'table'  table_blocktable_options
syn cluster nft_c_add_table_table_block_table_options
\ contains=
\    nft_add_table_table_options_table_flag_keyword,
\    nft_add_table_table_options_comment_spec,
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

" add_cmd 'table' table_block
hi link nft_add_table_table_block  nftHL_PreProc
syn region nft_add_table_table_block  start=/{/ end=/}/ skipwhite contained
\ contains=
\    nft_add_table_table_block_chain_keyword,
\    @nft_c_add_table_table_block_table_options,
\    @nft_c_common_block
\ nextgroup=
\    nft_add_table_table_block_chain_keyword,
\    nft_hash_comment,
\    nft_Semicolon
\ contains=ALLBUT,nft_base_cmd_add_table
"\    nft_add_chain_table_spec_identifier,
""""""""" END OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""
"\    nft_add_chain_spec_family_spec_explicit,

" base_cmd add_cmd 'table' table_spec family_spec identifier
hi link nft_add_table_spec_identifier nftHL_Identifier
syn match nft_add_table_spec_identifier "\v[a-zA-Z0-9_\.\\\/]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_table_table_block,
\    nft_comment_inline

" base_cmd add_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_add_table_spec_family_spec_valid nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_add_table_spec_family_spec_valid "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_table_spec_identifier

" base_cmd add_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_add_table_spec_family_spec_invalid_with_cr_lf nftHL_Error  " _add_ to make 'table_spec' pathway unique
syn match nft_add_table_spec_family_spec_invalid_with_cr_lf "\v(ip(6)?|inet|arp|bridge|netdev)\s{1,64}[\n#{;]" skipwhite contained

" base_cmd add_cmd 'table' table_spec
syn cluster nft_c_add_table_spec
\ contains=
\    nft_add_table_spec_family_spec_invalid_with_cr_lf,
\    nft_add_table_spec_family_spec_valid,
\    nft_add_table_spec_identifier

" base_cmd add_cmd 'table'
hi link   nft_base_cmd_add_table nftHL_Command
syn match nft_base_cmd_add_table "\v(add\s{1,15}table|table)" skipwhite contained
\ nextgroup=@nft_c_add_table_spec


hi link nft_add_cmd_set_set_spec_set_block_separator nftHL_Normal
syn match nft_add_cmd_set_set_spec_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type_data_type_expr "[A-Za-z0-9\-_./]\{1,64}" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}(\.[a-zA-Z0-9]{1,64}){0,5}" contained  " do not use 'skipwhite' here
\ nextgroup=nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=@nft_c_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_add_cmd_set_set_spec_set_block_typeof_key_expr
\ contains=
\    nft_add_cmd_set_set_spec_set_block_typeof_key_expr_typeof,
\    nft_add_cmd_set_set_spec_set_block_typeof_key_expr_type


" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_comma nftHL_Operator
syn match nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_comma "," skipwhite contained
\ nextgroup=@nft_c_add_cmd_set_set_spec_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_set_flag nftHL_Action
syn match nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_set_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_add_cmd_set_set_spec_set_block_set_flag_list
\ contains=
\    nft_add_cmd_set_set_spec_set_block_flags_set_flag_list_set_flag

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_add_cmd_set_set_spec_set_block_flags nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_add_cmd_set_set_spec_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_set_set_spec_set_block_time_spec nftHL_Number
syn match nft_add_cmd_set_set_spec_set_block_time_spec "\v[A-Za-z0-9\-\_\:]{1,32}" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_add_cmd_set_set_spec_set_block_timeout nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_timeout "timeout" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'gc-interval'
hi link   nft_add_cmd_set_set_spec_set_block_gc_interval nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_time_spec


" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '=' set_block_expr
hi link   nft_add_cmd_set_set_spec_set_block_elements_set_block_expr_set_expr nftHL_Command
syn region nft_add_cmd_set_set_spec_set_block_elements_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_set_set_spec_set_block_element_set_block_elements_block_items
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator

syn region nft_c_add_cmd_set_set_spec_set_block_elements_set_block_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_set_set_spec_set_block_elements_set_block_expr_set_expr

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link   nft_add_cmd_set_set_spec_set_block_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_set_set_spec_set_block_expr_variable_expr "\$\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '='
hi link   nft_add_cmd_set_set_spec_set_block_elements_equal nftHL_Operator
syn match nft_add_cmd_set_set_spec_set_block_elements_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_set_block_expr_variable_expr,
""\    @nft_c_add_cmd_set_set_spec_set_block_elements_set_block_expr

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_elements_equal

" base_cmd add_cmd 'set' set_spec '{' set_block 'automerge'
hi link   nft_add_cmd_set_set_spec_set_block_automerge nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_automerge "auto\-merge" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size' <interval>
hi link   nft_add_cmd_set_set_spec_set_block_set_mechanism_size_value nftHL_Number
syn match nft_add_cmd_set_set_spec_set_block_set_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator,nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size'
hi link   nft_add_cmd_set_set_spec_set_block_set_mechanism_size nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_set_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_set_block_set_mechanism_size_value


" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'memory'
hi link   nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator,nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'performance'
hi link   nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=nft_add_cmd_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy'
hi link   nft_add_cmd_set_set_spec_set_block_set_mechanism_policy nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_set_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_memory,
\    nft_add_cmd_set_set_spec_set_block_set_mechanism_policy_performance

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism
syn cluster nft_c_add_cmd_set_set_spec_set_block_set_mechanism
\ contains=
\    nft_add_cmd_set_set_spec_set_block_set_mechanism_size,
\    nft_add_cmd_set_set_spec_set_block_set_mechanism_policy

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec STRING
hi link   nft_add_cmd_set_set_spec_set_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_set_set_spec_set_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_set_set_spec_set_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_set_set_spec_set_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_set_set_spec_set_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_set_set_spec_set_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_set_set_spec_set_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_set_set_spec_set_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec
syn cluster nft_c_add_cmd_set_set_spec_set_block_comment_string
\ contains=
\   nft_add_cmd_set_set_spec_set_block_comment_string_asterisk,
\   nft_add_cmd_set_set_spec_set_block_comment_string_quoted_single,
\   nft_add_cmd_set_set_spec_set_block_comment_string_quoted_double,
\   nft_add_cmd_set_set_spec_set_block_comment_string_string

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment'
hi link   nft_add_cmd_set_set_spec_set_block_comment_spec nftHL_Command
syn match nft_add_cmd_set_set_spec_set_block_comment_spec "comment" skipwhite contained
\ nextgroup=@nft_c_add_cmd_set_set_spec_set_block_comment_string

" base_cmd add_cmd 'set' set_spec '{' set_block '}'
hi link    nft_add_cmd_set_set_spec_set_block nftHL_Normal
syn region nft_add_cmd_set_set_spec_set_block start=/{/ end=/}/ skipwhite contained
\ contains=
\    @nft_c_add_cmd_set_set_spec_set_block_typeof_key_expr,
\    nft_add_cmd_set_set_spec_set_block_flags,
\    nft_add_cmd_set_set_spec_set_block_timeout,
\    nft_add_cmd_set_set_spec_set_block_gc_interval,
\    undefined_stateful_stmt_list,
\    undefined_set_mechanism,
\    nft_add_cmd_set_set_spec_set_block_comment_spec,
\    nft_add_cmd_set_set_spec_set_block_elements,
\    nft_add_cmd_set_set_spec_set_block_automerge,
\    @nft_c_add_cmd_set_set_spec_set_block_set_mechanism,
\    @nft_c_common_block,
\    nft_add_cmd_set_set_spec_set_block_separator,
\    nft_Semicolon,
\    BUT,nft_UnexpectedEOS
\ nextgroup=
\    nft_comment_inline,
\    nft_UnexpectedEOS,
\    nft_Semicolon,

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link   nft_add_cmd_set_set_spec_set_block_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_set_set_spec_set_block_expr_variable_expr "\$\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_UnexpectedEOS

" base_cmd add_cmd 'set' set_spec set_identifier
hi link   nft_add_cmd_set_set_spec_set_id nftHL_Set
syn match nft_add_cmd_set_set_spec_set_id "\v[0-9a-zA-Z\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_UnexpectedEmptyCurlyBraces,
\    nft_add_cmd_set_set_spec_set_block_expr_variable_expr,
\    nft_add_cmd_set_set_spec_set_block,
\    nft_UnexpectedEOS


" base_cmd add_cmd 'set' set_spec identifier (chain)
hi link   nft_add_cmd_set_set_spec_chain_id nftHL_Chain
syn match nft_add_cmd_set_set_spec_chain_id "\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_set_id,
\    nft_UnexpectedEOS

" base_cmd add_cmd 'set' set_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_set_set_spec_table_spec_family_spec_table_id nftHL_Table
syn match nft_add_cmd_set_set_spec_table_spec_family_spec_table_id "\v[a-zA-Z\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_chain_id,
\    nft_UnexpectedEOS

" base_cmd add_cmd 'set' set_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_set_set_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_set_set_spec_table_spec_family_spec_family_spec_explicit
\ "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_set_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedEOS

" base_cmd [ 'add' ] 'set' set_spec table_spec
syn cluster nft_c_add_cmd_set_set_spec_table_spec
\ contains=
\    nft_add_cmd_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_set_set_spec_table_spec_family_spec_table_id

" base_cmd [ 'add' ] 'set' set_spec
syn cluster nft_c_add_cmd_set_set_spec
\ contains=@nft_c_add_cmd_set_set_spec_table_spec

" base_cmd [ 'add' ] 'set'
hi link   nft_base_cmd_add_set nftHL_Command
syn match nft_base_cmd_add_set "\v(add\s{1,15}set|set)" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_set_set_spec,
\    nft_UnexpectedEOS


hi link nft_add_cmd_map_map_spec_map_block_separator nftHL_Normal
syn match nft_add_cmd_map_map_spec_map_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr "[A-Za-z0-9\-_./]\{1,64}" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}(\.[a-zA-Z0-9]{1,64}){0,5}" contained  " do not use 'skipwhite' here
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


" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '=' map_block_expr
hi link   nft_add_cmd_map_map_spec_map_block_elements_map_block_expr nftHL_Command
syn region nft_add_cmd_map_map_spec_map_block_elements_map_block_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_element_map_block_elements_block_items
\ nextgroup=nft_add_cmd_map_map_spec_map_block_separator

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '='
hi link   nft_add_cmd_map_map_spec_map_block_elements_equal nftHL_Operator
syn match nft_add_cmd_map_map_spec_map_block_elements_equal "=" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_map_block_elements_set_block_expr

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
hi link    nft_add_cmd_map_map_spec_map_block nftHL_Normal
syn region nft_add_cmd_map_map_spec_map_block start=/{/ end=/}/ skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_timeout,
\    nft_add_cmd_map_map_spec_map_block_gc_interval,
\    nft_add_cmd_map_map_spec_map_block_flags,
\    undefined_stateful_stmt_list,
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
syn match nft_add_cmd_map_map_spec_identifier_set "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block

" base_cmd add_cmd 'map' map_spec chain_identifier (chain)
hi link   nft_add_cmd_map_map_spec_identifier_chain nftHL_Chain
syn match nft_add_cmd_map_map_spec_identifier_chain "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_identifier_set

" base_cmd add_cmd 'map' map_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_identifier_chain

" base_cmd add_cmd 'map' map_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit
\ "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec table_spec
syn cluster nft_c_add_cmd_map_map_spec_table_spec
\ contains=
\    nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec
syn cluster nft_c_add_cmd_map_map_spec
\ contains=@nft_c_add_cmd_map_map_spec_table_spec

" base_cmd [ 'add' ] 'map'
hi link   nft_base_cmd_add_map nftHL_Command
syn match nft_base_cmd_add_map "\v(add\s{1,15}map|map)" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec



hi link nft_add_cmd_flowtable_flowtable_spec_flowtable_block_separator nftHL_Normal
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd_add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_hook nftHL_Command
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_hook "hook" skipwhite contained
\ nextgroup=@nft_c_add_cmd_flowtable_flowtable_spec_flowtable_block_hook_string

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list flowtable_flag
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag nftHL_Action
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag skipwhite contained
\ "\v(offload)"

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list
syn cluster nft_c_add_cmd_flowtable_flowtable_spec_flowtable_block_flowtable_flag_list
\ contains=
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags'
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags nftHL_Command
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags "flags" skipwhite contained
\ nextgroup=@nft_c_add_cmd_flowtable_flowtable_spec_flowtable_block_flowtable_flag_list


" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'counter'
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_counter nftHL_Action
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_counter "counter" skipwhite contained

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'devices' '='
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices_equal nftHL_Operator
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices_equal "=" skipwhite contained
\ nextgroup=nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices_set_block_expr

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'devices'
hi link   nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices nftHL_Action
syn match nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices "devices" skipwhite contained
\ nextgroup=nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices_equal

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block '}'
hi link    nft_add_cmd_flowtable_flowtable_spec_flowtable_block nftHL_Normal
syn region nft_add_cmd_flowtable_flowtable_spec_flowtable_block start=/{/ end=/}/ skipwhite contained
\ nextgroup=nft_comment_inline,nft_Semicolon
\ contains=
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_counter,
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_devices,
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_flags,
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_hook,
\    @nft_c_common_block,
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block_separator

" base_cmd add_cmd 'flowtable' flowtable_spec identifier (chain)
hi link   nft_add_cmd_flowtable_flowtable_spec_identifier_flowtable nftHL_Chain
syn match nft_add_cmd_flowtable_flowtable_spec_identifier_flowtable "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_flowtable_flowtable_spec_flowtable_block

" base_cmd add_cmd 'flowtable' flowtable_spec identifier (chain)
hi link   nft_add_cmd_flowtable_flowtable_spec_identifier_chain nftHL_Chain
syn match nft_add_cmd_flowtable_flowtable_spec_identifier_chain "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_flowtable_flowtable_spec_identifier_flowtable

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_identifier_table "\v\w{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_flowtable_flowtable_spec_identifier_chain

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit
\ "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'flowtable' flowtable_spec table_spec
syn cluster nft_c_add_cmd_flowtable_flowtable_spec_table_spec
\ contains=
\    nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_flowtable_flowtable_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'flowtable' flowtable_spec
syn cluster nft_c_add_cmd_flowtable_flowtable_spec
\ contains=@nft_c_add_cmd_flowtable_flowtable_spec_table_spec

" base_cmd [ 'add' ] 'flowtable'
hi link   nft_base_cmd_add_flowtable nftHL_Command
syn match nft_base_cmd_add_flowtable "\v(add\s{1,15}flowtable|flowtable)" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_flowtable_flowtable_spec


" base_cmd [ 'add' ] 'flowtable' flowtable_spec
syn cluster nft_c_add_cmd_flowtable_flowtable_spec
\ contains=@nft_c_add_cmd_flowtable_flowtable_spec_table_spec

" base_cmd [ 'add' ] 'flowtable'
hi link   nft_base_cmd_add_flowtable nftHL_Command
syn match nft_base_cmd_add_flowtable "\v(add\s{1,15}flowtable|flowtable)" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_flowtable_flowtable_spec


syn cluster nft_c_add_cmd_rule_rule_alloc_again
\ contains=@nft_c_add_cmd_rule_rule_alloc_alloc

" base_cmd [ 'add' ] 'rule' rule_alloc comment_spec
hi link   nft_add_cmd_rule_comment_spec_string nftHL_Comment
syn match nft_add_cmd_rule_comment_spec_string "\v[A-Za-z0-9 ]{1,64}" skipwhite contained

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

" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec position_spec_num
hi link   nft_add_cmd_rule_rule_position_chain_spec_position_spec_num nftHL_Number
syn match nft_add_cmd_rule_rule_position_chain_spec_position_spec_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_rule_rule

" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec table_spec identifier
hi link   nft_add_cmd_rule_rule_position_chain_spec_table_spec_identifier nftHL_Table
syn match nft_add_cmd_rule_rule_position_chain_spec_table_spec_identifier "\v([A-Za-z0-9]{1,64}){2}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_rule_rule_position_chain_spec_identifier

hi link   nft_add_cmd_rule_rule_position_keywords_position_handle_index  nftHL_Command
syn match nft_add_cmd_rule_rule_position_keywords_position_handle_index
\ "\v\w\s\w\s\ze((position)|handle|index)?\s" skipwhite contained

hi link   nft_add_cmd_rule_rule_position_chain_spec_table_spec_family_spec_family_spec_explicit  nftHL_Family
syn match nft_add_cmd_rule_rule_position_chain_spec_table_spec_family_spec_family_spec_explicit
\ "\v(ip6?|arp|inet|bridge|netdev)?" skipwhite contained
\ nextgroup=nft_add_cmd_rule_rule_position_keywords_position_handle_index

" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position chain_spec position_spec
hi link   nft_add_cmd_rule_rule_position_chain_spec_position_spec nftHL_Identifier
syn match nft_add_cmd_rule_rule_position_chain_spec_position_spec skipwhite contained
\ "\v(ip6?|arp|inet|bridge|netdev)?(\s{1,16}[A-Za-z0-9\_\-]{1,64}){2}\s{1,16}(position|handle|index)"
\ nextgroup=nft_add_cmd_rule_rule_position_chain_spec_position_spec_num
\ contains=
\    nft_add_cmd_rule_rule_position_chain_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_rule_rule_position_keywords_position_handle_index,


" base_cmd add_cmd [[ 'add' ] 'rule' ] rule_position
syn cluster nft_c_add_cmd_rule_rule_position
\ contains=
\    nft_add_cmd_rule_rule_position_chain_spec_position_spec


" base_cmd add_cmd [[ 'add' ] 'rule' ]
syn cluster nft_c_add_cmd_rule
\ contains=@nft_c_add_cmd_rule_rule_position

" base_cmd [[ 'add' ] 'rule' ] keywords
hi link   nft_base_cmd_add_cmd_add_rule_keyword nftHL_Command
syn match nft_base_cmd_add_cmd_add_rule_keyword "\v(add\s{1,15}rule|rule)" skipwhite contained
\ nextgroup=@nft_c_add_cmd_rule

" base_cmd [[ 'add' ] 'rule' ]
syn cluster nft_c_base_cmd_add_rule
\ contains=
\    nft_base_cmd_add_cmd_add_rule_keyword,
\    @nft_c_add_cmd_rule

" base_cmd [ 'add' ]
syn cluster nft_c_base_cmd_add
\ contains=
\    nft_base_cmd_add_set,
\    nft_base_cmd_add_map,
\    nft_base_cmd_add_flowtable,
\    nft_base_cmd_add_table,
\    nft_base_cmd_add_chain,
\    nft_base_cmd_add_counter,
\    @nft_c_base_cmd_add_rule
"\    nft_base_cmd_add_element,
"\    nft_base_cmd_add_quota,
"\    nft_base_cmd_add_ct,
"\    nft_base_cmd_add_limit,
"\    nft_base_cmd_add_synproxy,
" '', 'rule', 'add rule' forces nft_base_cmd_add_rule to be the last 'contains=' entry!!!


""""" BEGIN OF add_cmd/'reset' """""
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '{' ... '}'
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set nftHL_Normal
syn region nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set start=/{/ end=/}/ skipwhite skipnl contained
\ nextgroup=
\    nft_EOL

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable "\$\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained

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
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id "\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set

" base_cmd 'reset' [ 'set' | 'map' ] table_id
hi link nft_base_cmd_reset_set_or_map_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id "\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
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
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id_set nftHL_Normal
syn region nft_base_cmd_reset_element_family_spec_table_id_spec_id_set start=/{/ end=/}/ skipwhite skipnl contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" base_cmd 'reset' 'element' table_id spec_id $variable
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable "\v\$[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id

" base_cmd 'reset' 'element' table_id spec_id
hi link nft_base_cmd_reset_element_family_spec_table_id_spec_id nftHL_Set
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id "\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_set

" base_cmd 'reset' 'element' table_id
hi link nft_base_cmd_reset_element_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_element_family_spec_table_id "\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
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

" base_cmd 'reset' 'rule' table_id chain_id
hi link   nft_base_cmd_reset_rule_ruleset_spec_id_chain nftHL_Family
syn match nft_base_cmd_reset_rule_ruleset_spec_id_chain "\v[a-zA-Z0-9\_]{1,64}" skipwhite contained

" base_cmd 'reset' 'rule' table_id
hi link   nft_base_cmd_reset_rule_ruleset_spec_id_table nftHL_Family
syn match nft_base_cmd_reset_rule_ruleset_spec_id_table "\v[a-zA-Z0-9\_]{1,64}" skipwhite contained
\ nextgroup=nft_base_cmd_reset_rule_ruleset_spec_id_chain

" base_cmd 'reset' 'counter'/'quota' family_spec
hi link   nft_base_cmd_reset_rule_ruleset_spec_family_spec nftHL_Family
syn match nft_base_cmd_reset_rule_ruleset_spec_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_base_cmd_reset_rule_ruleset_spec_id_table

" base_cmd 'reset' 'rule' ruleset_spec
syn cluster nft_c_base_cmd_reset_rule_ruleset_spec
\ contains=
\    nft_base_cmd_reset_rule_ruleset_spec_family_spec,
\    nft_base_cmd_reset_rule_ruleset_spec_id_table

" base_cmd 'reset' 'rule'
hi link nft_base_cmd_reset_rule nftHL_Action
syn match nft_base_cmd_reset_rule "rule" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_rule_ruleset_spec_family_spec,
\    nft_base_cmd_reset_rule_ruleset_spec_id_table


" base_cmd 'reset' 'rules' chain_id
hi link   nft_base_cmd_reset_rules_ruleset_spec_id_chain nftHL_Table
syn match nft_base_cmd_reset_rules_ruleset_spec_id_chain "\v[a-zA-Z0-9\_]{1,64}" skipwhite contained

" base_cmd 'reset' 'rules' table_id
hi link   nft_base_cmd_reset_rules_ruleset_spec_id_table nftHL_Table
syn match nft_base_cmd_reset_rules_ruleset_spec_id_table "\v[a-zA-Z0-9\_]{1,64}" skipwhite contained
\ nextgroup=nft_base_cmd_reset_rules_ruleset_spec_id_chain

" base_cmd 'reset' 'rules' family_spec_explicit
hi link   nft_base_cmd_reset_rules_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_base_cmd_reset_rules_ruleset_spec_family_spec_explicit "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_rules_ruleset_spec_id_table


" base_cmd 'reset' 'rules' ruleset_spec
syn cluster nft_c_base_cmd_reset_rules_ruleset_spec
\ contains=
\    nft_base_cmd_reset_rules_ruleset_spec_family_spec_explicit,
\    nft_base_cmd_reset_rules_ruleset_spec_id_table

" base_cmd 'reset' 'rules' 'chain'/'table' ruleset_spec
syn cluster @nft_c_base_cmd_reset_rules_ruleset_spec
\ contains=
\    nft_base_cmd_reset_rule_ruleset_spec_family_spec,
\    nft_base_cmd_reset_rule_ruleset_spec_id_table

" base_cmd 'reset' 'rules' 'chain'
hi link nft_base_cmd_reset_rules_chain_keyword nftHL_Action
syn match nft_base_cmd_reset_rules_chain_keyword "chain" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_reset_rule_ruleset_spec

" base_cmd 'reset' 'rules' 'table'
hi link nft_base_cmd_reset_rules_table_keyword nftHL_Action
syn match nft_base_cmd_reset_rules_table_keyword "table" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_reset_rule_ruleset_spec

" base_cmd 'reset' 'rules'
hi link nft_base_cmd_reset_rules nftHL_Action
syn match nft_base_cmd_reset_rules "rules" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_rules_table_keyword,
\    nft_base_cmd_reset_rules_chain_keyword,
\    @nft_c_base_cmd_reset_rules_ruleset_spec
"\    nft_base_cmd_reset_rules_family_spec_explicit,

" base_cmd 'reset' 'quota'
hi link nft_base_cmd_reset_quota nftHL_Action
syn match nft_base_cmd_reset_quota "quota" skipwhite contained

" base_cmd 'reset' 'counter' obj_spec
" base_cmd 'reset' 'counter'/'quota' table_id chain_id
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_chain nftHL_Chain
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_chain "\v[a-zA-Z0-9]{1,64}" skipwhite contained

" base_cmd 'reset' 'counter'/'quota' 'table' identifier
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_table nftHL_Table
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_table "\v[a-zA-Z0-9]{1,64}" skipwhite contained
\ nextgroup=nft_base_cmd_reset_counter_quota_obj_spec_id_chain

" base_cmd 'reset' 'counter'/'quota' family_spec
hi link   nft_base_cmd_reset_counter_quota_family_spec nftHL_Family
syn match nft_base_cmd_reset_counter_quota_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_base_cmd_reset_counter_quota_obj_spec_id_table

" base_cmd 'reset' 'quota'
hi link nft_base_cmd_reset_quota nftHL_Action
syn match nft_base_cmd_reset_quota "quota" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table

" base_cmd 'reset' 'counter'
hi link nft_base_cmd_reset_counter nftHL_Action
syn match nft_base_cmd_reset_counter "counter" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier identifier
hi link nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain "\v[a-zA-Z0-9]{1,64}" skipwhite contained

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier
hi link nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table "\v[a-zA-Z0-9]{1,64}" skipwhite contained
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

" base_cmd 'reset' 'counters'
hi link nft_base_cmd_reset_counters nftHL_Action
syn match nft_base_cmd_reset_counters "counters" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_base_cmd_reset_counters_quotas_table_keyword

" base_cmd 'reset'
hi link   nft_base_cmd_reset nftHL_Command
syn match nft_base_cmd_reset "reset" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters,
\    nft_base_cmd_reset_counter,
\    nft_base_cmd_reset_quotas,
\    nft_base_cmd_reset_quota,
\    nft_base_cmd_reset_rules,
\    nft_base_cmd_reset_rule,
\    nft_base_cmd_reset_element,
\    nft_base_cmd_reset_set_or_map,

" base_cmd [ 'set' ]
""""" END OF add_cmd/'reset' """""

"""""""""""""""""" rename_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd 'rename' 'chain' chain_spec identifier
" base_cmd 'rename' 'chain' [ family_spec ] table_id chain_id [ 'last' | <string> ]

hi link   nft_base_cmd_rename_chain_spec_table_spec_identifier nftHL_String
syn match nft_base_cmd_rename_chain_spec_table_spec_identifier "\v[a-zA-Z_\-]{1,63}" skipempty skipnl skipwhite contained
\ nextgroup=nft_EOL

hi link   nft_base_cmd_rename_chain_spec_table_spec_chain_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_chain_id "\v[a-zA-Z_\-]{1,63}" skipwhite contained
\ nextgroup=
\     nft_base_cmd_rename_chain_spec_table_spec_identifier

hi link   nft_base_cmd_rename_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_table_id "\v[a-zA-Z_\-]{1,63}" skipwhite contained
\ nextgroup=
\     nft_base_cmd_rename_chain_spec_table_spec_chain_id "\v[a-zA-Z_\-]{1,63}" skipwhite contained

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
hi link   nft_base_cmd_rename_chain_keyword nftHL_Action
syn match nft_base_cmd_rename_chain_keyword "chain" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_rename_chain_spec

" base_cmd 'rename'
hi link   nft_base_cmd_rename nftHL_Command
syn match nft_base_cmd_rename "rename" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_keyword
"""""""""""""""""" rename_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" get_cmd BEGIN """"""""""""""""""""""""""""""""""
hi link nft_get_cmd_set_block_separator nftHL_Normal
syn match nft_get_cmd_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,nft_comment_inline

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}"
" do not use 'skipwhite' here

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr "[A-Za-z0-9\-_./]\{1,64}" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_get_cmd_set_block_typeof_key_expr_type nftHL_Command
syn match nft_get_cmd_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z0-9]{1,64}(\.[a-zA-Z0-9]{1,64}){0,5}" contained  " do not use 'skipwhite' here
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
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'icmp6' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'igmp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'gre' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'comp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'dccp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'sctp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'redirect' '}'
hi link   nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords nftHL_Expression
syn match nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords
\ "\v(tcp|udplite|udp|esp|ah|icmp6|icmp|igmp|gre|comp|dccp|sctp|direct)" skipwhite contained

hi link nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block nftHL_Normal
syn region nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block start= /(/ end=/)/ skipwhite contained

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
\ contains=
\    nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords,
\    nft_primary_rhs_expr_block,
\    @nft_c_integer_expr,
\    @nft_c_boolean_expr,
\    @nft_c_keyword_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_bsaic_rhs_expr_lshift,
"\    nft_c_concat_rhs_expr_bsaic_rhs_expr_rshift


" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr
\ contains=
\          @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_bsaic_rhs_expr_ampersand

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_shift_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_bsaic_rhs_expr_caret

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_bsaic_rhs_expr_bar

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

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' multiton_rhs_expr prefix_rhs_expr basic_rhs_expr '}'
syn cluster nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' multiton_rhs_expr prefix_rhs_expr '}'
syn cluster nft_c_multiton_rhs_expr_prefix_rhs_expr
\ contains=
\    @nft_c_multiton_rhs_expr_prefix_rhs_expr_basic_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' multiton_rhs_expr range_rhs_expr '}'
syn cluster nft_c_multiton_rhs_expr_range_rhs_expr
\ contains=
\    @nft_c_nft_c_multiton_rhs_expr_XXX

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr multiton_rhs_expr '}'
syn cluster nft_c_multiton_rhs_expr
\ contains=
\    @nft_c_nft_c_multiton_rhs_expr_prefix_rhs_expr,
\    @nft_c_nft_c_multiton_rhs_expr_range_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_lhs_expr concat_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr
\ contains=
\    @nft_c_basic_rhs_expr,
\    @nft_c_multition_rhs_expr

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
hi link    nft_get_cmd_set_block_expr_set_expr nftHL_Normal
syn region nft_get_cmd_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_get_cmd_set_block_expr_set_expr_set_list_member_expr
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" base_cmd 'get' 'element' table_id spec_id '$'identifier
hi link   nft_get_cmd_set_block_expr_variable_expr nftHL_Variable
syn match nft_get_cmd_set_block_expr_variable_expr "\$\v[a-zA-Z0-9\-_]{1,64}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_Error

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id set_block_expr
syn cluster nft_c_base_cmd_get_cmd_set_block_expr
\ contains=
\    nft_get_cmd_set_block_expr_variable_expr,
\    nft_get_cmd_set_block_expr_set_expr

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_cmd_set_id nftHL_Set
syn match nft_get_cmd_set_id "\v[a-zA-Z_\-]{1,63}" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_get_cmd_set_block_expr

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_base_cmd_get_cmd_table_id nftHL_Table
syn match nft_base_cmd_get_cmd_table_id "\v[a-zA-Z_\-]{1,63}" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_id

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_base_cmd_get_cmd_family_spec_explicit nftHL_Family
syn match nft_base_cmd_get_cmd_family_spec_explicit "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_get_cmd_table_id

" base_cmd 'get' 'element' set_spec
syn cluster nft_c_base_cmd_get_cmd_set_spec
\ contains=
\    nft_base_cmd_get_cmd_family_spec_explicit,
\    nft_base_cmd_get_cmd_table_id

" base_cmd 'get' get_cmd
" base_cmd 'get' 'element'
hi link   nft_base_cmd_get nftHL_Command
syn match nft_base_cmd_get "\vget\s{1,16}element" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_get_cmd_set_spec
"""""""""""""""""" get_cmd END """"""""""""""""""""""""""""""""""


"""""""""""""""""" list_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd list_cmd 'table' table_spec family_spec identifier
hi link nft_list_table_spec_identifier nftHL_Identifier
syn match nft_list_table_spec_identifier "\v\w{1,64}" skipwhite contained

" base_cmd list_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_list_table_spec_family_spec_valid nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_list_table_spec_family_spec_valid "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_list_table_spec_identifier

" base_cmd [ 'list' ] [ 'table' ] table_spec
syn cluster nft_c_list_table_spec_end
\ contains=
\    nft_list_table_spec_family_spec_valid,
\    nft_list_table_spec_identifier

" base_cmd list_cmd 'table'
hi link   nft_base_cmd_list_table nftHL_Command
syn match nft_base_cmd_list_table "\vlist\s{1,15}table" skipwhite contained
\ nextgroup=@nft_c_list_table_spec_end

" base_cmd list_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link nft_list_chain_table_spec_identifier nftHL_Identifier
syn match nft_list_chain_spec_identifier "\v\w{1,64}" skipwhite contained

" base_cmd list_cmd 'chain' [ family_spec ] table_spec
hi link nft_list_chain_table_spec_identifier nftHL_Identifier
syn match nft_list_chain_table_spec_identifier "\v\w{1,64}" skipwhite contained
\ nextgroup=nft_list_chain_spec_identifier

" list_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_list_chain_spec_family_spec_explicit nftHL_Family
syn match nft_list_chain_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_list_chain_table_spec_identifier

" base_cmd list_cmd 'chain' chain_spec
syn cluster nft_c_list_cmd_chain_spec_end
\ contains=
\    nft_list_chain_table_spec_identifier,
\    nft_list_chain_spec_family_spec_explicit

" base_cmd list_cmd 'chain'
" base_cmd [ 'list' ] [ 'chain' ] chain_spec
hi link   nft_base_cmd_list_chain nftHL_Command
syn match nft_base_cmd_list_chain "\vlist\s{1,15}chain" skipwhite contained
\ nextgroup=@nft_c_list_cmd_chain_spec_end

" base_cmd list_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_list_set_chain_spec_identifier nftHL_Identifier
syn match nft_list_set_chain_spec_identifier "\v\w{1,64}" skipwhite contained

" list_cmd 'set' set_spec family_spec family_spec_explicit
hi link   nft_list_set_table_spec_identifier nftHL_Identifier
syn match nft_list_set_table_spec_identifier "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=nft_list_set_chain_spec_identifier

hi link   nft_list_set_spec_family_spec_explicit nftHL_Family
syn match nft_list_set_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_list_set_table_spec_identifier

" base_cmd list_cmd 'set' set_spec
syn cluster nft_c_list_cmd_set_spec_end
\ contains=
\    nft_list_set_table_spec_identifier,
\    nft_list_set_spec_family_spec_explicit

" base_cmd [ 'list' ] [ 'set' ] set_spec
" base_cmd [ 'list' ] [ 'meter' ] set_spec
hi link   nft_base_cmd_list_set_map_meter_end nftHL_Command
syn match nft_base_cmd_list_set_map_meter_end "\vlist\s{1,15}(set|map|meter)" skipwhite contained
\ nextgroup=@nft_c_list_cmd_set_spec_end

" base_cmd [ 'list' ] [ 'flowtables' ] set_spec

" base_cmd list_cmd 'flowtables' [ family_spec ] table_spec chain_spec
" base_cmd list_cmd 'flow' 'tables' [ family_spec ] table_spec chain_spec
hi link   nft_list_flowtables_ruleset_chain_spec_identifier nftHL_Identifier
syn match nft_list_flowtables_ruleset_chain_spec_identifier "\v\w{1,64}" skipwhite contained

" list_cmd 'flowtables' ruleset_spefc family_spec family_spec_explicit
hi link   nft_list_flowtables_ruleset_table_spec_identifier nftHL_Identifier
syn match nft_list_flowtables_ruleset_table_spec_identifier "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=nft_list_flowtables_ruleset_chain_spec_identifier

hi link   nft_list_flowtables_spec_family_spec_explicit nftHL_Family
syn match nft_list_flowtables_spec_family_spec_explicit "\v(ip(6)?|inet)" skipwhite contained
\ nextgroup=nft_list_flowtables_ruleset_table_spec_identifier

" base_cmd list_cmd 'flowtable' set_spec
syn cluster nft_c_list_cmd_flowtables_ruleset_spec_end
\ contains=
\    nft_list_flowtables_ruleset_table_spec_identifier,
\    nft_list_flowtables_spec_family_spec_explicit

" base_cmd [ 'list' ] [ 'flow' ] [ 'tables' ] set_spec
hi link   nft_base_cmd_list_flow_table_end nftHL_Command
syn match nft_base_cmd_list_flow_table_end "\vlist\s{1,15}(flow table[s]?|flowtable[s]?)" skipwhite contained
\ nextgroup=@nft_c_list_cmd_flowtables_ruleset_spec_end

" base_cmd 'list' 'ruleset' ruleset_spec
hi link   nft_list_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_list_ruleset_spec_family_spec_explicit "\v(ip(6)?|inet)" skipwhite contained
\ nextgroup=nft_list_set_table_spec_identifier

" base_cmd 'list' 'ruleset' set_spec
hi link   nft_base_cmd_list_ruleset_end nftHL_Command
syn match nft_base_cmd_list_ruleset_end "\vlist\s{1,15}ruleset" skipwhite contained
\ nextgroup=nft_list_ruleset_spec_family_spec_explicit


" base_cmd [ 'list' ]
syn cluster nft_c_base_cmd_list
\ contains=
\    nft_base_cmd_list_table,
\    nft_base_cmd_list_chain,
\    nft_base_cmd_list_set_map_meter_end,
\    nft_base_cmd_list_flow_table_end,
\    nft_base_cmd_list_ruleset_end
"""""""""""""""""" list_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" flush_cmd BEGIN """"""""""""""""""""""""""""""""""

" base_cmd flush_cmd 'table' table_spec family_spec identifier
hi link nft_flush_table_spec_identifier nftHL_Identifier
syn match nft_flush_table_spec_identifier "\v\w{1,64}" skipwhite contained

" base_cmd flush_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_flush_table_spec_family_spec_valid nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_flush_table_spec_family_spec_valid "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_flush_table_spec_identifier

" base_cmd [ 'flush' ] [ 'table' ] table_spec
syn cluster nft_c_flush_table_spec_end
\ contains=
\    nft_flush_table_spec_family_spec_valid,
\    nft_flush_table_spec_identifier

" base_cmd flush_cmd 'table'
hi link   nft_base_cmd_flush_table nftHL_Command
syn match nft_base_cmd_flush_table "\vflush\s{1,15}table" skipwhite contained
\ nextgroup=@nft_c_flush_table_spec_end

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link nft_flush_chain_table_spec_identifier nftHL_Identifier
syn match nft_flush_chain_spec_identifier "\v\w{1,64}" skipwhite contained

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec
hi link nft_flush_chain_table_spec_identifier nftHL_Identifier
syn match nft_flush_chain_table_spec_identifier "\v\w{1,64}" skipwhite contained
\ nextgroup=nft_flush_chain_spec_identifier

" flush_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_flush_chain_spec_family_spec_explicit nftHL_Family
syn match nft_flush_chain_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_flush_chain_table_spec_identifier

" base_cmd flush_cmd 'chain' chain_spec
syn cluster nft_c_flush_cmd_chain_spec_end
\ contains=
\    nft_flush_chain_table_spec_identifier,
\    nft_flush_chain_spec_family_spec_explicit

" base_cmd flush_cmd 'chain'
" base_cmd [ 'flush' ] [ 'chain' ] chain_spec
hi link   nft_base_cmd_flush_chain nftHL_Command
syn match nft_base_cmd_flush_chain "\vflush\s{1,15}chain" skipwhite contained
\ nextgroup=@nft_c_flush_cmd_chain_spec_end

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_flush_set_chain_spec_identifier nftHL_Identifier
syn match nft_flush_set_chain_spec_identifier "\v\w{1,64}" skipwhite contained

" flush_cmd 'set' set_spec family_spec family_spec_explicit
hi link   nft_flush_set_table_spec_identifier nftHL_Identifier
syn match nft_flush_set_table_spec_identifier "\v[a-zA-Z0-9\-\_]{1,64}" skipwhite contained
\ nextgroup=nft_flush_set_chain_spec_identifier

hi link   nft_flush_set_spec_family_spec_explicit nftHL_Family
syn match nft_flush_set_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_flush_set_table_spec_identifier

" base_cmd flush_cmd 'set' set_spec
syn cluster nft_c_flush_cmd_set_spec_end
\ contains=
\    nft_flush_set_table_spec_identifier,
\    nft_flush_set_spec_family_spec_explicit

" base_cmd [ 'flush' ] [ 'set' ] set_spec
" base_cmd [ 'flush' ] [ 'flow' ] [ 'table' ] set_spec
" base_cmd [ 'flush' ] [ 'meter' ] set_spec
hi link   nft_base_cmd_flush_set_map_meter_end nftHL_Command
syn match nft_base_cmd_flush_set_map_meter_end "\vflush\s{1,15}(set|map|meter|flow table)" skipwhite contained
\ nextgroup=@nft_c_flush_cmd_set_spec_end

" base_cmd 'flush' 'ruleset' ruleset_spec
hi link   nft_flush_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_flush_ruleset_spec_family_spec_explicit "\v(ip(6)?|inet)" skipwhite contained
\ nextgroup=nft_flush_set_table_spec_identifier

" base_cmd 'flush' 'ruleset' set_spec
hi link   nft_base_cmd_flush_ruleset_end nftHL_Command
syn match nft_base_cmd_flush_ruleset_end "\vflush\s{1,15}ruleset" skipwhite contained
\ nextgroup=nft_flush_ruleset_spec_family_spec_explicit


" base_cmd [ 'flush' ]
syn cluster nft_c_base_cmd_flush
\ contains=
\    nft_base_cmd_flush_table,
\    nft_base_cmd_flush_chain,
\    nft_base_cmd_flush_set_map_meter_end,
\    nft_base_cmd_flush_ruleset_end
"""""""""""""""""" flush_cmd END """"""""""""""""""""""""""""""""""

""""""""""""""""" BASE CMD """""""""""""""""""""""""""""""""""""
" base_cmd
syn cluster nft_c_base_cmd
\ contains=
\    nft_base_cmd_replace,
\    nft_base_cmd_create,
\    nft_base_cmd_get,
\    @nft_c_base_cmd_list,
\    nft_base_cmd_reset,
\    @nft_c_base_cmd_flush,
\    nft_base_cmd_rename,
\    nft_base_cmd_import,
\    nft_base_cmd_export,
\    nft_base_cmd_monitor,
\    nft_base_cmd_describe,
\    @nft_c_base_cmd_add
"\    nft_base_cmd_insert,
"\    nft_base_cmd_delete,
"\    nft_base_cmd_destroy,

hi link nft_comment_whole_line nftHL_Comment
syn match nft_comment_whole_line "^\s*#.*$" keepend contained

"""""""""""""""" TOP-LEVEL SYNTAXES """"""""""""""""""""""""""""
" `line` main top-level syntax, do not add 'contained' here.
syn match nft_line '^\v\s{0,16}'
\ nextgroup=
\    nft_comment_whole_line,
\    @nft_c_base_cmd,
\    @nft_c_common_block,

" opt_newline (via flowtable_expr, set_expr, set_list_member_expr, verdict_map_expr,
"                  verdict_map_list_member_exp)
syn match nft_opt_newline "\v[\n]*" skipwhite contained

" common_block (via chain_block, counter_block, ct_expect_block, ct_helper_block,
"                   ct_timeout_block, flowtable_block, limit_block, line, map_block,
"                   quota_block, secmark_block, set_block, synproxy_block, table_block
syn cluster nft_c_common_block
\ contains=
\    nft_include,
\    nft_common_block_define,
\    nft_common_block_redefine,
\    nft_common_block_undefine,
\    nft_stmt_separator,
\    nft_hash_comment,
\    nft_EOL
"\    nft_InlineComment,

syn cluster nft_c_stmt
\ contains=
\    nft_ct_stmt
""\    @nft_c_payload_stmt

"""""""""""""""""""""" END OF SYNTAX """"""""""""""""""""""""""""


let b:current_syntax = 'nftables'

let &cpoptions = s:save_cpo
unlet s:save_cpo

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

