


" 'quota' <NUM> ('bytes'|'string') [ 'used' <NUM> ('bytes'|'string') ]
" quota_unit->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_quota_unit nftHL_Action
syn match nft_quota_stmt_quota_used_quota_unit "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'quota' <NUM> ('bytes'|'string') [ 'used' <NUM> ... ]
" <NUM>->quota_used->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_num nftHL_Number
syn match nft_quota_stmt_quota_used_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_used_quota_unit

" 'quota' <NUM> ('bytes'|'string') [ 'used' ... ]
" 'used'->quota_used->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_used_keyword_used nftHL_Statement
syn match nft_quota_stmt_quota_used_keyword_used "used" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_used_num

" 'quota' <NUM> ('bytes'|'string')
" quota_unit->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_quota_unit nftHL_Action
syn match nft_quota_stmt_quota_unit "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_used_keyword_used,
\    nft_EOS

" 'quota' <NUM>
" <NUM>->quota_mode->quota_stmt->stateful_stmt
hi link   nft_quota_stmt_num nftHL_Number
syn match nft_quota_stmt_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_quota_unit

" 'quota' quota_mode
" quota_mode->quota_stmt->stateful_stmt
hi link   nft_quota_mode nftHL_Action
syn match nft_quota_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_quota_stmt_num

" 'quota'
" quota_stmt->stateful_stmt
hi link   nft_quota_stmt nftHL_Command
syn match nft_quota_stmt "quota" skipwhite contained
\ nextgroup=
\    nft_quota_mode,
\    nft_quota_stmt_num

