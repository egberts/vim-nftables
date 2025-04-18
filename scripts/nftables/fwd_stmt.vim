


" 'fwd' ('ip'|'ip6') 'to'
" 'to'->fwd_stmt
hi link   nft_fwd_stmt_nf_key_proto_keyword_to nftHL_Command
syn match nft_fwd_stmt_nf_key_proto_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'fwd' ('ip'|'ip6')
" nf_key_proto->fwd_stmt
hi link   nft_fwd_stmt_nf_key_proto nftHL_Command
syn match nft_fwd_stmt_nf_key_proto "\vip[6]?" skipwhite contained
\ nextgroup=
\    nft_fwd_stmt_nf_key_proto_keyword_to

" 'fwd' 'to'
hi link   nft_fwd_stmt_keyword_to nftHL_Command
syn match nft_fwd_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'fwd'
" fwd_stmt
hi link   nft_fwd_stmt nftHL_Command
syn match nft_fwd_stmt "fwd" skipwhite contained
\ nextgroup=
\    nft_fwd_stmt_keyword_to,
\    nft_fwd_stmt_nf_key_proto

" TODO 'dup 'to' stmt_expr 'device' stmt_expr

" 'dup' 'to'
" 'to'->dup_stmt->stmt
hi link   nft_dup_stmt_keyword_to nftHL_Command
syn match nft_dup_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr
