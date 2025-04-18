


" 'describe'->base_cmd->line
hi link   nft_base_cmd_keyword_describe nftHL_Command
syn match nft_base_cmd_keyword_describe "describe" skipwhite contained
\ nextgroup=
\    @nft_c_primary_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error