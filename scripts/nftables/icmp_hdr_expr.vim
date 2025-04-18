




hi link   nft_icmp_hdr_field_values nftHL_Number
syn match nft_icmp_hdr_field_values "\v([A-Za-z0-9\-\._]{1,32}|[0-9]{1,6})" skipwhite contained

" icmp_hdr_field (via icmp_hdr_expr)
hi link   nft_icmp_hdr_field nftHL_Action
syn match nft_icmp_hdr_field "\v(type|code|checksum|id|seq|gateway|mtu)" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_field_values

" icmp_hdr_expr (via inner_inet_expr, payload_expr)
" icmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_icmp_hdr_expr nftHL_Statement
syn match nft_icmp_hdr_expr "icmp" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_field

hi link   nft_icmp_hdr_expr_icmp_hdr_field nftHL_Action
syn match nft_icmp_hdr_expr_icmp_hdr_field "\v(type|code|checksum|id|seq|gateway|mtu)" skipwhite contained

hi link   nft_icmp_hdr_expr_via_payload_expr nftHL_Command
syn match nft_icmp_hdr_expr_via_payload_expr "icmp" skipwhite contained
\ nextgroup=
\    nft_icmp_hdr_expr_icmp_hdr_field