


" 'log' 'flags' 'tcp' log_flag_tcp ',' log_flag_tcp
" log_flag_tcp->log_flags->log_arg->log_stmt->stmt
hi link   nft_log_flags_log_flag_keyword_tcp nftHL_Action
syn match nft_log_flags_log_flag_keyword_tcp "\v(seq|options)" skipwhite contained
\ nextgroup=
\    nft_log_flags_log_flags_tcp_expression_comma,
\    nft_EOS

" 'log' 'flags' 'tcp' 'seq'|'options' ','
" ','->log_flag_tcp->log_arg->log_stmt->stmt
hi link   nft_log_flags_log_flags_tcp_expression_comma nftHL_Operator
syn match nft_log_flags_log_flags_tcp_expression_comma /,/ skipwhite contained
\ nextgroup=
\    @nft_c_log_flags_log_flags_tcp,
\    nft_EOS

" 'log' 'flags' 'tcp' ('seq'|'options')
" log_flag_tcp->log_arg->log_stmt->stmt
syn cluster nft_c_log_flags_log_flags_tcp
\ contains=
\    nft_log_flags_log_flag_keyword_tcp

" 'log' 'flags' 'tcp'
" 'tcp'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_tcp nftHL_Action
syn match nft_log_flags_keyword_tcp "tcp" skipwhite contained
\ nextgroup=
\    @nft_c_log_flags_log_flags_tcp,
\    nft_UnexpectedEOS

" 'log' 'flags' 'ip' 'options'
" 'options'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ip_keyword_options nftHL_Action
syn match nft_log_flags_keyword_ip_keyword_options "options" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'log' 'flags' 'ip'
" 'ip'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ip nftHL_Action
syn match nft_log_flags_keyword_ip "ip" skipwhite contained
\ nextgroup=
\    nft_log_flags_keyword_ip_keyword_options,
\    nft_UnexpectedEOS

" 'log' 'flags' 'skuid'
" 'skuid'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_skuid nftHL_Action
syn match nft_log_flags_keyword_skuid "skuid" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'log' 'flags' 'ether'
" 'ether'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_ether nftHL_Action
syn match nft_log_flags_keyword_ether "ether" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'log' 'flags' 'all'
" 'all'->log_arg->log_stmt->stmt
hi link   nft_log_flags_keyword_all nftHL_Action
syn match nft_log_flags_keyword_all "all" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'log' 'prefix' <ASTERISK_STRING>
hi link   nft_log_arg_keyword_prefix_string_asterisks nftHL_String
syn region nft_log_arg_keyword_prefix_string_asterisks start="\*" end="\*" skip="\\\*" skipwhite oneline contained
\ nextgroup=
\    nft_EOS

" 'log' 'prefix' <QUOTED_STRING> (single-quoted)
hi link   nft_log_arg_keyword_prefix_string_quoted_singles nftHL_String
syn region nft_log_arg_keyword_prefix_string_quoted_singles start="\'" end="\'" skip="\\\'" skipwhite oneline contained
\ nextgroup=
\    nft_EOS

" 'log' 'prefix' <QUOTED_STRING> (double-quoted)
hi link   nft_log_arg_keyword_prefix_string_quoted_doubles nftHL_String
syn region nft_log_arg_keyword_prefix_string_quoted_doubles start="\"" end="\"" skip="\\\"" skipwhite oneline contained
\ nextgroup=
\    nft_EOS

" 'log' 'prefix' <STRING>  ; unquoted strings (no whitespace)
hi link   nft_log_arg_keyword_prefix_string_unquoted nftHL_String
syn match nft_log_arg_keyword_prefix_string_unquoted "\v[a-zA-Z0-9]{1,64}" skipwhite contained oneline
\ nextgroup=
\    nft_EOS

" 'log' 'level' <STRING>
hi link   nft_log_arg_string_level nftHL_String
syn match nft_log_arg_string_level "\v(emerg|alert|crit|err|warn|notice|info|debug|audit|level[0-9])" skipwhite contained
\ nextgroup=
\    nft_EOS

" 'log' 'group' <NUM>
" 'log' 'snaplen' <NUM>
" 'log' 'queue-threshold' <NUM>
hi link   nft_log_arg_num nftHL_Number
syn match nft_log_arg_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

" nft_log_arg_keyword_prefix
hi link   nft_log_arg_keyword_prefix nftHL_Statement
syn match nft_log_arg_keyword_prefix "prefix" skipwhite contained
\ nextgroup=
\    nft_log_arg_keyword_prefix_string_quoted_singles,
\    nft_log_arg_keyword_prefix_string_quoted_doubles,
\    nft_log_arg_keyword_prefix_string_asterisks,
\    nft_log_arg_keyword_prefix_string_unquoted,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_group
hi link   nft_log_arg_keyword_group nftHL_Statement
syn match nft_log_arg_keyword_group "group" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_snaplen
hi link   nft_log_arg_keyword_snaplen nftHL_Statement
syn match nft_log_arg_keyword_snaplen "snaplen" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

"  nft_log_arg_keyword_queue_threshold
hi link   nft_log_arg_keyword_queue_threshold nftHL_Statement
syn match nft_log_arg_keyword_queue_threshold "queue\-threshold" skipwhite contained
\ nextgroup=
\    nft_log_arg_num,
\    nft_UnexpectedEOS

" nft_log_arg_keyword_level
hi link   nft_log_arg_keyword_level nftHL_Statement
syn match nft_log_arg_keyword_level "level" skipwhite contained
\ nextgroup=
\    nft_log_arg_string_level,
\    nft_UnexpectedEOS

" 'log' 'flags' ('tcp'|'ip'|'skuid'|'ether'|'all')
" log_flags->log_arg->log_stmt->stmt
hi link   nft_log_arg_keyword_flags nftHL_Statement
syn match nft_log_arg_keyword_flags "flags" skipwhite contained
\ nextgroup=
\    nft_log_flags_keyword_tcp,
\    nft_log_flags_keyword_ip,
\    nft_log_flags_keyword_skuid,
\    nft_log_flags_keyword_ether,
\    nft_log_flags_keyword_all,
\    nft_UnexpectedEOS

" 'log' ( log_arg )*
" log_arg->log_stmt->stmt
syn cluster nft_c_log_arg
\ contains=
\    nft_log_arg_keyword_prefix,
\    nft_log_arg_keyword_group,
\    nft_log_arg_keyword_snaplen,
\    nft_log_arg_keyword_queue_threshold,
\    nft_log_arg_keyword_level,
\    nft_log_arg_keyword_flags

" 'log'
" log_stmt->stmt
hi link   nft_log_stmt nftHL_Command
syn match nft_log_stmt "log" skipwhite contained
\ nextgroup=
\    @nft_c_log_arg,
\    nft_EOS
" No `nft_UnexpectedEOS` for nft_log_stmt, `log` alone is permitted.

