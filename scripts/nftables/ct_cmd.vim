


" limit_config->(add_cmd|create_cmd|limit_block)
hi link   nft_limit_config nftHL_Command
syn match nft_limit_config "rate" skipwhite contained
\ nextgroup=
\    nft_limit_config_limit_mode,
\    nft_limit_config_limit_rate_pktsbytes_num

hi link   nft_ct_expect_config_ct_l4protoname nftHL_Type
syn match nft_ct_expect_config_ct_l4protoname "\v(udp|tcp)" skipwhite contained

" 'protocol'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_keyword_protocol nftHL_Action
syn match nft_ct_expect_config_keyword_protocol "protocol" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_ct_l4protoname

" <num>->('dport'|'size')->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_num nftHL_Action
syn match nft_ct_expect_config_num "\v[0-9]{1,11}" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'dport'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_keyword_dport nftHL_Action
syn match nft_ct_expect_config_keyword_dport "dport" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_num

" 'size'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_keyword_size nftHL_Action
syn match nft_ct_expect_config_keyword_size "size" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_num

" <time_spec>->'timeout'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_time_spec nftHL_Family
syn match nft_ct_expect_config_time_spec "\w{1,32}" skipwhite contained

" 'timeout'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_keyword_timeout nftHL_Action
syn match nft_ct_expect_config_keyword_timeout "timeout" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_time_spec

" ('ip'|'ip6'|'inet'|'bridge'|'netdev'|'arp')->'l3proto'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_family_spec_explicit nftHL_Family
syn match nft_ct_expect_config_family_spec_explicit "\v(ip[6]|inet|bridge|netdev|arp)" skipwhite contained

" 'l3proto'->ct_expect_config->ct_expect_block
hi link   nft_ct_expect_config_keyword_l3proto nftHL_Action
syn match nft_ct_expect_config_keyword_l3proto "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_expect_config_family_spec_explicit

" ct_expect_config->ct_expect_block
syn cluster nft_c_ct_expect_config
\ contains=
\    nft_ct_expect_config_keyword_protocol,
\    nft_ct_expect_config_keyword_dport,
\    nft_ct_expect_config_keyword_size,
\    nft_ct_expect_config_keyword_timeout,
\    nft_ct_expect_config_keyword_l3proto

" 'protocol'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_ct_l4protoname nftHL_Action
syn match nft_ct_timeout_config_ct_l4protoname "\v(tcp|udp)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'protocol'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_keyword_protocol nftHL_Command
syn match nft_ct_timeout_config_keyword_protocol "protocol" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_ct_l4protoname

" <family_spec_explicit>->'l3proto'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_family_spec_explicit nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_ct_timeout_config_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'l3protocol'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_keyword_l3protocol nftHL_Command
syn match nft_ct_timeout_config_keyword_l3protocol "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_family_spec_explicit

" ','->timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_policy_block_comma nftHL_Element
syn match nft_ct_timeout_config_policy_block_comma "," skipwhite contained
\ nextgroup=
\    @nft_c_ct_timeout_config_policy_block_timeout_states

" time_spec_or_num_s->timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_policy_block_time_spec_or_num_s nftHL_Number
syn match nft_ct_timeout_config_policy_block_time_spec_or_num_s "\v\w{1,32}" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_comma

" timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_policy_block_colon nftHL_Expression
syn match nft_ct_timeout_config_policy_block_colon ":" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_time_spec_or_num_s

" timeout_state->'{'->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_policy_block_timeout_state nftHL_Statement
syn match nft_ct_timeout_config_policy_block_timeout_state "\v\w{1,32}" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_policy_block_colon

" timeout_states->'{'->'policy'->ct_timeout_config->ct_timeout_block
syn cluster nft_c_ct_timeout_config_policy_block_timeout_states
\ contains=
\    nft_ct_timeout_config_policy_block_timeout_state

" '{'->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_keyword_policy_block nftHL_BlockDelimiters
syn region nft_ct_timeout_config_keyword_policy_block start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_ct_timeout_config_policy_block_timeout_states
\ nextgroup=
\    nft_Semicolon

" '='->'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_keyword_policy_equal nftHL_Operator
syn match nft_ct_timeout_config_keyword_policy_equal "=" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_keyword_policy_block

" 'policy'->ct_timeout_config->ct_timeout_block
hi link   nft_ct_timeout_config_keyword_policy nftHL_Command
syn match nft_ct_timeout_config_keyword_policy "policy" skipwhite contained
\ nextgroup=
\    nft_ct_timeout_config_keyword_policy_equal

" ct_timeout_config->ct_timeout_block
syn cluster nft_c_ct_timeout_config
\ contains=
\    nft_c_ct_timeout_config_keyword_protocol,
\    nft_ct_timeout_config_keyword_l3protocol,
\    nft_ct_timeout_config_keyword_policy

" 'protocol'->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_ct_l4protoname nftHL_Family
syn match nft_ct_helper_config_ct_l4protoname "\v(tcp|udp)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'protocol'->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_protocol nftHL_Command
syn match nft_ct_helper_config_protocol "protocol" skipwhite contained
\ nextgroup=
\    nft_ct_helper_config_ct_l4protoname

" <quoted_string>->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_type_string_quoted nftHL_String
syn region nft_ct_helper_config_type_string_quoted start="\"" skip="\\\"" end="\"" skipwhite oneline contained
\ nextgroup=
\    nft_ct_helper_config_protocol

" 'type'->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_type nftHL_Command
syn match nft_ct_helper_config_type "type" skipwhite contained
\ nextgroup=
\    nft_ct_helper_config_type_string_quoted

" family_spec_explicit->'l3proto'->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_l3protocol_family_spec_explicit nftHL_Family
syn match nft_ct_helper_config_l3protocol_family_spec_explicit "\v(ip(6)?|inet|bridge|netdev|arp)" skipwhite contained
\ nextgroup=
\    nft_Semicolon

" 'l3proto'->ct_helper_config->ct_helper_block
hi link   nft_ct_helper_config_l3protocol nftHL_Command
syn match nft_ct_helper_config_l3protocol "l3proto" skipwhite contained
\ nextgroup=
\    nft_ct_helper_config_l3protocol_family_spec_explicit

" ct_helper_config->ct_helper_block
syn cluster nft_c_ct_helper_config
\ contains=
\    nft_ct_helper_config_type,
\    nft_ct_helper_config_l3protocol

" skipping ct_l4protoname (via inlining)

" ct_cmd_type->list_cmd
hi link   nft_ct_cmd_type nftHL_Type
syn match nft_ct_cmd_type "\v(helpers|timeout|expectation)" skipwhite contained

" ct_obj_type->(delete_cmd|destroy_cmd|list_cmd)
hi link   nft_ct_obj_type nftHL_Type
syn match nft_ct_obj_type "\v(helpers|timeout|expectation)" skipwhite contained
