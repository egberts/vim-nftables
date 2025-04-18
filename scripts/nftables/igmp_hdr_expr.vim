" File: igmp_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr


" igmp_hdr_field (via igmp_hdr_expr)
hi link   nft_igmp_hdr_field nftHL_Action
syn match nft_igmp_hdr_field "\v(type|checksum|mrt|group)" skipwhite contained

" igmp_hdr_expr (via inner_inet_expr, payload_expr)
" igmp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" igmp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_igmp_hdr_expr nftHL_Statement
syn match nft_igmp_hdr_expr "igmp" skipwhite contained
\ nextgroup=
\    nft_igmp_hdr_field