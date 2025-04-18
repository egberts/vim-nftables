

source ../scripts/nftables/vlan_hdr_field.vim


" vlan_hdr_expr (via inner_eth_expr, payload_expr)
hi link   nft_vlan_hdr_expr nftHL_Statement
syn match nft_vlan_hdr_expr "vlan" skipwhite contained
\ nextgroup=
\    @nft_c_vlan_hdr_field