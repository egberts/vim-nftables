


" ****************** BEGIN delete_cmd ***********************
" 'delete' 'table' [ ip|ip6|inet|netdev|bridge|arp ] identifier
" 'last'->identifier->table_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier nftHL_Identifier
syn match nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedIdentifierChar,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table' [ ip|ip6|inet|netdev|bridge|arp ] 'last'
" 'last'->identifier->table_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table' 'handle' <NUM>
" <NUM>->'handle'->'table'->delete_cmd->'delete'->base_cmd->line
" <NUM>->tableid_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num nftHL_Number
syn match nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num "\v[0-9]{1,11}" skipwhite contained

" 'delete' 'table' 'handle'
" 'handle'>tableid_spec->table_or_id_spec->'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_table_table_or_id_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_table_table_or_id_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier,  " last match entry"
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete' 'table'
" 'table'->delete_cmd->'delete'->base_cmd->line
hi link   nft_delete_cmd_keyword_table nftHL_Statement
syn match nft_delete_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table_table_or_id_spec_family_spec,
\    nft_delete_cmd_keyword_table_table_or_id_spec_tableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_table_table_or_id_spec_table_spec_identifier,  " last match entry"
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain_chainid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_chain_chainid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain nftHL_Table
syn match nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block

hi link   nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain_chain_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_chain_chain_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_chain_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_chain_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_delete_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_delete_cmd_keyword_chain_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_chain_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_delete_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_delete_cmd_keyword_chain_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_chain_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_table_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_chain nftHL_Statement
syn match nft_delete_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_chain_table_spec_family_spec,
\    nft_delete_cmd_keyword_chain_table_spec_keyword_last,
\    nft_delete_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num nftHL_Number
syn match nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain nftHL_Chain
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_handle_spec_keyword_handle,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_identifier_string_chain,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_rule nftHL_Statement
syn match nft_delete_cmd_keyword_rule "rule" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_family_spec,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_keyword_last,
\    nft_delete_cmd_keyword_rule_ruleid_spec_chain_spec_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_set_setid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_set_setid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_set_set_spec_identifier_string_set nftHL_Table
syn match nft_delete_cmd_keyword_set_set_spec_identifier_string_set "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_set_setid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_set_setid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_num

hi link   nft_delete_cmd_keyword_set_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_set_set_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_set_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_set_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_keyword_handle,
\    nft_delete_cmd_keyword_set_set_spec_keyword_last,
\    nft_delete_cmd_keyword_set_set_spec_identifier_string_set
hi link   nft_delete_cmd_keyword_set_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_set_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_setid_spec_keyword_handle,
\    nft_delete_cmd_keyword_set_set_spec_keyword_last,
\    nft_delete_cmd_keyword_set_set_spec_identifier_string_set
hi link   nft_delete_cmd_keyword_set_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_set_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_table_spec_keyword_last,
\    nft_delete_cmd_keyword_set_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_set nftHL_Statement
syn match nft_delete_cmd_keyword_set "set" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_set_table_spec_family_spec,
\    nft_delete_cmd_keyword_set_table_spec_keyword_last,
\    nft_delete_cmd_keyword_set_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_map_spec_identifier_string_map nftHL_Table
syn match nft_delete_cmd_keyword_map_map_spec_identifier_string_map "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_map_map_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_map_map_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_map_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_map_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_map_spec_keyword_last,
\    nft_delete_cmd_keyword_map_map_spec_identifier_string_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_map_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_map_spec_keyword_last,
\    nft_delete_cmd_keyword_map_map_spec_identifier_string_map,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_map_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_table_spec_keyword_last,
\    nft_delete_cmd_keyword_map_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_map nftHL_Statement
syn match nft_delete_cmd_keyword_map "map" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_map_table_spec_family_spec,
\    nft_delete_cmd_keyword_map_table_spec_keyword_last,
\    nft_delete_cmd_keyword_map_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_set_spec_identifier_string_element nftHL_Table
syn match nft_delete_cmd_keyword_element_set_spec_identifier_string_element "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_set_expr

hi link   nft_delete_cmd_keyword_element_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_element_set_spec_keyword_last "last" skipwhite contained
"\ nextgroup=
"\    nft_set_expr

