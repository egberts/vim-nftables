


" masq_stmt_args
" 'masquerade' 'to' ':' stmt_expr [ nf_nat_flags ]
" 'masquerade' nf_nat_flags
hi link   nft_masq_stmt_masq_stmt_args_keyword_to nftHL_Command
syn match nft_masq_stmt_masq_stmt_args_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr
" TODO: expand stmt_expr to append nf_nat_flags

" 'masquerade'
" masq_stmt_alloc->masq_stmt->stmt
hi link   nft_masq_stmt_masq_stmt_alloc_keyword_masq nftHL_Command
syn match nft_masq_stmt_masq_stmt_alloc_keyword_masq "masq" skipwhite contained
\ nextgroup=
\    nft_masq_stmt_masq_stmt_args_keyword_to,
\    @nft_c_nf_nat_flags

" 'masq'
" masq_stmt->stmt
syn cluster nft_c_masq_stmt
\ contains=
\    nft_masq_keyword_masq
