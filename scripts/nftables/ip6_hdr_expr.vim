

" ip6_hdr_field (via ip6_hdr_expr)
hi link   nft_ip6_hdr_field nftHL_Action
syn match nft_ip6_hdr_field "\v(version|dscp|ecn|flowlabel|length|nexthdr|hoplimit|saddr|daddr)" skipwhite contained

" ip6_hdr_expr (via inner_inet_expr, payload_expr)
" ip6_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" ip6_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_ip6_hdr_expr nftHL_Statement
syn match nft_ip6_hdr_expr "ip6" skipwhite contained
\ nextgroup=
\    nft_ip6_hdr_field