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

" TIPS:
" - always add '\v' to any OR-combo list like '\v(opt1|opt2|opt3)' in `syntax match`
" - always add '\v' to any OR-combo list like '\v[a-zA-Z0-9_]' in `syntax match`
" - place any 'contained' keyword at end of line (EOL)
" - never use '?' in `match` statements
" - 'contains=' ordering MATTERS in `cluster` statements

" quit if terminal is a black and white
if &t_Co == 0
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

let s:deviceNameRegex = '[A-Za-z0-9\-_./]\{1,256}'
let s:tableNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'
let s:chainNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'

hi link nftHL_Comment     Comment
hi link nftHL_Include     Preproc
hi link nftHL_ToDo        Todo
hi link nftHL_Identifier  Identifier
hi link nftHL_Variable    Variable  " doesn't work, stuck on dark cyan
hi link nftHL_Number      Number
hi link nftHL_String      String
hi link nftHL_Option      Label     " could use a 2nd color here
hi link nftHL_Operator    Operator    " was Operator  
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

hi link nftHL_Verdict     Underlined
hi link nftHL_Hook        Type    
hi link nftHL_Action      Special

hi link nft_ToDo nftHL_ToDo
syn keyword nft_ToDo xxx contained XXX FIXME TODO TODO: FIXME: TBS TBD TBA skipwhite
"\ containedby=nft_InlineComment

hi link nft_InlineComment nftHL_Comment
syn match nft_InlineComment "\# " skipwhite contained

"hi link nft_EOS nftHL_Error
"syn match nft_EOS /\v[^ \t]*[^\n;# ]/ contained

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
syn match nft_stmt_separator "\v(\n|;)"


syn match nft_Set contained /{.*}/ contains=nft_SetEntry
syn match nft_SetEntry contained /[a-zA-Z0-9]\+/ contained
hi def link nft_Set nftHL_Keyword
hi def link nft_SetEntry nftHL_Operator

" syn match nft_Number "\<[0-9A-Fa-f./:]\+\>" contains=nft_Mask,nft_Delimiter
syn match nft_Hex "\<0x[0-9A-Fa-f]\+\>" contained
syn match nft_Delimiter "[./:]" contained
syn match nft_Mask "/[0-9.]\+" contained contains=nft_Delimiter
" hi def link nft_Number nftHL_Number
hi def link nft_Hex nftHL_Number
hi def link nft_Delimiter nftHL_Operator
hi def link nft_Mask nftHL_Operator

" We'll do error RED highlighting on all statement firstly, then later on
" all the options, then all the clauses.
" Uncomment following two lines for RED highlight of typos (still Beta here)
hi link nft_Error nftHL_Error
syn match nft_Error /[ \ta-zA-Z0-9_./]\{1,64}/   " uncontained, on purpose

"hi link nft_UnexpectedEOS nftHL_Error
"syn match nft_UnexpectedEOS contained skipwhite /[;\n]\+/

" expected end-of-line (iterator capped for speed)
syn match nft_EOL /[\n\r]\{1,16}/ skipwhite contained

" hi link nft_Semicolon nftHL_Normal
" syn match nft_Semicolon contained /[;]\{1,15}/  skipwhite
" \ nextgroup=nft_EOL

hi link nft_identifier nftHL_Identifier
syn match nft_identifier "\v[a-zA-Z0-9\_\-]" skipwhite  contained

" variable_expr (via chain_expr, dev_spec, extended_prio_spec, flowtable_expr,
"                    flowtable_expr_member, policy_expr, queue_expr,
"                    queue_stmt_expr_simple, set_block_expr, set_ref_expr
"                    symbol_expr
syn match nft_variable_expr "\$" skipwhite contained
\ nextgroup=nft_identifier

hi link nft_string_unquoted nftHL_String
syn match nft_string_unquoted "\v[a-zA-Z0-9\/\\\[\]]+" keepend contained

hi link nft_string_sans_double_quote nftHL_String
syn match nft_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]+" keepend contained

