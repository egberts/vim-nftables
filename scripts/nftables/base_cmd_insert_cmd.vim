

" *************** BEGIN insert_cmd *******************
hi link   nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num nftHL_Number
syn match nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    @nft_c_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec "\v(position|handle|index)" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain nftHL_Chain
syn match nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec,
\    @nft_c_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_keywords_position_et_al_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table nftHL_Identifier
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain,
\    nft_Error,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_table_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'rule'->insert_cmd->'insert'->base_cmd->line
hi link   nft_base_cmd_keyword_insert_keyword_rule nftHL_Command
syn match nft_base_cmd_keyword_insert_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_family_spec_explicit,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_keyword_last,
\    nft_insert_cmd_keyword_rule_rule_position_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'insert'->base_cmd->line
hi link   nft_base_cmd_keyword_insert nftHL_Command
syn match nft_base_cmd_keyword_insert "insert" skipwhite contained
\ nextgroup=
\    nft_base_cmd_keyword_insert_keyword_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error


" *************** END insert_cmd *******************