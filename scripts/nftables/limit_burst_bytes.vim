


" limit_burst_bytes
" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM> ('bytes'|'string')
" 'bytes'->limit_burst_bytes->limit_config
hi link   nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes nftHL_Action
syn match nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM> ('bytes'|'string')
" 'bytes'->limit_burst_bytes->set_elem_stmt->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes nftHL_Action
syn match nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes "\v(bytes|string)" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM>
" num->limit_burst_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_burst_bytes_limit_bytes_num nftHL_Number
syn match nft_limit_config_limit_burst_bytes_limit_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_limit_bytes_keyword_bytes

" limit_burst_bytes
" 'burst' <NUM>
" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst' <NUM>
" num->limit_burst_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num nftHL_Number
syn match nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_limit_bytes_keyword_bytes

" 'limit' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_burst_bytes_keyword_burst nftHL_Command
syn match nft_limit_config_limit_burst_bytes_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_limit_bytes_num

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_burst_bytes_keyword_burst nftHL_Command
syn match nft_set_elem_stmt_limit_burst_bytes_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_limit_bytes_num


