


" udplite_hdr_field (via udplite_hdr_expr)
hi link   nft_udplite_hdr_field nftHL_Action
syn match nft_udplite_hdr_field "\v(sport|dport|csumcov|checksum)" skipwhite contained

" udp_hdr_field (via udp_hdr_expr)
hi link   nft_udp_hdr_field nftHL_Action
syn match nft_udp_hdr_field "\v(sport|dport|length|checksum)" skipwhite contained
\ nextgroup=
\     @nft_c_tcp_hdr_field_keywords_ports_block

" udp_hdr_expr (via inner_inet_expr, payload_expr)
" udp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_udp_hdr_expr nftHL_Statement
syn match nft_udp_hdr_expr "udp" skipwhite contained
\ nextgroup=
\    nft_udp_hdr_field

" udplite_hdr_expr (via inner_inet_expr, payload_expr)
" udplite_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" udplite_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_udplite_hdr_expr nftHL_Statement
syn match nft_udplite_hdr_expr "udplite" skipwhite contained
\ nextgroup=
\    nft_udplite_hdr_field


