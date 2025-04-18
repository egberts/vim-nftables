


" xfrm_state_proto_key->xfrm_expr->primary_expr
hi link   nft_xfrm_state_proto_key nftHL_Action
syn match nft_xfrm_state_proto_key "\v(s|d)addr" skipwhite contained

" nf_key_protoxfrm_state_proto_key->xfrm_expr->primary_expr
hi link   nft_nf_key_proto nftHL_Action
syn match nft_nf_key_proto "\v(ip[6])" skipwhite contained
\ nextgroup=
\    nft_xfrm_state_proto_key

" xfrm_state_key->xfrm_expr->primary_expr
hi link   nft_xfrm_state_key nftHL_Number
syn match nft_xfrm_state_key "\v(spi|reqid)" skipwhite contained

" xfrm_spnum_num->xfrm_spnum->xfrm_expr->primary_expr
hi link   nft_xfrm_num nftHL_Number
syn match nft_xfrm_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_xfrm_state_key,
\    nft_nf_key_protoxfrm_state_proto_key

" xfrm_spnum->xfrm_expr->primary_expr
hi link   nft_xfrm_spnum nftHL_Command
syn match nft_xfrm_spnum "spnum" skipwhite contained
\ nextgroup=
\    nft_xfrm_spnum_num

" xfrm_dir->xfrm_expr->primary_expr
hi link   nft_xfrm_dir nftHL_Action
syn match nft_xfrm_dir "\v(in|out)" skipwhite contained
\ nextgroup=
\    nft_xfrm_spnum,
\    nft_xfrm_state_key,
\    nft_nf_key_proto

" xfrm_expr ->primary_expr
hi link   nft_xfrm_expr_keyword nftHL_Command
syn match nft_xfrm_expr_keyword "ipsec" skipwhite contained
\ nextgroup=
\    nft_xfrm_dir
