

" auth_hdr_expr (via inner_inet_expr, payload_expr)
" auth_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" auth_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_auth_hdr_expr nftHL_Statement
syn match nft_auth_hdr_expr "auth" skipwhite contained
\ nextgroup=
\    nft_auth_hdr_field