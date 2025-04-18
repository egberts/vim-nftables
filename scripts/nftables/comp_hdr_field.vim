" File: comp_hdr_expr.vim
"
" Called by: payload_expr
" Called by: inner_inet_expr


" comp_hdr_field (via comp_hdr_expr)
hi link   nft_comp_hdr_field nftHL_Action
syn match nft_comp_hdr_field "\v(nexthdr|flags|cpi)" skipwhite contained

