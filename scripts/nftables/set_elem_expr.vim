


" set_lhs_expr->set_elem_key_expr
syn cluster nft_c_set_lhs_expr
\ contains=
\    @nft_c_concat_rhs_expr

" time_spec->set_elem_expr_option->set_elem_expr
hi link   nft_set_elem_expr_option_time_spec nftHL_String
syn match nft_set_elem_expr_option_time_spec "\v\s{1,64}" skipwhite contained

" set_elem_expr_option->set_elem_expr
hi link   nft_set_elem_expr_option_expires nftHL_Element
syn match nft_c_set_elem_expr_timeout_expires "\v(timeout|expires)" skipwhite contained
\ nextgroup=
\    nft_set_elem_expr_option_time_spec

" set_elem_expr_option->set_elem_expr
syn cluster nft_c_set_elem_expr_option
\ contains=
\    nft_set_elem_expr_option_timeout_expires,
\    nft_comment_spec

" 'counter' 'packets' <NUM> 'bytes' <NUM>
"nnum->'bytes'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_counter_bytes_num nftHL_Number
syn match nft_set_elem_stmt_counter_bytes_num "\v\d{1,11}" skipwhite contained

" 'counter' 'packets' <NUM> 'bytes'
" 'bytes'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_counter_bytes nftHL_Action
syn match nft_set_elem_stmt_counter_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_bytes_num

" 'counter' 'packets' <NUM>
" num->'packets'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_counter_packets_num nftHL_Number
syn match nft_set_elem_stmt_counter_packets_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_bytes

" 'counter' 'packets'
" 'packets'->'counter'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_counter_packets nftHL_Action
syn match nft_set_elem_stmt_counter_packets "packets" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_packets_num

" 'counter'
" 'counter'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_counter nftHL_Command
syn match nft_set_elem_stmt_counter "counter" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_counter_packets

" 'rate'->'limit'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit_rate nftHL_Command
syn match nft_set_elem_stmt_limit_rate "rate" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate_limit_mode

" 'limit'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_limit nftHL_Command
syn match nft_set_elem_stmt_limit "limit" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_limit_rate

" 'num'->'ct'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_ct_num nftHL_Number
syn match nft_set_elem_stmt_ct_num "\v[0-9]{1,11}" skipwhite contained

" 'count'->'ct'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_ct_count nftHL_Command
syn match nft_set_elem_stmt_ct "count" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_ct_over,
\    nft_set_elem_stmt_ct_num

" 'ct'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_ct nftHL_Command
syn match nft_set_elem_stmt_ct "ct" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_ct_count

" quota_unit->quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_used_unit nftHL_Action
syn match nft_set_elem_stmt_quota_used_unit "\v(bytes|strings)" skipwhite contained

" quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_used_num nftHL_Number
syn match nft_set_elem_stmt_quota_used_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_unit_used

" quota_used->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_used nftHL_Action
syn match nft_set_elem_stmt_quota_used "used" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_used_num,
\    nft_Error_Always

" quota_unit->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_unit nftHL_Action
syn match nft_set_elem_stmt_quota_unit "\v(bytes|strings)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_used

" num->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_num nftHL_Number
syn match nft_set_elem_stmt_quota_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_unit

" 'over/under'->'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota_mode nftHL_Action
syn match nft_set_elem_stmt_quota_mode "\v(over|until)" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_num

" 'quota'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_quota nftHL_Command
syn match nft_set_elem_stmt_quota "quota" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_quota_mode,
\    nft_set_elem_stmt_quota_num

" time_spec->'last'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_last_time_spec nftHL_Number
syn match nft_set_elem_stmt_last_time_spec "\v\s{1,16}" skipwhite contained

" 'never'->'last'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_last_never nftHL_Action
syn match nft_set_elem_stmt_last_never "never" skipwhite contained

" 'used'->'last'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_last_used nftHL_Command
syn match nft_set_elem_stmt_last_used "used" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_last_never,
\    nft_set_elem_stmt_last_time_spec

" 'last'->set_elem_stmt->set_elem_expr_alloc
hi link   nft_set_elem_stmt_last nftHL_Command
syn match nft_set_elem_stmt_last "last" skipwhite contained
\ nextgroup=
\    nft_set_elem_stmt_last_used

syn cluster nft_c_set_elem_stmt
\ contains=
\    nft_set_elem_stmt_counter,
\    nft_set_elem_stmt_limit,
\    nft_set_elem_stmt_ct,
\    nft_set_elem_stmt_quota,
\    nft_set_elem_stmt_last

" time_spec->set_elem_option->set_elem_options
hi link   nft_set_elem_option_time_spec nftHL_Number
syn match nft_set_elem_option_time_spec "\v\s{1,16}" skipwhite contained

hi link   nft_set_elem_option_timeout_expires nftHL_Action
syn match nft_set_elem_option_timeout_expires "\v(timeout|expires)" skipwhite contained
\ nextgroup=
\    nft_set_elem_option_time_spec

" set_elem_option->set_elem_options
syn cluster nft_c_set_elem_option
\ contains=
\    nft_set_elem_option_timeout_expires,
\    @nft_comment_spec

" set_elem_options->(meter_key_expr|set_elem_expr_stmt)
syn cluster nft_c_set_elem_options
\ contains=
\    @nft_c_set_elem_option

" set_elem_stmt->set_elem_expr_alloc->set_elem_expr
syn cluster nft_c_set_elem_expr_alloc
\ contains=
\    @nft_c_set_elem_key_expr

" set_elem_expr_alloc->set_elem_expr
syn cluster nft_c_set_elem_expr_alloc
\ contains=
\    @nft_c_set_elem_key_expr,
\    @nft_c_set_elem_stmt
" TODO make set_elem_key_expr start firstly before any set_elem_stmt

" '*'->set_elem_key_expr->set_elem_expr_alloc
hi link   nft_set_elem_key_expr_asterisk nftHL_Expression
syn match nft_set_elem_key_expr_asterisk "\*" skipwhite contained

" set_elem_key_expr->set_elem_expr_alloc
syn cluster nft_c_set_elem_key_expr
\ contains=
\    nft_set_elem_key_expr_asterisk,
\    @nft_c_set_lhs_expr

" set_elem_expr_option->set_elem_expr->(set_list_member_expr|verdict_map_list_member_expr)
syn cluster nft_c_set_elem_expr_set_elem_expr_alloc
\ contains=
\    @nft_c_set_elem_expr_set_elem_expr_alloc
" TODO expand dual-logic of set_elem_expr_alloc specifically set_elem_expr_optionsset_elem_stmt_list

" set_elem_expr->(set_list_member_expr|verdict_map_list_member_expr)
syn cluster  nft_c_set_elem_expr
\ contains=
\    @nft_c_set_elem_expr_set_elem_expr_alloc

