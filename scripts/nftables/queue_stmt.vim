


" ( 'bypass' | 'fanout' ) ','
hi link   nft_c_queue_stmt_flags_comma nftHL_Operator
syn match nft_queue_stmt_flags_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_flags

" 'bypass' | 'fanout'
" queue_stmt_flag->queue_stmt_flags
hi link   nft_c_queue_stmt_flag nftHL_Action
syn match nft_queue_stmt_flag "\v(bypass|fanout)" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_flags_comma

" ( 'bypass' | 'fanout' ) ',' ( 'bypass' | 'fanout' )
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
syn cluster nft_c_queue_stmt_flags
\ contains=
\    nft_queue_stmt_flag

" 'numgen'
" 'jhash' | 'symhash'
" 'map'
" <NUM>
" $<variable>
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
" <integer> | $<variable>
" 'queue' 'flags' ('bypass'|'fanout') 'num' queue_stmt_expr_simple
syn cluster nft_c_queue_stmt_expr_simple
\ contains=
\    nft_queue_stmt_expr_simple_integer,
\    nft_queue_stmt_expr_simple_variable

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM> [ 'offset' <NUM> ]
" <NUM>->offset_opt->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_offset_opt_num nftHL_Number
syn match nft_queue_stmt_expr_numgen_expr_offset_opt_num "\v\d{1,11}" skipwhite contained

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM> [ 'offset' ]
" offset_opt->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_offset_opt nftHL_Action
syn match nft_queue_stmt_expr_numgen_expr_offset_opt "offset" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_expr_numgen_expr_offset_opt_num

" 'numgen' ( 'inc' | 'random' ) 'mod' <NUM>
" <NUM>->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_num nftHL_Number
syn match nft_queue_stmt_expr_numgen_expr_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_expr_numgen_expr_offset_opt

" 'numgen' ( 'inc' | 'random' ) 'mod'
" 'mod'->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_mod nftHL_Action
syn match nft_queue_stmt_expr_numgen_expr_mod "mod" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_expr_numgen_expr_num

" 'numgen' ( 'inc' | 'random' )
" numgen_type->numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr_type nftHL_Statement
syn match nft_queue_stmt_expr_numgen_expr_type "\v(inc|random)" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_expr_numgen_expr_mod

" 'numgen'
" numgen_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_numgen_expr nftHL_Command
syn match nft_queue_stmt_expr_numgen_expr "numgen" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_expr_numgen_expr_type

" 'queue' 'jhash'
" hash_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_hash_expr_jhash nftHL_Command
syn match nft_queue_stmt_expr_hash_expr_jhash "jhash" skipwhite contained
\ nextgroup=
\    nft_hash_expr_jhash_expr

" 'queue' 'symhash'
" 'symhash'->hash_expr->queue_stmt_expr->queue_stmt->stmt
hi link   nft_queue_stmt_expr_hash_expr_symhash nftHL_Command
syn match nft_queue_stmt_expr_hash_expr_symhash "symhash" skipwhite contained

" 'queue'
" 'queue' 'to' queue_stmt_expr
" queue_stmt_expr->queue_stmt->stmt
syn cluster nft_c_queue_stmt_expr
\ contains=
\    nft_queue_stmt_expr_numgen_expr,
\    @nft_c_hash_expr,
\    nft_queue_stmt_expr_map_expr,
\    @nft_c_queue_stmt_expr_simple

" 'queue' ( 'bypass' | 'fanout' ) [ ',' ('bypass'|'fanout') ]
" queue_stmt_flag->queue_stmt_flags->queue_stmt_arg->queue_stmt_compat->queue_stmt->stmt
syn cluster nft_c_queue_stmt_compat_flags
\ contains=
\    @nft_c_queue_stmt_flags

" 'QUEUENUM'->queue_stmt_arg->queue_stmt_compat->queue_stmt->stmt
hi link   nft_c_queue_stmt_compat_arg_queuenum nftHL_Statement
syn match nft_c_queue_stmt_compat_arg_queuenum "num" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr_simple

" 'queue' 'to'
" 'to'->'queue'->queue_stmt->stmt
hi link   nft_c_queue_stmt_keyword_to nftHL_Statement
syn match nft_c_queue_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr

" ( 'bypass' | 'fanout' ) ','
hi link   nft_queue_stmt_keyword_flags_queue_stmt_flags_comma nftHL_Operator
syn match nft_queue_stmt_keyword_flags_queue_stmt_flags_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_keyword_flags_queue_stmt_flags

" 'queue' 'flags' ('bypass'|'fanout') 'to' queue_stmt_expr
" 'to'->queue_stmt_flag->queue_stmt_flags
hi link   nft_queue_stmt_keyword_flags_queue_stmt_keyword_to nftHL_Action
syn match nft_queue_stmt_keyword_flags_queue_stmt_keyword_to "to" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr

" 'queue' 'flags' ('bypass'|'fanout') 'num' queue_stmt_expr_simple
" 'num'->queue_stmt->stmt
hi link   nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword nftHL_Command
syn match nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword "num" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_expr_simple

" 'bypass' | 'fanout'
" queue_stmt_flag->queue_stmt_flags
hi link   nft_queue_stmt_keyword_flags_queue_stmt_flag nftHL_Action
syn match nft_queue_stmt_keyword_flags_queue_stmt_flag "\v(bypass|fanout)" skipwhite contained
\ nextgroup=
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_keyword_to,
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_queuenum_keyword,
\    nft_queue_stmt_keyword_flags_queue_stmt_flags_comma

" ( 'bypass' | 'fanout' ) ',' ( 'bypass' | 'fanout' )
" queue_stmt_flags->(queue_stmt|queue_stmt_arg)
syn cluster nft_c_queue_stmt_keyword_flags_queue_stmt_flags
\ contains=
\    nft_queue_stmt_keyword_flags_queue_stmt_flag

" 'queue' 'flags'
" 'flags'->'queue'->queue_stmt->stmt
hi link   nft_c_queue_stmt_keyword_flags nftHL_Statement
syn match nft_c_queue_stmt_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_keyword_flags_queue_stmt_flags

" 'queue'
" 'queue'->queue_stmt->stmt
hi link   nft_queue_stmt nftHL_Command
syn match nft_queue_stmt "queue" skipwhite contained
\ nextgroup=
\    @nft_c_queue_stmt_compat_flags,
\    @nft_c_queue_stmt_compat_arg_queuenum,
\    nft_c_queue_stmt_keyword_to,
\    nft_c_queue_stmt_keyword_flags

syn cluster nft_c_queue_stmt
\ contains=
\    nft_queue_stmt

