


" 'tcp' '.*' [ 'accept' / 'drop' ]
hi link   nft_tcp_hdr_field_keyword_action nftHL_Action
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
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit nftHL_Number
syn match nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit "\v[0-9]{1,5}(\-[0-9]{1,5})?" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_block_expression_comma

" 'tcp' 'sport' 'vmap' '{' '!='
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_operator_negative nftHL_Operator
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_operator_negative "\v\!\=" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_service_name,
\    nft_Error

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_operator_negative nftHL_Operator
syn match nft_tcp_hdr_field_keywords_ports_operator_negative "\v\!\=" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_keywords_ports_service_name,
\    nft_Error

" 'tcp' 'sport' 'vmap' '{' service_name ','
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_expression_comma nftHL_Element
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_expression_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_num_or_numrange_5digit,
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_operator_negative,
\    nft_tcp_hdr_field_ports_keywords_ports_keyword_vmap_service_name

" 'tcp' 'sport' '{' service_name ','
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_block_expression_comma nftHL_Element
syn match nft_tcp_hdr_field_keywords_ports_block_expression_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_ports_keywords_ports_num_or_numrange_5digit,
\    nft_tcp_hdr_field_ports_keywords_ports_operator_negative,
\    nft_tcp_hdr_field_ports_keywords_ports_service_name

" 'tcp' 'sport' vmap '{' <NUM>
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_service_name nftHL_Identifier
syn match nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_service_name "\v[a-z]{1,17}" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_field_keywords_ports_keyword_vmap_block_block_expression_comma

" 'tcp' 'sport' <NUM> [ '-' <NUM> ]
" tcp_hdr_field  (outside of Bison/Yacc)
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
" tcp_hdr_field  (outside of Bison/Yacc)
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
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords nftHL_Action
syn match nft_tcp_hdr_field_keywords "dport" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field_keywords_ports_block,
\    nft_EOS,
\    nft_Error

" 'tcp' 'sport'
" tcp_hdr_field  (outside of Bison/Yacc)
hi link   nft_tcp_hdr_field_keywords nftHL_Action
syn match nft_tcp_hdr_field_keywords "sport" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field_keywords_ports_block,
\    nft_EOS,
\    nft_Error
hi link   nft_tcp_hdr_field_keywords nftHL_Action

syn match nft_tcp_hdr_field_keywords "\v(sequence|ackseq|doff|reserved|flags|window|checksum|urgptr)" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_field_keywords_ports_block,
\    nft_EOS,
\    nft_Error


" tcp_hdr_field
syn cluster nft_c_tcp_hdr_field
\ contains=
\    nft_tcp_hdr_field_keywords,
\    nft_Error


" tcp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM ',' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at_payload_raw_len nftHL_Number
syn match nft_tcp_hdr_option_at_payload_raw_len "\v[0-9]{1,11}" skipwhite contained

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM ',' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at_comma2 nftHL_Expression
syn match nft_tcp_hdr_option_at_comma2 "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_payload_raw_len,
\    nft_Error_Always

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' NUM (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at_num nftHL_Number
syn match nft_tcp_hdr_option_at_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_comma2,
\    nft_Error_Always

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type ',' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at_comma nftHL_Expression
syn match nft_tcp_hdr_option_at_comma "," skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_num,
\    nft_Error_Always

" tcp_hdr_expr 'option' 'tcp' 'at' tcp_hdr_option_type (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at_tcp_hdr_option_type nftHL_Action
syn match nft_tcp_hdr_option_at_tcp_hdr_option_type "\v(echo|eol|fastopen|md5sig|mptcp|mss|nop|timestamp|window|num)" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_comma,
\    nft_Error_Always
" relocated 'sack-permitted' to nft_tcp_hdr_option_sack

" tcp_hdr_expr 'option' 'tcp' 'at' (via tcp_hdr_expr)
hi link   nft_tcp_hdr_option_at nftHL_Action
syn match nft_tcp_hdr_option_at "at" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at_tcp_hdr_option_type,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" tcp_hdr_expr 'option' (via inner_inet_expr, payload_expr)
hi link   nft_tcp_hdr_expr_option nftHL_Statement
syn match nft_tcp_hdr_expr_option "option" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_option_at,
\    nft_tcp_hdr_option_sack,
\    @nft_c_tcp_hdr_option_type,
\    @nft_c_tcp_hdr_option_kind_and_field,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" tcp_hdr_expr
" 'tcp'->tcp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" 'tcp'->tcp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_tcp_hdr_expr nftHL_Statement
syn match nft_tcp_hdr_expr "tcp" skipwhite contained
\ nextgroup=
\    nft_tcp_hdr_expr_option,
\    @nft_c_tcp_hdr_field,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

