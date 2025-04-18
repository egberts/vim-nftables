


" 'xt' 'string' <STRING>
" <STRING>->xt_stmt->stmt
hi link   nft_xt_stmt_string nftHL_String
syn match nft_xt_stmt_string "\v[a-zA-Z0-9 ]{1,64}" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'xt' 'string'
" 'string'->xt_stmt->stmt
hi link   nft_xt_stmt_keyword_string nftHL_Statement
syn match nft_xt_stmt_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_xt_stmt_string

" 'xt'
" xt_stmt->stmt
hi link   nft_xt_stmt nftHL_Command
syn match nft_xt_stmt "xt" skipwhite contained
\ nextgroup=
\    nft_xt_stmt_keyword_string
