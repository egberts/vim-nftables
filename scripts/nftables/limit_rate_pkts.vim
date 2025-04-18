


" time_unit
" 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_pkts_time_unit nftHL_Action
syn match nft_limit_config_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_pkts_time_unit nftHL_Action
syn match nft_limit_stmt_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst


" limit_rate_pkts
" 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_limit_config_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_pkts_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->limit_stmt->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_stmt_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_limit_stmt_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_pkts_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/'
" '/'->limit_rate_pkts->set_elem_stmt->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_pkts_expression_slash nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_pkts_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_pkts_time_unit



" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week')
" time_unit->limit_rate_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_pkts_time_unit nftHL_Action
syn match nft_set_elem_stmt_limit_rate_pkts_time_unit "\v(second|minute|hour|day|week)" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_burst

