

" nft_gretap_hdr_expr is defined AFTER nft_gre_hdr_expr
hi link   nft_gretap_hdr_expr nftHL_Statement
syn match nft_gretap_hdr_expr "gretap" skipwhite contained
\ nextgroup=
\    @nft_c_inner_expr

