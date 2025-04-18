

" ******************* BEGIN base_cmd 'add quota' *************
hi link    nft_add_cmd_quota_block nft_BlockDelimitersQuota
syn region nft_add_cmd_quota_block start="{" end="}" skip="\\}" skipwhite contained
\ contains=
\    @nft_c_quota_config,
\    @nft_c_common_block,
\    nft_stmt_separator,
\    nft_comment_spec

hi link   nft_add_cmd_quota_cmd_obj_spec_identifier_string nft_Identifier
syn match nft_add_cmd_quota_cmd_obj_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    @nft_c_quota_config,
\    nft_add_cmd_quota_block

hi link   nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    @nft_c_quota_config,
\    nft_add_cmd_quota_block

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'quota'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_quota nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_quota "quota" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string_unknown,
\    nft_add_cmd_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" ******************* END base_cmd 'add quota' *************

" ******************* BEGIN base_cmd 'quota' *************
hi link   nft_quota_cmd_obj_spec_identifier_string nft_Identifier
syn match nft_quota_cmd_obj_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_block,
\    nft_quota_config_quota_mode,
\    nft_quota_config_num

hi link   nft_quota_cmd_obj_spec_identifier_keyword_last nftHL_Action
syn match nft_quota_cmd_obj_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_quota_block,
\    nft_quota_config_quota_mode,
\    nft_quota_config_num

hi link   nft_quota_cmd_obj_spec_table_spec_identifier_string nftHL_Identifier
syn match nft_quota_cmd_obj_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_quota_cmd_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_quota_cmd_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'quota'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_quota nftHL_Command
syn match nft_base_cmd_keyword_quota "\vquota\ze " skipwhite contained
\ nextgroup=
\    nft_quota_cmd_obj_spec_table_spec_identifier_keyword_last,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_quota_cmd_obj_spec_table_spec_family_spec_explicit,
\    nft_quota_cmd_obj_spec_table_spec_identifier_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
" ******************* END base_cmd 'quota' *************