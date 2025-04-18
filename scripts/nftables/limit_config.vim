

source ../scripts/nftables/limit_burst_bytes.vim
source ../scripts/nftables/limit_rate_bytes.vim

source ../scripts/nftables/limit_burst_pkts.vim
source ../scripts/nftables/limit_rate_pkts.vim

" limit_rate_bytes
" 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_time_unit

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes' '/'
" '/'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_expression_slash nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_expression_slash "/" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_time_unit


" 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'bytes'
" 'bytes'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_expression_slash

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_limit_config_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_expression_slash,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_limit_stmt_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_expression_slash,
\    nft_EOS

" 'limit' 'rate' [ 'over'|'until' ] <NUM> 'string'
" 'string'->limit_rate_bytes->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_bytes_keyword_string nftHL_Expression
syn match nft_set_elem_stmt_limit_rate_bytes_keyword_string "string" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_expression_slash,
\    nft_EOS


" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->*->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_rate_pktsbytes_num nftHL_Number
syn match nft_limit_config_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_bytes_keyword_string,
\    nft_limit_config_limit_rate_pkts_expression_slash,
\    nft_limit_config_limit_rate_bytes_limit_bytes_keyword_bytes

" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->*->limit_stmt->stateful_stmt
hi link   nft_limit_stmt_limit_rate_pktsbytes_num nftHL_Number
syn match nft_limit_stmt_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_limit_stmt_limit_rate_bytes_keyword_string,
\    nft_limit_stmt_limit_rate_pkts_expression_slash,
\    nft_limit_stmt_limit_rate_bytes_limit_bytes_keyword_bytes

" 'limit' 'rate' [ 'over'|'until' ] <NUM>
" <num>->limit_rate->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate_pktsbytes_num nftHL_Number
syn match nft_set_elem_stmt_limit_rate_pktsbytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_bytes_keyword_string,
\    nft_limit_config_limit_rate_pkts_expression_slash,
\    nft_set_elem_stmt_limit_rate_bytes_limit_bytes_keyword_bytes



" 'rate' [ 'over'|'until' ]
" limit_mode->limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config_limit_mode nftHL_Action
syn match nft_limit_config_limit_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_rate_pktsbytes_num

