


" set_expr->map_stmt_expr_set->map_stmt_expr
" set_ref_expr->map_stmt_expr_set->map_stmt_expr

" map_stmt_expr->stmt_expr
syn cluster nft_c_map_stmt_expr
\ contains=
\    @nft_c_concat_stmt_expr

" map_stmt_expr_set"
syn cluster nft_c_map_stmt_expr_set
\ contains=
\    nft_set_expr,
\    @nft_c_set_ref_expr

" map_stmt_expr_set->map_stmt_expr
syn cluster nft_c_map_stmt
\ contains=
\    nft_map