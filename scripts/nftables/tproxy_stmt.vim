


" 'tproxy' [ 'ip'|'ip6' ] 'to' stmt_expr ':' stmt_expr
syn match nft_tproxy_stmt_keyword_to_colon /:/ skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'tproxy' [ 'ip'|'ip6' ] 'to'
syn match nft_tproxy_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr,
\    nft_tproxy_stmt_keyword_to_colon

" 'tproxy' 'ip'
" 'tproxy' 'ip6'
syn match nft_tproxy_stmt_nf_key_proto "\v(ip[6]?)" skipwhite contained
\ nextgroup=
\    nft_tproxy_stmt_keyword_to

" 'tproxy'
" tproxy_stmt->stmt
syn match nft_tproxy_stmt "tproxy" skipwhite contained
\ nextgroup=
\    nft_tproxy_stmt_keyword_to,
\    nft_tproxy_stmt_nf_key_proto
