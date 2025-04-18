" File: esp_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr


" esp_hdr_field (via esp_hdr_expr)
hi link   nft_esp_hdr_field nftHL_Action
syn match nft_esp_hdr_field "\v(spi|seq)" skipwhite contained

" esp_hdr_expr (via inner_inet_expr, payload_expr)
" esp_hdr_expr->inner_inet_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" esp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
hi link   nft_esp_hdr_expr nftHL_Statement
syn match nft_esp_hdr_expr "esp" skipwhite contained
\ nextgroup=
\    nft_esp_hdr_field
