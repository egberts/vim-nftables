


syn cluster nft_c_counter_arg
\ contains=
\    nft_counter_arg

" 'packets'|'bytes' <NUM>
" <NUM>->counter_arg->counter_stmt->stateful_stmt
hi link   nft_counter_arg_num nftHL_Number
syn match nft_counter_arg_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_counter_arg

" 'packets'|'bytes'
" counter_arg->counter_stmt->stateful_stmt
hi link   nft_counter_arg nftHL_Statement
syn match nft_counter_arg "\v(packets|bytes)" skipwhite contained
\ nextgroup=
\    nft_counter_arg_num,
\    nft_Error

" 'counter'
" counter_stmt->stateful_stmt
hi link   nft_counter_stmt nftHL_Command
syn match nft_counter_stmt "counter" skipwhite contained
\ nextgroup=
\    nft_counter_arg
" TODO NOTE: eventually, one of counter_stmt and add_cmd_counter will have `^` to differentiate between

