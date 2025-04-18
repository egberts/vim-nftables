

" 'mss' <NUM> 'wscale' [ 'timestamp' ] [ 'sack-perm' ]
" synproxy_sack->synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_synproxy_sack nftHL_Statement
syn match nft_synproxy_config_synproxy_sack "sack\-perm" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'mss' <NUM> 'wscale' [ 'timestamp' ]
" synproxy_ts->synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_synproxy_ts nftHL_Statement
syn match nft_synproxy_config_synproxy_ts "timestamp" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_wscale_num nftHL_Number
syn match nft_synproxy_config_keyword_wscale_num "num" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_ts,
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_wscale nftHL_Action
syn match nft_synproxy_config_keyword_wscale "wscale" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_wscale_num


hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator nftHL_Command
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator ";" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_synproxy_ts,
\    nft_synproxy_config_synproxy_sack,
\    nft_EOS

" 'mss' <NUM> 'wscale' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale_num nftHL_Number
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale_num "num" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_second_keyword_wscale_stmt_separator

" 'mss' <NUM> 'wscale'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_second_keyword_wscale nftHL_Action
syn match nft_synproxy_config_keyword_mss_second_keyword_wscale "wscale" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_second_keyword_wscale_num

hi link   nft_synproxy_config_keyword_mss_stmt_separator nftHL_Command
syn match nft_synproxy_config_keyword_mss_stmt_separator ";" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_second_keyword_wscale

" 'mss' <NUM>
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss_num nftHL_Number
syn match nft_synproxy_config_keyword_mss_num "num" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_keyword_wscale,
\    nft_synproxy_config_keyword_mss_stmt_separator

" 'mss'
" synproxy_config->(add_cmd|create_cmd|synproxy_block)
hi link   nft_synproxy_config_keyword_mss nftHL_Command
syn match nft_synproxy_config_keyword_mss "mss" skipwhite contained
\ nextgroup=
\    nft_synproxy_config_keyword_mss_num

syn cluster nft_synproxy_config
\ contains=
\    nft_synproxy_config_keyword_mss

" synproxy_arg->synproxy_stmt->stmt
hi link   nft_synproxy_arg nftHL_Action
syn match nft_synproxy_arg "\v(timestamp|sack\-perm|((mss|wscale)num))" skipwhite contained
\ nextgroup=
\    @nft_c_synproxy_arg

" 'synproxy'
" synproxy_stmt->stmt
syn match nft_synproxy_stmt_alloc "synproxy" skipwhite contained
\ nextgroup=
\    @nft_c_synproxy_arg

" 'synproxy'
" synproxy_stmt->stmt
syn cluster nft_c_synproxy_stmt
\ contains=
\    nft_synproxy_stmt
