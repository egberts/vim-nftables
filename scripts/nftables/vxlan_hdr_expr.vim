" vxlan_hdr_field (via vxlan_hdr_expr)
hi link   nft_vxlan_hdr_field nftHL_Action
syn match nft_vxlan_hdr_field "\v(vni|flags)" skipwhite contained

" vxlan_hdr_expr 'vxlan' (via payload_expr)
hi link   nft_vxlan_hdr_expr nftHL_Statement
syn match nft_vxlan_hdr_expr "vxlan" skipwhite contained
\ nextgroup=
\    nft_vxlan_hdr_field,
\    @nft_c_inner_expr