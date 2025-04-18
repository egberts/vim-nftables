" File: eth_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr

hi link   nft_eth_hdr_field_addr_value nftHL_Number
"syn match nft_eth_hdr_field_addr_value "\v[0-9a-fA-F]{1,2}:([0-9a-fA-F]{1,2}){6}" skipwhite contained
syn match nft_eth_hdr_field_addr_value "\v[0-9a-fA-F]{1,2}(:[0-9a-fA-F]{1,2}){5}" skipwhite contained

" eth_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" eth_hdr_field 'saddr'/'daddr' (via eth_hdr_field)
hi link   nft_eth_hdr_field_addrs nftHL_Action
syn match nft_eth_hdr_field_addrs "\v(saddr|daddr)" skipwhite contained
\ nextgroup=
\    nft_eth_hdr_field_addr_value,
\    nft_numgen_expr

hi link   nft_eth_hdr_field_type_value nftHL_Number
syn match nft_eth_hdr_field_type_value "\v((0[Xx])?[0-9a-fA-F]{2,4}|[0-9]{1,6})" skipwhite contained

" eth_hdr_field 'type' (via eth_hdr_field)
hi link  nft_eth_hdr_field_type nftHL_Action
syn match nft_eth_hdr_field_type "\v(type)" skipwhite contained
\ nextgroup=
\    nft_eth_hdr_field_type_value,
\    nft_Error

" eth_hdr_field (via eth_hdr_expr)
hi link  nft_c_eth_hdr_field nftHL_Action
syn cluster nft_c_eth_hdr_field
\  contains=
\    nft_eth_hdr_field_addrs,
\    nft_eth_hdr_field_type

" eth_hdr_expr (via inner_eth_expr, payload_expr)
hi link   nft_eth_hdr_expr nftHL_Statement
syn match nft_eth_hdr_expr "ether" skipwhite contained
\  nextgroup=
\    @nft_c_eth_hdr_field