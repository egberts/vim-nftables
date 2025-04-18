

" geneve_hdr_field (via geneve_hdr_expr)
hi link   nft_geneve_hdr_field nftHL_Action
syn match nft_geneve_hdr_field "\v(vni|type)" skipwhite contained


" geneve_hdr_expr (via payload_expr)
hi link   nft_geneve_hdr_expr nftHL_Statement
syn match nft_geneve_hdr_expr "geneve" skipwhite contained
\ nextgroup=
\    nft_geneve_hdr_field,
\    @nft_c_inner_expr