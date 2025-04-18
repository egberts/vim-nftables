

" ***************** BEGIN 'add' 'flowtable' ***************

source ../scripts/nftables/flowtable_block.vim


" [ 'add' ] 'flowtable' table_id flow_id '{' flowtable_block
" flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link    nft_flowtable_spec_flowtable_block nftHL_BlockDelimitersFlowTable
syn region nft_flowtable_spec_flowtable_block start="{" end="}" skipwhite contained
\ nextgroup=
\    nft_comment_inline,
\    nft_Semicolon,
\    nft_EOS,
\    nft_Error
\ contains=
\    @nft_c_flowtable_block,
\    @nft_c_common_block,
\    nft_flowtable_block_stmt_separator,
\    nft_Error
"\    nft_flowtable_spec_flowtable_block_counter,
"\    nft_flowtable_spec_flowtable_block_devices,
"\    nft_flowtable_spec_flowtable_block_flags,
"\    nft_flowtable_spec_flowtable_block_hook,

" base_cmd add_cmd 'flowtable' flowtable_spec identifier (chain)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable nftHL_Chain
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flowtable_spec_flowtable_block,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_identifier_flowtable,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd [ 'add' ] 'flowtable' flowtable_spec table_spec
syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec_table_spec
\ contains=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_flowtable_flowtable_spec_table_spec_family_spec_identifier_table,

" base_cmd [ 'add' ] 'flowtable' flowtable_spec
syn cluster nft_c_add_cmd_keyword_flowtable_flowtable_spec
\ contains=@nft_c_add_cmd_keyword_flowtable_flowtable_spec_table_spec
" ***************** END 'add' 'flowtable' ***************

" ***************** BEGIN base_cmd 'flowtable' *****************
" 'flowtable'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_flowtable nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_flowtable "flowtable" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_flowtable_flowtable_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'flowtable'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_flowtable nftHL_Command
syn match nft_base_cmd_keyword_flowtable "\vflowtable\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_flowtable_flowtable_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" ***************** END base_cmd 'flowtable' *****************