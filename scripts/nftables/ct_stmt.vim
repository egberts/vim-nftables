
" 'set'->(ct_key|ct_key_dir|ct_stmt)
hi link   nft_ct_key_dir_ct_stmt_keyword_set nftHL_Action
syn match nft_ct_key_dir_ct_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'set'->(ct_key|ct_key_dir|ct_stmt)
hi link   nft_ct_key_ct_stmt_keyword_set nftHL_Command
syn match nft_ct_key_ct_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr



" ct_key_dir_optional->(ct_stmt|ct_key_dir|ct_key)
hi link   nft_ct_stmt_ct_key_dir_optional nftHL_Action
syn match nft_ct_stmt_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_stmt_keyword_set

" ct_key_dir_optional->ct_key_dir
hi link   nft_ct_stmt_ct_key_dir_optional nftHL_Action
syn match nft_ct_stmt_ct_key_dir_optional "\v(bytes|packets|avgpkt|zone)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_stmt_keyword_set

hi link   nft_ct_stmt_ct_dir nftHL_Action
syn match nft_ct_stmt_ct_dir "\v(original|reply)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_stmt_keyword_set

" ct_key->ct_stmt->stmt
hi link   nft_ct_stmt_ct_key nftHL_Action
syn match nft_ct_stmt_ct_key "\v(l3proto|proto|mark|state|direction|status|expiration|helper|saddr|daddr|proto\-src|proto\-dst|label|event|proto|secmark| \zsid)" skipwhite contained
\ nextgroup=
\    nft_ct_key_dir_ct_stmt_keyword_set

" ct_stmt->stmt
hi link   nft_ct_stmt nftHL_Command
syn match nft_ct_stmt "ct" skipwhite contained
\ nextgroup=
\    nft_ct_stmt_ct_key,
\    nft_ct_stmt_ct_key_dir_optional,
\    nft_ct_stmt_ct_dir,
\    nft_UnexpectedEOS