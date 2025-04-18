


"""""""""""""""""" get_cmd BEGIN """"""""""""""""""""""""""""""""""
hi link   nft_get_cmd_set_block_separator nftHL_Normal
syn match nft_get_cmd_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_comment_inline

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}"
" do not use 'skipwhite' here

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_get_cmd_set_block_typeof_key_expr_type nftHL_Command
syn match nft_get_cmd_set_block_typeof_key_expr_type "type\s" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_block_typeof_key_expr_type_data_type_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,5}" contained  " do not use 'skipwhite' here
\ nextgroup=
\    nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_get_cmd_set_spec_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_get_cmd_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_get_cmd_set_block_typeof_key_expr_typeof nftHL_Command
syn match nft_get_cmd_set_block_typeof_key_expr_typeof "typeof" skipwhite contained
\ nextgroup=
\    @nft_c_get_cmd_set_spec_set_block_typeof_key_expr_typeof_expr

" base_cmd 'get' 'element' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_get_cmd_set_spec_set_block_typeof_key_expr
\ contains=
\    nft_get_cmd_set_block_typeof_key_expr_typeof,
\    nft_get_cmd_set_block_typeof_key_expr_type

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_get_cmd_set_block_flags_set_flag_list_comma nftHL_Operator
syn match nft_get_cmd_set_block_flags_set_flag_list_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_get_cmd_set_spec_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_get_cmd_set_block_flags_set_flag_list_set_flag nftHL_Action
syn match nft_get_cmd_set_block_flags_set_flag_list_set_flag skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=
\    nft_get_cmd_set_block_flags_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_get_cmd_set_spec_set_block_set_flag_list
\ contains=
\    nft_get_cmd_set_block_flags_set_flag_list_set_flag

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_get_cmd_set_block_flags nftHL_Command
syn match nft_get_cmd_set_block_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_get_cmd_set_spec_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_get_cmd_set_block_time_spec nftHL_Number
syn match nft_get_cmd_set_block_time_spec "\v[A-Za-z0-9\-\_\:]{1,32}" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_block_separator
" TODO clarify <time_spec>

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_get_cmd_set_block_timeout nftHL_Command
syn match nft_get_cmd_set_block_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_get_cmd_set_block_time_spec

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'tcp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'udp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'udplite' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'esp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'ah' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'icmp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'icmpv6' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'igmp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'gre' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'comp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'dccp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'sctp' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr 'redirect' '}'
hi link   nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords nftHL_Expression
syn match nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords skipwhite contained
\ "\v(tcp|udplite|udp|esp|ah|icmpv6|icmp|igmp|gre|comp|dccp|sctp|direct)"

hi link    nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block nftHL_Normal
syn region nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_block start="(" end=")" skipwhite contained

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr primary_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
\ contains=
\    nft_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_expr_keywords,
\    nft_primary_rhs_expr_block,
\    nft_integer_expr,
\    @nft_c_boolean_expr,
\    nft_keyword_expr
"\ nextgroup=
"\    nft_concat_rhs_expr_basic_rhs_expr_lshift,
"\    nft_concat_rhs_expr_basic_rhs_expr_rshift


" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr shift_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr
\ contains=
\          @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr_shift_rhs_expr_primary_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_ampersand

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr and_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_shift_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_caret

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr exclusive_or_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr
\ contains=
\    @nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr_and_rhs_expr
"\ nextgroup=
"\    nft_c_concat_rhs_expr_basic_rhs_expr_bar

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr '}'
syn cluster nft_c_concat_rhs_expr_basic_rhs_expr
\ contains=
\    @nft_c_nft_c_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr basic_rhs_expr '.' '}'
" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' concat_rhs_expr multiton_rhs_expr '.' '}'
hi link   nft_get_et_al_cmd_set_block_expr_concat_rhs_expr_dot nftHL_Operator
syn match nft_get_et_al_cmd_set_block_expr_concat_rhs_expr_dot /./ skipwhite contained
\ nextgroup=
\    @nft_c_concat_rhs_expr_basic_rhs_expr,
\    @nft_c_concat_rhs_expr_multiton_rhs_expr



" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_key_expr set_lhs_expr '}'
syn cluster nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr
\ contains=
\    @nft_c_concat_rhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_key_expr '*' '}'
hi link   nft_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk nftHL_Verdict
syn match nft_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk "\*" skipwhite contained
\ nextgroup=
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_elem_stmt_m,
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc_set_elem_expr_option,
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc_set_elem_expr_options

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_expr_alloc set_elem_key_expr '}'
syn cluster nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr
\ contains=
\    nft_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_asterisk,
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr,
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr_set_lhs_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_elem_expr set_elem_expr_alloc '}'
syn cluster nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc
\ contains=
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_key_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_list_member_expr set_elem_expr '}'
syn cluster nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr
\ contains=
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr_alloc

hi link   nft_get_et_al_cmd_set_block_expr_set_expr_comma nftHL_Command
syn match nft_get_et_al_cmd_set_block_expr_set_expr_comma /,/ skipwhite contained
\ nextgroup=
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_list_member_expr '}'
syn cluster nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr
\ contains=
\    nft_get_et_al_cmd_set_block_expr_set_expr,
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr_set_elem_expr
"\ nextgroup=
"\     nft_c_get_et_al_cmd_set_block_expr_set_expr_comma

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' ... '}'
hi link    nft_get_et_al_cmd_set_block_expr_set_expr nftHL_BlockDelimitersSet
syn region nft_get_et_al_cmd_set_block_expr_set_expr start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_get_et_al_cmd_set_block_expr_set_expr_set_list_member_expr
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOL,
\    nft_Error

" base_cmd 'get' 'element' table_id spec_id '$'identifier
hi link   nft_Error_get_cmd_set_block_expr_variable_expr nftHL_Error
syn match nft_Error_get_cmd_set_block_expr_variable_expr /[^\;\s\wa-zA-Z0-9_./]{1,64}/  skipwhite contained " uncontained, on purpose
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_Error,


hi link   nft_get_et_al_cmd_set_block_expr_variable_expr nftHL_Variable
syn match nft_get_et_al_cmd_set_block_expr_variable_expr "\$\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_Error,
\    nft_Error_get_cmd_block_expr_variable_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" All nft_c_get_et_al_cmd also applies toward:
"   add_cmd, create_cmd, delete_cmd, destroy_cmd, get_cmd, and reset_cmd
"   nft_c_get_et_al_cmd includes add_cmd, create_cmd, delete_cmd, destroy_cmd, get_cmd, and reset_cmd
" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id set_block_expr
syn cluster nft_c_get_et_al_cmd_set_block_expr
\ contains=
\    nft_get_et_al_cmd_set_block_expr_variable_expr,
\    nft_get_et_al_cmd_set_block_expr_set_expr

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
"   nft_c_get_et_al_cmd includes add_cmd, create_cmd, delete_cmd, destroy_cmd, get_cmd, and reset_cmd
hi link   nft_get_et_al_cmd_set_spec_identifier nftHL_Set
syn match nft_get_et_al_cmd_set_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_get_et_al_cmd_set_block_expr_variable_expr,
\    nft_get_et_al_cmd_set_block_expr_set_expr,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_et_al_cmd_set_spec_table_spec_identifier nftHL_Table
syn match nft_get_et_al_cmd_set_spec_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_get_et_al_cmd_set_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'get' 'element' [ family_spec_explicit ] table_id set_id
hi link   nft_get_et_al_cmd_set_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_get_et_al_cmd_set_spec_table_spec_family_spec_explicit "\v(ip6|ip|inet|netdev|bridge|arp)" skipwhite contained
\ nextgroup=
\    nft_get_et_al_cmd_set_spec_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd 'get' 'element' set_spec
syn cluster nft_c_get_cmd_set_spec
\ contains=
\    nft_get_et_al_cmd_set_spec_table_spec_family_spec_explicit,
\    nft_get_et_al_cmd_set_spec_table_spec_identifier

" 'element'->get_cmd->'get'->base_cmd->line
"   nft_c_get_et_al_cmd includes add_cmd, create_cmd, delete_cmd, destroy_cmd, get_cmd, and reset_cmd
hi link   nft_get_et_al_cmd_keyword_element nftHL_Statement
syn match nft_get_et_al_cmd_keyword_element "element" skipwhite contained
\ nextgroup=
\    nft_get_et_al_cmd_set_spec_table_spec_family_spec_explicit,
\    nft_get_et_al_cmd_set_spec_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

"""""""""""""""""" get_cmd END """"""""""""""""""""""""""""""""""

" 'get'->base_cmd->line
"   nft_c_get_et_al_cmd includes add_cmd, create_cmd, delete_cmd, destroy_cmd, get_cmd, and reset_cmd
hi link   nft_base_cmd_keyword_get nftHL_Command
syn match nft_base_cmd_keyword_get "get" skipwhite contained
\ nextgroup=
\    nft_get_et_al_cmd_keyword_element,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error