


""""" BEGIN OF add_cmd_/'chain'/chain_spec """""
" add_cmd 'chain' table_identifier [ chain_identifier | 'last' ]
hi link   nft_add_cmd_chain_spec_chain_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup= nft_add_cmd_keyword_table_table_block_chain_chain_block
" nft_add_cmd_chain_chain_block

hi link   nft_add_cmd_chain_spec_chain_last nftHL_Command
syn match nft_add_cmd_chain_spec_chain_last "last" skipwhite contained
\ nextgroup=
\     nft_add_cmd_keyword_table_table_block_chain_chain_block
"\ nextgroup=
"\    nft_add_cmd_chain_chain_block

" add_cmd 'chain' chain_spec table_identifier
hi link   nft_add_cmd_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ contains=
\    nft_keyword_last
\ nextgroup=
\    nft_add_cmd_chain_spec_chain_last,
\    nft_add_cmd_chain_spec_chain_id
" This is really interesting, reusing a chain_block may work after all TODO"

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_cmd_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_chain_spec_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_chain_spec_table_spec_table_id

" base_cmd add_cmd 'chain' chain_spec
syn cluster nft_c_add_cmd_chain_spec
\ contains=
\    nft_add_cmd_chain_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_chain_spec_table_spec_table_id

""""" END OF add_cmd_/'chain'/chain_spec """""