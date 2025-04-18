


" 'redirect' 'to' [ ':' ] stmt_expr [ nf_nat_flags ]
" 'to' [ ':' ] stmt_expr
syn cluster nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr
\ contains=
\    @nft_c_stmt_expr

" redir_stmt_arg->redir_stmt
hi link   nft_redir_stmt_redir_stmt_arg_keyword_to_colon nftHL_Operator
syn match nft_redir_stmt_redir_stmt_arg_keyword_to_colon /:/ skipwhite contained
\ nextgroup=
\    nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr

" 'to' nf_nat_flags
" redir_stmt_arg->redir_stmt
hi link   nft_redir_stmt_redir_stmt_arg_keyword_to nftHL_Command
syn match nft_redir_stmt_redir_stmt_arg_keyword_to "to" skipwhite contained
\ nextgroup=
\    nft_redir_stmt_redir_stmt_arg_keyword_to_colon,
\    nft_redir_stmt_redir_stmt_arg_keyword_to_stmt_expr

" 'redirect'
" redir_stmt_alloc->redir_stmt->stmt
hi link   nft_redir_stmt_redir_stmt_alloc_keyword_redir nftHL_Command
syn match nft_redir_stmt_redir_stmt_alloc_keyword_redir "redir" skipwhite contained
\ nextgroup=
\    nft_redir_stmt_redir_stmt_arg_keyword_to,
\    @nft_c_nf_nat_flags

" 'redirect'
" redir_stmt->stmt
syn cluster nft_c_redir_stmt
\ contains=
\    nft_redir_stmt_redir_stmt_alloc_keyword_redir
