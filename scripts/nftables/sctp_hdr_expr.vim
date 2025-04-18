

" sctp_hdr_expr (via inner_inet_expr, payload_expr)

" 'sctp' 'sport'
" 'sport'->sctp_hdr_field->'sctp'->sctp_hdr_expr
hi link   nft_sctp_hdr_field_keyword_sport nftHL_Action
syn match nft_sctp_hdr_field_keyword_sport "sport" contained skipwhite

" 'sctp' 'dport'
" 'dport'->sctp_hdr_field->'sctp'->sctp_hdr_expr
hi link   nft_sctp_hdr_field_keyword_dport nftHL_Action
syn match nft_sctp_hdr_field_keyword_dport "dport" contained skipwhite

" 'sctp' 'vtag'
" 'vtag'->sctp_hdr_field->'sctp'->sctp_hdr_expr
hi link   nft_sctp_hdr_field_keyword_vtag nftHL_Action
syn match nft_sctp_hdr_field_keyword_vtag "vtag" contained skipwhite

" 'sctp' 'checksum'
" 'checksum'->sctp_hdr_field->'sctp'->sctp_hdr_expr
hi link   nft_sctp_hdr_field_keyword_checksum nftHL_Action
syn match nft_sctp_hdr_field_keyword_checksum "checksum" contained skipwhite

syn cluster nft_c_sctp_hdr_field
\ contains=
\    nft_sctp_hdr_field_keyword_sport,
\    nft_sctp_hdr_field_keyword_dport,
\    nft_sctp_hdr_field_keyword_vtag,
\    nft_sctp_hdr_field_keyword_checksum


" 'sctp' 'chunk' 'type'
" 'type'->sctp_chunk_common_field->sctp_chunk_allow->'chunk'->'sctp'->sctp_hdr_expr
hi link   nft_sctp_chunk_common_field_type nftHL_Action
syn match nft_sctp_chunk_common_field_type "type" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'sctp' 'chunk' 'flags'
" 'flags'->sctp_chunk_common_field->sctp_chunk_allow->'chunk'->'sctp'->sctp_hdr_expr
hi link   nft_sctp_chunk_common_field_flags nftHL_Action
syn match nft_sctp_chunk_common_field_flags "flags" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'sctp' 'chunk' 'length'
" 'length'->sctp_chunk_common_field->sctp_chunk_allow->'chunk'->'sctp'->sctp_hdr_expr
hi link   nft_sctp_chunk_common_field_length nftHL_Action
syn match nft_sctp_chunk_common_field_length "length" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'sctp' 'chunk'
" sctp_chunk_common_field->sctp_chunk_allow->'chunk'->'sctp'->sctp_hdr_expr
syn cluster nft_c_sctp_chunk_common_field
\ contains=
\    nft_sctp_chunk_common_field_type,
\    nft_sctp_chunk_common_field_flags,
\    nft_sctp_chunk_common_field_length,
\    nft_EOS

" 'sctp' 'chunk' 'data' [ 'tsn' | 'stream' | 'ssn' | 'ppid' ]
" sctp_chunk_data_field->'data'->sctp_chuck_alloc->'chunk'->'sctp'->sctp_hdr_expr
hi link   nft_sctp_chunk_data_field nftHL_Action
syn match nft_sctp_chunk_data_field "\v(tsn|stream|ssn|ppid)" skipwhite contained

" 'sctp' 'chunk' 'data'
" 'data'->sctp_chunk_alloc->'chunk'->'sctp'->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_data nftHL_Action
syn match nft_sctp_chunk_alloc_keyword_data "data" skipwhite contained
\ nextgroup=
\     @nft_c_sctp_chunk_common_field,
\     nft_sctp_chunk_data_field,
\     nft_EOS

" 'sctp' 'chunk' 'init' ('init-tag'|'a-rwnd'|'num-outbound-streams'|'num-inbound-streams'|'initial-tsn')
" ('cum-tsn-ack'|'a-rwnd'|'num-gap-ack-block'|'num-dup-tsns')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_init_field nftHL_Action
syn match nft_sctp_chunk_alloc_sctp_chunk_init_field "\v(init\-tag|a\-rwnd|num\-(outbound|inbound)\-streams|initial\-tsn)" skipwhite contained
\ nextgroup=
\    nft_EOS

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
hi link   nft_sctp_chunk_alloc_sctp_chunk_type_keyword_heartbeat_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_heartbeat_et_al "\vheartbeat(\-ack)?" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'abort'->sctp_chunk_type->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_sctp_chunk_type_keyword_abort nftHL_Statement
syn match nft_sctp_chunk_alloc_sctp_chunk_type_keyword_abort "abort" skipwhite contained
\ nextgroup=
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" 'sctp' 'chunk' 'shutdown ('cum-tsn-ack'|'type'|'flags'|'length')
" 'cum-tsn-ack'->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_shutdown_field nftHL_Action
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
hi link   nft_sctp_chunk_alloc_ecne_cwr_field nftHL_Action
syn match nft_sctp_chunk_alloc_ecne_cwr_field "lowest\-tsn" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'sctp' 'chunk' ('ecne'|'cwr')
" ('ecne'|'cwr')->sctp_chunk_alloc->sctp_hdr_expr
hi link   nft_sctp_chunk_alloc_keyword_ecne_cwr nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_ecne_cwr "\v(ecne|cwr)" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_ecne_cwr_field,
\    nft_EOS

" sctp_chunk_alloc_asconf_ack 'seqno' (via sctp_hdr_expr)
hi link   nft_sctp_chunk_alloc_asconf_ack_field nftHL_Action
syn match nft_sctp_chunk_alloc_asconf_ack_field "seqno" skipwhite contained

" sctp_chunk_alloc_asconf_ack
hi link   nft_sctp_chunk_alloc_keyword_asconf_et_al nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_asconf_et_al "\vasconf(\-ack)?" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_asconf_ack_field,
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS

" sctp_chunk_alloc_forward_tsn
hi link   nft_sctp_chunk_alloc_forward_tsn_field nftHL_Action
syn match nft_sctp_chunk_alloc_forward_tsn_field "new\-cum\-tsn" skipwhite contained

" sctp_chunk_alloc_forward_tsn
hi link   nft_sctp_chunk_alloc_keyword_forward_tsn nftHL_Statement
syn match nft_sctp_chunk_alloc_keyword_forward_tsn "\vforward\-tsn" skipwhite contained
\ nextgroup=
\    nft_sctp_chunk_alloc_forward_tsn_field,
\    @nft_c_sctp_chunk_common_field,
\    nft_EOS


" sctp_chunk_alloc (via sctp_hdr_expr)
hi link   nft_sctp_hdr_expr_chunk nftHL_Statement
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
