


""""" BEGIN OF add_cmd_/'counter'/obj_spec """""
hi link   nft_add_cmd_keyword_counter_block_stmt_separator nftHL_Normal
syn match nft_add_cmd_keyword_counter_block_stmt_separator "\v(\n|;)" skipwhite contained

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes' <integer>
hi link   nft_add_cmd_keyword_counter_counter_config_bytes_num nftHL_Number
syn match nft_add_cmd_keyword_counter_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOL

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes'
hi link   nft_add_cmd_keyword_counter_counter_config_bytes nftHL_Action
syn match nft_add_cmd_keyword_counter_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_bytes_num

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num>
hi link   nft_add_cmd_keyword_counter_counter_config_packet_num nftHL_Number
syn match nft_add_cmd_keyword_counter_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_bytes

hi link   nft_add_cmd_counter_Error_Always nftHL_Error
syn match nft_add_cmd_counter_Error_Always "\v\i{1,15}" skipwhite contained

" add_cmd 'counter' obj_spec counter_config 'last' 'packet'
hi link   nft_add_cmd_keyword_counter_counter_config_last_packet nftHL_Identifier
syn match nft_add_cmd_keyword_counter_counter_config_last_packet "packet" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_packet_num

" add_cmd 'counter' obj_spec counter_config obj_id 'packet'
hi link   nft_add_cmd_keyword_counter_counter_config nftHL_Action
syn match nft_add_cmd_keyword_counter_counter_config "packets" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_packet_num

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes' <integer>
hi link   nft_add_cmd_keyword_counter_block_counter_config_bytes_num nftHL_Number
syn match nft_add_cmd_keyword_counter_block_counter_config_bytes_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator,
\    nft_EOL

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num> 'bytes'
hi link   nft_add_cmd_keyword_counter_block_counter_config_bytes nftHL_Action
syn match nft_add_cmd_keyword_counter_block_counter_config_bytes "bytes" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_block_config_bytes_num

" add_cmd 'counter' obj_spec counter_config 'packet' <packet_num>
hi link   nft_add_cmd_keyword_counter_block_counter_config_packet_num nftHL_Number
syn match nft_add_cmd_keyword_counter_block_counter_config_packet_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config_bytes

hi link   nft_add_cmd_counter_block_Error_Always nftHL_Error
syn match nft_add_cmd_counter_block_Error_Always "\v\i{1,15}" skipwhite contained

" add_cmd 'counter' obj_spec counter_config obj_id 'packet'
hi link   nft_add_cmd_keyword_counter_block_counter_config nftHL_Action
syn match nft_add_cmd_keyword_counter_block_counter_config "packets" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_block_counter_config_packet_num

" base_cmd add_cmd 'counter' set_spec '{' set_block 'comment' comment_spec STRING
hi link   nft_add_cmd_keyword_counter_counter_block_comment_string_string nftHL_Constant
syn match nft_add_cmd_keyword_counter_counter_block_comment_string_string "\v[\"\'\_\-A-Za-z0-9]{1,64}" contained

" base_cmd add_cmd 'set' counter_counter_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_single nftHL_Constant
syn match nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_single "\v\'[\"\_\- A-Za-z0-9]{1,64}\'" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec QUOTED_STRING
hi link   nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_double nftHL_Constant
syn match nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_double "\v\"[\'\_\- A-Za-z0-9]{1,64}\"" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec ASTERISK_STRING
hi link   nft_add_cmd_keyword_counter_counter_block_comment_string_asterisk nftHL_Constant
syn match nft_add_cmd_keyword_counter_counter_block_comment_string_asterisk "\v\*[\"\'\_\-A-Za-z0-9 ]{1,64}\*" contained

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment' comment_spec
syn cluster nft_c_add_cmd_keyword_counter_counter_block_comment_string
\ contains=
\   nft_add_cmd_keyword_counter_counter_block_comment_string_asterisk,
\   nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_single,
\   nft_add_cmd_keyword_counter_counter_block_comment_string_quoted_double,
\   nft_add_cmd_keyword_counter_counter_block_comment_string_string

