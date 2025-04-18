


" 'dup'
" dup_stmt->stmt
hi link   nft_dup_stmt nftHL_Command
syn match nft_dup_stmt "dup" skipwhite contained
\ nextgroup=
\    nft_dup_stmt_keyword_to

