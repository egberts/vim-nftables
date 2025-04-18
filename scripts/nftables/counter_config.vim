


" num->'bytes'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_bytes_num nftHL_Number
syn match nft_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" 'bytes'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_bytes nftHL_Action
syn match nft_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_counter_config_bytes_num

" num->'packets'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config_packet_num nftHL_Number
syn match nft_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_counter_config_bytes

" 'packets'->counter_config->(add_cmd|counter_block|create_cmd)
hi link   nft_counter_config nftHL_Identifier
syn match nft_counter_config "packet" skipwhite contained
\ nextgroup=
\    nft_counter_config_packet_num
