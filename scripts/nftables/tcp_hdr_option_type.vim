


" nft_tcpopt_field_mptcp
" 'subtype'->tcpopt_field_mptcp->'mptcp'->tcp_hdr_option_kind_and_field->'option'->tcp_hdr_option_kind_and_field->'tcp'->tcp_hdr_expr->payload_expr
hi link   nft_tcpopt_field_mptcp nftHL_Action
syn match nft_tcpopt_field_mptcp "subtype" skipwhite contained

" tcpopt_field_maxseg (via_tcp_hdr_option_kind_and_field)
hi link   nft_tcpopt_field_maxseg nftHL_Number
syn match nft_tcpopt_field_maxseg "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

" tcpopt_field_tsopt (via_tcp_hdr_option_kind_and_field)
hi link   nft_tcpopt_field_tsopt nftHL_Action
syn match nft_tcpopt_field_tsopt "\v(tsval|tsecr)" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_maxseg,
\    nft_Error

" tcpopt_field_window (via_tcp_hdr_option_kind_and_field)
hi link   nft_tcpopt_field_window nftHL_Number
syn match nft_tcpopt_field_window "\v[0-9]{1,11}" skipwhite contained

" tcpopt_field_sack (via tcp_hdr_option_kind_and_field)
hi link   nft_tcpopt_field_sack nftHL_Action
syn match nft_tcpopt_field_sack "\v(left|right)" skipwhite contained
\ nextgroup=
\    nft_EOS

" tcp_hdr_option_sack (via tcp_hdr_option_kind_and_field, *tcp_hdr_option_type*)
hi link   nft_tcp_hdr_option_sack nftHL_Action
syn match nft_tcp_hdr_option_sack "\v(sack\-permitted|sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_sack,
\    nft_Error_Always

hi link   nft_tcp_hdr_option_size nftHL_Number
syn match nft_tcp_hdr_option_size "\v[0-9]{1,11}[gGmMkK]?" skipwhite contained
\ nextgroup=nft_EOS

" tcp_hdr_option_type (via optstrip_stmt, tcp_hdr_expr, tcp_hdr_option)
hi link   nft_tcp_hdr_option_length nftHL_Number
syn match nft_tcp_hdr_option_length "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=nft_EOS

" tcp_hdr_option_type (via optstrip_stmt, tcp_hdr_expr, tcp_hdr_option)
hi link   nft_tcp_hdr_option_types nftHL_Action
syn match nft_tcp_hdr_option_types "\v(echo|eol|fastopen|md5sig|nop|num|sack\-perm)" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_length,
\    nft_EOS

syn cluster nft_c_tcp_hdr_option_type
\ contains=
\    nft_tcp_hdr_option_types,
\    nft_tcp_hdr_option_sack
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

hi link   nft_optstrip_stmt_type nftHL_Action
syn match nft_optstrip_stmt_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

hi link   nft_tcp_hdr_expr_type nftHL_Action  " nft_tcp_hdr_option_kind_and_field
syn match nft_tcp_hdr_expr_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

" tcp_hdr_option_kind_and_field 'mss' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_kaf_mss nftHL_Action
syn match nft_tcp_hdr_option_kaf_mss "mss" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_maxseg

" tcp_hdr_option_kind_and_field "sack" (via *tcp_hdr_option_kind_and_field*, tcp_hdr_option_type)
hi link   nft_tcp_hdr_option_sack_kaf nftHL_Action
syn match nft_tcp_hdr_option_sack_kaf "\v(sack0|sack1|sack2|sack3|sack\-permitted|sack)" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_sack

" tcp_hdr_option_kind_and_field 'window' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_kaf_window nftHL_Action
syn match nft_tcp_hdr_option_kaf_window "window" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_window,
\    nft_EOS

" tcp_hdr_option_kind_and_field 'timestamp' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_kaf_timestamp nftHL_Action
syn match nft_tcp_hdr_option_kaf_timestamp "timestamp" skipwhite contained
\ nextgroup=
\    nft_tcpopt_field_tsopt

" tcp_hdr_option_type (via tcp_hdr_option_kind_and_field)
hi link   nft_tcp_hdr_option_type_kaf nftHL_Action
syn match nft_tcp_hdr_option_type_kaf "\v(sack\-permitted|sack0|sack1|sack2|sack3|sack)" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_length,
\    nft_tcp_hdr_option_sack_direction

