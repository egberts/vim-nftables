


hi link  nft_payload_raw_expr_via_payload_expr_set nftHL_Action
syn match  nft_payload_raw_expr_via_payload_expr_set "at" skipwhite contained
\ nextgroup=
\    nft_payload_base_spec_via_payload_expr_set


hi link   nft_payload_raw_len nftHL_Number
syn match nft_payload_raw_len "\v\d{1,11}" skipwhite contained
hi link   nft_payload_raw_len_via_payload_expr_set nftHL_Number
syn match nft_payload_raw_len_via_payload_expr_set "\v\d{1,11}" skipwhite contained

hi link   nft_payload_raw_expr_comma2 nftHL_Operator
syn match nft_payload_raw_expr_comma2 /,/ skipwhite contained
\ nextgroup=
\    nft_payload_raw_len
hi link   nft_payload_raw_expr_comma2_via_payload_expr_set nftHL_Operator
syn match nft_payload_raw_expr_comma2_via_payload_expr_set /,/ skipwhite contained
\ nextgroup=
\    nft_payload_raw_len

hi link   nft_payload_raw_expr_num nftHL_Number
syn match nft_payload_raw_expr_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_comma2
hi link   nft_payload_raw_expr_num_via_payload_expr_set nftHL_Number
syn match nft_payload_raw_expr_num_via_payload_expr_set "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_comma2_via_payload_expr_set

hi link   nft_payload_raw_expr_comma1 nftHL_Operator
syn match nft_payload_raw_expr_comma1 "\v," skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_num

hi link   nft_payload_raw_expr_comma1_via_payload_expr_set nftHL_Operator
syn match nft_payload_raw_expr_comma1_via_payload_expr_set "\v," skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_num_via_payload_expr_set

hi link   nft_payload_base_spec_hdrs nftHL_Action
syn match nft_payload_base_spec_hdrs "\v(ll|nh|th|hdr|string)" skipwhite contained
\ nextgroup=
\    nft_payload_raw_expr_comma1

" payload_base_spec (via payload_raw_expr)
syn cluster nft_c_payload_base_spec
\ contains=
\    nft_payload_base_spec_hdrs

" payload_raw_expr (via payload_expr)
hi link   nft_payload_raw_expr nftHL_Statement
syn match nft_payload_raw_expr "\v \zsat\ze " skipwhite contained
\ nextgroup=
\    @nft_c_payload_base_spec