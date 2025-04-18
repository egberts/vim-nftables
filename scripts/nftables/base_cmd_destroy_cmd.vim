

" **************** BEGIN destroy_cmd ***************
hi link   nft_destroy_cmd_keyword_chain_chainid_spec_num nftHL_Handle
syn match nft_destroy_cmd_keyword_chain_chainid_spec_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain nftHL_Table
syn match nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained

hi link   nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle nftHL_Action
syn match nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle "handle" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_chainid_spec_num

hi link   nft_destroy_cmd_keyword_chain_chain_spec_keyword_last nftHL_Action
syn match nft_destroy_cmd_keyword_chain_chain_spec_keyword_last "last" skipwhite contained

hi link   nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table nftHL_Table
syn match nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.]{0,63}" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_destroy_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_destroy_cmd_keyword_chain_table_spec_keyword_last nftHL_Action
syn match nft_destroy_cmd_keyword_chain_table_spec_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_chainid_spec_keyword_handle,
\    nft_destroy_cmd_keyword_chain_chain_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_chain_spec_identifier_string_chain

hi link   nft_destroy_cmd_keyword_chain_table_spec_family_spec nftHL_Family
syn match nft_destroy_cmd_keyword_chain_table_spec_family_spec "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_table_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_destroy_cmd_keyword_chain nftHL_Statement
syn match nft_destroy_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_destroy_cmd_keyword_chain_table_spec_family_spec,
\    nft_destroy_cmd_keyword_chain_table_spec_keyword_last,
\    nft_destroy_cmd_keyword_chain_table_spec_identifier_string_table,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" 'destroy'->base_cmd->line
hi link   nft_base_cmd_keyword_destroy nftHL_Command
syn match nft_base_cmd_keyword_destroy "destroy" skipwhite contained
\ nextgroup=
\    nft_delete_cmd_keyword_table,
\    nft_destroy_cmd_keyword_chain,
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
" **************** END destroy_cmd ***************

" 'delete' 'set' table_spec 'handle' <NUM>
" 'destroy' 'set' table_spec 'handle' <NUM>
" setid_spec->'set'->(delete_cmd|destroy_cmd)->('destroy'|'delete')->base_cmd->line
syn cluster nft_delete_destroy_cmd_keyword_set_family_spec
\ contains=
\    nft_delete_destroy_cmd_keyword_set_setid_spec_family_spec,
\    nft_delete_destroy_cmd_keyword_set_setid_spec_table_id

" 'delete' 'set' setid_spec
" 'destroy' 'set' setid_spec
" set_or_id_spec->'set'->(delete_cmd|destroy_cmd)->('destroy'|'delete')->base_cmd->line
syn cluster nft_delete_destroy_cmd_keyword_set_set_or_id_spec_setid_spec
\ contains=
\    nft_delete_destroy_cmd_keyword_set_setid_spec_family_spec,
\    nft_delete_destroy_cmd_keyword_set_setid_spec_table_id