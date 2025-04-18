


" '(saddr|daddr)->ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link   nft_ct_expr_ct_key_proto_field_keyword_addrs nftHL_Action
syn match nft_ct_expr_ct_key_proto_field_keyword_addrs "\v(saddr|daddr)" skipwhite contained

" ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link   nft_ct_expr_ct_key_proto_field_keyword_ip_ip6 nftHL_Command
syn match nft_ct_expr_ct_key_proto_field_keyword_ip_ip6 "\vip[6]?" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key_proto_field_keyword_addrs

" ct_key_dir->ct_expr->(primary_expr|primary_stmt_expr)
hi link   nft_ct_expr_ct_key_dir nftHL_Action
syn match nft_ct_expr_ct_key_dir "\v(saddr|daddr|l3proto|proto\-(src|dst))" skipwhite contained

" ct_key_dir_optional->(ct_stmt|ct_key_dir|ct_key)
hi link   nft_ct_expr_ct_key_dir_optional nftHL_Action
syn match nft_ct_expr_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_expr_keyword_set

" ct_key_proto_field->ct_expr->(primary_expr|primary_stmt_expr)
hi link   nft_ct_expr_ct_dir nftHL_Action
syn match nft_ct_expr_ct_dir "\v(original|reply)" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key_dir_optional,
\    nft_ct_expr_ct_key_dir

" ct_key->ct_expr->(payload_expr|payload_stmt_expr)
hi link   nft_ct_expr_ct_key nftHL_Action
syn match nft_ct_expr_ct_key "\v(l3proto|mark|state|direction|status|expiration|helper|saddr|daddr|proto\-src|proto\-dst|label|event|proto|secmark|id)" skipwhite contained

" ct_expr->(primary_expr|primary_stmt_expr)
hi link   nft_ct_expr nftHL_Command
syn match nft_ct_expr "ct" skipwhite contained
\ nextgroup=
\    nft_ct_expr_ct_key,
\    nft_ct_expr_ct_key_dir_optional,
\    nft_ct_expr_ct_dir,
\    nft_ct_expr_ct_key_proto_field_keyword_ip_ip6
