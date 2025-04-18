

" unquoted_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link   nft_secmark_config_string_unquoted nftHL_String
syn match nft_secmark_config_string_unquoted "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite keepend contained

" double_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link   nft_secmark_config_string_sans_double_quote nftHL_String
syn match nft_secmark_config_string_sans_double_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\"]{0,63}" keepend contained

" single_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link   nft_secmark_config_string_sans_single_quote nftHL_String
syn match nft_secmark_config_string_sans_single_quote "\v[a-zA-Z][a-zA-Z0-9\\\/_\[\]\']{0,63}" keepend contained

" single_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link   nft_secmark_config_string_single nftHL_String
syn region nft_secmark_config_string_single start="'" skip="\\\'" end="'" keepend oneline contained
\ contains=
\    nft_secmark_config_string_sans_single_quote

" double_string->secmark_config->(add_cmd|create_cmd|secmark_block)
hi link   nft_secmark_config_string_double nftHL_String
syn region nft_secmark_config_string_double start="\"" skip="\\\"" end="\"" keepend oneline contained
\ contains=
\    nft_secmark_config_string_sans_double_quote

" quoted_string->secmark_config->(add_cmd|create_cmd|secmark_block)
syn cluster nft_c_secmark_quoted_string
\ contains=
\    nft_secmark_config_string_single,
\    nft_secmark_config_string_double

" secmark_config->secmark_config->(add_cmd|create_cmd|secmark_block)
syn cluster nft_c_secmark_config
\ contains=
\    @nft_c_secmark_config_quoted_string,
\    nft_secmark_config_string_unquoted