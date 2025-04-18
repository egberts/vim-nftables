


" meter_key_expr->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> [ 'size' <num> ] '{' meter_key_expr '}'
hi link   nft_meter_stmt_alloc_block nftHL_BlockDelimitersMeter
syn region nft_meter_stmt_alloc_block start='{' end='}' skipwhite contained
\ contains=
\    @nft_c_meter_key_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" NUM->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> 'size' <num>
hi link   nft_meter_stmt_alloc_num nftHL_Number
syn match nft_meter_stmt_alloc_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_block,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" SIZE->meter_stmt_alloc->meter_stmt
" 'meter' <identifier> 'size'
hi link   nft_meter_stmt_alloc_size nftHL_Action
syn match nft_meter_stmt_alloc_size "size" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" <identifier> meter_stmt_alloc->meter_stmt
" meter_stmt_alloc->meter_stmt
" 'meter' <identifier>
hi link   nft_meter_stmt_alloc_identifier nftHL_Identifier
syn match nft_meter_stmt_alloc_identifier "\v[A-Za-z][A-Za-z0-9]{0,63}" skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_size,
\    nft_meter_stmt_alloc_block,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" meter_stmt_alloc->meter_stmt->stmt
" 'meter'
hi link   nft_meter_stmt_alloc nftHL_Statement
syn match nft_meter_stmt_alloc "\vmeter\ze " skipwhite contained
\ nextgroup=
\    nft_meter_stmt_alloc_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" meter_stmt->stmt
syn cluster nft_c_meter_stmt
\ contains=
\    nft_meter_stmt_alloc

