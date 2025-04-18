


" common_block
" common_block (via chain_block, counter_block, ct_expect_block, ct_helper_block,
"                   ct_timeout_block, flowtable_block, limit_block, line, map_block,
"                   quota_block, secmark_block, set_block, synproxy_block, table_block

" common_block 'define'/'redefine identifier <STRING> '=' initializer_expr
" common_block 'define'/'redefine identifier <STRING> '=' rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' list_rhs_expr
" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
" common_block 'define'/'redefine identifier <STRING> '=' '-'number
hi link   nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\v\-[0-9]{1,7}" skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine' value (via nft_common_block_define_redefine_equal)
hi link   nft_common_block_define_redefine_value nftHL_Number
syn match nft_common_block_define_redefine_value "\v[\'\"\$\{\}:a-zA-Z0-9\_\/\\\.\,\}\{]+\s{0,16}" skipwhite contained
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier <STRING> '=' '{' '}'
hi link    nft_common_block_define_redefine_initializer_expr_empty_set nftHL_Normal
syn region nft_common_block_define_redefine_initializer_expr_empty_set start="{" end="}" skipwhite contained
\ contains=
\    nft_Error
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier <STRING> '=' -number
hi link   nft_common_block_define_redefine_initializer_expr_dash_num nftHL_Number
syn match nft_common_block_define_redefine_initializer_expr_dash_num "\v\-[0-9]{1,7}" skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator

" common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr basic_rhs_expr
hi link   nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr nftHL_Operator
syn match nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_exclusive_or_rhs_expr /|/ skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_initializer_expr_nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr_bar,
\    nft_common_block_stmt_separator
" TODO: typo ^^^^

" END OF common_block

" num->initializer_expr->common_block
hi link   nft_common_block_define_redefine_keywords_initializer_expr_num nftHL_Integer
syn match nft_common_block_define_redefine_keywords_initializer_expr_num "\v[0-9]{1,11}" skipwhite contained

" '-'->initializer_expr->common_block
hi link   nft_common_block_define_redefine_keywords_initializer_expr_dash nftHL_Element
syn match nft_common_block_define_redefine_keywords_initializer_expr_dash /-/ skipwhite contained
\ nextgroup=
\    nft_common_block_define_redefine_keywords_initializer_expr_num

" '{'->initializer_expr->common_block
hi link   nft_common_block_define_redefine_keywords_initializer_expr_block nftHL_Normal
syn region nft_common_block_define_redefine_keywords_initializer_expr_block start="{" end="}" skipwhite contained

" initializer_expr->common_block
syn cluster nft_common_block_define_redefine_keywords_initializer_expr
\ contains=
\    nft_common_block_define_redefine_keywords_initializer_expr_dash,
\    nft_common_block_define_redefine_keywords_initializer_expr_block,
\    @nft_c_rhs_expr,
\    @nft_c_list_rhs_expr
" list_rhs_expr must be the last 'contains=' entry
"     as its basic_rhs_expr->exclusive_or_rhs_expr->and_rhs_expr->shift_rhs_expr->primary_rhs_expr->symbol_expr
"     uses <string> which is a (wildcard)

hi link   nft_common_block_filespec_sans_single_quote nftHL_String
syn match nft_common_block_filespec_sans_single_quote "\v[\"_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\\\(\)\{\}\[\]\<\>(\\\')]+" keepend contained

hi link    nft_common_block_filespec_quoted_single nftHL_String
syn region nft_common_block_filespec_quoted_single start="\'" skip="\\\'" end="\'" skipwhite keepend oneline contained
\ contains=
\    nft_common_block_filespec_sans_single_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_common_block_filespec_sans_double_quote nftHL_String
syn match nft_common_block_filespec_sans_double_quote "\v[\'_\-\.\;\?a-zA-Z0-9\,\:\+\=\*\&\^\%\$\!`\~\#\@\|\/\(\)\{\}\[\]\<\>(\\\")]+" keepend contained

hi link    nft_common_block_filespec_quoted_double nftHL_String
syn region nft_common_block_filespec_quoted_double start="\"" skip="\\\"" end="\"" skipwhite oneline keepend contained
\ contains=
\    nft_common_block_filespec_sans_double_quote
\ nextgroup=
\    nft_comment_inline,
\    nft_common_block_stmt_separator,
\    nft_Error