hi link   nft_delete_cmd_keyword_element_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_element_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_set_spec_keyword_last,
\    nft_delete_cmd_keyword_element_set_spec_identifier_string_element,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_element_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_set_spec_keyword_last,
\    nft_delete_cmd_keyword_element_set_spec_identifier_string_element,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_element_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_table_spec_keyword_last,
\    nft_delete_cmd_keyword_element_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_element nftHL_Statement
syn match nft_delete_cmd_keyword_element "element" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_element_table_spec_family_spec,
\    nft_delete_cmd_keyword_element_table_spec_keyword_last,
\    nft_delete_cmd_keyword_element_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" flowtableflowtableflowtable
hi link   nft_delete_cmd_keyword_flowtable_flowtableid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_flowtable_flowtableid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable nftHL_Table
syn match nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flowtable_spec_flowtable_block

hi link   nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_num

hi link   nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_flowtable_flowtable_spec_flowtable_block

hi link   nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable,

hi link   nft_delete_cmd_keyword_flowtable_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_flowtable_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_flowtableid_spec_keyword_handle,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_flowtable_spec_identifier_string_flowtable

hi link   nft_delete_cmd_keyword_flowtable_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_flowtable_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_table_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_flowtable nftHL_Statement
syn match nft_delete_cmd_keyword_flowtable "flowtable" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_flowtable_table_spec_family_spec,
\    nft_delete_cmd_keyword_flowtable_table_spec_keyword_last,
\    nft_delete_cmd_keyword_flowtable_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" flowtableflowtableflowtable

hi link   nft_delete_cmd_keyword_counter_objid_spec_num nftHL_Handle
syn match nft_delete_cmd_keyword_counter_objid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter nftHL_Table
syn match nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_counter_objid_spec_keyword_handle nftHL_Action
syn match nft_delete_cmd_keyword_counter_objid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_num,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter_obj_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_counter_obj_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_counter_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_counter_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_keyword_handle,
\    nft_delete_cmd_keyword_counter_obj_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_obj_spec_identifier_string_counter,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter_table_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_counter_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_objid_spec_keyword_handle,
\    nft_delete_cmd_keyword_counter_obj_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_obj_spec_identifier_string_set

hi link   nft_delete_cmd_keyword_counter_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_counter_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_counter nftHL_Statement
syn match nft_delete_cmd_keyword_counter "counter" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_quota nftHL_Statement
syn match nft_delete_cmd_keyword_quota "quota" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct nftHL_Table
syn match nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_delete_cmd_keyword_ct_set_spec_keyword_last nftHL_Action
syn match nft_delete_cmd_keyword_ct_set_spec_keyword_last "last" skipwhite contained

hi link   nft_delete_cmd_keyword_ct_table_spec_identifier_string_table nftHL_Table
syn match nft_delete_cmd_keyword_ct_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_set_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct
hi link   nft_delete_cmd_keyword_ct_table_spec_keyword_last nftHL_Action

syn match nft_delete_cmd_keyword_ct_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_set_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_set_spec_identifier_string_ct

hi link   nft_delete_cmd_keyword_ct_table_spec_family_spec nftHL_Family
syn match nft_delete_cmd_keyword_ct_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_table_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct_obj_type_keywords nftHL_Statement
syn match nft_delete_cmd_keyword_ct_obj_type_keywords "\v(expectation|helper|timeout)" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_table_spec_family_spec,
\    nft_delete_cmd_keyword_ct_table_spec_keyword_last,
\    nft_delete_cmd_keyword_ct_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_ct nftHL_Statement
syn match nft_delete_cmd_keyword_ct "ct" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_ct_obj_type_keywords,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_limit nftHL_Statement
syn match nft_delete_cmd_keyword_limit "limit" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_secmark nftHL_Statement
syn match nft_delete_cmd_keyword_secmark "secmark" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_delete_cmd_keyword_synproxy nftHL_Statement
syn match nft_delete_cmd_keyword_synproxy "synproxy" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_counter_table_spec_family_spec,
\    nft_delete_cmd_keyword_counter_table_spec_keyword_last,
\    nft_delete_cmd_keyword_counter_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'delete'->base_cmd->line
hi link   nft_base_cmd_keyword_delete nftHL_Command
syn match nft_base_cmd_keyword_delete "delete" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table,
\    nft_delete_cmd_keyword_chain,
\    nft_delete_cmd_keyword_rule,
\    nft_delete_cmd_keyword_set,
\    nft_delete_cmd_keyword_map,
\    nft_get_et_al_cmd_keyword_element,
\    nft_delete_cmd_keyword_flowtable,
\    nft_delete_cmd_keyword_counter,
\    nft_delete_cmd_keyword_quota,
\    nft_delete_cmd_keyword_ct,
\    nft_delete_cmd_keyword_limit,
\    nft_delete_cmd_keyword_secmark,
\    nft_delete_cmd_keyword_synproxy,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error
" ****************** END delete_cmd ***********************