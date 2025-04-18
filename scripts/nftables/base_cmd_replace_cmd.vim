

"""""""""""""""""" replace_cmd BEGIN """"""""""""""""""""""""""""""""""

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier rule
syn cluster nft_c_base_cmd_replace_rule_alloc_stmt
\ contains=
\    @nft_c_payload_stmt,
\    @nft_c_stmt,
\    @nft_c_base_cmd_replace_rule_alloc_stmt

syn cluster nft_c_base_cmd_replace_rule_alloc
\ contains=
\    @nft_c_base_cmd_replace_rule_alloc_stmt,
\    @nft_comment_spec

syn cluster nft_c_base_cmd_replace_rule
\ contains=
\    @nft_c_base_cmd_replace_rule_alloc

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id nftHL_Handle
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id "\v[0-9]{1,9}" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_replace_rule,
\    nft_Error

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier handle_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index nftHL_Action
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index "\v(position|index|handle)\s" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_handle_id

" base_cmd 'replace' [ family_spec ] table_identifier chain_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id nftHL_Chain
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id "\v[a-zA-Z0-9\\\/_\.\-]{1,64}\s+" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keywords_handle_position_index,
\    @nft_c_payload_stmt
"\    nft_ip_hdr_expr via @nft_c_payload_stmt
"\    @nft_c_rule

" base_cmd 'replace' [ family_spec ] table_identifier
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id nftHL_Table
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id "\v[a-zA-Z0-9\\\/_\.\-]{1,64}\s+" contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_chain_id,

" base_cmd 'replace' family_spec
hi link   nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family nftHL_Family
syn match nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family "\v(ip6|ip|inet|bridge|netdev|arp)\s+" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id,
\    nft_UnexpectedIdentifierChar,

" base_cmd 'replace' [ family_spec ]
syn cluster nft_c_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec
\ contains=
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec_family,
\    nft_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_table_id

" base_cmd 'replace' 'rule'
hi link   nft_replace_cmd_keyword_rule nftHL_Statement
syn match nft_replace_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    @nft_c_replace_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

"""""""""""""""""" replace_cmd END """"""""""""""""""""""""""""""""""



" 'replace'->base_cmd->line
hi link   nft_base_cmd_keyword_replace nftHL_Command
syn match nft_base_cmd_keyword_replace "replace" skipwhite contained
\ nextgroup=
\    nft_replace_cmd_keyword_rule,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

