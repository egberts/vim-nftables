

hi link   nft_symbol_stmt_expr_nested_comma namedHL_Type
syn match nft_symbol_stmt_expr_nested_comma /,/ skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_symbol_stmt_expr_recursive,
\    nft_symbol_stmt_expr_nested_comma

" keyword_expr (via primary_rhs_expr, primary_stmt_expr, symbol_stmt_expr)
syn match nft_keyword_expr "\v(ether|ip6|ip |vlan|arp|dnat|snat|ecn|reset|destroy|original|reply|label|last)" skipwhite contained

" symbol_stmt_expr (via stmt_expr)
syn cluster nft_c_symbol_stmt_expr
\ contains=
\    nft_keyword_expr,
\    @nft_c_symbol_expr
" nft_c_symbol_expr must be the LAST contains= (via nft_unquoted_string)

" symbol_stmt_expr ',' (via stmt_expr)
hi link   nft_symbol_stmt_expr_recursive nftHL_Operator
syn match nft_symbol_stmt_expr_recursive "," skipwhite contained
\ contains=
\    @nft_c_symbol_stmt_expr,
\    nft_symbol_stmt_expr_nested_comma
\ nextgroup=
\    nft_symbol_stmt_expr_nested_comma,
\    nft_symbol_stmt_expr_recursive

" symbol_stmt_expr->stmt_expr
syn cluster nft_symbol_stmt_expr
\ contains=
\    nft_symbol_stmt_expr_nested_comma