

"""""""""""""""""" add_cmd BEGIN """"""""""""""""""""""""""""""""""
" 'add'

" 'table'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_table nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_spec

" 'table'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_table nftHL_Command
syn match nft_base_cmd_keyword_table "\v(^|table[ ]+)\zstable\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_table_spec

" 'chain'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_chain nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_chain_spec

" 'chain'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_chain nftHL_Command
syn match nft_base_cmd_keyword_chain "\vchain\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_chain_spec


" ***************** BEGIN base_cmd 'element' *****************
" ***************** END base_cmd 'element' *****************


source ../scripts/nftables/base_cmd_quota_cmd.vim
source ../scripts/nftables/base_cmd_quota_cmd.vim
source ../scripts/nftables/base_cmd_secmark_cmd.vim

" add_cmd-.'add'->base_cmd->line
" nft_c_base_cmd_add_cmd ordering DO matters: see `test/ct.nft` test file
syn cluster nft_c_base_cmd_add_cmd
\ contains=
\    nft_add_cmd_rule_position_family_spec_explicit,
\    nft_base_cmd_add_cmd_keyword_flowtable,
\    nft_base_cmd_add_cmd_keyword_synproxy,
\    nft_base_cmd_add_cmd_keyword_counter,
\    nft_get_et_al_cmd_keyword_element,
\    nft_base_cmd_add_cmd_keyword_secmark,
\    nft_base_cmd_add_cmd_keyword_quota,
\    nft_base_cmd_add_cmd_keyword_limit,
\    nft_base_cmd_add_cmd_keyword_table,
\    nft_base_cmd_add_cmd_keyword_chain,
\    nft_base_cmd_add_cmd_keyword_rule,
\    nft_base_cmd_add_cmd_keyword_map,
\    nft_base_cmd_add_cmd_keyword_set,
\    nft_base_cmd_add_cmd_keyword_ct,
\    nft_base_cmd_add_cmd_rule_position_table_spec_wildcard,
"\    nft_UnexpectedSemicolon,
"\    nft_UnexpectedEOS
" '', 'rule', 'add rule' forces nft_base_cmd_add_rule_position_table_spec to be the last 'contains=' entry!!!
"""""""""""""""""" add_cmd END """"""""""""""""""""""""""""""""""

"""""""""""""""""" base_cmd BEGIN """""""""""""""""""""""""""""""""""""""""""""""""
" 'add'->base_cmd->line
hi link   nft_base_cmd_keyword_add nftHL_Command
syn match nft_base_cmd_keyword_add "\vadd\ze " skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_add_cmd,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

