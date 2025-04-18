


" limit_burst_pkts
" 'burst' <NUM> 'packets'
" 'packet'->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" 'packet'->limit_burst_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_keyword_packets nftHL_Action
syn match nft_limit_burst_pkts_keyword_packets "packets" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'burst' <NUM>
" num->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" num->limit_burst_pkts->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_num nftHL_Number
syn match nft_limit_burst_pkts_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_keyword_packets

" 'burst'
" 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'limit' 'rate' [ 'over'|'until' ] <NUM> '/' ('second'|'minute'|'hour'|'day'|'week') 'burst'
" 'burst'->limit_burst_pkts->limit_config->(add_cmd|create_cmd|limit_block)
" 'burst'->limit_burst_pkts->->set_elem_stmt->set_elem_expr_alloc
hi link   nft_limit_burst_pkts_keyword_burst nftHL_Command
syn match nft_limit_burst_pkts_keyword_burst "burst" skipwhite contained
\ nextgroup=
\    nft_limit_burst_pkts_num

