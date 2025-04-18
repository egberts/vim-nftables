



" optstrip_stmt (via stmt)
hi link   nft_optstrip_stmt nftHL_Action
syn match nft_optstrip_stmt "\vreset\s+tcp\s+option" skipwhite contained
\ nextgroup=
\    @nft_c_tcp_hdr_option_type

