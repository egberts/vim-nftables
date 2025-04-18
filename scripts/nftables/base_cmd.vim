" base_cmd Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     2.0
" Initial Date: 2025-04-18
" Last Change:  2025-04-18
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
"
"  WARNING:  Do not add online comments using a quote symbol, it ALTERS patterns
"
"


" base_cmd->line
syn cluster nft_c_base_cmd
\ contains=
\    nft_base_cmd_keyword_flowtable,
\    nft_base_cmd_keyword_counter,
\    nft_base_cmd_keyword_describe,
\    nft_base_cmd_keyword_replace,
\    nft_base_cmd_keyword_synproxy,
\    nft_get_et_al_cmd_keyword_element,
\    nft_base_cmd_keyword_destroy,
\    nft_base_cmd_keyword_monitor,
\    nft_base_cmd_keyword_create,
\    nft_base_cmd_keyword_secmark,
\    nft_base_cmd_keyword_insert,
\    nft_base_cmd_keyword_delete,
\    nft_base_cmd_keyword_rename,
\    nft_base_cmd_keyword_chain,
\    nft_base_cmd_keyword_import,
\    nft_base_cmd_keyword_export,
\    nft_base_cmd_keyword_limit,
\    nft_base_cmd_keyword_flush,
\    nft_base_cmd_keyword_reset,
\    nft_base_cmd_keyword_quota,
\    nft_base_cmd_keyword_table,
\    nft_base_cmd_keyword_list,
\    nft_base_cmd_keyword_rule,
\    nft_base_cmd_keyword_get,
\    nft_base_cmd_keyword_map,
\    nft_base_cmd_keyword_set,
\    nft_base_cmd_keyword_add,
\    nft_base_cmd_keyword_ct,
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_base_cmd_rule_position_table_spec_wildcard,
