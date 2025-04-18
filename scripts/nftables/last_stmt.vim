


" 'last' 'used' time_spec
" time_spec->last_stmt->stateful_stmt
hi link   nft_last_stmt_time_spec nftHL_String
syn match nft_last_stmt_time_spec "\v\w{1,63}" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'last' 'used' 'never'
" 'never'->last_stmt->stateful_stmt
hi link   nft_last_stmt_keyword_never nftHL_Action
syn match nft_last_stmt_keyword_never "never" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'last' 'used'
" 'used'->last_stmt->stateful_stmt
hi link   nft_last_stmt_keyword_used nftHL_Statement
syn match nft_last_stmt_keyword_used "used" skipwhite contained
\ nextgroup=
\    nft_last_stmt_keyword_never,
\    nft_last_stmt_time_spec

" 'last'
" last_stmt->stateful_stmt
hi link   nft_last_stmt_keyword_last nftHL_Command
syn match nft_last_stmt_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_last_stmt_keyword_used,
\    nft_EOS

syn cluster nft_c_last_stmt
\ contains=
\    nft_last_stmt_keyword_last
