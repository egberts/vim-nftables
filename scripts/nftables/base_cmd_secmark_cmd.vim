

" ******************* BEGIN base_cmd 'secmark' *************
" 'secmark'
syn cluster nft_c_add_cmd_keyword_secmark_obj_spec_table_spec
\ contains=
\    nft_add_cmd_secmark_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_secmark_obj_spec_table_spec_table_id
" TODO undefined nft_add_cmd_secmark_obj_spec_table_spec_family_spec_explicit

" 'secmark'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_secmark nftHL_Command
syn match nft_base_cmd_keyword_secmark "\vsecmark\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_secmark_obj_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'add' 'secmark'
" 'secmark'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_secmark nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_secmark "secmark" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_secmark_obj_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ******************* END base_cmd 'secmark' *************

" ******************* BEGIN base_cmd 'secmark' *************
" 'synproxy'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_synproxy nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_synproxy_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'synproxy'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_synproxy nftHL_Command
syn match nft_base_cmd_keyword_synproxy "\vsynproxy\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_synproxy_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ******************* END base_cmd 'secmark' *************