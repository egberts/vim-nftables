

hi link   nft_flowtable_block_hook_keyword_priority_extended_int nftHL_Integer
syn match nft_flowtable_block_hook_keyword_priority_extended_int "\v\-?[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_flowtable_block_hook_keyword_priority_extended_var nftHL_Variable
syn match nft_flowtable_block_hook_keyword_priority_extended_var "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_c_flowtable_block_hook_keyword_priority_extended_sign nftHL_Expression
syn match nft_c_flowtable_block_hook_keyword_priority_extended_sign "\v[-+]" skipwhite contained
\ nextgroup=
\    nft_flowtable_block_hook_keyword_priority_extended_int

hi link   nft_flowtable_block_hook_keyword_priority_extended_name nftHL_Action
syn match nft_flowtable_block_hook_keyword_priority_extended_name "\v[a-zA-Z][a-zA-Z]{1,16}" skipwhite contained
\ nextgroup=
\     nft_c_flowtable_block_hook_keyword_priority_extended_sign

syn cluster nft_c_flowtable_block_hook_keyword_priority_extended
\ contains=
\    nft_flowtable_block_hook_keyword_priority_extended_int,
\    nft_flowtable_block_hook_keyword_priority_extended_var,
\    nft_flowtable_block_hook_keyword_priority_extended_name

hi link   nft_flowtable_block_hook_keyword_priority nftHL_Action
syn match nft_flowtable_block_hook_keyword_priority "priority" skipwhite contained
\ nextgroup=
\    @nft_c_flowtable_block_hook_keyword_priority_extended

hi link    nft_flowtable_block_hook_string_quoted_double nftHL_String
syn region nft_flowtable_block_hook_string_quoted_double start='"' end='"' skip="\\\"" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_flowtable_block_hook_keyword_priority

hi link    nft_flowtable_block_hook_string_quoted_single nftHL_String
syn region nft_flowtable_block_hook_string_quoted_single start="'" end="'" skip="\\\'" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_flowtable_block_hook_keyword_priority

hi link    nft_flowtable_block_hook_string_unquoted nftHL_String
syn match nft_flowtable_block_hook_string_unquoted "\v[a-zA-Z0-9]{1,64}" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_flowtable_block_hook_keyword_priority

syn cluster nft_c_flowtable_block_hook_string
\ contains=
\    nft_flowtable_block_hook_string_quoted_double,
\    nft_flowtable_block_hook_string_quoted_single,
\    nft_flowtable_block_hook_string_unquoted

hi link   nft_flowtable_block_stmt_separator nftHL_Operator
syn match nft_flowtable_block_stmt_separator ";" skipwhite contained

" base_cmd_add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
" base_cmd_create_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
" base_cmd_delete_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
" base_cmd_destroy_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
" table_block 'flowtable' flowtable_spec '{' flowtable_block 'hook'
hi link   nft_flowtable_block_hook nftHL_Statement
syn match nft_flowtable_block_hook "\v[{ ;]\zshook\ze[;} ]" skipwhite skipnl skipempty contained
\ nextgroup=
\    @nft_c_flowtable_block_hook_string

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list flowtable_flag
hi link   nft_flowtable_block_flags_flowtable_flag_list_flowtable_flag nftHL_Action
syn match nft_flowtable_block_flags_flowtable_flag_list_flowtable_flag skipwhite contained
\ "\v(offload)"
\ nextgroup=
\    nft_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list
syn cluster nft_c_flowtable_block_flowtable_flag_list
\ contains=
\    nft_flowtable_block_flags_flowtable_flag_list_flowtable_flag

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags'
hi link   nft_flowtable_block_flags nftHL_Statement
syn match nft_flowtable_block_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_flowtable_block_flowtable_flag_list,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" TODO: [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '=' flowtable_expr
" flowtable_block_expr->'='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'counter'
hi link   nft_flowtable_block_counter nftHL_Statement
syn match nft_flowtable_block_counter "counter" skipwhite contained
\ nextgroup=
\    nft_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_Error

hi link    nft_flowtable_block_devices_flowtable_block_expr nftHL_BlockDelimitersFlowtable
syn region nft_flowtable_block_devices_flowtable_block_expr start="{" end="}" skipwhite contained

hi link   nft_flowtable_expr_variable nftHL_Variable
syn match nft_flowtable_expr_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '='
" '='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_flowtable_block_devices_equal nftHL_Expression
syn match nft_flowtable_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_flowtable_block_devices_flowtable_block_expr,
\    nft_flowtable_expr_variable

" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices'
" 'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_flowtable_block_devices nftHL_Statement
syn match nft_flowtable_block_devices "devices" skipwhite contained
\ nextgroup=
\    nft_flowtable_block_devices_equal

syn cluster nft_flowtable_block
\ contains=
\    nft_flowtable_block_counter,
\    nft_flowtable_block_devices,
\    nft_flowtable_block_flags,
\    nft_flowtable_block_hook

