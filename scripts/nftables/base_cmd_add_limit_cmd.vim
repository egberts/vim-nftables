


" ***************** BEGIN base_cmd 'limit' ********************
" base_cmd add_cmd 'limit' <table_id> <limit_id>
hi link    nft_add_cmd_limit_obj_spec_limit_identifier nftHL_Identifier
syn match nft_add_cmd_limit_obj_spec_limit_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_limit_block,
\    nft_limit_config
" TODO: limit_block
" TODO: undefined nft_add_cmd_limit_limit_block

" base_cmd add_cmd 'limit' table_spec
hi link    nft_add_cmd_limit_obj_spec_table_identifier nftHL_Identifier
syn match nft_add_cmd_limit_obj_spec_table_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_limit_identifier

" base_cmd add_cmd 'limit' ('ip'|'ip6'|'inet'|'arp'|'bridge'|'netdev')
" base_cmd add_cmd 'limit' family_spec
hi link   nft_add_cmd_limit_obj_spec_family_spec nftHL_Family
syn match nft_add_cmd_limit_obj_spec_family_spec "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd add_cmd 'limit' obj_spec
syn cluster nft_c_add_cmd_limit_obj_spec
\ contains=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd 'add' add_cmd 'limit'
hi link   nft_base_cmd_add_cmd_keyword_limit nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_limit "limit" skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier

" base_cmd add_cmd 'limit'
hi link   nft_base_cmd_keyword_limit nftHL_Command
syn match nft_base_cmd_keyword_limit "\vlimit\ze " skipwhite contained
\ nextgroup=
\    nft_add_cmd_limit_obj_spec_family_spec,
\    nft_add_cmd_limit_obj_spec_table_identifier
" ***************** END base_cmd 'limit' ********************
