" File: auth_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr


" auth_hdr_field (via auth_hdr_expr)
hi link   nft_auth_hdr_field nftHL_Action
syn match nft_auth_hdr_field "\v(nexthdr|hdrlength|reserved|spi|seq)" skipwhite contained