" base_cmd add_cmd 'set' set_spec '{' set_block 'comment'
hi link   nft_add_cmd_keyword_counter_counter_block_comment_spec nftHL_Command
syn match nft_add_cmd_keyword_counter_counter_block_comment_spec "comment" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_counter_block_comment_string

" add_cmd 'counter' obj_spec '{' counter_block '}'
hi link    nft_add_cmd_keyword_counter_counter_block nftHL_BlockDelimitersCounter
syn region nft_add_cmd_keyword_counter_counter_block start="{" end="}" skipwhite contained
\ nextgroup=
\    nft_line_stmt_separator
\ contains=
\    nft_add_cmd_keyword_counter_counter_block_comment_spec,
\    @nft_c_common_block,
\    nft_add_cmd_keyword_counter_block_stmt_separator,
\    nft_add_cmd_keyword_counter_counter_config,
\    @nft_c_common_block,
\    nft_comment_spec,
\    nft_add_cmd_keyword_counter_block_stmt_separator

" add_cmd 'counter' table_identifier [ obj_id | 'last' ]
hi link   nft_add_cmd_counter_obj_spec_obj_id nftHL_Identifier
syn match nft_add_cmd_counter_obj_spec_obj_id "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_counter_config,
\    nft_add_cmd_keyword_counter_counter_block,
\    nft_line_stmt_separator,
\    nft_Error

hi link   nft_add_cmd_counter_Semicolon nftHL_Normal
syn match nft_add_cmd_counter_Semicolon contained "\v\s{0,8};" skipwhite contained
\ nextgroup=
\    nft_EOL,
\    nft_comment_inline

hi link   nft_add_cmd_counter_last_Error_Always nftHL_Error
syn match nft_add_cmd_counter_last_Error_Always "\v\i{1,15}" skipwhite contained

syn cluster nft_c_add_cmd_keyword_counter_obj_spec_obj_last
\ contains=
\    nft_add_cmd_keyword_counter_counter_block,
\    nft_add_cmd_keyword_counter_counter_config_last_packet,
\    nft_line_stmt_separator

hi link   nft_add_cmd_keyword_counter_obj_spec_identifier_last nftHL_Action
syn match nft_add_cmd_keyword_counter_obj_spec_identifier_last "last" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec_obj_last

" add_cmd 'counter' obj_spec obj_id table_spec table_id
hi link   nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id nftHL_Identifier
syn match nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id "\v[a-zA-Z][a-zA-Z0-9\\\/\_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_obj_spec_identifier_last,
\    nft_add_cmd_counter_obj_spec_obj_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

hi link   nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id_keyword_last nftHL_Action
syn match nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id_keyword_last "last" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_obj_spec_identifier_last,
\    nft_add_cmd_counter_obj_spec_obj_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" _add_ to make 'chain_spec' pathway unique
hi link   nft_add_cmd_keyword_counter_obj_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_add_cmd_keyword_counter_obj_spec_table_spec_family_spec_explicit "\v(ip6?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id_keyword_last,
\    nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" base_cmd add_cmd 'counter' obj_spec
syn cluster nft_c_add_cmd_keyword_counter_obj_spec
\ contains=
\    nft_add_cmd_keyword_counter_obj_spec_table_spec_family_spec_explicit,
\    nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id_keyword_last,
\    nft_add_cmd_keyword_counter_obj_spec_table_spec_table_id,

""""" END OF add_cmd_/'counter'/obj_spec """""

" ***************** BEGIN base_cmd 'counter' *****************
" 'counter'->add_cmd->'add'->base_cmd->line
hi link   nft_base_cmd_add_cmd_keyword_counter nftHL_Command
syn match nft_base_cmd_add_cmd_keyword_counter "counter" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS

" 'counter'->add_cmd->base_cmd->line
hi link   nft_base_cmd_keyword_counter nftHL_Command
syn match nft_base_cmd_keyword_counter "\v {0,32}counter" skipwhite contained
\ nextgroup=
\    @nft_c_add_cmd_keyword_counter_obj_spec,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS
" ***************** END base_cmd 'counter' *****************