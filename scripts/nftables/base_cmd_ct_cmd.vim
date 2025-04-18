

" **************** BEGIN ct_cmd *******************
hi link   nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_identifier nftHL_Table
syn match nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
" TODO: undefined ct_expectation_block

hi link   nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_table_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_table_spec_identifier_table "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_identifier

" base_cmd 'ct' 'expectation' obj_spec table_spec
hi link   nft_base_cmd_add_ct_expectation_obj_spec_table_spec nftHL_Command
syn match nft_base_cmd_add_ct_expectation_obj_spec_table_spec "\v(ip[6]|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_table_spec_identifier_table

" base_cmd 'ct' 'expectation' obj_spec
syn cluster nft_c_base_cmd_add_ct_expectation_obj_spec
\ contains=
\    nft_base_cmd_add_ct_expectation_obj_spec_table_spec,
\    nft_add_cmd_keyword_ct_keyword_expectation_obj_spec_table_spec_identifier_table

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
hi link   nft_base_cmd_add_ct_keyword_expectation nftHL_Command
syn match nft_base_cmd_add_ct_keyword_expectation "expectation" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_add_ct_expectation_obj_spec

hi link    nft_add_cmd_keyword_ct_keyword_timeout_ct_timeout_block nftHL_BlockDelimitersCT
syn region nft_add_cmd_keyword_ct_keyword_timeout_ct_timeout_block start="{" end="}" skip="\\[\{\}]"  skipwhite contained
\ contains=
\    @nft_c_ct_timeout_config

hi link   nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_identifier nftHL_Chain
syn match nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_timeout_ct_timeout_block

hi link   nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_table_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_table_spec_identifier_table "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_identifier

" base_cmd 'ct' 'timeout' obj_spec table_spec
hi link   nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_table_spec_identifier_table

" base_cmd 'ct' 'timeout' obj_spec
syn cluster nft_c_base_cmd_add_ct_timeout_obj_spec
\ contains=
\    nft_base_cmd_add_ct_timeout_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_keyword_ct_keyword_timeout_obj_spec_table_spec_identifier_table
" TODO: missing table_spec

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
" base_cmd 'ct' 'timeout' obj_spec table_spec
hi link   nft_base_cmd_add_ct_keyword_timeout nftHL_Command
syn match nft_base_cmd_add_ct_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    @nft_c_base_cmd_add_ct_timeout_obj_spec

hi link    nft_add_cmd_ct_helper_block nftHL_BlockDelimitersCT
syn region nft_add_cmd_ct_helper_block start="{" end="}" skip="\\}" skipwhite contained
\ contains=
\    @nft_c_ct_helper_config,
\    nft_comment_spec,
\    nft_stmt_separator,
\    @nft_c_common_block

hi link   nft_add_cmd_keyword_ct_keyword_helper_obj_spec_identifier nftHL_Chain
syn match nft_add_cmd_keyword_ct_keyword_helper_obj_spec_identifier "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_ct_helper_block

hi link   nft_add_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_table nftHL_Table
syn match nft_add_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_table "\v[A-Za-z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_helper_obj_spec_identifier

" base_cmd 'ct' 'helper' obj_spec table_spec
" family_spec->table_spec->obj_spec->'helper'->add_cmd->base_cmd->line
hi link   nft_base_cmd_add_ct_helper_obj_spec_table_spec_family_spec nftHL_Family
syn match nft_base_cmd_add_ct_helper_obj_spec_table_spec_family_spec "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_table

" base_cmd [ 'ct' ] ('helper'|'timeout'|'expectation')
hi link   nft_base_cmd_add_ct_keyword_helper nftHL_Command
syn match nft_base_cmd_add_ct_keyword_helper "helper" skipwhite contained
\ nextgroup=
\    nft_base_cmd_add_ct_helper_obj_spec_table_spec_family_spec,
\    nft_add_cmd_keyword_ct_keyword_helper_obj_spec_table_spec_identifier_table

syn cluster nft_c_cmd_add_ct_keywords
\ contains=
\    nft_base_cmd_add_ct_keyword_helper,
\    nft_base_cmd_add_ct_keyword_timeout,
\    nft_base_cmd_add_ct_keyword_expectation

" **************** BEGIN ct_cmd *******************

" base_cmd [ 'ct' ]
hi link   nft_base_cmd_keyword_ct nftHL_Command
syn match nft_base_cmd_keyword_ct "\vct\ze " skipwhite contained
\ nextgroup=
\    @nft_c_cmd_add_ct_keywords