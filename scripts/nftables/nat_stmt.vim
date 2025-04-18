


" ('snat'|'dnat') ('ip'|'ip6')
" 'ip[6]?'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_nf_key_proto nftHL_Action
syn match nft_nat_stmt_nf_key_proto "\vip[6]?" skipwhite contained

" ('snat'|'dnat') 'to' stmt_expr
" stmt_expr->nat_stmt_alloc->nat_stmt->stmt
syn cluster nft_c_nat_stmt_keyword_to_stmt_expr_lone
\ contains=
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to' ':'
" ':'->nat_stmt_alloc->nat_stmt->stmt
syn match nft_c_nat_stmt_keyword_to_colon /:/ skipwhite contained
\ contains=
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to' stmt_expr ':' stmt_expr
" stmt_expr->nat_stmt_alloc->nat_stmt->stmt
syn cluster nft_c_nat_stmt_keyword_to_stmt_expr
\ contains=
\    @nft_c_nat_stmt_keyword_to_colon,
\    @nft_c_stmt_expr

" ('snat'|'dnat') 'to'
" 'to'->'interval'|'prefix'->nat_stmt_alloc->nat_stmt->stmt
\    @nft_c_nat_stmt_interval_prefix_keywords_to_keyword

" ('snat'|'dnat') 'to'
" 'to'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_keyword_to nftHL_Action
syn match nft_nat_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_nat_stmt_keyword_to_stmt_expr_lone,
\    nft_nat_stmt_keyword_to_colon,
\    @nft_c_nat_stmt_keyword_to_stmt_expr

" ('snat'|'dnat') ( 'interval' | 'prefix' ) 'to'
" 'to'->'interval'|'prefix'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_keywords_interval_prefix nftHL_Action
syn match nft_nat_stmt_keywords_interval_prefix "\v(interval|prefix)" skipwhite contained
\ nextgroup=
\    @nft_c_nat_stmt_interval_prefix_keywords_to_keyword
" \    @nft_c_stmt_expr

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr' '.' 'port'
" 'port'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr_port nftHL_Action
syn match nft_nat_stmt_addr_port "port" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_keyword_to

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr' '.'
" '.'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr_dot nftHL_Action
syn match nft_nat_stmt_addr_dot "\." skipwhite contained
\ nextgroup=
\    nft_nat_stmt_addr_port

" ('snat'|'dnat') ( 'ip' | 'ip6' ) 'addr'
" 'addr'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_addr nftHL_Action
syn match nft_nat_stmt_addr "addr" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_addr_dot

" ('snat'|'dnat') ( 'ip' | 'ip6' )
" 'ip'|'ip6'->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_nf_key_proto nftHL_Action
syn match nft_nat_stmt_nf_key_proto "\v(ip[6]?)" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_keyword_to,
\    nft_nat_stmt_keywords_interval_prefix,
\    nft_nat_stmt_addr

" ('snat'|'dnat') stmt_expr
" stmt_expr->nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt_stmt_expr nftHL_Command
syn match nft_nat_stmt_stmt_expr "\v(snat|dnat)" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_stmt_expr_nat_flags,
\    nft_nat_stmt_stmt_expr_delimiter_colon

" ('snat'|'dnat')
" nat_stmt_alloc->nat_stmt->stmt
hi link   nft_nat_stmt nftHL_Command
syn match nft_nat_stmt "\v(snat|dnat)" skipwhite contained
\ nextgroup=
\    nft_nat_stmt_stmt_expr,
\    nft_nat_stmt_delimiter_colon,
\    nft_nat_stmt_keyword_to,
\    nft_nat_stmt_keywords_interval_prefix,
\    nft_nat_stmt_nf_key_proto