syn cluster nft_c_common_block_keyword_include_quoted_string
\ contains=
\    nft_common_block_filespec_quoted_single,
\    nft_common_block_filespec_quoted_double,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

hi link   nft_common_block_keyword_include nftHL_Include
syn match nft_common_block_keyword_include "include" skipwhite oneline contained
\ nextgroup=
\    @nft_c_common_block_keyword_include_quoted_string,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr concat_rhs_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_basic_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr_multion_rhs_expr

" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_expr
" TODO: common_block 'define'/'redefine identifier '=' rhs_expr set_ref_symbol_expr

" common_block 'define'/'redefine identifier '=' rhs_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr_rhs_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_concat_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_set_expr,
\    nft_common_block_define_redefine_initializer_expr_rhs_expr_set_ref_symbol_expr

" common_block 'define'/'redefine identifier '=' initializer_expr
syn cluster nft_c_common_block_define_redefine_initializer_expr
\ contains=
\    nft_common_block_define_redefine_initializer_expr_empty_set,
\    nft_common_block_define_redefine_initializer_expr_dash_num,
\    @nft_c_common_block_define_redefine_initializer_expr_rhs_expr,
\    nft_common_block_define_redefine_initializer_expr_list_rhs_expr

" common_block 'define'/'redefine identifier '='
hi link   nft_common_block_define_redefine_equal nftHL_Operator
syn match nft_common_block_define_redefine_equal "=" skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_initializer_expr

" common_block 'define'/'redefine identifier <STRING>
hi link   nft_common_block_define_redefine_identifier_string nftHL_Identifier
syn match   nft_common_block_define_redefine_identifier_string '[A-Za-z0-9\-_./]\{1,64}' skipwhite contained
\ nextgroup=
\    nft_common_block_define_redefine_equal

" common_block 'define'/'redefine identifier <STRING>
hi link   nft_common_block_define_redefine_identifier_last nftHL_Action
syn match nft_common_block_define_redefine_identifier_last "last" skipwhite contained
\ nextgroup=
\    nft_common_block_define_redefine_equal

" common_block 'define'/'redefine' identifier (via common_block 'redefine'/'define')
syn cluster nft_c_common_block_define_redefine_identifier
\ contains=
\    nft_common_block_define_redefine_identifier_last,
\    nft_common_block_define_redefine_identifier_string

" 'define' (via "
" commmon_block 'redefine' (via common_block)
hi link   nft_common_block_redefine nftHL_Command
syn match nft_common_block_redefine contained "redefine" skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_identifier

" common_block 'define' (via common_block)
hi link   nft_common_block_define nftHL_Command
syn match nft_common_block_define contained "define" skipwhite contained
\ nextgroup=
\    @nft_c_common_block_define_redefine_identifier

" common_block 'undefine' identifier (via common_block 'undefine')
hi link   nft_common_block_undefine_identifier nftHL_Identifier
syn match nft_common_block_undefine_identifier '\v[a-zA-Z][A-Za-z0-9\\\/_\.]{0,63}' oneline skipwhite contained
\ nextgroup=
\    nft_common_block_stmt_separator,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS

" commmon_block 'undefine' (via common_block)
hi link   nft_common_block_undefine nftHL_Command
syn match nft_common_block_undefine "undefine" oneline skipwhite contained
\ nextgroup=
\    nft_common_block_undefine_identifier,
\    nft_UnexpectedCurlyBrace,
\    nft_EOS
" commmon_block 'redefine' (via common_block)
" common_block->line
" common_block->table_block
" common_block->chain_block
" common_block->counter_block
" common_block->ct_expect_block
" common_block->ct_helper_block
" common_block->ct_timeout_block
" common_block->flowtable_block
" common_block->limit_block
" common_block->map_block
" common_block->quota_block
" common_block->secmark_block
" common_block->set_block
" common_block->synproxy_block
syn cluster nft_c_common_block
\ contains=
\    nft_common_block_keyword_include,
\    nft_common_block_define,
\    nft_common_block_redefine,
\    nft_common_block_undefine,
\    nft_common_block_stmt_separator,
\    nft_hash_comment,
\    nft_EOL
"\    nft_InlineComment,