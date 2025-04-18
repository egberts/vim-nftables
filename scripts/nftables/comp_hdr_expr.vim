
" comp_hdr_expr (via inner_inet_expr, payload_expr)
" comp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" comp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_comp_hdr_expr nftHL_Statement
syn match nft_comp_hdr_expr "comp" skipwhite contained
\ nextgroup=
\    nft_comp_hdr_field

