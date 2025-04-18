


" common_block 'undefine' identifier (via common_block 'undefine')
hi link   nft_common_block_undefine_identifier nftHL_Identifier
syn match nft_common_block_undefine_identifier '\v[a-zA-Z][A-Za-z0-9\/\\_\.\-]{0,63}' oneline skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS

" commmon_block 'undefine' (via common_block)
hi link   nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine "undefine" oneline skipwhite contained
\ nextgroup=
\    nft_common_block_undefine_identifier,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS

