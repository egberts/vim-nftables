


""""" BEGIN OF 'add table' <identifier> { chain
""""" BEGIN of table <identifier> { chain <identifier> {"
" add 'table' table_block chain_block hook_spec
" add_cmd 'table' table_block 'chain' chain_block ';'
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_separator nftHL_Normal
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_separator ';' skipwhite contained
\ nextgroup=
\    nft_comment_inline

" cmd_add 'table' table_block chain_block hook_spec 'type' prio_spec number
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number_valid nftHL_Number
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number_valid "\v[0-9\-]{1,5}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_separator

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number nftHL_Table
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number_valid

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_variable nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

" cmd_add 'table' table_block chain_block hook_spec 'type' prio_spec 'priority'
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec nftHL_Command
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec 'priority' skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_variable,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number_valid,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec_number,

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device' string
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_string nftHL_Device
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_string  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device' variable_expr
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr "\v\$[a-zA-Z0-9\_\-]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device'
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec_device_variable_expr_or_string
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_variable_expr,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_device_string

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'device'
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_device nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_device "device" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec_device_variable_expr_or_string

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices' flowtable_expr variable_expr
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr "\v\$[a-zA-Z0-9\_\-]{1,64}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec


" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr <string> ','
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma nftHL_Element
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma "," skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string


" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr <string>
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string "\v[a-zA-Z0-9 \t]{1,64}" skipwhite oneline contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr "'" <string> "'"
hi link    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles nftHL_String
syn region nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles start="\'" end="\'" skip="\\\'" skipwhite oneline contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr '"' <string> '"'
hi link    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles nftHL_String
syn region nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles start="\"" end="\"" skip="\\\"" skipwhite oneline contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add_cmd 'table' table_block 'chain' chain_block hook_spec 'type' dev_spec 'devices. flowtable_expr flowtable_block flowtable_member_expr
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_comma

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr flowtable_block
hi link    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block nftHL_BlockDelimitersFlowTable
syn region nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block skipwhite contained
\ start="{" end="}"
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_variable,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_doubles,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string_quote_singles,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_flowtable_expr_flowtable_expr_member_string
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec

" add 'table' table_block chain_block hook_spec dev_spec devices flowtable_expr
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec_flowtable_expr
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_variable_expr,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_flowtable_expr_block,
\    nft_MissingDeviceVariable,
\    nft_UnexpectedEOS

" add 'table' table_block chain_block hook_spec dev_spec devices '='
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_equal nftHL_Operator
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_equal "=" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec_flowtable_expr,
\    nft_UnexpectedEOS

" dev_spec 'devices ='
hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_devices nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_devices "devices" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_dev_spec_devices_equal,
\    nft_UnexpectedEOS

" dev_spec (via hook_spec)
hi link     nft_c_add_table_block_chain_block_hook_spec_dev_spec nftHL_Identifier
syn cluster nft_c_add_table_block_chain_block_hook_spec_dev_spec
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_devices,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_device,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_hooks nftHL_Hook
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_hooks "\v(ingress|prerouting|input|forward|output|postrouting)" skipwhite contained
\ nextgroup=
\    @nft_c_add_table_block_chain_block_hook_spec_dev_spec,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_prio_spec,
\    nft_UnexpectedEOS

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_hook nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_hook "hook" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_hooks

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_types nftHL_Type
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_types "\v(filter|route|nat)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_hook,
\    nft_Semicolon,
\    nft_EOL

hi link   nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_type nftHL_Command
syn match nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_type "type" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_types

" chain_policy->policy_expr->'policy'->policy_spec->chain_block->'{'->
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy nftHL_Action
syn match nft_add_cmd_keyword_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy "\v(accept|drop)" skipwhite contained


" policy_expr->'policy'->policy_spec->chain_block->'{'->
syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_policy_spec_policy_expr
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_policy_spec_policy_expr_chain_policy

hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_policy_spec_keyword_policy nftHL_Command
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_policy_spec_keyword_policy "policy" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_policy_spec_policy_expr,
\    nft_Semicolon,
\    nft_EOL,
\    nft_Error


" add_cmd 'table' table_block 'chain' chain_block flags_spec 'offload' ';'
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_flags_spec_separator nftHL_BlockDelimitersChain
syn match nft_add_cmd_keyword_table_table_block_chain_chain_flags_spec_separator ";" skipwhite contained
\ nextgroup=
\    nft_Semicolon,
\    nft_hash_comment

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'offload'
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_offload nftHL_Action
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_offload "offload" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_flags_spec_separator,
\    nft_Error

" add_cmd 'table' table_block 'chain' chain_block flags_spec 'flags'
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_flags nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_flags "\v[ \t]\zsflags" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_offload,
\    nft_Error
" TODO: Add negatation of 'tcp' in 'tcp flags' or add to nextgroup=BUT in chain_block


" add_cmd 'table' table_block 'chain' chain_block comment_spec 'comment' string
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_unquoted nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]]{0,63}" keepend contained

hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

hi link    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_single nftHL_String
syn region nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_single start="'" skip="\\'" end="'" keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_double_quote

hi link    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_double nftHL_String
syn region nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_sans_single_quote

syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_quoted_string
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_single,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_double

hi link    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_asterisk_string nftHL_String
syn region nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_asterisk_string start="\*" skip="\\\*" end="\*" keepend oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_unquoted

hi link     nft_c_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string nftHL_Error
syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string_unquoted,
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_quoted_string,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_asterisk_string

" add_cmd 'table' table_block 'chain' chain_block comment_spec 'comment'
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec "comment" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec_string



" add_cmd 'table' table_block 'chain' chain_block rule 'rule' comment_spec
"    re-using nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec

" add_cmd 'table' table_block 'chain' chain_block rule 'rule' rule_alloc
" short-circuiting to chain_block comment_spec
syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_block_rule_rule_alloc
\ contains=
\    @nft_c_stmt

" add_cmd 'table' table_block 'chain' chain_block rule 'rule'
" TODO unused nft_add_cmd_keyword_table_table_block_chain_chain_block_rule
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_rule nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_rule "rule" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_block_rule_rule_alloc,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_rule_comment_spec


" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '$'identifier
" '$'identifier->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_stmt_separator

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_member ','
" ','->flowtable_expr_member->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma nftHL_Operator
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma "," skipwhite contained
\ containedin=nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' <STRING>
" <STRING>->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' '$'identifier
" '$'identifier->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr nftHL_Variable
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_EOS,
\    nftHL_Error

syn match nft_CurlyBraceAheadSilent "\v\ze\}" skipwhite contained

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' <QUOTED_STRING>
" <QUOTED_STRING>->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string nftHL_String
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string "\v\"[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,63}\"" keepend skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_comma,
\    nft_CurlyBraceAheadSilent,
\    nftHL_EOS,
\    nftHL_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_member
" flowtable_expr_member->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string

hi link   nft_MissingDeviceVariable2 nftHL_Error
syn match nft_MissingDeviceVariable2 "\v[^\$\{\}]{1,5}" skipwhite contained " do not use 'keepend' here

syn cluster nft_c_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block
\ contains=@nft_c_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member

" 'table' identifier '{' 'chain' identifier '{' 'devices' '=' '{' flowtable_expr_block
" flowtable_expr_block->'{'->'='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block nftHL_BlockDelimitersFlowTable
syn region nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block start=/{/ end=/}/ skipwhite contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_variable_expr,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_quoted_string,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block_flowtable_expr_member_string
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_stmt_separator,

" 'table' identifier '{' 'chain' identifier '{' 'devices' '='
" '='->'devices'->chain_block->'chain'->table_block->'table'->add_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_equal nftHL_Operator
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_variable_expr,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_flowtable_expr_block,
\    nft_UnexpectedSemicolon,
\    nft_Error

" 'table' identifier '{' 'chain' identifier '{' 'devices'
" 'devices'->chain_block->'chain'->table_block->'table'->add_cmd->base_cmd->line
" 'devices'->chain_block->'chain'->table_block->'table'->add_cmd->'add'->base_cmd->line
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_devices nftHL_Statement
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_devices "devices" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices_equal

hi link   nft_chainError nftHL_Error
syn match nft_chainError /"v[a-zA-Z0-9\\\/_\.;:]{1,64}/ skipwhite contained

" common_block is contains=lastly due to 'comment' in chain_block & chain_block/rule
" 'table' identifier '{' 'chain' identifier '{' chain_block
" chain_block->'chain'->table_block->'table'->add_cmd->base_cmd->line
" chain_block->'chain'->table_block->'table'->add_cmd->'add'->base_cmd->line
hi link    nft_add_cmd_keyword_table_table_block_chain_chain_block nftHL_BlockDelimitersChain
syn region nft_add_cmd_keyword_table_table_block_chain_chain_block start="{" end="}" skipwhite contained
\ nextgroup=
\    nft_table_block_stmt_separator,
\    nft_comment_inline,
\    nft_hash_comment
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_comment_spec,
\    nft_add_cmd_keyword_table_table_block_chain_block_hook_spec_keyword_type,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_policy_spec_keyword_policy,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_flags_spec_flags,
\    nft_add_cmd_keyword_table_table_block_chain_chain_block_devices,
\    nft_comment_inline,
\    @nft_c_common_block,
\    @nft_c_add_cmd_keyword_table_table_block_chain_chain_block_rule_rule_alloc


"\ contains=
"\ nextgroup=
"\    nft_add_cmd_keyword_table_table_block_chain_flags_spec,
"\    nft_add_cmd_keyword_table_table_block_chain_rule_spec,
"\    nft_add_cmd_keyword_table_table_block_chain_device_keyword
" \ contains=ALLBUT,
" \    nft_add_table_options_flag_keyword,
" \    nft_add_table_options_comment_spec,
" \    nft_add_cmd_table_block_keyword_chain

" 'table' 'T' '{' 'chain' 'C' '{' ';'
" ';'->stmt_separator->chain_block->'chain'->table_block->'table'->add_cmd->base_cmd
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_block_stmt_separator nftHL_Expression
syn match nft_add_cmd_keyword_table_table_block_chain_chain_block_stmt_separator contained /\v\s{0,8}[\n;]{1,15}/  skipwhite contained
\ nextgroup=
\    nft_comment_inline

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_unquoted nftHL_Chain
syn match nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_double_quote nftHL_Chain
syn match nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link   nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_single_quote nftHL_Chain
syn match nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_single_quote "\v[a-zA_Z][a-zA-Z0-9\\\/_\.\-]{0,63}" keepend skipwhite contained

" add_cmd 'table' table_block 'chain' chain_spec table_id chain_id
hi link    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_single nftHL_Chain
syn region nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_single start="'" skip="\\\'" end="'" keepend skipwhite oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_single_quote
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' <DOUBLE_STRING>
hi link    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_double nftHL_Chain
syn region nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_double start="\"" skip="\\\"" end="\"" keepend skipwhite oneline contained
\ contains=
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_sans_double_quote
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain' 'last'
hi link  nft_add_cmd_keyword_table_table_block_chain_chain_identifier_last nftHL_Action
syn match nft_add_cmd_keyword_table_table_block_chain_chain_identifier_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_block

" add_cmd 'table' table_block 'chain'
hi link   nft_add_cmd_table_block_keyword_chain nftHL_Command
syn match nft_add_cmd_table_block_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_single,
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_double,
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_last,
\    nft_add_cmd_keyword_table_table_block_chain_chain_identifier_string_unquoted
""""" END OF table <identifier> { chain



" ************* BEGIN table_block 'set' set_block ***************
"  this is NOT the 'set' found inside the chain_block
"  this IS the 'set' found inside the table_block

hi link   nft_add_cmd_table_block_set_block_separator nftHL_Normal
syn match nft_add_cmd_table_block_set_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_comment_inline

" base_cmd add_cmd 'table' 'set' set_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr skipwhite contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_table_block_set_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_table_block_set_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'type'
hi link   nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_type nftHL_Command
syn match nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_type "type" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,23}" contained  " do not use 'skipwhite' here
\ nextgroup=
\    nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_typeof nftHL_Command
syn match nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_typeof "typeof" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_set_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'set' set_spec '{' set_block typeof_key_expr
syn cluster nft_c_add_cmd_table_block_set_block_typeof_key_expr
\ contains=
\    nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_typeof,
\    nft_add_cmd_table_block_set_block_typeof_key_expr_keyword_type

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag ','
hi link   nft_add_cmd_table_block_set_block_set_flag_list_comma nftHL_Operator
syn match nft_add_cmd_table_block_set_block_set_flag_list_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_set_block_set_flag_list

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list set_flag
hi link   nft_add_cmd_table_block_set_block_set_flag_list_item nftHL_Action
syn match nft_add_cmd_table_block_set_block_set_flag_list_item skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=
\    nft_add_cmd_table_block_set_block_set_flag_list_comma

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags' set_flag_list
syn cluster nft_c_add_cmd_table_block_set_block_set_flag_list
\ contains=
\    nft_add_cmd_table_block_set_block_set_flag_list_item

" base_cmd add_cmd 'set' set_spec '{' set_block 'flags'
hi link   nft_add_cmd_table_block_set_block_keyword_flags nftHL_Command
syn match nft_add_cmd_table_block_set_block_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_set_block_set_flag_list


" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_table_block_set_block_time_spec nftHL_Number
syn match nft_add_cmd_table_block_set_block_time_spec "\v[a-zA-Z0-9\\\/_\.\:]{1,31}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block 'timeout'
hi link   nft_add_cmd_table_block_set_block_keyword_timeout nftHL_Command
syn match nft_add_cmd_table_block_set_block_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_time_spec

" base_cmd add_cmd 'set' set_spec '{' set_block 'gc-interval'
hi link   nft_add_cmd_table_block_set_block_keyword_gc_interval nftHL_Command
syn match nft_add_cmd_table_block_set_block_keyword_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_time_spec

" unused nft_add_cmd_keyword_set_set_spec_set_block_element_set_block_semicolon
hi link   nft_add_cmd_table_block_set_block_set_block_expr_set_expr_comma nftHL_Operator
syn match nft_add_cmd_table_block_set_block_set_block_expr_set_expr_comma /,/ skipwhite contained

hi link    nft_add_cmd_table_block_set_block_set_block_expr_set_expr nftHL_BlockDelimitersSet
syn region nft_add_cmd_table_block_set_block_set_block_expr_set_expr start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_table_block_set_block_set_block_expr_set_expr_comma,
\    nft_set_expr

hi link   nft_add_cmd_table_block_set_block_set_block_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_table_block_set_block_set_block_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_table_block_stmt_separator,
\    nft_EOS

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements' '='
hi link   nft_add_cmd_table_block_set_block_elements_equal nftHL_Operator
syn match nft_add_cmd_table_block_set_block_elements_equal /=/ skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_set_block_expr_variable_expr,
\    nft_set_expr

" base_cmd add_cmd 'set' set_spec '{' set_block 'elements'
hi link   nft_add_cmd_table_block_set_block_keyword_elements nftHL_Command
syn match nft_add_cmd_table_block_set_block_keyword_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_elements_equal

" base_cmd add_cmd 'set' set_spec '{' set_block 'automerge'
hi link   nft_add_cmd_table_block_set_block_automerge nftHL_Command
syn match nft_add_cmd_table_block_set_block_automerge "auto\-merge" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_separator,

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size' <interval>
hi link   nft_add_cmd_table_block_set_block_set_mechanism_size_value nftHL_Number
syn match nft_add_cmd_table_block_set_block_set_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'size'
hi link   nft_add_cmd_table_block_set_block_set_mechanism_size nftHL_Command
syn match nft_add_cmd_table_block_set_block_set_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_set_mechanism_size_value


" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'memory'
hi link   nft_add_cmd_table_block_set_block_set_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_table_block_set_block_set_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy' 'performance'
hi link   nft_add_cmd_table_block_set_block_set_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_table_block_set_block_set_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_separator

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism 'policy'
hi link   nft_add_cmd_table_block_set_block_set_mechanism_policy nftHL_Command
syn match nft_add_cmd_table_block_set_block_set_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_set_mechanism_policy_memory,
\    nft_add_cmd_table_block_set_block_set_mechanism_policy_performance

" base_cmd add_cmd 'set' set_spec '{' set_block set_mechanism
syn cluster nft_c_add_cmd_table_block_set_block_set_mechanism
\ contains=
\    nft_add_cmd_table_block_set_block_set_mechanism_size,
\    nft_add_cmd_table_block_set_block_set_mechanism_policy

" base_cmd add_cmd 'table' table_block 'set' identifier '{' set_block '}'
hi link    nft_add_cmd_table_block_set_block_delimiters nftHL_BlockDelimitersSet
syn region nft_add_cmd_table_block_set_block_delimiters start="{" end="}" skip="\\{" skipwhite contained
\ contains=
\    @nft_c_add_cmd_table_block_set_block_typeof_key_expr,
\    nft_add_cmd_table_block_set_block_keyword_flags,
\    nft_add_cmd_table_block_set_block_keyword_timeout,
\    nft_add_cmd_table_block_set_block_keyword_gc_interval,
\    @nft_c_stateful_stmt,
\    @nft_c_add_cmd_table_block_set_block_set_mechanism,
\    nft_add_cmd_table_block_set_block_keyword_elements,
\    nft_add_cmd_table_block_set_block_automerge
\ nextgroup=
\    nft_comment_inline,
\    nft_line_stmt_separator

" base_cmd add_cmd 'table' table_block 'set' identifier
hi link   nft_add_cmd_table_block_keyword_set_identifier nftHL_Identifier
syn match nft_add_cmd_table_block_keyword_set_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_delimiters

" base_cmd add_cmd 'table' table_block 'set' 'last'
hi link   nft_add_cmd_table_block_keyword_set_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_table_block_keyword_set_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_set_block_delimiters

" base_cmd add_cmd 'table' table_block 'set'
hi link   nft_add_cmd_table_block_keyword_set nftHL_Command
syn match nft_add_cmd_table_block_keyword_set "set" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_keyword_set_identifier_keyword_last,
\    nft_add_cmd_table_block_keyword_set_identifier,

" ************* END table_block 'set' set_block ***************
" SLE7 end
" ************* BEGIN table_block 'map' map ***************
"  this is NOT the 'map' found inside the chain_block
"  this IS the 'map' found inside the table_block

hi link   nft_add_cmd_table_block_map_block_separator nftHL_Normal
syn match nft_add_cmd_table_block_map_block_separator /;/ skipwhite contained
\ nextgroup=
\    nft_comment_inline

" base_cmd add_cmd 'table' 'map' map_block typeof_key_expr 'type' typeof_expr primary_expr
hi link   nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr skipwhite contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}"
" do not use 'skipwhite' here

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'  <family>
hi link   nft_add_cmd_table_block_map_block_typeof_key_expr_type_data_type_expr nftHL_Action
syn match nft_add_cmd_table_block_map_block_typeof_key_expr_type_data_type_expr "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'type'
hi link   nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_type nftHL_Command
syn match nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_type "type" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_typeof_key_expr_type_data_type_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr primary_expr
hi link   nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr nftHL_Identifier
syn match nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr contained
\  "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}(\.[a-zA-Z][a-zA-Z0-9]{0,63}){0,23}" contained  " do not use 'skipwhite' here
\ nextgroup=
\    nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr_with_dot

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof' typeof_expr
syn cluster nft_c_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr
\ contains=
\    nft_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr_primary_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr 'typeof'
hi link   nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_typeof nftHL_Command
syn match nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_typeof "typeof" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_map_block_typeof_key_expr_typeof_expr

" base_cmd_add_cmd 'map' map_spec '{' map_block typeof_key_expr
syn cluster nft_c_add_cmd_table_block_map_block_typeof_key_expr
\ contains=
\    nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_typeof,
\    nft_add_cmd_table_block_map_block_typeof_key_expr_keyword_type

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag ','
hi link   nft_add_cmd_table_block_map_block_map_flag_list_comma nftHL_Operator
map match nft_add_cmd_table_block_map_block_map_flag_list_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_map_block_map_flag_list

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list map_flag
hi link   nft_add_cmd_table_block_map_block_map_flag_list_item nftHL_Action
syn match nft_add_cmd_table_block_map_block_map_flag_list_item skipwhite contained
\ "\v(constant|interval|timeout|dynamic)"
\ nextgroup=
\    nft_add_cmd_table_block_map_block_map_flag_list_comma

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags' map_flag_list
syn cluster nft_c_add_cmd_table_block_map_block_map_flag_list
\ contains=
\    nft_add_cmd_table_block_map_block_map_flag_list_item

" base_cmd add_cmd 'map' map_spec '{' map_block 'flags'
hi link   nft_add_cmd_table_block_map_block_keyword_flags nftHL_Command
syn match nft_add_cmd_table_block_map_block_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_table_block_map_block_map_flag_list


" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'/'gc-interval' time_spec
hi link   nft_add_cmd_table_block_map_block_time_spec nftHL_Number
syn match nft_add_cmd_table_block_map_block_time_spec "\v[a-zA-Z0-9\\\/_\.\:]{1,31}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_separator

" base_cmd add_cmd 'map' map_spec '{' map_block 'timeout'
hi link   nft_add_cmd_table_block_map_block_keyword_timeout nftHL_Command
syn match nft_add_cmd_table_block_map_block_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_time_spec

" base_cmd add_cmd 'map' map_spec '{' map_block 'gc-interval'
hi link   nft_add_cmd_table_block_map_block_keyword_gc_interval nftHL_Command
syn match nft_add_cmd_table_block_map_block_keyword_gc_interval "\vgc\-interval" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_time_spec

" unused nft_add_cmd_keyword_map_map_spec_map_block_element_map_block_semicolon
hi link   nft_add_cmd_table_block_map_block_map_block_expr_map_expr_comma nftHL_Operator
syn match nft_add_cmd_table_block_map_block_map_block_expr_map_expr_comma /,/ skipwhite contained

hi link    nft_add_cmd_table_block_map_block_map_block_expr_map_expr nftHL_BlockDelimitersSet
syn region nft_add_cmd_table_block_map_block_map_block_expr_map_expr start="{" end="}" skipnl skipempty skipwhite contained
\ contains=
\    nft_add_cmd_table_block_map_block_map_block_expr_map_expr_comma,
\    nft_map_expr

hi link   nft_add_cmd_table_block_map_block_map_block_expr_variable_expr nftHL_Variable
syn match nft_add_cmd_table_block_map_block_map_block_expr_variable_expr "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_table_block_stmt_separator,
\    nft_EOS

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements' '='
hi link   nft_add_cmd_table_block_map_block_elements_equal nftHL_Operator
syn match nft_add_cmd_table_block_map_block_elements_equal /=/ skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_map_block_expr_variable_expr,
\    nft_map_expr

" base_cmd add_cmd 'map' map_spec '{' map_block 'elements'
hi link   nft_add_cmd_table_block_map_block_keyword_elements nftHL_Command
syn match nft_add_cmd_table_block_map_block_keyword_elements "elements" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_elements_equal

" base_cmd add_cmd 'map' map_spec '{' map_block 'automerge'
hi link   nft_add_cmd_table_block_map_block_automerge nftHL_Command
syn match nft_add_cmd_table_block_map_block_automerge "auto\-merge" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_separator,

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size' <interval>
hi link   nft_add_cmd_table_block_map_block_map_mechanism_size_value nftHL_Number
syn match nft_add_cmd_table_block_map_block_map_mechanism_size_value "\v[0-9]{1,32}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'size'
hi link   nft_add_cmd_table_block_map_block_map_mechanism_size nftHL_Command
syn match nft_add_cmd_table_block_map_block_map_mechanism_size "size" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_map_mechanism_size_value


" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'memory'
hi link   nft_add_cmd_table_block_map_block_map_mechanism_policy_memory nftHL_Action
syn match nft_add_cmd_table_block_map_block_map_mechanism_policy_memory "memory" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_separator,
\    nft_comment_inline

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy' 'performance'
hi link   nft_add_cmd_table_block_map_block_map_mechanism_policy_performance nftHL_Action
syn match nft_add_cmd_table_block_map_block_map_mechanism_policy_performance "performance" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_separator

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism 'policy'
hi link   nft_add_cmd_table_block_map_block_map_mechanism_policy nftHL_Command
syn match nft_add_cmd_table_block_map_block_map_mechanism_policy "policy" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_map_mechanism_policy_memory,
\    nft_add_cmd_table_block_map_block_map_mechanism_policy_performance

" base_cmd add_cmd 'map' map_spec '{' map_block map_mechanism
syn cluster nft_c_add_cmd_table_block_map_block_map_mechanism
\ contains=
\    nft_add_cmd_table_block_map_block_map_mechanism_size,
\    nft_add_cmd_table_block_map_block_map_mechanism_policy

" base_cmd add_cmd 'table' table_block 'map' identifier '{' map_block '}'
hi link    nft_add_cmd_table_block_map_block_delimiters nftHL_BlockDelimitersSet
syn region nft_add_cmd_table_block_map_block_delimiters start="{" end="}" skip="\\{" skipwhite contained
\ contains=
\    @nft_c_add_cmd_table_block_map_block_typeof_key_expr,
\    nft_add_cmd_table_block_map_block_keyword_flags,
\    nft_add_cmd_table_block_map_block_keyword_timeout,
\    nft_add_cmd_table_block_map_block_keyword_gc_interval,
\    @nft_c_stateful_stmt,
\    @nft_c_add_cmd_table_block_map_block_map_mechanism,
\    nft_add_cmd_table_block_map_block_keyword_elements,
\    nft_add_cmd_table_block_map_block_automerge
\ nextgroup=
\    nft_comment_inline,
\    nft_line_stmt_separator

" base_cmd add_cmd 'table' table_block 'map' identifier
hi link   nft_add_cmd_table_block_keyword_map_identifier nftHL_Identifier
syn match nft_add_cmd_table_block_keyword_map_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_delimiters

" base_cmd add_cmd 'table' table_block 'map' 'last'
hi link   nft_add_cmd_table_block_keyword_map_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_table_block_keyword_map_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_map_block_delimiters

" base_cmd add_cmd 'table' table_block 'map'
hi link   nft_add_cmd_table_block_keyword_map nftHL_Command
syn match nft_add_cmd_table_block_keyword_map "map" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_keyword_map_identifier_keyword_last,
\    nft_add_cmd_table_block_keyword_map_identifier,

" ************* END table_block 'map' map_block ***************
" ************* BEGIN table_block 'flowtable' flowtable_block ***************
hi link   nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_int nftHL_Integer
syn match nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_int "\v\-?[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

hi link   nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_var nftHL_Variable
syn match nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_var "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained

hi link   nft_c_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_sign nftHL_Expression
syn match nft_c_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_sign "\v[-+]" skipwhite contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_int

hi link   nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_name nftHL_Action
syn match nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_name "\v[a-zA-Z][a-zA-Z]{1,16}" skipwhite contained
\ nextgroup=
\     nft_c_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_sign

syn cluster nft_c_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended
\ contains=
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_int,
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_var,
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended_name

hi link   nft_add_cmd_block_table_flowtable_block_hook_keyword_priority nftHL_Action
syn match nft_add_cmd_block_table_flowtable_block_hook_keyword_priority "priority" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_block_table_flowtable_block_hook_keyword_priority_extended

hi link    nft_add_cmd_block_table_flowtable_block_hook_string_quoted_double nftHL_String
syn region nft_add_cmd_block_table_flowtable_block_hook_string_quoted_double start='"' end='"' skip="\\\"" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority

hi link    nft_add_cmd_block_table_flowtable_block_hook_string_quoted_single nftHL_String
syn region nft_add_cmd_block_table_flowtable_block_hook_string_quoted_single start="'" end="'" skip="\\\'" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority

hi link    nft_add_cmd_block_table_flowtable_block_hook_string_unquoted nftHL_String
syn match nft_add_cmd_block_table_flowtable_block_hook_string_unquoted "\v[a-zA-Z0-9]{1,64}" skipwhite skipnl skipempty contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_hook_keyword_priority

syn cluster nft_c_add_cmd_block_table_flowtable_spec_flowtable_block_hook_string
\ contains=
\    nft_add_cmd_block_table_flowtable_block_hook_string_quoted_double,
\    nft_add_cmd_block_table_flowtable_block_hook_string_quoted_single,
\    nft_add_cmd_block_table_flowtable_block_hook_string_unquoted

hi link   nft_add_cmd_block_table_flowtable_block_stmt_separator nftHL_Operator
syn match nft_add_cmd_block_table_flowtable_block_stmt_separator ";" skipwhite contained

" base_cmd_add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'hook'
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_hook nftHL_Statement
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_hook "\v[{ ;]\zshook\ze[;} ]" skipwhite skipnl skipempty contained
\ nextgroup=
\    @nft_c_add_cmd_block_table_flowtable_spec_flowtable_block_hook_string

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list flowtable_flag
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag nftHL_Action
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag skipwhite contained
\ "\v(offload)"
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags' flowtable_flag_list
syn cluster nft_c_add_cmd_block_table_flowtable_spec_flowtable_block_flowtable_flag_list
\ contains=
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags_flowtable_flag_list_flowtable_flag

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'flags'
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags nftHL_Statement
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_block_table_flowtable_spec_flowtable_block_flowtable_flag_list,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" TODO: [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '=' flowtable_expr
" flowtable_block_expr->'='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line

" base_cmd add_cmd 'flowtable' flowtable_spec '{' flowtable_block 'counter'
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_counter nftHL_Statement
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_counter "counter" skipwhite contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_block_stmt_separator,
\    nft_CurlyBraceAheadSilent,
\    nft_Error

hi link    nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_flowtable_block_expr nftHL_BlockDelimitersFlowtable
syn region nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_flowtable_block_expr start="{" end="}" skipwhite contained

hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_expr_variable nftHL_Variable
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_expr_variable "\v\$[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices' '='
" '='->'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_equal nftHL_Expression
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_equal "=" skipwhite contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_flowtable_block_expr,
\    nft_add_cmd_block_table_flowtable_spec_flowtable_expr_variable

" [ 'add' ] 'flowtable' table_id flow_id '{' 'devices'
" 'devices'->flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link   nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices nftHL_Statement
syn match nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices "devices" skipwhite contained
\ nextgroup=
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices_equal

" [ 'add' ] 'flowtable' table_id flow_id '{' flowtable_block
" flowtable_block->'{'->'flowtable'->add_cmd->base_cmd->line
hi link    nft_add_cmd_block_table_flowtable_spec_flowtable_block nftHL_BlockDelimitersFlowTable
syn region nft_add_cmd_block_table_flowtable_spec_flowtable_block start="{" end="}" skipwhite contained
\ nextgroup=
\    nft_comment_inline,
\    nft_Semicolon,
\    nft_EOS,
\    nft_Error
\ contains=
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_counter,
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_devices,
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_flags,
\    nft_add_cmd_block_table_flowtable_spec_flowtable_block_hook,
\    @nft_c_common_block,
\    nft_add_cmd_block_table_flowtable_block_stmt_separator,
\    nft_Error

" base_cmd add_cmd 'table' table_block 'flowtable' identifier '{' flowtable_block '}'
hi link    nft_add_cmd_table_block_flowtable_block_delimiters nftHL_BlockDelimitersSet
syn region nft_add_cmd_table_block_flowtable_block_delimiters start="{" end="}" skip="\\{" skipwhite contained
\ contains=
\    @nft_c_flowtable_block
\ nextgroup=
\    nft_comment_inline,
\    nft_line_stmt_separator

" base_cmd add_cmd 'table' table_block 'flowtable' identifier
hi link   nft_add_cmd_table_block_keyword_flowtable_identifier nftHL_Identifier
syn match nft_add_cmd_table_block_keyword_flowtable_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_flowtable_block_delimiters

" base_cmd add_cmd 'table' table_block 'flowtable' 'last'
hi link   nft_add_cmd_table_block_keyword_flowtable_identifier_keyword_last nftHL_Action
syn match nft_add_cmd_table_block_keyword_flowtable_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_flowtable_block_delimiters

" base_cmd add_cmd 'table' table_block 'flowtable'
hi link   nft_add_cmd_table_block_keyword_flowtable nftHL_Command
syn match nft_add_cmd_table_block_keyword_flowtable "flowtable" skipwhite contained
\ nextgroup=
\    nft_add_cmd_table_block_keyword_flowtable_identifier_keyword_last,
\    nft_add_cmd_table_block_keyword_flowtable_identifier,

" ************* END table_block 'flowtable' flowtable_block ***************
""""""""" END OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""

