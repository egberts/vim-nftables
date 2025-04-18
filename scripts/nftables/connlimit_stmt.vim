


" 'ct' 'count' [ 'over' ] <NUM>
" <NUM>->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_num nftHL_Number
syn match nft_connlimit_stmt_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'ct' 'count' 'over'
" 'over'->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_keyword_over nftHL_Action
syn match nft_connlimit_stmt_keyword_over "over" skipwhite contained
\ nextgroup=
\    nft_connlimit_stmt_num,
\    nft_Error

" 'ct' 'count'
" 'count'->connlimit_stmt->stateful_stmt
hi link   nft_connlimit_stmt_keyword_count nftHL_Command
syn match nft_connlimit_stmt_keyword_count "\vct {1,15}count" skipwhite contained
\ nextgroup=
\    nft_connlimit_stmt_keyword_over,
\    nft_connlimit_stmt_num
