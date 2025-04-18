


" markup_format (via monitor_cmd '@nft_c_monitor_object'
hi link   nft_markup_format_keyword_json nftHL_Action
syn match nft_markup_format_keyword_json "json" skipwhite contained

hi link   nft_markup_format nftHL_Action
syn match nft_markup_format "xml" skipwhite contained
syn match nft_markup_format "json" skipwhite contained
syn match nft_markup_format "vm" skipwhite contained
\ nextgroup=
\    nft_markup_format_keyword_json,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

