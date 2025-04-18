" File:  concat_hdr_expr.vim
" Description: concat_hdr_expr Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     2.0
" Initial Date: 2025-04-18
" Last Change:  2025-04-18
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
"
"  WARNING:  Do not add online comments using a quote symbol, it ALTERS patterns
"
" Called by: set_rhs_expr
" Called by: set_rhs_expr
" Called by: multiton_rhs_expr
"
" Calls directly: multiton_rhs_expr
" Calls directly: basic_rhs_expr
"
" Also calls: basic_rhs_expr
" Also calls: multion_rhs_expr
"

" base_cmd 'get' 'element' table_id spec_id set_block_expr set_expr '{' set_lhs_expr concat_rhs_expr '}'
" concat_rhs->(rhs_expr|set_lhs_expr|set_rhs_expr)
syn cluster nft_c_concat_rhs_expr
\ contains=
\    @nft_c_basic_rhs_expr,
\    @nft_c_multition_rhs_expr