" base_cmd add_cmd 'table' table_block table_options ';'
hi link   nft_add_cmd_keyword_table_table_block_table_options_semicolon nftHL_Normal
syn match nft_add_cmd_keyword_table_table_block_table_options_semicolon ";" skipwhite contained

" base_cmd_add_cmd 'table'  table_blocktable_options
syn cluster nft_c_add_cmd_keyword_table_table_block_table_options
\ contains=
\    nft_add_cmd_keyword_table_table_options_table_keyword_flags,
\    nft_add_cmd_keyword_table_table_options_comment_spec,
\    nft_add_cmd_keyword_table_table_block_table_options_semicolon  " this makes it unique apart from nft_add_chain
\    nft_UnexpectedEOS

" table_block 'chain' (via table_block)
" hi link   nft_chain_identifier_keyword nftHL_Command
" syn match nft_chain_identifier_keyword ^\vchain skipnl skipwhite contained


" [ [ 'add' ] 'table' ] table_id '{' ';'
" ';'->stmt_separator->table_block->'table'->add_cmd->'add'->base_cmd->line
hi link   nft_table_block_stmt_separator nftHL_BlockDelimitersTable
syn match nft_table_block_stmt_separator "\v(\n|;)" skipwhite contained

" [ [ 'add' ] 'table' ] table_id '{'
" table_block->add_cmd->base_cmd->line
" table_block->'table'->add_cmd->'add'->base_cmd->line
hi link    nft_add_cmd_keyword_table_table_block nftHL_BlockDelimitersTable
syn region nft_add_cmd_keyword_table_table_block start="{" end="}" skipnl skipempty skipwhite contained
\ nextgroup=
\    nft_hash_comment,
\    nft_table_block_stmt_separator,
\    nft_EOS
\ containedin=
\    nft_add_cmd_keyword_table_table_options_comment_spec,
\    nft_add_cmd_keyword_table_table_options_table_flag_keyword,
\    nft_add_cmd_keyword_table_table_block_table_options_semicolon
\ contains=
\    @nft_c_common_block,
\    @nft_c_add_cmd_keyword_table_table_block_table_options,
\    nft_add_cmd_table_block_keyword_chain,
\    nft_add_cmd_table_block_keyword_set,
\    nft_add_cmd_table_block_keyword_map,
\    nft_add_cmd_table_block_keyword_flowtable


