


hi link   nft_rt_key nftHL_Command
syn match nft_rt_key "\v(classid|nexthop|mtu|ipsec)" skipwhite contained

hi link   nft_nf_key_proto nftHL_Command
syn match nft_nf_key_proto "\vip[6]?" skipwhite contained
\ nextgroup=
\    nft_rt_key

hi link   nft_rt_expr nftHL_Command
syn match nft_rt_expr "rt\ze " skipwhite contained
\ nextgroup=
\    nft_nf_key_proto,
\    nft_rt_key