


" 'jump'|'goto' '{' rule '}'
" rule->chain_stmt_type->chain_stmt->stmt
syn cluster nft_c_chain_stmt_block_rule
\ contains=@nft_c_rule
" TODO missing stmt_separator

" 'jump'|'goto' '{' ...
" chain_stmt_type->chain_stmt->stmt
hi link    nft_chain_stmt_block_delimiters nftHL_BlockDelimitersChain
syn region nft_chain_stmt_block_delimiters start="{" end="}" skipwhite contained
\ contains=
\    @nft_c_chain_stmt_block_rule
\ nextgroup=
\    nft_EOS

" 'jump'|'goto'
" chain_stmt_type->chain_stmt->stmt
hi link   nft_chain_stmt_type nftHL_Statement
syn match nft_chain_stmt_type "\v(jump|goto)" skipwhite contained
\ nextgroup=
\    nft_chain_stmt_block_delimiters

" chain_stmt->stmt
syn cluster nft_c_chain_stmt
\ contains=
\   nft_chain_stmt_type