hi link nft_string_sans_single_quote nftHL_String
syn match nft_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']+" keepend contained

hi link nft_quoted_string_single nftHL_String
syn region nft_quoted_string_single start="'" end="'" keepend contained
\ contains=nft_string_sans_double_quote

hi link nft_quoted_string_double nftHL_String
syn region nft_quoted_string_double start="\"" end="\"" keepend contained
\ contains=nft_string_sans_single_quote

syn cluster nft_c_quoted_string
\ contains=
\    nft_quoted_string_single,
\    nft_quoted_string_double

hi link nft_asterisk_string nftHL_String
syn region nft_asterisk_string start="\*" end="\*" keepend contained
\ contains=nft_string_unquoted

hi link nft_string nftHL_String
syn cluster nft_string
\ contains=
\    nft_string_unquoted,
\    @nft_c_quoted_string,
\    nft_asterisk_string

" nft_identifier_last (via identifer)
hi link  nft_identifier_last nftHL_Identifier
syn match nft_identifier_last "\vlast" skipwhite contained

" identifier
syn cluster nft_identifier
\ contains=
\    nft_string,
\    nft_identifier_last

"hi link nft_common_block_define_redefine_identifier nftHL_String
"syn match nft_common_block_define_redefine_identifier "\v[a-zA-Z0-9\_]+" skipwhite contained

" common_block 'define'/'redefine' value (via nft_common_block_define_redefine_equal)
hi link nft_common_block_define_redefine_value nftHL_String
syn match nft_common_block_define_redefine_value "\v[\'\"\$\{\}:a-zA-Z0-9\_\/\\\. \,]+" skipwhite contained

" common_block 'define'/'redefine' '=' (via nft_common_block_define_redefine_define_identifier_set)
hi link nft_common_block_define_redefine_equal nftHL_Operator
syn match nft_common_block_define_redefine_equal "=" skipwhite contained
\ nextgroup=nft_common_block_define_redefine_value

" common_block 'define'/'redefine' identifier (via common_block 'redefine'/'define')
hi link nft_common_block_define_redefine_identifier nftHL_Identifier
syn match   nft_common_block_define_redefine_identifier "\v[a-zA-Z0-9\_]+" skipwhite contained
\ nextgroup=nft_common_block_define_redefine_equal

" 'define' (via "
" common_block 'define' (via common_block)
hi link nft_common_block_define nftHL_Command
syn match nft_common_block_define contained "^\s*define" skipwhite contained
\ nextgroup=nft_common_block_define_redefine_identifier

" commmon_block 'redefine' (via common_block)
hi link nft_common_block_redefine nftHL_Command
syn match nft_common_block_redefine contained "^\s*redefine" skipwhite contained
\ nextgroup=nft_common_block_define_redefine_identifier

" common_block 'undefine' identifier (via common_block 'undefine')
hi link nft_common_block_undefine_identifier nftHL_Identifier
syn match nft_common_block_undefine_identifier "\v[a-zA-Z0-9\_]+" skipwhite contained

" commmon_block 'undefine' (via common_block)
hi link nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine contained "^\s*undefine" skipwhite contained
\ nextgroup=nft_common_block_undefine_identifier

hi link nft_filespec_sans_double_quote nftHL_Normal
syn match nft_filespec_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]+" keepend contained

hi link nft_filespec_sans_single_quote nftHL_Normal
syn match nft_filespec_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']+" keepend contained

hi link nft_filespec_quoted_single nftHL_Include
syn region nft_filespec_quoted_single start="'" end="'" keepend contained
\ contains=nft_filespec_sans_double_quote

hi link nft_filespec_quoted_double nftHL_Include
syn region nft_filespec_quoted_double start="\"" end="\"" keepend contained
\ contains=nft_filespec_sans_single_quote

hi link nft_c_filespec_quoted nftHL_Identifier
syn cluster nft_c_filespec_quoted
\ contains=
\    nft_filespec_quoted_single,
\    nft_filespec_quoted_double

