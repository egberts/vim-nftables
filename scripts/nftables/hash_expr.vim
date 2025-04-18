

syn cluster nft_c_hash_expr_jhash_expr
\ contains=
\    @nft_c_concat_expr,
\    nft_set_expr,
\    nft_map_expr

" 'jhash' hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
hi link   nft_hash_expr_jhash nftHL_Command
syn match nft_hash_expr_jhash "jhash" skipwhite contained
\ nextgroup=
\    nft_hash_expr_jhash_expr

" 'symhash' hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
hi link   nft_hash_expr_symhash nftHL_Command
syn match nft_hash_expr_symhash "symhash" skipwhite contained
\ nextgroup=
\    nft_hash_expr_symhash_mod

" hash_expr->(primary_expr|primary_stmt_expr|queue_stmt_expr)"
syn cluster nft_c_hash_expr
\ contains=
\    nft_hash_expr_jhash,
\    nft_hash_expr_symhash