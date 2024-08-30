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

set cpo&vim  " Line continuation '\' at EOL is used here

" syn sync match nftablesSync grouphere NONE \"^(table|chain|set)\"
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

hi link nft_InlineComment nftHL_Comment
syn region nft_InlineComment start=/#/ end=/$/ contains=nft_ToDo skipwhite contained

hi link nft_EOS nftHL_Error
syn match nft_EOS /[^ \t]*[^\n;# ]/ contained

hi link nft_UnexpectedSemicolon nftHL_Error
syn match nft_UnexpectedSemicolon /;\+/ skipwhite skipempty contained


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

syn match nft_EOL /[\n\r]\{1,16}/ contained skipwhite

hi link nft_Semicolon nftHL_Normal
syn match nft_Semicolon contained /[;]\{1,15}/  skipwhite
\ nextgroup=nft_EOL

hi link nft_define nftHL_Command
syn keyword nft_define contained define skipwhite 
\ nextgroup=nft_define_Identifier

hi link nft_redefine nftHL_Command
syn keyword nft_redefine contained redefine skipwhite 
\ nextgroup=nft_define_Identifier

hi link nft_undefine nftHL_Command
syn keyword nft_undefine contained undefine skipwhite 
\ nextgroup=nft_undefine_Identifier

syn cluster nft_c_common_block
\ contains=
\    nft_include,
\    nft_define,
\    nft_redefine,
\    nft_undefine,
\    nft_InlineComment,
\    nft_Semicolon,
\    nft_EOS
"""""""""""""""" NEW WORK BEGINS HERE """""""""""""""""""""""""""""""
"  All fields are in output order of bgnault's Railroad

" exthdr_key
hi link nft_exthdr_key_hbh nftHL_Action
syn match nft_exthdr_key_hbh "\vhbh" contained skipwhite

hi link nft_exthdr_key_rt nftHL_Action
syn match nft_exthdr_key_rt "\vrt" contained skipwhite

hi link nft_exthdr_key_frag nftHL_Action
syn match nft_exthdr_key_frag "\vfrag" contained skipwhite

hi link nft_exthdr_key_dst nftHL_Action
syn match nft_exthdr_key_dst "\vdst" contained skipwhite

hi link nft_exthdr_key_mh nftHL_Action
syn match nft_exthdr_key_mh "\vmh" contained skipwhite

hi link nft_exthdr_key_ah nftHL_Action
syn match nft_exthdr_key_ah "\vah" contained skipwhite

syn cluster nft_c_exthdr_key
\ contains=
\    nft_exthdr_key_hbh,
\    nft_exthdr_key_rt,
\    nft_exthdr_key_frag,
\    nft_exthdr_key_dst,
\    nft_exthdr_key_mh,
\    nft_exthdr_key_ah

" exthdr_exists_expr
hi link nft_exthdr_exists_expr nftHL_Statement
syn match nft_exthdr_exists_expr "\vexthdr" skipwhite contained
\ nextgroup=@nft_exthdr_key


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
syn match nft_frag_hdr_field_nexthdr "\vnexthdr" contained skipwhite

hi link nft_frag_hdr_field_reserved nftHL_Action
syn match nft_frag_hdr_field_reserved "\vreserved" contained skipwhite

hi link nft_frag_hdr_field_frag_off nftHL_Action
syn match nft_frag_hdr_field_frag_off "\vfrag_off" contained skipwhite

hi link nft_frag_hdr_field_reserved2 nftHL_Action
syn match nft_frag_hdr_field_reserved2 "\vreserved2" contained skipwhite

hi link nft_frag_hdr_field_more_fragments nftHL_Action
syn match nft_frag_hdr_field_more_fragments "\vmore_fragments" contained skipwhite

hi link nft_frag_hdr_field_id nftHL_Action
syn match nft_frag_hdr_field_id "\vid" contained skipwhite

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
syn match nft_rt4_hdr_field_last_ent "\vlast_ent" contained skipwhite

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
syn match nft_c_rt4_hdr_expr "\vrt4" skipwhite contained
\ nextgroup=@nft_c_rt4_hdr_field


" rt2_hdr_field (via rt2_hdr_expr)
hi link nft_rt2_hdr_field_addr nftHL_Action
syn match nft_rt2_hdr_field_addr "\vaddr" contained skipwhite

syn cluster nft_c_rt2_hdr_field
\ contains=
\    nft_rt2_hdr_field_addr

" rt2_hdr_expr (via exthdr_expr)
hi link nft_rt2_hdr_expr nftHL_Statement
syn match nft_rt2_hdr_expr "\vrt2" skipwhite contained
\ nextgroup=@nft_c_rt2_hdr_field


" rt0_hdr_field (via rt0_hdr_expr)
hi link nft_rt0_hdr_field_addr_num nftHL_Action
syn match nft_rt0_hdr_field_addr_num "\v[0-9]+" contained skipwhite

hi link nft_rt0_hdr_field_addr_num_block nftHL_Command
" keepend because brackets should be on same line
syn match nft_rt0_hdr_field_addr_num_block "\v\[\s*\d\s*\]" contained

hi link nft_rt0_hdr_field_addr nftHL_Action
syn match nft_rt0_hdr_field_addr "\vaddr" contained skipwhite
\ nextgroup=nft_rt0_hdr_field_addr_num_block

syn cluster nft_c_rt0_hdr_field
\ contains=
\    nft_rt0_hdr_field_addr

" rt0_hdr_expr (via exthdr_expr)
hi link nft_rt0_hdr_expr nftHL_Statement
syn match nft_rt0_hdr_expr "\vrt0" skipwhite contained
\ nextgroup=@nft_c_rt0_hdr_field


" rt_hdr_field (via rt_hdr_expr)
hi link nft_rt_hdr_field_nexthdr nftHL_Action
syn match nft_rt_hdr_field_nexthdr "\vnexthdr" contained skipwhite

hi link nft_rt_hdr_field_hdrlength nftHL_Action
syn match nft_rt_hdr_field_hdrlength "\vhdrlength" contained skipwhite

hi link nft_rt_hdr_field_type nftHL_Action
syn match nft_rt_hdr_field_type "\vtype" contained skipwhite

hi link nft_rt_hdr_field_seg_left nftHL_Action
syn match nft_rt_hdr_field_seg_left "\vseg_left" contained skipwhite

syn cluster nft_c_rt_hdr_field
\ contains=
\    nft_rt_hdr_field_nexthdr,
\    nft_rt_hdr_field_hdrlength,
\    nft_rt_hdr_field_type,
\    nft_rt_hdr_field_seg_left

" rt_hdr_expr (via exthdr_expr)
hi link nft_rt_hdr_expr nftHL_Statement
syn match nft_rt_hdr_expr "\vrt" skipwhite contained
\ nextgroup=@nft_c_rt_hdr_field


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
\    nft_rt_hdr_expr,
\    nft_rt0_hdr_expr,
\    nft_rt2_hdr_expr,
\    nft_rt4_hdr_expr,
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
syn match nft_th_hdr_expr "\vtransport_hdr" skipwhite contained
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
syn match nft_chunk_type /(data|init_ack|init|sack|heartbeat_ack|heartbeat|abort|shutdown_complete|shutdown_ack|error|cookie_echo|cookie_ack|ecne|cwr|shutdown|asconf_ack|forward_tsn|asconf)/ skipwhite contained
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
syn match nft_c_sctp_chunk_init_field "\v(init_tag|a_rwnd|num_ostream|num_istreams|init_tsn)" skipwhite contained

" sctp_chunk_alloc 'init' (via sctp_hdr_expr)
syn match nft_sctp_chunk_alloc_init "\v(init_ack|init)" skipwhite contained
\ nextgroup=@nft_c_sctp_chunk_init_field

" sctp_chunk_alloc 'sack' (via sctp_hdr_expr)
hi link nft_c_sctp_chunk_sack_field nftHL_Action
syn match nft_c_sctp_chunk_sack_field "\v(cum_tsn_ack|a_rwnd|num_gack_blocks|num_dup_tsns)" skipwhite contained

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
\    nft_sctp_chunk_alloc_sack
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nft_tcpopt_field_mptcp
hi link nft_tcpopt_field_mptcp nftHL_Action
syn match nft_tcpopt_field_mptcp "\vsubtype" skipwhite contained

hi link nft_tcpopt_field_maxseg nftHL_Action
syn match nft_tcpopt_field_maxseg "\vsize" skipwhite contained

" tcpopt_field_tsopt
hi link nft_tcpopt_field_tsopt nftHL_Action
syn match nft_tcpopt_field_tsopt "\v(tsval|tsecr)" skipwhite contained

" tcpopt_field_window
hi link nft_tcpopt_field_window nftHL_Action
syn match nft_tcpopt_field_window "\v(count)" skipwhite contained

" tcpopt_field_sack
hi link nft_tcpopt_field_sack nftHL_Action
syn match nft_tcpopt_field_sack "\v(left|right)" skipwhite contained

" tcp_hdr_option_sack
hi link nft_tcp_hdr_option_type_sack nftHL_Action
syn match nft_tcp_hdr_option_type_sack "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained
hi link nft_tcp_hdr_option_kaf_sack nftHL_Action
syn match nft_tcp_hdr_option_kaf_sack "\v(sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=nft_tcpopt_field_sack

" tcp_hdr_field
hi link nft_tcp_hdr_field nftHL_Action
syn match nft_tcp_hdr_field "\v(sport|dport|sequence|ackseq|doff|reserved|flags|window|checksum|urgptr)" skipwhite contained

" tcp_hdr_option_type
hi link nft_tcp_hdr_option_types nftHL_Action
syn match nft_tcp_hdr_option_types "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack_perm|timestamp|window|num)" skipwhite contained

hi link nft_c_tcp_hdr_option_type nftHL_Action
syn cluster nft_c_tcp_hdr_option_type
\ contains=
\    nft_tcp_hdr_option_types,
\    nft_tcp_hdr_option_type_sack
hi link nft_optstrip_stmt_type nftHL_Action
syn match nft_optstrip_stmt_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack_perm|timestamp|window|num)" skipwhite contained
hi link nft_tcp_hdr_expr_type nftHL_Action  " nft_tcp_hdr_option_kind_and_field
syn match nft_tcp_hdr_expr_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|sack_perm|timestamp|window|num)" skipwhite contained
"\ nextgroup=XXXXXXXXXXXXXXXXXXXXXp

" tcp_hdr_option_kind_and_field
hi link nft_tcp_hdr_option_kaf_mss nftHL_Action
syn match nft_tcp_hdr_option_kaf_mss "\vmss" skipwhite contained
\ nextgroup=nft_tcpopt_field_maxseg

hi link nft_tcp_hdr_option_kaf_window nftHL_Action
syn match nft_tcp_hdr_option_kaf_window "\vwindow" skipwhite contained
\ nextgroup=nft_tcpopt_field_window

hi link nft_tcp_hdr_option_kaf_timestamp nftHL_Action
syn match nft_tcp_hdr_option_kaf_timestamp "\vtimestamp" skipwhite contained
\ nextgroup=nft_tcpopt_field_tsopt

hi link nft_tcp_hdr_option_kind_and_field nftHL_Action
syn cluster nft_tcp_hdr_option_kind_and_field
\ contains=
\    nft_tcp_hdr_option_kaf_mss,
\    nft_tcp_hdr_option_kaf_sack,
\    nft_tcp_hdr_option_kaf_windows,
\    nft_tcp_hdr_option_kaf_timestamp,
\    @nft_c_tcp_hdr_option_type,
\    nft_tcp_hdr_option_kaf_mptcp,

" tcp_hdr_expr_option
hi link nft_tcp_hdr_expr_option nftHL_Action
syn match nft_tcp_hdr_expr_option "\voption" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_type,
\    nft_tcp_hdr_option_type_sack,  " tcp_hdr_option_sack
\    nft_tcp_hdr_option_kind_and_field,
\    nft_tcp_hdr_option_at

" tcp_hdr_expr
hi link nft_tcp_hdr_expr nftHL_Statement
syn match nft_tcp_hdr_expr "\vtcp" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field,
\    @nft_tcp_hdr_expr_option


" dccp_hdr_field
syn cluster nft_c_dccp_hdr_field
\ contains=
\    nft_dccp_hdr_field_sport,
\    nft_dccp_hdr_field_dport,
\    nft_dccp_hdr_field_type

" nft_dccp_hdr_expr
hi link nft_dccp_hdr_expr_option nftHL_Action
syn match nft_dccp_hdr_expr_option "\voption\s+\d+" skipwhite contained

syn match nft_dccp_hdr_expr "\vdccp" skipwhite contained
\ nextgroup=
\    @nft_c_dccp_hdr_field,
\    nft_dccp_hdr_expr_option


" inner_inet_expr
syn cluster nft_c_inner_inet_expr
\ contains=
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr
"\    nft_ip_hdr_expr,
"\    nft_icmp_hdr_expr,
"\    nft_igmp_hdr_expr,
"\    nft_ip6_hdr_expr,
"\    nft_icmp6_hdr_expr,
"\    nft_auth_hdr_expr,
"\    nft_esp_hdr_expr,
"\    nft_comp_hdr_expr,
"\    nft_udp_hdr_expr,
"\    nft_udplite_hdr_expr,
"\    nft_tcp_hdr_expr,


" inner_eth_expr
syn cluster nft_c_inner_eth_expr
\ contains=
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr

" inner_expr
syn cluster nft_c_inner_expr
\ contains=
\    @nft_c_inner_eth_expr,
\    @nft_c_inner_inet_expr


syn cluster nft_c_primary_expr
\ contains=
\    @nft_c_exthdr_expr,
\    nft_exthdr_exists_expr

hi link nft_base_cmd_describe nftHL_Command
syn match nft_base_cmd_describe "\vdescribe" skipwhite contained
\ nextgroup=
\    @nft_c_primary_expr
"\    nft_symbol_expr,
"\    nft_integer_expr,
"\    nft_payload_expr,
"\    nft_meta_expr,
"\    nft_socket_expr,
"\    nft_rt_expr,
"\    nft_ct_expr,
"\    nft_numgen_expr,
"\    nft_hash_expr,
"\    nft_fib_expr,
"\    nft_osf_expr,
"\    nft_xfrm_expr,
"\    nft_basic_expr

""""""""""""""""" BASE CMD """""""""""""""""""""""""""""""""""""

hi link nft_comment nftHL_Comment
syn region nft_comment start="^\s*#" end="$" contained

"""""""""""""""" TOP-LEVEL SYNTAXES """"""""""""""""""""""""""""
" `line` main top-level syntax, do not add 'contained' here.
syn match nft_line '^\v'
\ nextgroup=
\    nft_base_cmd_describe
"\    nft_stmt_separator,
"\    nft_comment
"\    nft_common_block
"\    nft_base_cmd_add,
"\    nft_base_cmd_replace,
"\    nft_base_cmd_create,
"\    nft_base_cmd_insert,
"\    nft_base_cmd_delete,
"\    nft_base_cmd_get,
"\    nft_base_cmd_list,
"\    nft_base_cmd_reset,
"\    nft_base_cmd_flush,
"\    nft_base_cmd_rename,
"\    nft_base_cmd_import,
"\    nft_base_cmd_export,
"\    nft_base_cmd_monitor,
"\    nft_base_cmd_destroy,
"\    nft_stmt_separator,

"""""""""""""""""""""" END OF SYNTAX """"""""""""""""""""""""""""


let b:current_syntax = 'nftables'

let &cpoptions = s:save_cpo
unlet s:save_cpo

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

