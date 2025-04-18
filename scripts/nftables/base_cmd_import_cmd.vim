



" base_cmd 'import' (via base_cmd)
hi link   nft_import_cmd_keyword_ruleset nftHL_Operator
syn match nft_import_cmd_keyword_ruleset "ruleset" skipwhite keepend contained
\ nextgroup=
\    nft_markup_format,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error



" 'import'->base_cmd->line
hi link   nft_base_cmd_keyword_import nftHL_Command
syn match nft_base_cmd_keyword_import "import" skipwhite contained
\ nextgroup=
\    nft_import_cmd_keyword_ruleset,
\    nft_markup_format,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error