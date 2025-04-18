


" 'limit' 'rate' [ 'over'|'until' ]
" limit_mode->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_config_limit_mode nftHL_Action
syn match nft_limit_stmt_limit_config_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_pktsbytes_num

" 'limit' 'rate' [ 'over'|'until' ]
" limit_mode->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_mode nftHL_Action
syn match nft_set_elem_stmt_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_pktsbytes_num

" 'rate'->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_keyword_rate nftHL_Statement
syn match nft_limit_stmt_keyword_rate "rate" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_mode,
\    nft_set_elem_stmt_limit_rate_pktsbytes_num

" 'limit'
" 'limit'->limit_stmt->stateful_stmt
hi link   nft_limit_stmt nftHL_Statement
syn match nft_limit_stmt "limit" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_keyword_rate
