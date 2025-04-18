

hi link   nft_add_cmd_keyword_set_set_spec_set_block_separator nftHL_Normal
syn match nft_add_cmd_keyword_set_set_spec_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_comment_inline

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr skipwhite contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,23}" contained  " do not use 'skipwhite' here
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot
" TODO undefined nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_with_dot

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_typeof,
\    nft_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr_type

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma nftHL_Operator
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_flags_set_flag_list_set_flag

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_flags nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_keyword_set_set_spec_set_block_time_spec nftHL_Number
syn match nft_add_cmd_keyword_set_set_spec_set_block_time_spec "\v[a-zA-Z0-9\\\/_\.\:]{1,31}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_timeout nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'gc-interval'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_gc_interval nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_time_spec


" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '=' set_block_expr
" set_expr->set_block_expr
" TODO unused nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block_expr_set_expr
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block_expr_set_expr nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_elements_block_items
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator

" unused nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon
hi link  nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon nftHL_Operator
syn match nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon /;/ skipwhite contained

hi link    nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_elements_block_items
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator
" TODO: undefined nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_elements_block_items "
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '='
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements_equal nftHL_Normal
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements_equal /=/ skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_elements_set_block

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_elements nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_elements_equal

" base_cmd add_cmd 'set' set_spec '{' set_block 'automerge'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_automerge nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_automerge "auto\-merge" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size' <interval>
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value nftHL_Number
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size_value


" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'memory'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'performance'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_memory,
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy_performance

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_set_mechanism
\ contains=
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_size,
\    nft_add_cmd_keyword_set_set_spec_set_block_set_mechanism_policy

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec_set_block_comment_string
\ contains=
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_asterisk,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_single,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_quoted_double,
\   nft_add_cmd_keyword_set_set_spec_set_block_comment_string_string

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment'
hi link   nft_add_cmd_keyword_set_set_spec_set_block_comment_spec nftHL_Command
syn match nft_add_cmd_keyword_set_set_spec_set_block_comment_spec "comment" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_comment_string

" base_cmd add_cmd 'set' set_spec '{' set_block '}'
hi link    nft_add_cmd_keyword_set_set_spec_set_block nftHL_BlockDelimitersSet
syn region nft_add_cmd_keyword_set_set_spec_set_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_stateful_stmt,
\    nft_add_cmd_keyword_set_set_spec_set_block_automerge,
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_typeof_key_expr,
\    nft_add_cmd_keyword_set_set_spec_set_block_flags,
\    nft_add_cmd_keyword_set_set_spec_set_block_timeout,
\    nft_add_cmd_keyword_set_set_spec_set_block_gc_interval,
\    undefined_set_mechanism,
\    nft_add_cmd_keyword_set_set_spec_set_block_comment_spec,
\    nft_add_cmd_keyword_set_set_spec_set_block_elements,
\    @nft_c_add_cmd_keyword_set_set_spec_set_block_set_mechanism,
\    @nft_c_common_block,
\    nft_add_cmd_keyword_set_set_spec_set_block_separator
\ nextgroup=
\    nft_comment_inline,
\    nft_line_stmt_separator

" ************* BEGIN set_spec 'set' ('add'|'clean') ***************
" base_cmd 'reset' [ 'set' | 'map' ] table_id spec_id '$'identifier
hi link   nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr nftHL_Position
syn match nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,31}" contained
\ nextgroup=
\    nft_Semicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'set' set_spec set_identifier
" set_identifier->'set'->add_cmd->base_cmd->line
hi link   nft_add_cmd_keyword_set_set_spec_set_id nftHL_Set
syn match nft_add_cmd_keyword_set_set_spec_set_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_block,
\    nft_add_cmd_keyword_set_set_spec_set_block_expr_variable_expr,
\    nft_MissingCurlyBrace,


" base_cmd add_cmd 'set' set_spec table_spec family_spec identifier (table)
hi link   nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id nftHL_Table
syn match nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_set_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedEOS,

" base_cmd add_cmd 'set' set_spec table_spec family_spec family_spec_explicit (table)
hi link   nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit skipwhite contained
\ "\v(ip(6)?|inet|arp|bridge|netdev)"
\ nextgroup=
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedEOS,

" base_cmd [ 'add' ] 'set' set_spec table_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec_table_spec
\ contains=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id

" base_cmd [ 'add' ] 'set' set_spec
syn cluster nft_c_add_cmd_keyword_set_set_spec
\ contains=@nft_c_add_cmd_keyword_set_set_spec_table_spec
" ************* END set_spec 'set' ('add'|'clean') ***************



" 'set'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_set nftHL_Command
syn match nft_base_cmd_keyword_set "set\>" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon

" do not add ^ regex to nft_base_cmd_add_cmd_keyword_set, already done by nft_line
" 'set'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_set nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_set "set" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_set_set_spec_table_spec_family_spec_family_spec_explicit,
\    nft_add_cmd_keyword_set_cmd_set_spec_table_spec_family_spec_table_id,
\    nft_UnexpectedCurlyBrace,
\    nft_UnexpectedSemicolon
" do not add ^ regex to nft_base_cmd_add_cmd_keyword_set, already done by nft_line

