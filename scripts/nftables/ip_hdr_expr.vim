

" 'ip' 'option' 'lsrr' 'type'
" 'type'->ip_option_field->'lsrr'->ip_option_type->'option'->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_option_field nftHL_Statement
syn match nft_ip_option_field "\v(type|length|value|ptr|addr)" skipwhite contained

" 'ip' 'option' 'lsrr'
" 'lsrr'->ip_option_type->'option'->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_option_type nftHL_Action
syn match nft_ip_option_type "\v(lsrr|rr|ssrr|ra)" skipwhite contained
\ nextgroup=
\    nft_ip_option_field,
\    nft_Semicolon

" 'ip' 'option'
" 'option'->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_expr_option nftHL_Statement
syn match nft_ip_hdr_expr_option "option" skipwhite contained
\ nextgroup=
\    nft_ip_option_type

source ../scripts/nftables/ip_ip6_fields.vim

" 'ip' 'daddr'
" 'daddr'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "daddr" skipwhite contained
\ nextgroup=
\    nft_ip_ip6_fields

" 'ip' 'saddr'
" 'saddr'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "saddr" skipwhite contained
\ nextgroup=
\    nft_ip_ip6_fields

" 'ip' 'checksum'
" 'checksum'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "checksum" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_checksum_value


hi link   nft_ip_hdr_expr_keyword_protocol_num nftHL_Number
syn match nft_ip_hdr_expr_keyword_protocol_num "\v[a-zA-Z0-9]{1,32}" skipwhite contained

" 'ip' 'protocol'
" 'protocol'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "protocol" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_protocol_num

" 'ip' 'ttl'
" 'ttl'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "ttl" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_ttl_count

" 'ip' 'fra_off'
" 'frag-off'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "frag\-off" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_fra_off_count

" 'ip' 'id'
" 'id'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "id" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_id_num

" 'ip' 'length'
" 'length'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "length" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_length_num

" 'ip' 'ecn'
" 'ecn'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "ecn" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_ecn_id

" 'ip' 'dscp' <NUM>
" ip_hdr_field (via ip_hdr_expr) (internal Bison/Lex)
hi link   nft_ip_hdr_field_keyword_dscp_id_number nftHL_Number
syn match nft_ip_hdr_field_keyword_dscp_id_number "\v[0-9]{1,3}" skipwhite contained
\ nextgroup=
\    nft_EOS
syn match nft_ip_hdr_field_keyword_dscp_id_number "\v0x[0-9]{1,2}" skipwhite contained
\ nextgroup=
\    nft_EOS
hi link   nft_ip_hdr_field_keyword_dscp_id_label nftHL_Label
syn match nft_ip_hdr_field_keyword_dscp_id_label "\v(ef|cs[0-7]|af[1-4][1-3])" skipwhite contained
\ nextgroup=
\    nft_EOS
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
" 'dscp'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "dscp" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr
"\    nft_ip_hdr_field_keyword_dscp_block_delimiter,
"\    nft_ip_hdr_field_keyword_dscp_operator_negation,
"\    nft_ip_hdr_field_keyword_dscp_id_label,
"\    nft_ip_hdr_field_keyword_dscp_id_number

" 'ip' 'hdrlength'
" 'hdrlength'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "hdrlength" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field_keyword_hdrlength_num

" 'ip' 'version'
" 'version'->ip_hdr_field->'ip'->ip_hdr_expr (internal Bison/Lex)
hi link   nft_ip_hdr_field nftHL_Action
syn match nft_ip_hdr_field "version" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_expr_keyword_version_num

" 'ip'
" ip_hdr_expr
" 'ip->ip_hdr_expr
hi link   nft_ip_hdr_expr nftHL_Statement
syn match nft_ip_hdr_expr "ip" skipwhite contained
\ nextgroup=
\    nft_ip_hdr_field,
\    nft_ip_hdr_expr_option

