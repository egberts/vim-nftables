


" time_unit
" 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_burst_bytes_keyword_burst,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_burst_bytes_keyword_burst,
\    nft_EOS

" time_unit
" 'limit' 'rate' [ 'over'|'until' ] <NUM> ('bytes'|'string') '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_time_unit nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_burst_bytes_keyword_burst,
\    nft_EOS

