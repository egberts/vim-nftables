

" inner_expr (via geneve_hdr_expr, gretap_hdr_expr, vxlan_hdr_expr)
syn cluster nft_c_inner_expr
\ contains=
\    @nft_c_inner_eth_expr,
\    @nft_c_inner_inet_expr

source ../scripts/nftables/inner_eth_expr.vim
source ../scripts/nftables/inner_inet_expr.vim

