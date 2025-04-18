


" ('accept'|'drop'|'continue'|'return')->verdict_expr->(verdict_stmt|set_rhs_expr)
hi link   nft_verdict_expr_keywords_unchained nftHL_Command
syn match nft_verdict_expr_keywords_unchained "\v(accept|drop|continue|return)" skipwhite contained
\ nextgroup=
\    nft_EOS

" verdict_expr->(verdict_stmt|set_rhs_expr)
syn cluster nft_c_verdict_expr
\ contains=
\    nft_verdict_expr_keywords_unchained,
\    nft_verdict_expr_keywords_chain_expr,