hi link nft_include nftHL_Include
syn match nft_include "\v^\s*include" skipwhite keepend contained
\ nextgroup=@nft_c_filespec_quoted

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
"\    nft_inner_inet_expr

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
syn match nft_vxlan_hdr_field "\v(vni||type)" skipwhite contained

" vxlan_hdr_expr 'vxlan' (via payload_expr)
hi link nft_vxlan_hdr_expr nftHL_Action
syn match nft_vxlan_hdr_expr "\vvxlan" skipwhite contained
\ nextgroup=
\    nft_vxlan_hdr_field,
\    nft_c_inner_expr

" ETHER ETHER ETHER ETHER
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
\ nextgroup=nft_c_arp_hdr_field

" vlan_hdr_field 'type' (via vlan_hdr_field)
hi link nft_vlan_hdr_field_type nftHL_Action
syn match nft_vlan_hdr_field_type "\vtype" skipwhite contained

" vlan_hdr_field keywords (via vlan_hdr_field)
hi link nft_vlan_hdr_field_keywords nftHL_Action
syn match nft_vlan_hdr_field_keywords "\v(id|cfi|dei|pcp|type)" skipwhite contained

" vlan_hdr_field (via vlan_hdr_expr)
syn cluster nft_vlan_hdr_field
\ contains=
\    nft_vlan_hdr_field_keywords,
\    nft_vlan_hdr_field_type

" vlan_hdr_expr (via inner_eth_expr, payload_expr)
hi link nft_vlan_hdr_expr nftHL_Action
syn match nft_vlan_hdr_expr "\vvlan" skipwhite contained
\ nextgroup=nft_vlan_hdr_field

" eth_hdr_field 'saddr'/'daddr' (via eth_hdr_field)
hi link  nft_c_eth_hdr_field_addrs nftHL_Action
syn match nft_c_eth_hdr_field_addrs "\v(saddr|daddr)" skipwhite contained

" eth_hdr_field 'type' (via eth_hdr_field)
hi link  nft_c_eth_hdr_field_type nftHL_Action
syn match nft_c_eth_hdr_field_type "\v(type)" skipwhite contained

" eth_hdr_field (via eth_hdr_expr)
hi link  nft_c_eth_hdr_field nftHL_Action
syn cluster nft_c_eth_hdr_field
\  contains=
\    nft_eth_hdr_field_addrs,
\    nft_eth_hdr_field_type

" eth_hdr_expr (via inner_eth_expr, payload_expr)
hi link nft_c_eth_hdr_expr nftHL_Action
syn match nft_c_eth_hdr_expr "\vether" skipwhite contained
\  contains=nft_eth_hdr_field

" inner_eth_expr (via inner_expr)
syn cluster nft_c_inner_eth_expr
\ contains=
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_eth_hdr_expr

" INET INET INET INET

" tcp_hdr_expr 'option' (via inner_inet_expr, payload_expr)
hi link nft_tcp_hdr_expr_option nftHL_Action
syn match nft_tcp_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_type,
\    nft_tcp_hdr_option_type_sack,  " tcp_hdr_option 'sack'
\    @nft_c_tcp_hdr_option_kind_and_field,
"\    nft_tcp_hdr_option_at

" tcp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_tcp_hdr_expr nftHL_Statement
syn match nft_tcp_hdr_expr "\vtcp" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords,
\    @nft_tcp_hdr_expr_option

" udplite_hdr_field (via udplite_hdr_expr)
hi link nft_udplite_hdr_field nftHL_Statement
syn match nft_udplite_hdr_field "\v(sport|dport|csumcov|checksum)" skipwhite contained

" udplite_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_udplite_hdr_expr nftHL_Statement
syn match nft_udplite_hdr_expr "\vudplite" skipwhite contained
\ nextgroup=
\    nft_udplite_hdr_field

" udp_hdr_field (via udp_hdr_expr)
hi link nft_udp_hdr_field nftHL_Statement
syn match nft_udp_hdr_field "\v(sport|dport|length|checksum)" skipwhite contained

