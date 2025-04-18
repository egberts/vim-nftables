

"^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
" 'reset' 'set'
" 'reset' 'map'
" set_or_id_spec->'set'->reset_cmd->base_cmd->line
" set_or_id_spec->'map'->reset_cmd->base_cmd->line
"    nft_reset_cmd_keyword_set_set_or_id_spec
"    nft_reset_cmd_keyword_map_set_or_id_spec
"

" base_cmd 'reset' 'counters'
hi link   nft_base_cmd_reset_cmd_keyword_counters nftHL_Action
syn match nft_base_cmd_reset_cmd_keyword_counters "counters" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_base_cmd_reset_counters_quotas_table_keyword,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error



""""" BEGIN OF add_cmd/'reset' """""
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '{' ... '}'
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set nftHL_BlockDelimitersSet
syn region nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set start="{" end="}" skipwhite skipnl contained
\ nextgroup=
\    nft_EOL

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable "\$\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id 'handle' handle_identifier
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id nftHL_Number
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id "\v[0-9]{1,7}" skipwhite contained

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id 'handle'
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec nftHL_Handle
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec "handle" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_id

" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id nftHL_Set
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_handle_spec,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id_set

" base_cmd 'reset' [ 'set' | 'map' ] table_id
hi link   nft_base_cmd_reset_set_or_map_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_set_or_map_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id_spec_id

" base_cmd 'reset' [ 'set' | 'map' ] family_spec table_id
hi link   nft_base_cmd_reset_set_or_map_family_spec nftHL_Family
syn match nft_base_cmd_reset_set_or_map_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec_table_id

" base_cmd 'reset' [ 'set' | 'map' ]
hi link   nft_base_cmd_reset_set_or_map nftHL_Action
syn match nft_base_cmd_reset_set_or_map "\v(set|map)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_set_or_map_family_spec,
\    nft_base_cmd_reset_set_or_map_family_spec_table_id


" base_cmd 'reset' 'element' table_id spec_id '{' ... '}'
hi link   nft_base_cmd_reset_element_family_spec_table_id_spec_id_set nftHL_BlockDelimitersSet
syn region nft_base_cmd_reset_element_family_spec_table_id_spec_id_set start="{" end="}" skipwhite skipnl contained
\ nextgroup=
\    nft_Semicolon,
\    nft_EOL

" base_cmd 'reset' 'element' table_id spec_id $variable
hi link   nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable nftHL_Variable
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id

" base_cmd 'reset' 'element' table_id spec_id
hi link   nft_base_cmd_reset_element_family_spec_table_id_spec_id nftHL_Set
syn match nft_base_cmd_reset_element_family_spec_table_id_spec_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_variable,
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id_set

" base_cmd 'reset' 'element' table_id
hi link   nft_base_cmd_reset_element_family_spec_table_id nftHL_Table
syn match nft_base_cmd_reset_element_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id_spec_id

" base_cmd 'reset' 'element'
hi link   nft_base_cmd_reset_element_family_spec nftHL_Family
syn match nft_base_cmd_reset_element_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_element_family_spec_table_id

" base_cmd 'reset' 'rules' 'chain' <table_identifier> <chain_identifier>
hi link   nft_reset_cmd_keyword_rules_chain_spec_identifier_string nftHL_Chain
syn match nft_reset_cmd_keyword_rules_chain_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_EOS,
\    nft_Semicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' <table_identifier> 'last'
hi link   nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last nftHL_Chain
syn match nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_EOS,
\    nft_Semicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain' <table_identifier>
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string nftHL_Table
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_string,
\    nft_Semicolon,
\    nft_EOS

" base_cmd 'reset' 'rules' 'chain' 'last'
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_identifier_string,
\    nft_Semicolon,
\    nft_EOS

" base_cmd 'reset' 'rules' 'chain' family_spec_explicit
hi link   nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Error

" base_cmd 'reset' 'rules' 'chain'
hi link   nft_reset_cmd_keyword_rules_keyword_chain nftHL_Action
syn match nft_reset_cmd_keyword_rules_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_family_spec_explicit,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_keyword_last,
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Error

hi link   nft_reset_cmd_keyword_rules_table_spec_table_id nftHL_Table
syn match nft_reset_cmd_keyword_rules_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Semicolon,
\    nft_EOS

hi link   nft_reset_cmd_keyword_rules_table_spec_keyword_last nftHL_Action
syn match nft_reset_cmd_keyword_rules_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_chain_spec_table_spec_identifier_string,
\    nft_Semicolon,
\    nft_EOS


