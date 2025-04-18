


" vlan_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" vlan_hdr_field 'type' (via vlan_hdr_field)
hi link   nft_vlan_hdr_field_type nftHL_Action
syn match nft_vlan_hdr_field_type "type" skipwhite contained

" vlan_hdr_field keywords (via vlan_hdr_field)
hi link   nft_vlan_hdr_field_keywords nftHL_Action
syn match nft_vlan_hdr_field_keywords "\v(id|cfi|dei|pcp)" skipwhite contained

" vlan_hdr_field (via vlan_hdr_expr)
syn cluster nft_c_vlan_hdr_field
\ contains=
\    nft_vlan_hdr_field_keywords,
\    nft_vlan_hdr_field_type
