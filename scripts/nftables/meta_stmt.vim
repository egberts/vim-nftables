


" 'set'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_set nftHL_Command
syn match nft_meta_stmt_set "set" skipwhite contained
\ nextgroup=
\    nft_stmt_expr

" <string>->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_meta_string nftHL_Command
syn match nft_meta_stmt_meta_string "\v[a-zA-Z0-9\\\/_\.\-]{1,65}" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_set

" meta_key_unqualified->(meta_stmt|meta_key|meta_stmt)
" meta_key_unqualified->meta_key
hi link   nft_meta_key_meta_key_unqualified nftHL_Command
syn match nft_meta_key_meta_key_unqualified "\v(mark|iif(|name|type|group)|oif(|name|type|group)|skuid|skgid|nftrace|rtclassid|ibriport|obriport|ibridgename|obridgename|pkttype|cpu|cgroup|ipsec|time|day|hour)" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_meta_key_unqualified_set

" meta_key_qualified->meta_key->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_meta_key_qualified nftHL_Command
syn match nft_meta_stmt_meta_key_qualified "\v(length|protocol|priority|random|secmark)" skipwhite contained

" meta_key->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
syn cluster nft_c_meta_stmt_meta_key
\ contains=
\    nft_meta_stmt_meta_key_qualified,
\    nft_meta_stmt_meta_key_unqualified

" 'meta'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_meta nftHL_Command
syn match nft_meta_stmt_meta "meta" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_meta_string,
\    nft_meta_stmt_meta_key

" 'set'->meta_key_unqualified->(meta_stmt|meta_key|meta_stmt)
hi link   nft_meta_stmt_meta_key_unqualified_set nftHL_Command
syn match nft_meta_stmt_meta_key_unqualified_set "set" skipwhite contained
\ nextgroup=
\    nft_stmt_expr

" 'notrack'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_notrack nftHL_Command
syn match nft_meta_stmt_notrack "notrack" skipwhite contained

hi link   nft_meta_stmt_at_string_unquoted nftHL_String
syn match nft_meta_stmt_at_string_unquoted "\v[a-zA-Z0-9\/\\\[\]\$]{1,64}" skipwhite keepend contained

hi link   nft_meta_stmt_at_string_sans_double_quote nftHL_String
syn match nft_meta_stmt_at_string_sans_double_quote "\v[a-zA-Z0-9\/\\\[\]\"]{1,64}" keepend contained

hi link   nft_meta_stmt_at_string_sans_single_quote nftHL_String
syn match nft_meta_stmt_at_string_sans_single_quote "\v[a-zA-Z0-9\/\\\[\]\']{1,64}" keepend contained

hi link   nft_meta_stmt_at_string_single nftHL_String
syn region nft_meta_stmt_at_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=
\    nft_meta_stmt_at_string_sans_single_quote

syn region nft_meta_stmt_at_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=
\    nft_meta_stmt_at_string_sans_double_quote

syn cluster nft_c_meta_stmt_at_quoted_string
\ contains=
\    nft_meta_stmt_at_string_single,
\    nft_meta_stmt_at_string_double

" <string>->'at'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_c_meta_stmt_at_string nftHL_String
syn cluster nft_c_meta_stmt_at_string
\ contains=
\    @nft_c_meta_stmt_at_quoted_string,
\    nft_meta_stmt_at_string_unquoted

" 'at'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_at nftHL_Command
syn match nft_meta_stmt_at "at" skipwhite contained
\ nextgroup=
\    @nft_c_meta_stmt_at_string

" 'add'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_add nftHL_Command
syn match nft_meta_stmt_add "add" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_at

" 'offload'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_offload nftHL_Command
syn match nft_meta_stmt_offload "offload" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_at

" 'flow'->meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
hi link   nft_meta_stmt_flow nftHL_Command
syn match nft_meta_stmt_flow "flow" skipwhite contained
\ nextgroup=
\    nft_meta_stmt_offload,
\    nft_meta_stmt_add

" meta_stmt->stmt->(rule_alloc|meter_stmt_alloc)
syn cluster nft_c_meta_stmt
\ contains=
\    nft_meta_stmt_meta,
\    nft_meta_stmt_meta_key_unqualified,
\    nft_meta_stmt_notrack,
\    nft_meta_stmt_flow