hi link   nft_reset_cmd_keyword_rules_table_spec_family_spec nftHL_Family
syn match nft_reset_cmd_keyword_rules_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_reset_cmd_keyword_rules_table_spec_keyword_last,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd 'reset' 'rules' 'table'
hi link   nft_reset_cmd_keyword_rules_keyword_table nftHL_Action
syn match nft_reset_cmd_keyword_rules_keyword_table "table" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_table_spec_family_spec,
\    nft_reset_cmd_keyword_rules_table_spec_keyword_last,
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_UnexpectedEOS,
\    nft_UnexpectedSemicolon,
\    nft_Error

" base_cmd 'reset' 'rules' family_spec_explicit <EOS>
hi link   nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_line_stmt_separator,
\    nft_EOS,

" base_cmd 'reset' 'rules'
hi link   nft_base_cmd_reset_rules nftHL_Statement
syn match nft_base_cmd_reset_rules "rules" skipwhite contained
\ nextgroup=
\    nft_reset_cmd_keyword_rules_ruleset_spec_family_spec_explicit,
\    nft_reset_cmd_keyword_rules_keyword_table,
\    nft_reset_cmd_keyword_rules_keyword_chain,
\    nft_reset_cmd_keyword_rules_table_spec_table_id,
\    nft_Error

" base_cmd 'reset' 'counter' obj_spec
" base_cmd 'reset' 'counter'/'quota' table_id chain_id
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_chain nftHL_Chain
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOS,

" base_cmd 'reset' 'counter'/'quota' 'table' identifier
hi link   nft_base_cmd_reset_counter_quota_obj_spec_id_table nftHL_Table
syn match nft_base_cmd_reset_counter_quota_obj_spec_id_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_obj_spec_id_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counter'/'quota' family_spec
hi link   nft_base_cmd_reset_counter_quota_family_spec nftHL_Family
syn match nft_base_cmd_reset_counter_quota_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'quota'
hi link   nft_base_cmd_reset_quota nftHL_Action
syn match nft_base_cmd_reset_quota "quota" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counter'
hi link   nft_base_cmd_reset_keyword_counter nftHL_Statement
syn match nft_base_cmd_reset_keyword_counter "counter " skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counter_quota_family_spec,
\    nft_base_cmd_reset_counter_quota_obj_spec_id_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier identifier
hi link   nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" base_cmd 'reset' 'counters'/'quotas' 'table' identifier
hi link   nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table nftHL_Identifier
syn match nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_table_table_spec_id_chain,

" base_cmd 'reset' 'counters'/'quotas' ruleset_spec
hi link   nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec nftHL_Family
syn match nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec "\v(ip6|ip|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'counters'/'quotas' 'table' table_spec
hi link   nft_base_cmd_reset_counters_quotas_table_keyword nftHL_Element
syn match nft_base_cmd_reset_counters_quotas_table_keyword "table" skipwhite contained
\ nextgroup=
\     nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\     nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'reset' 'quotas'
hi link   nft_base_cmd_reset_quotas nftHL_Action
syn match nft_base_cmd_reset_quotas "quotas" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_counters_quotas_ruleset_spec_family_spec,
\    nft_base_cmd_reset_counters_quotas_table_table_spec_identifier_table,
\    nft_base_cmd_reset_counters_quotas_table_keyword,


" base_cmd [ 'set' ]
""""" END OF add_cmd/'reset' """""

" 'reset'->base_cmd->line
hi link   nft_base_cmd_keyword_reset nftHL_Command
syn match nft_base_cmd_keyword_reset "reset" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_cmd_keyword_counters,
\    nft_base_cmd_reset_keyword_counter,
\    nft_get_et_al_cmd_keyword_element,
\    nft_base_cmd_reset_quotas,
\    nft_base_cmd_reset_quota,
\    nft_base_cmd_reset_rules,
\    nft_base_cmd_delete_destroy_reset_cmd_keyword_rule,
\    nft_base_cmd_reset_set_or_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error



" base_cmd 'reset' 'rule' table_id chain_id
hi link   nft_base_cmd_reset_rule_ruleset_spec_id_chain nftHL_Chain
syn match nft_base_cmd_reset_rule_ruleset_spec_id_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" base_cmd 'reset' 'rule' table_id
hi link   nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_id_table nftHL_Family
syn match nft_base_cmd_reset_cmd_keyword_rule_ruleset_spec_id_table "\v[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_base_cmd_reset_rule_ruleset_spec_id_chain