" base_cmd add_cmd 'table' table_spec family_spec identifier
hi link   nft_add_table_spec_identifier nftHL_Identifier
syn match nft_add_table_spec_identifier "\v[a-zA-Z][A-Za-z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block,
\    nft_comment_inline,
\    nft_Semicolon,
\    nft_EOS

hi link   nft_add_table_spec_identifier_keyword_last nftHL_Action
syn match nft_add_table_spec_identifier_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_table_table_block,
\    nft_comment_inline,
\    nft_Semicolon,
\    nft_EOS

" base_cmd add_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_add_table_spec_family_spec_valid nftHL_Family
syn match nft_add_table_spec_family_spec_valid "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_table_spec_identifier_keyword_last,
\    nft_add_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd add_cmd 'table' table_spec
syn cluster nft_c_add_table_spec
\ contains=
\    nft_add_table_spec_identifier_keyword_last,
\    nft_add_table_spec_family_spec_valid,
\    nft_add_table_spec_identifier



""""""""" BEGIN OF INSIDE THE TABLE BLOCK """""""""""""""""""""""""""""""""""""""""""""""
" table_flag (via table_options 'flags')
hi link   nft_add_table_options_flag_list_item_comma nftHL_Expression
syn match nft_add_table_options_flag_list_item_comma ',' skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_table_options_table_flag_recursive

hi link   nft_add_table_options_flag_list_item nftHL_String
syn match nft_add_table_options_flag_list_item "\v[a-zA-Z][a-zA-Z0-9\/\\_\.\-]{0,64}" skipwhite contained
\ nextgroup=
\    nft_add_table_options_flag_list_item_comma,
\    nft_Semicolon

" add_cmd 'table' table_block table_options 'flags' table_flag
syn cluster nft_c_add_cmd_keyword_table_table_block_table_options_table_flag_recursive
\ contains=
\    nft_add_table_options_flag_list_item

" add_cmd 'table' table_block table_options 'flags'
hi link   nft_add_cmd_keyword_table_table_options_table_keyword_flags nftHL_Statement
syn match nft_add_cmd_keyword_table_table_options_table_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_table_table_block_table_options_table_flag_recursive,
\    nft_Semicolon

