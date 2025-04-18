



" 'exthdr' 'hbh'
" 'hbh'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_hbh nftHL_Action
syn match nft_exthdr_key_hbh "hbh" contained skipwhite

" 'exthdr' 'rt'
" 'rt'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_rt nftHL_Action
syn match nft_exthdr_key_rt "rt" contained skipwhite

" 'exthdr' 'frag'
" 'frag'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_frag nftHL_Action
syn match nft_exthdr_key_frag "frag" contained skipwhite

" 'exthdr' 'dst'
" 'dst'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_dst nftHL_Action
syn match nft_exthdr_key_dst "dst" contained skipwhite

" 'exthdr' 'mh'
" 'mh'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_mh nftHL_Action
syn match nft_exthdr_key_mh "mh" contained skipwhite

" 'exthdr' 'ah'
" 'ah'->exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_key_ah nftHL_Action
syn match nft_exthdr_key_ah "ah" contained skipwhite

" exthdr_key->'exthdr'->exthdr_exists_expr->primary_expr
syn cluster nft_c_exthdr_key
\ contains=
\    nft_exthdr_key_hbh,
\    nft_exthdr_key_rt,
\    nft_exthdr_key_frag,
\    nft_exthdr_key_dst,
\    nft_exthdr_key_mh,
\    nft_exthdr_key_ah

" exthdr_exists_expr
" 'exthdr'->exthdr_exists_expr->primary_expr
hi link   nft_exthdr_exists_expr nftHL_Statement
syn match nft_exthdr_exists_expr "exthdr" skipwhite contained
\ nextgroup=
\    @nft_c_exthdr_key

" 'mh' 'nexthdr'
" 'nexthdr'->mh_hdr_field->'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_field_nexthdr nftHL_Action
syn match nft_mh_hdr_field_nexthdr "nexthdr" contained skipwhite