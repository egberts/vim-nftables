


"""""""""""""""""" rename_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd 'rename' 'chain' chain_spec identifier
" base_cmd 'rename' 'chain' [ family_spec ] table_id chain_id [ 'last' | <string> ]

hi link   nft_base_cmd_rename_chain_spec_table_spec_identifier nftHL_String
syn match nft_base_cmd_rename_chain_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipempty skipnl skipwhite contained
\ nextgroup=
\    nft_EOL,
\    nft_Semicolon,
\    nft_EOS

hi link   nft_base_cmd_rename_chain_spec_table_spec_chain_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_chain_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\     nft_base_cmd_rename_chain_spec_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_base_cmd_rename_chain_spec_table_spec_table_id nftHL_Identifier
syn match nft_base_cmd_rename_chain_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_spec_table_spec_chain_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_base_cmd_rename_chain_spec_table_spec_family_spec nftHL_Family
syn match nft_base_cmd_rename_chain_spec_table_spec_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_spec_table_spec_table_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

syn cluster nft_c_base_cmd_rename_chain_spec_table_spec
\ contains=
\    nft_base_cmd_rename_chain_spec_table_spec_family_spec,
\    nft_base_cmd_rename_chain_spec_table_spec_table_id

" base_cmd 'rename' 'chain' chain_spec
syn cluster nft_c_base_cmd_rename_chain_spec
\ contains=
\    @nft_c_base_cmd_rename_chain_spec_table_spec

" base_cmd 'rename' 'chain'
hi link   nft_base_cmd_rename_chain_keyword nftHL_Statement
syn match nft_base_cmd_rename_chain_keyword "chain" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_rename_chain_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

"""""""""""""""""" rename_cmd END """"""""""""""""""""""""""""""""""

" 'rename'->base_cmd->line
hi link   nft_base_cmd_keyword_rename nftHL_Command
syn match nft_base_cmd_keyword_rename "rename" skipwhite contained
\ nextgroup=
\    nft_base_cmd_rename_chain_keyword,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

