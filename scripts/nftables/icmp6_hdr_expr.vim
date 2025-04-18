" File: icmp6_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr


" icmp6_hdr_field (via icmp6_hdr_expr)
hi link   nft_icmp6_hdr_field nftHL_Action
syn match nft_icmp6_hdr_field "\v(type|code|checksum|param\-problem|mtu|id|seq|max\-delay|taddr|daddr)" skipwhite contained

" icmp6_hdr_expr (via inner_inet_expr, payload_expr)
" icmp6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" icmp6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_icmp6_hdr_expr nftHL_Statement
syn match nft_icmp6_hdr_expr "icmpv6" skipwhite contained
\ nextgroup=
\    nft_icmp6_hdr_field