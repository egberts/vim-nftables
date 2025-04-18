


" <num>->offset_opt->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_offset_num nftHL_Number
syn match nft_offset_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_num

" offset_opt->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_offset_opt nftHL_Command
syn match nft_offset_opt "offset" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_num

" <num>->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_numgen_num nftHL_Number
syn match nft_numgen_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_numgen_offset_opt

" 'mod'->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_numgen_mod_keyword nftHL_Action
syn match nft_numgen_mod_keyword "mod" skipwhite contained
\ nextgroup=
\    nft_numgen_num

" numgen_type->numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_numgen_type nftHL_Action
syn match nft_numgen_type "\v(inc|random)" skipwhite contained
\ nextgroup=
\    nft_numgen_mod_keyword

" numgen_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)
hi link   nft_numgen_expr nftHL_Command
syn match nft_numgen_expr "numgen" skipwhite contained
\ nextgroup=
\    nft_numgen_type
