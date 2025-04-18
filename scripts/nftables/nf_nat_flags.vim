


" ('random'|'fully-random'|'persistent') ','
" ','->nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
hi link   nft_nf_nat_flags_comma nftHL_Action
syn match nft_nf_nat_flags_comma "," skipwhite contained
\ contains=
\    nft_nf_nat_flag

" nf_nat_flag
" ('random'|'fully-random'|'persistent')
" ('random'|'fully-random'|'persistent')->nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
hi link   nft_nf_nat_flag nftHL_Action
syn match nft_nf_nat_flag "\v(random|fully\-random|persistent)" skipwhite contained
\ nextgroup=
\    nft_nf_nat_flags_comma

" nf_nat_flags
" nf_nat_flags->(masq_stmt_args|nat_stmt|redir|stmt_arg)
" nf_key_proto->(fwd_stmt|nat_stmt|rt_expr|tproxy_stmt)
syn cluster nft_c_nf_nat_flags
\ contains=
\    nft_nf_nat_flag