" udp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_udp_hdr_expr nftHL_Statement
syn match nft_udp_hdr_expr "\vudp" skipwhite contained
\ nextgroup=
\    nft_udp_hdr_field

" comp_hdr_field (via comp_hdr_expr)
hi link nft_comp_hdr_field nftHL_Statement
syn match nft_comp_hdr_field "\v(nexthdr|flags|cpi)" skipwhite contained

" comp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_comp_hdr_expr nftHL_Statement
syn match nft_comp_hdr_expr "\vcomp" skipwhite contained
\ nextgroup=
\    nft_comp_hdr_field

" esp_hdr_field (via esp_hdr_expr)
hi link nft_esp_hdr_field nftHL_Statement
syn match nft_esp_hdr_field "\v(spi|sequence)" skipwhite contained

" esp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_esp_hdr_expr nftHL_Statement
syn match nft_esp_hdr_expr "\vesp" skipwhite contained
\ nextgroup=
\    nft_esp_hdr_field

" auth_hdr_field (via auth_hdr_expr)
hi link nft_auth_hdr_field nftHL_Statement
syn match nft_auth_hdr_field "\v(nexthdr|hdrlength|reserved|spi|sequence)" skipwhite contained

" auth_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_auth_hdr_expr nftHL_Statement
syn match nft_auth_hdr_expr "\vauth" skipwhite contained
\ nextgroup=
\    nft_auth_hdr_field

" icmp6_hdr_field (via icmp6_hdr_expr)
hi link nft_icmp6_hdr_field nftHL_Statement
syn match nft_icmp6_hdr_field "\v(type|code|checksum|param\-problem|mtu|id|sequence|max\-delay|taddr|daddr)" skipwhite contained

" icmp6_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_icmp6_hdr_expr nftHL_Statement
syn match nft_icmp6_hdr_expr "\vicmp6" skipwhite contained
\ nextgroup=
\    nft_icmp6_hdr_field

" ip6_hdr_field (via ip6_hdr_expr)
hi link nft_ip6_hdr_field nftHL_Statement
syn match nft_ip6_hdr_field "\v(hdrversion|dscp|ecn|flowlabel|length|nexthdr|hoplimit|saddr|daddr)" skipwhite contained

" ip6_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_ip6_hdr_expr nftHL_Statement
syn match nft_ip6_hdr_expr "\vip6" skipwhite contained
\ nextgroup=
\    nft_ip6_hdr_field

" igmp_hdr_field (via igmp_hdr_expr)
hi link nft_igmp_hdr_field nftHL_Statement
syn match nft_igmp_hdr_field "\v(type|checksum|mrt|group)" skipwhite contained

" igmp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_igmp_hdr_expr nftHL_Statement
syn match nft_igmp_hdr_expr "\vigmp" skipwhite contained
\ nextgroup=
\    nft_igmp_hdr_field

" icmp_hdr_field (via icmp_hdr_expr)
hi link nft_icmp_hdr_field nftHL_Statement
syn match nft_icmp_hdr_field "\v(type|code|checksum|id|sequence|gateway|mtu)" skipwhite contained

" icmp_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_icmp_hdr_expr nftHL_Statement
syn match nft_icmp_hdr_expr "\vicmp" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_field

" ip_hdr_field (via ip_hdr_expr)
hi link nft_ip_hdr_field nftHL_Statement
syn match nft_ip_hdr_field "\v(hdrversion|hdrlength|dscp|ecn|length|id|fra_off|ttl|protocol|checksum|saddr|daddr)" skipwhite contained

" ip_option_field (via ip_hdr_expr_option)
hi link nft_ip_option_field nftHL_Statement
syn match nft_ip_option_field "\v(type|length|value|ptr|addr)" skipwhite contained

" ip_option_type (via ip_hdr_expr_option)
hi link nft_ip_option_type nftHL_Statement
syn match nft_ip_option_type "\v(lsrr|rr|ssrr|ra)" skipwhite contained
\ nextgroup=nft_ip_option_field

