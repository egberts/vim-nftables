


" socket_key->socket_expr->(primary_expr|primary_stmt_expr)
hi link   nft_socket_expr_socket_key nftHL_Action
syn match nft_socket_expr_socket_key "\v(transparent|mark|wildcard)" skipwhite contained

" 'cgroupv2' <num>->socket_expr->(primary_expr|primary_stmt_expr)
hi link   nft_socket_expr_cgroupv2_num nftHL_Action
syn match nft_socket_expr_cgroupv2_num "\v[0-9]{1,11}" skipwhite contained

" 'level'->socket_expr->(primary_expr|primary_stmt_expr)
hi link   nft_socket_expr_cgroupv2_level nftHL_Action
syn match nft_socket_expr_cgroupv2_level "level" skipwhite contained
\ nextgroup=
\    nft_socket_expr_cgroupv2_num

" 'cgroupv2'->socket_expr->(primary_expr|primary_stmt_expr)
hi link   nft_socket_expr_cgroupv2 nftHL_Command
syn match nft_socket_expr_cgroupv2 "cgroupv2" skipwhite contained
\ nextgroup=
\    nft_socket_expr_level

" socket_expr->(primary_expr|primary_stmt_expr)
hi link   nft_socket_expr nftHL_Action
syn match nft_socket_expr "socket" skipwhite contained
\ nextgroup=
\    nft_socket_expr_socket_key,
\    nft_socket_expr_socket_cgroupv2
