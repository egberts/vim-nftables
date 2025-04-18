


"""""""""""""""""" flush_cmd BEGIN """"""""""""""""""""""""""""""""""
" base_cmd 'flush' 'ruleset' ruleset_spec
hi link   nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit "\v(ip6?|inet)" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" base_cmd 'flush' 'ruleset' set_spec
" family_spec_explicit->ruleset_spec->'ruleset'->flush_cmd-'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_ruleset_end nftHL_Command
syn match nft_flush_cmd_keyword_ruleset_end "ruleset" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_ruleset_ruleset_spec_family_spec_explicit,
\    nft_UnexpectedSemicolon,
\    nft_EOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
" identifier->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_chain_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_set_et_al_chain_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" flush_cmd 'set' set_spec family_spec family_spec_explicit
" identifier->table_spec->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_set_et_al_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_set_et_al_chain_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" family_spec_explicit->table_spec->chain_spec->'chain'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_set_et_al_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'set' set_spec
syn cluster nft_c_flush_cmd_keyword_set_et_al_set_spec_end
\ contains=
\    nft_flush_cmd_keyword_set_et_al_set_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_set_et_al_table_spec_identifier

" base_cmd [ 'flush' ] [ 'set' ] set_spec
" base_cmd [ 'flush' ] [ 'flow' ] [ 'table' ] set_spec
" base_cmd [ 'flush' ] [ 'meter' ] set_spec
hi link   nft_flush_cmd_keyword_set_map_flow_meter_end nftHL_Command
syn match nft_flush_cmd_keyword_set_map_flow_meter_end "\v(set|map|meter|flow table)" skipwhite contained
\ nextgroup=
\    @nft_c_flush_cmd_keyword_set_et_al_set_spec_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec chain_spec
hi link   nft_flush_cmd_keyword_chain_chain_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_chain_chain_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_EOS,
\    nft_Error

" base_cmd flush_cmd 'chain' [ family_spec ] table_spec
hi link   nft_flush_cmd_keyword_chain_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_chain_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_chain_chain_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" flush_cmd 'chain' chain_spec family_spec family_spec_explicit
hi link   nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit nftHL_Family
syn match nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_chain_table_spec_identifier,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'chain' chain_spec
syn cluster nft_c_flush_cmd_keyword_chain_end
\ contains=
\    nft_flush_cmd_keyword_chain_chain_spec_table_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_chain_table_spec_identifier

" base_cmd flush_cmd 'chain'
" base_cmd [ 'flush' ] [ 'chain' ] chain_spec
hi link   nft_flush_cmd_keyword_chain nftHL_Command
syn match nft_flush_cmd_keyword_chain "chain" skipwhite contained
\ nextgroup=
\    @nft_c_flush_cmd_keyword_chain_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

" base_cmd flush_cmd 'table' table_spec family_spec identifier
hi link   nft_flush_cmd_keyword_flush_table_spec_identifier nftHL_Identifier
syn match nft_flush_cmd_keyword_flush_table_spec_identifier "\v[a-zA-Z][a-zA-Z0-9\\\/_\.\-]{0,63}" skipwhite contained
\ nextgroup=
\    nft_stmt_separator,
\    nft_Error

" base_cmd flush_cmd 'table' table_spec family_spec family_spec_explicit
hi link   nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit nftHL_Family  " _add_ to make 'table_spec' pathway unique
syn match nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit "\v(ip(6)?|inet|arp|bridge|netdev)" skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_flush_table_spec_identifier

" base_cmd [ 'flush' ] [ 'table' ] table_spec
" table_spec->'table'->flush_cmd->'flush'->base_cmd->line
syn cluster nft_c_flush_cmd_keyword_flush_table_spec_end
\ contains=
\    nft_flush_cmd_keyword_flush_table_spec_family_spec_explicit,
\    nft_flush_cmd_keyword_flush_table_spec_identifier

" base_cmd flush_cmd 'table'
" 'table'->flush_cmd->'flush'->base_cmd->line
hi link   nft_flush_cmd_keyword_table nftHL_Command
syn match nft_flush_cmd_keyword_table "table" skipwhite contained
\ nextgroup=
\    @nft_c_flush_cmd_keyword_flush_table_spec_end

"""""""""""""""""" flush_cmd END """"""""""""""""""""""""""""""""""



" 'flush'->base_cmd->line
hi link   nft_base_cmd_keyword_flush nftHL_Command
syn match nft_base_cmd_keyword_flush "\vflush\ze " skipwhite contained
\ nextgroup=
\    nft_flush_cmd_keyword_table,
\    nft_flush_cmd_keyword_chain,
\    nft_flush_cmd_keyword_set_map_flow_meter_end,
\    nft_flush_cmd_keyword_ruleset_end,
\    nft_UnexpectedSemicolon,
\    nft_UnexpectedEOS,
\    nft_Error