" ip_hdr_expr_option (via ip_hdr_expr)
hi link nft_ip_hdr_expr_option nftHL_Statement
syn match nft_ip_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=nft_ip_option_type

" ip_hdr_expr (via inner_inet_expr, payload_expr)
hi link nft_ip_hdr_expr nftHL_Statement
syn match nft_ip_hdr_expr "\vip" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field,
\    nft_ip_hdr_expr_option

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
hi link nft_payload_base_spec nftHL_Action
syn match nft_payload_base_spec "\vll|nh|th|string" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1
hi link nft_payload_base_spec_via_payload_expr_set nftHL_Action
syn match nft_payload_base_spec_via_payload_expr_set "\vll|nh|th|string" skipwhite contained
\ nextgroup=nft_payload_raw_expr_comma1_via_payload_expr_set

" payload_raw_expr (via payload_expr)
hi link nft_payload_raw_expr nftHL_Action
syn match nft_payload_raw_expr "\vat" skipwhite contained
\ nextgroup=nft_payload_base_spec
hi link  nft_payload_raw_expr_via_payload_expr_set nftHL_Action
syn match  nft_payload_raw_expr_via_payload_expr_set "\vat" skipwhite contained
\ nextgroup=nft_payload_base_spec_via_payload_expr_set

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

" inner_expr (via geneve_hdr_expr, gretap_hdr_expr, vxlan_hdr_expr)
syn cluster nft_c_inner_expr
\ contains=
\    @nft_c_inner_eth_expr,
\    @nft_c_inner_inet_expr


" NEED TO DUPLICATE in payload_stmt but without nextgroup='set'
" Add 'nextgroup=nft_payload_stmt_set' toward each here
" payload_expr (via payload_stmt, *primary_expr*, primary_stmt_expr)
syn cluster nft_c_payload_expr_via_primary_expr
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

" stmt_expr/symbol_stmt_expr
syn cluster nft_symbol_stmt_expr
\ contains=nft_symbol_stmt_expr_nested_comma


" keyword_expr (via primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn match nft_c_keyword_expr "\v(ether|ip6|ip |vlan|arp|dnat|snat|ecn|reset|destroy|original|reply|label|last)" skipwhite contained

" symbol_expr (via primary_expr, primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn cluster nft_c_symbol_expr
\ contains=
\    nft_variable_expr,
\    nft_string

" symbol_stmt_expr (via stmt_expr)
syn cluster nft_c_symbol_stmt_expr
\ contains=
\    nft_symbol_expr,
\    nft_keyword_expr

" stmt_expr (via ct_stmt, dup_stmt, fwd_stmt, masq_stmt_args, meta_stmt, nat_stmt,
"                objref_stmt_counter, objref_stmt_ct, objref_stmt_limit, objref_stmt_quota,
"                objref_stmt_synproxy, payload_stmt, redir_stmt_arg, tproxy_stmt)
syn cluster nft_c_stmt_expr
\ contains=
\    symbol_stmt_expr
"\    map_stmt_expr,
"\    multiton_stmt_expr,

" symbol_stmt_expr ',' (via stmt_expr)
hi link nft_symbol_stmt_expr_recursive nftHL_Operator
syn match nft_symbol_stmt_expr_recursive "," skipwhite contained
\ contains=
\    nft_symbol_stmt_expr,
\    nft_symbol_stmt_expr_nested_comma
\ nextgroup=
\    nft_symbol_stmt_expr_nested_comma,
\    nft_symbol_stmt_expr_recursive

syn cluster nft_c_stmt_expr
\ contains=nft_symbol_stmt_expr

" primary_expr (via primary_stmt, primary_expr, primary_stmt_expr)
syn cluster nft_c_primary_expr
\ contains=
\    nft_integer_expr,
\    @nft_c_payload_expr,
\    @nft_c_exthdr_expr,
\    nft_exthdr_exists_expr,
\    nft_meta_expr,
"\    nft_symbol_expr,
"\    nft_socket_expr,
"\    nft_rt_expr,
"\    nft_ct_expr,
"\    nft_numgen_expr,
"\    nft_hash_expr,
"\    nft_fib_expr,
"\    nft_osf_expr,
"\    nft_xfrm_expr,
"\    nft_basic_expr

