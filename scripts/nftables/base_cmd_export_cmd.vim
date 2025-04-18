

source ../scripts/nftables/markup_format.vim

" export_cmd markup_format (via export_cmd)
hi link   nft_export_cmd_keyword_ruleset nftHL_Operator
syn match nft_export_cmd_keyword_ruleset "ruleset" skipwhite contained
\ nextgroup=
\    nft_markup_format,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error



" 'export'->base_cmd->line
hi link   nft_base_cmd_keyword_export nftHL_Command
syn match nft_base_cmd_keyword_export "export" skipwhite contained
\ nextgroup=
\    nft_export_cmd_keyword_ruleset,
\    nft_markup_format,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

