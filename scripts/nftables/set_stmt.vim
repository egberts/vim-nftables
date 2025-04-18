


" set_ref_expr->(map_stmt|set_stmt)"
syn cluster nft_c_set_stmt_set_ref_expr
\ contains=
\    nft_set_stmt_set_ref_symbol_expr,
\    nft_set_stmt_variable_expr
" set_ref_symbol_expr starts with 'at'
" variable_expr starts with '$'

" 'set' 'add'|'update'|'delete' set_elem_expr_stmt_alloc [ set_elem_options ] set_ref_expr

" 'set' 'add'|'update'|'delete' set_elem_expr_stmt_alloc
" set_elem_expr_stmt_alloc->set_elem_expr_stmt->set_stmt->stmt
syn cluster nft_c_set_stmt_set_keyword_set_elem_expr_stmt
\ contains=@nft_c_concat_expr

" 'set' 'add'|'update'|'delete'
" set_stmt_op->set_stmt->stmt
hi link   nft_set_stmt_set_keyword_set_stmt_op nftHL_Statement
syn match nft_set_stmt_set_keyword_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=
\    @nft_c_set_stmt_set_keyword_set_elem_expr_stmt

" 'set'
" 'set'->set_stmt->stmt
hi link   nft_set_stmt_set_keyword nftHL_Statement
syn match nft_set_stmt_set_keyword "set" skipwhite contained
\ nextgroup=
\    nft_set_stmt_set_keyword_set_stmt_op



" 'add'|'update'|'delete' [ $<identifier> | 'at' ... ] '{' set_elem_expr_stmt [ stateful_stmt_list ] '}'

syn cluster nft_c_set_stmt_block_set_elem_expr_stmt
\ contains=
\    @nft_c_concat_expr,
\    nft_set_elem_options

" '{'->set_stmt->stmt
" 'add'|'update'|'delete' [ $<identifier> | 'at' ... ] '{'
hi link   nft_set_stmt_block_delimiters nftHL_BlockDelimitersSet
syn region nft_set_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\   @nft_c_set_stmt_block_set_elem_expr_stmt,
\   @nft_c_stateful_stmt_list

" set_stmt_op->set_stmt->stmt
" 'add'|'update'|'delete'
hi link   nft_set_stmt_set_stmt_op nftHL_Statement
syn match nft_set_stmt_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=
\    nft_set_stmt_op_set_ref_expr

" set_stmt->stmt
syn cluster nft_c_set_stmt
\ contains=
\    nft_set_stmt_set_keyword,
\    nft_set_stmt_set_stmt_op
