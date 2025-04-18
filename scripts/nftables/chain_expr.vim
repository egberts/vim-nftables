


" variable_expr->chain_expr->verdict_expr
hi link   nft_chain_expr_variable_expr nftHL_Variable
syn match nft_chain_expr_variable_expr "\v\$[A-Za-z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'last'->identifier->chain_expr->verdict_expr
hi link   nft_chain_expr_identifier_last nftHL_Action
syn match nft_chain_expr_identifier_last "last" skipwhite contained
\ nextgroup=
\    nft_EOS

" <string>->identifier->chain_expr->verdict_expr
hi link   nft_chain_expr_identifier_string nftHL_Action
syn match nft_chain_expr_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,65}" skipwhite contained
\ nextgroup=
\    nft_EOS

" chain_expr->verdict_expr
syn cluster nft_c_chain_expr
\ contains=
\    nft_chain_expr_identifier_last,
\    nft_chain_expr_variable_expr,
\    nft_chain_expr_identifier_string
" nft_chain_expr_identifier_string has wildcard and must be last in contains=

" ('jump'|'goto')->verdict_expr->(verdict_stmt|set_rhs_expr)
hi link   nft_verdict_expr_keywords_chain_expr nftHL_Command
syn match nft_verdict_expr_keywords_chain_expr "\v(jump|goto)" skipwhite contained
\ nextgroup=
\    @nft_c_chain_expr
