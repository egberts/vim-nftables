


" objref_stmt->stmt
syn cluster nft_c_objref_stmt
\ contains=
\    nft_objref_stmt_counter,
\    nft_objref_stmt_limit,
\    nft_objref_stmt_quota,
\    nft_objref_stmt_synproxy,
\    nft_objref_stmt_keyword_ct

" SLE update


" 'ct' ('timeout'|'expectation') 'set'
" 'set'->objref_stmt_ct->objref_stmt->stmt
syn match nft_objref_stmt_keyword_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'ct' 'timeout'
" 'timeout'->objref_stmt_ct->objref_stmt->stmt
syn match nft_objref_stmt_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_ct_keyword_set

" 'ct' 'expectation'
" 'expectation'->objref_stmt_ct->objref_stmt->stmt
hi link   nft_objref_stmt_keyword_ct_keyword_expectation nftHL_Command
syn match nft_objref_stmt_keyword_ct_keyword_expectation "expectation" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_ct_keyword_set

" 'ct'
" objref_stmt_ct->objref_stmt->stmt
hi link   nft_objref_stmt_keyword_ct nftHL_Command
syn match nft_objref_stmt_keyword_ct "ct" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_keyword_ct_keyword_timeout,
\    nft_objref_stmt_keyword_ct_keyword_expectation

" 'synproxy' 'name'
" 'name'->objref_stmt_synproxy->objref_stmt->stmt
syn match nft_objref_stmt_synproxy_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'synproxy'
" objref_stmt_synproxy->objref_stmt->stmt
syn match nft_objref_stmt_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_synproxy_keyword_name

" 'quota' 'name'
" 'name'->objref_stmt_quota->objref_stmt->stmt
syn match nft_objref_stmt_quota_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'quota'
" objref_stmt_quota->objref_stmt->stmt
syn match nft_objref_stmt_quota "quota" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name

" 'limit' 'name'
" 'name'->objref_stmt_limit->objref_stmt->stmt
syn match nft_objref_stmt_limit_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'limit'
" objref_stmt_limit->objref_stmt->stmt
syn match nft_objref_stmt_limit "limit" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name

" 'counter' 'name'
" 'name'->objref_stmt_counter->objref_stmt->stmt
syn match nft_objref_stmt_counter_keyword_name "name" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr

" 'counter'
" objref_stmt_counter->objref_stmt->stmt
syn match nft_objref_stmt_counter "counter" skipwhite contained
\ nextgroup=
\    nft_objref_stmt_quota_keyword_name
