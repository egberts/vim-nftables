

" gre_hdr_field (via gre_hdr_expr)
hi link   nft_gre_hdr_field nftHL_Action
syn match nft_gre_hdr_field "\v(version|flags|protocol)" skipwhite contained

" gre_hdr_expr
hi link   nft_gre_hdr_expr nftHL_Statement
syn match nft_gre_hdr_expr " \zsgre\ze " skipwhite contained
\ nextgroup=
\    nft_gre_hdr_field,
\    nft_inner_inet_expr