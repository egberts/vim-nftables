

" base_cmd [ 'ct' ]
hi link   nft_base_cmd_add_cmd_keyword_ct nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_ct "\vct\ze " skipwhite contained
\ nextgroup=
\    @nft_c_cmd_add_ct_keywords