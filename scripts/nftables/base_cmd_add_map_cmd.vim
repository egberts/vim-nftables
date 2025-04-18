


" ************* BEGIN set_spec 'map' ('add'|'clean') ***************
" set_spec 'map' ('add'|'clean')
" set_spec 'element' ('add'|'clean')
" set_spec 'map' ('delete'|'destroy')
" set_spec 'element' ('delete'|'destroy')
" set_spec ('set'|'map'|'flow table'|'meter') 'flush'
" set_spec 'element' 'get'
" set_spec ('set'|'meter'|'map') 'list'
" set_spec 'element' 'reset'
" set_spec set_or_id_spec 'set' ('delete'|'destroy')
" set_spec set_or_id_spec ('set'|'map') 'reset'

" (string|'last') chain_identifier table_block

" chain_or_id_spec 'chain' 'delete'
" chain_or_id_spec 'chain' 'destroy'

" table_or_id_spec 'table' ('delete'|'destroy')

" insert_cmd 'insert' base_cmd line

" create_cmd 'create' base_cmd line

" replace_cmd 'replace' base_cmd line



hi link   nft_add_cmd_map_map_spec_map_block_separator nftHL_Normal
syn match nft_add_cmd_map_map_spec_map_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_comment_inline

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]\{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}(\.[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}){0,5}" contained  " do not use 'skipwhite' here
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr
syn cluster nft_c_add_cmd_map_mamappec_map_block_typeof_key_expr
\ contains=
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_typeof,
\    nft_add_cmd_map_map_spec_map_block_typeof_key_expr_type


" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag ','
hi link   nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma nftHL_Operator
syn match nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec_map_block_map_flag_list

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag
hi link   nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_comma

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list
syn cluster nft_c_add_cmd_map_map_spec_map_block_map_flag_list
\ contains=
\    nft_add_cmd_map_map_spec_map_block_flags_map_flag_list_map_flag

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags'
hi link   nft_add_cmd_map_map_spec_map_block_flags nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec_map_block_map_flag_list


" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_map_map_spec_map_block_time_spec nftHL_Number
syn match nft_add_cmd_map_map_spec_map_block_time_spec "\v[A-Za-z0-9\-\_\:]{1,32}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_separator
" TODO clarify <time_spec>

" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'
hi link   nft_add_cmd_map_map_spec_map_block_timeout nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_time_spec

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements'
hi link   nft_add_cmd_map_map_spec_map_block_elements nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_time_spec

" base_cmd add_cmd 'map' map_spec '{' map_block 'gc-interval'
hi link   nft_add_cmd_map_map_spec_map_block_gc_interval nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_time_spec



" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '=' '{' map_block_item
hi link    nft_add_cmd_map_map_spec_map_block_elements_block_items nftHL_BlockDelimitersMap
syn match nft_add_cmd_map_map_spec_map_block_elements_block_items "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]" skipwhite contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '=' '{' map_block_expr
hi link    nft_add_cmd_map_map_spec_map_block_elements_map_block_expr nftHL_BlockDelimitersMap
syn region nft_add_cmd_map_map_spec_map_block_elements_map_block_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_elements_block_items
\ nextgroup=
\    nft_Semicolon,
\    nft_EOS,
\    nft_Error

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '='
hi link   nft_add_cmd_map_map_spec_map_block_elements_equal nftHL_Operator
syn match nft_add_cmd_map_map_spec_map_block_elements_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_elements_map_block_expr

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements'
hi link   nft_add_cmd_map_map_spec_map_block_elements nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_elements_equal

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size' <interval>
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value nftHL_Number
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_size nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_size_value


" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'memory'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'performance'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_separator

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy'
hi link   nft_add_cmd_map_map_spec_map_block_map_mechanism_policy nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_map_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_memory,
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy_performance

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism
syn cluster nft_c_add_cmd_map_map_spec_map_block_map_mechanism
\ contains=
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_size,
\    nft_add_cmd_map_map_spec_map_block_map_mechanism_policy

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_map_map_spec_map_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_map_map_spec_map_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment' comment_spec
syn cluster nft_c_add_cmd_map_map_spec_map_block_comment_string
\ contains=
\   nft_add_cmd_map_map_spec_map_block_comment_string_asterisk,
\   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_single,
\   nft_add_cmd_map_map_spec_map_block_comment_string_quoted_double,
\   nft_add_cmd_map_map_spec_map_block_comment_string_string

" base_cmd add_cmd 'map' map_spec '{' map_block 'comment'
hi link   nft_add_cmd_map_map_spec_map_block_comment_spec nftHL_Command
syn match nft_add_cmd_map_map_spec_map_block_comment_spec "comment" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec_map_block_comment_string

" base_cmd add_cmd 'map' map_spec '{' map_block '}'
hi link    nft_add_cmd_map_map_spec_map_block nftHL_BlockDelimitersMap
syn region nft_add_cmd_map_map_spec_map_block start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_map_map_spec_map_block_timeout,
\    nft_add_cmd_map_map_spec_map_block_gc_interval,
\    nft_add_cmd_map_map_spec_map_block_flags,
\    @nft_c_stateful_stmt,
\    nft_add_cmd_map_map_spec_map_block_comment_spec,
\    @nft_c_add_cmd_map_map_spec_map_block_map_mechanism,
\    @nft_c_add_cmd_map_map_spec_map_block_typeof_key_expr,
\    undefined_map_map_spec_map_block_type_datatype,
\    nft_add_cmd_map_map_spec_map_block_elements,
\    @nft_c_common_block,
\    nft_add_cmd_map_map_spec_map_block_separator
\ nextgroup=
\    nft_comment_inline,
\    nft_Semicolon

" base_cmd add_cmd 'map' map_spec set_identifier (chain)
hi link   nft_add_cmd_map_map_spec_identifier_set nftHL_Chain
syn match nft_add_cmd_map_map_spec_identifier_set "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_map_block

" base_cmd add_cmd 'map' map_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table nftHL_Table
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_map_map_spec_identifier_set

" base_cmd add_cmd 'map' map_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=
\    nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec table_spec
syn cluster nft_c_add_cmd_map_map_spec_table_spec
\ contains=
\    nft_add_cmd_map_map_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_map_map_spec_table_spec_family_spec_identifier_table

" base_cmd [ 'add' ] 'map' map_spec
syn cluster nft_c_add_cmd_map_map_spec
\ contains=@nft_c_add_cmd_map_map_spec_table_spec

" 'map'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_map nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_map "map" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec

hi link   nft_base_cmd_keyword_map nftHL_Command
syn match nft_base_cmd_keyword_map "\v \zsmap\ze " skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_map_map_spec
" do not add ^ regex to nft_base_cmd_map, already done by nft_line

