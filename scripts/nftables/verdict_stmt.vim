


" set_elem_stmt->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt
\ contains=
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_counter,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_limit,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_ct,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_quota,
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt_keyword_last,

" '*'->set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn match nft_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_asterisk "\*" skipwhite contained
\ nextgroup=
\    nft_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_elem_stmt

" set_lhs_expr->set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_lhs_expr
\ contains=
\    nft_nothing

" set_elem_key_expr->set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr
\ contains=
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr_set_lhs_expr

" set_elem_expr_alloc->set_elem_expr->verdict_map_list_member_expr->verdict_map_expr
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc
\ contains=
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc_set_elem_key_expr

" cannot use nft_c_set_elem_expr here,
" MUST CLONE IT ALL because we continue on with ':'
syn cluster nft_c_verdict_map_list_expr_set_elem_expr_alloc
\ contains=
\    nft_c_verdict_map_list_expr_set_elem_expr_set_elem_expr_alloc

hi link    nft_verdict_map_expr_block_delimiters nftHL_BlockDelimitersMap
syn region nft_verdict_map_expr_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_verdict_map_list_member_expr

" '{'
" verdict_map_expr->verdict_map_stmt
syn cluster nft_c_verdict_map_expr
\ contains=
\    nft_verdict_map_expr_block_delimiters,
\    @nft_c_set_ref_expr

hi link   nft_verdict_map_expr_keyword_vmap nftHL_Command
syn match nft_verdict_map_expr_keyword_vmap "vmap" skipwhite contained
\ nextgroup=
\    @nft_c_verdict_map_expr

syn cluster nft_c_verdict_map_stmt
\ contains=
\    nft_verdict_map_expr_keyword_vmap
" TODO: need to insert concat_expr into here

" verdict_stmt->stmt
syn cluster nft_c_verdict_stmt
\ contains=
\    @nft_c_verdict_expr,
\    @nft_c_verdict_map_stmt
