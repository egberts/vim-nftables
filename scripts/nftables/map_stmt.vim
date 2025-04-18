


" 'set' 'at' <identifier> '{'
hi link   nft_map_stmt_block_delimiters nftHL_BlockDelimitersMap
syn region nft_map_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    nft_set_elem_expr_stmt

" 'set' 'at' <identifier>
" identifier->set_ref_symbol_expr->(rhs_expr|set_ref_expr)
hi link   nft_map_stmt_set_ref_symbol_expr_identifier nftHL_Identifier
syn match nft_map_stmt_set_ref_symbol_expr_identifier "\v[a-zA-Z_][a-zA-Z0-9\\\/_\.\-]{0,31}" skipwhite contained
\ nextgroup=
\    nft_map_stmt_block_delimiters

" 'set' 'at'
" set_ref_symbol_expr->(rhs_expr|set_ref_expr)
hi link   nft_map_stmt_set_ref_symbol_expr nftHL_Statement
syn match nft_map_stmt_set_ref_symbol_expr "at" skipwhite contained
\ nextgroup=
\    nft_map_stmt_set_ref_symbol_expr_identifier

hi link   nft_map_stmt_variable_expr nft_Variable
syn match nft_map_stmt_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained

" set_ref_expr->(map_stmt|set_stmt)"
syn cluster nft_c_map_stmt_set_ref_expr
\ contains=
\    nft_map_stmt_set_ref_symbol_expr,
\    nft_map_stmt_variable_expr
" set_ref_symbol_expr starts with 'at'
" variable_expr starts with '$'

" set_stmt_op->(map_stmt|set_stmt)->stmt
"  'add' | 'update' | 'delete
hi link   nft_map_stmt_set_stmt_op nftHL_Command
syn match nft_map_stmt_set_stmt_op "\v(add|update|delete)" skipwhite contained
\ nextgroup=
\    @nft_c_map_stmt_set_ref_expr

" map_stmt->stmt
" 'map'
syn cluster nft_c_map_stmt
\ contains=
\    nft_map_stmt_set_stmt_op