" payload_stmt <payload_expr> 'set' (via payload_stmt <payload_expr>)
hi link nft_payload_stmt_before_set nftHL_Statement
syn match nft_payload_stmt_before_set "\vset" skipwhite contained
\ nextgroup=nft_stmt_expr

" payload_stmt <payload_expr> (via payload_stmt)
syn cluster nft_c_payload_expr_via_payload_stmt
\ contains=
\    nft_payload_raw_expr_via_payload_expr_set,
\    nft_eth_hdr_expr_via_payload_expr_set,
\    nft_vlan_hdr_expr_via_payload_expr_set,
\    nft_arp_hdr_expr_via_payload_expr_set,
\    nft_ip_hdr_expr_via_payload_expr_set,
\    nft_icmp_hdr_expr_via_payload_expr_set,
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

hi link nft_payload_stmt nftHL_Statement
syn cluster nft_c_payload_stmt
\ contains=@nft_c_payload_expr_via_payload_stmt

" base_cmd 'describe' (via line)
hi link nft_base_cmd_describe nftHL_Command
syn match nft_base_cmd_describe "\vdescribe" skipwhite contained
\ nextgroup=
\    @nft_c_primary_expr,



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
\    nft_identifier,
\    nft_monitor_object,
\    nft_markup_format
\ nextgroup=
\    nft_monitor_object,
\    nft_markup_format

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


hi link nft_add_table_block nftHL_Special
syn region nft_add_table_block start="{" end="}" keepend skipwhite contained

" add_table <family_spec> identifier
hi link nft_add_table_identifier nftHL_Identifier
syn match nft_add_table_identifier "\v\w{1,32}" skipwhite contained
\ nextgroup=nft_add_table_block
" syn match nft_add_table_identifier "?!(ip)6)?|inet|arp|bridge|netdev)" skipwhite contained


" base_cmd 'add table'/'table' (via base_cmd)
hi link   nft_add_table_spec nftHL_Command  " _add_ to make 'table_spec' pathway unique
syn match nft_add_table_spec "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=nft_add_table_identifier

" base_cmd 'add table'/'table' (via base_cmd)
hi link   nft_base_cmd_add nftHL_Command
syn match nft_base_cmd_add "\v(add\s{1,15}table|table)" skipwhite contained
\ nextgroup=
\    nft_add_table_spec,
\    nft_add_table_identifier

""""""""""""""""" BASE CMD """""""""""""""""""""""""""""""""""""
" base_cmd 
syn cluster nft_c_base_cmd
\ contains=
\    nft_base_cmd_describe,
\    nft_base_cmd_monitor,
\    nft_base_cmd_import,
\    nft_base_cmd_export,
\    nft_base_cmd_add,
"\    nft_base_cmd_replace,
"\    nft_base_cmd_create,
"\    nft_base_cmd_insert,
"\    nft_base_cmd_delete,
"\    nft_base_cmd_get,
"\    nft_base_cmd_list,
"\    nft_base_cmd_reset,
"\    nft_base_cmd_flush,
"\    nft_base_cmd_rename,
"\    nft_base_cmd_destroy,

hi link nft_comment_whole_line nftHL_Comment
syn match nft_comment_whole_line "^\s*#.*$" keepend contained

"""""""""""""""" TOP-LEVEL SYNTAXES """"""""""""""""""""""""""""
" `line` main top-level syntax, do not add 'contained' here.
syn match nft_line '^\v'
\ nextgroup=
\    @nft_c_common_block,
\    nft_stmt_separator,
\    @nft_c_base_cmd,
\    nft_comment_whole_line,

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
\    nft_EOL
"\    nft_InlineComment,

"""""""""""""""""""""" END OF SYNTAX """"""""""""""""""""""""""""


let b:current_syntax = 'nftables'

let &cpoptions = s:save_cpo
unlet s:save_cpo

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

