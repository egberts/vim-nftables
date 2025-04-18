


" 'reject' 'with' 'icmp' 'type'
" 'reject' 'with' 'icmpv6' 'type'
" reject_opts->reject_stmt->stmt

hi link   nft_reject_with_expr nftHL_Statement
syn match nft_reject_with_expr "type" skipwhite contained
\ nextgroup=
\    nft_keyword_string,
\    nft_integer_expr

" 'reject' 'with' 'icmp' 'type'
" 'reject' 'with' 'icmpv6' 'type'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_type nftHL_Statement
syn match nft_reject_opts_keyword_type "type" skipwhite contained
\ nextgroup=
\    nft_reject_with_expr

" 'reject' 'with' ('icmp'|'icmpv6')
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_icmp nftHL_Action
syn match nft_reject_opts_keyword_icmp "\vicmp[6]?" skipwhite contained
\ nextgroup=
\    nft_reject_opts_icmp_keyword_type,
\    nft_reject_with_expr

" 'reject' 'with' 'icmpx'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_icmpx nftHL_Action
syn match nft_reject_opts_keyword_icmpx "icmpx" skipwhite contained
\ nextgroup=
\    nft_reject_opts_icmp_keyword_type,
\    nft_reject_with_expr

" 'reject' 'with' 'tcp'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts_keyword_tcp nftHL_Action
syn match nft_reject_opts_keyword_tcp "\vtcp\s{1,15}reset" skipwhite contained

" 'reject' 'with'
" reject_opts->reject_stmt->stmt
hi link   nft_reject_opts nftHL_Statement
syn match nft_reject_opts "with" skipwhite contained
\ nextgroup=
\    nft_reject_opts_keyword_icmp,
\    nft_reject_opts_keyword_icmpx,
\    nft_reject_opts_keyword_tcp

hi link   nft_keyword_string nftHL_Command
syn match nft_keyword_string "string" skipwhite contained

" 'reject'
" reject_stmt_alloc->reject_stmt->stmt
hi link   nft_reject_stmt_keyword_reject nftHL_Command
syn match nft_reject_stmt_keyword_reject "reject" skipwhite contained
\ nextgroup=
\    nft_reject_opts

" 'reject'
" reject_stmt->stmt
syn cluster nft_c_reject_stmt
\ contains=
\    nft_reject_stmt_keyword_reject

