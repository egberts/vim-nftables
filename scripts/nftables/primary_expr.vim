

source ../scripts/exthdr_exists_expr.vim
source ../scripts/mh_hdr_expr.vim

" 'dst' 'nexthdr'
" 'nexthdr'->dst_hdr_field->'dst'->dst_hdr_expr->exthdr_expr->primary_expr
hi link   nft_dst_hdr_field_nexthdr nftHL_Action
syn match nft_dst_hdr_field_nexthdr "nexthdr" contained skipwhite

" 'dst' 'hdrlength'
" 'hdrlength'->dst_hdr_field->'dst'->dst_hdr_expr->exthdr_expr->primary_expr
hi link   nft_dst_hdr_field_hdrlength nftHL_Action
syn match nft_dst_hdr_field_hdrlength "hdrlength" contained skipwhite

syn cluster nft_c_dst_hdr_field
\ contains=
\    nft_dst_hdr_field_nexthdr,
\    nft_dst_hdr_field_hdrlength

" 'dst'
" 'dst'->dst_hdr_expr->exthdr_expr->primary_expr
hi link   nft_dst_hdr_expr nftHL_Statement
syn match nft_dst_hdr_expr "dst" skipwhite contained
\ nextgroup=
\    @nft_c_dst_hdr_field

" frag_hdr_field
" 'frag' 'nexthdr'
" 'nexthdr'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_nexthdr nftHL_Action
syn match nft_frag_hdr_field_nexthdr "nexthdr" skipwhite contained

" 'frag' 'reserved'
" 'reserved'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_reserved nftHL_Action
syn match nft_frag_hdr_field_reserved "reserved" skipwhite contained

" 'frag' 'frag-off'
" 'frag-off'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_frag_off nftHL_Action
syn match nft_frag_hdr_field_frag_off "\vfrag\\-off" skipwhite contained

" 'frag' 'reserved2'
" 'reserved2'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_reserved2 nftHL_Action
syn match nft_frag_hdr_field_reserved2 "reserved2" skipwhite contained

" 'frag' 'more-fragments'
" 'more-fragments'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_more_fragments nftHL_Action
syn match nft_frag_hdr_field_more_fragments "\vmore\-fragments" skipwhite contained

" 'frag' 'id'
" 'id'->frag_hdr_field->'frag'->frag_hdr_expr->exthdr_expr->primary_expr
hi link   nft_frag_hdr_field_id nftHL_Action
syn match nft_frag_hdr_field_id "id" skipwhite contained

syn cluster nft_c_frag_hdr_field
\ contains=
\    nft_frag_hdr_field_nexthdr,
\    nft_frag_hdr_field_reserved,
\    nft_frag_hdr_field_frag_off,
\    nft_frag_hdr_field_reserved2,
\    nft_frag_hdr_field_more_fragments,
\    nft_frag_hdr_field_id

" 'frag'
" 'frag'->frag_hdr_expr->'exthdr'->exthdr_expr->primary_expr
hi link   nft_frag_hdr_expr nftHL_Statement
syn match nft_frag_hdr_expr "frag" skipwhite contained
\ nextgroup=
\    @nft_c_frag_hdr_field

" 'rt4' 'last-entry'
" 'last-ent'->rt4_hdr_field->'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_field_last_ent nftHL_Action
syn match nft_rt4_hdr_field_last_ent "\vlast\-entry" contained skipwhite

" 'rt4' 'flags'
" 'flags'->rt4_hdr_field->'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_field_flags nftHL_Action
syn match nft_rt4_hdr_field_flags "flags" contained skipwhite

" 'rt4' 'tag'
" 'tag'->rt4_hdr_field->'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_field_tag nftHL_Action
syn match nft_rt4_hdr_field_tag "tag" contained skipwhite

" 'rt4' 'sid' '[' digits ']'
" 'sid'->rt4_hdr_field->'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_field_sid_num_block nftHL_Command
syn match nft_rt4_hdr_field_sid_num_block "\v\[\s*\d\s*\]" contained

" 'rt4' 'sid'
" 'sid'->rt4_hdr_field->'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_field_sid nftHL_Action
syn match nft_rt4_hdr_field_sid "sid" contained skipwhite
\ nextgroup=
\    nft_rt4_hdr_field_sid_num_block

syn cluster nft_c_rt4_hdr_field
\ contains=
\    nft_rt4_hdr_field_last_ent,
\    nft_rt4_hdr_field_flags,
\    nft_rt4_hdr_field_tag,
\    nft_rt4_hdr_field_sid

" 'rt4'
" 'rt4'->rt4_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt4_hdr_expr nftHL_Statement
syn match nft_rt4_hdr_expr "rt4" skipwhite contained
\ nextgroup=
\    @nft_c_rt4_hdr_field

" rt2_hdr_field
" 'rt2' ADDR
" ADDR->rt2_hdr_field->'rt2'->rt2_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt2_hdr_field_addr nftHL_Action
syn match nft_rt2_hdr_field_addr "addr" skipwhite contained
syn cluster nft_c_rt2_hdr_field
\ contains=
\    nft_rt2_hdr_field_addr

" rt2_hdr_expr
" 'rt2'
" 'rt2'->rt2_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt2_hdr_expr nftHL_Statement
syn match nft_rt2_hdr_expr "rt2" skipwhite contained
\ nextgroup=
\    @nft_c_rt2_hdr_field

hi link   nft_rt0_hdr_field_addr_num_block nftHL_Identifier
" keepend because brackets should be on same line
syn match nft_rt0_hdr_field_addr_num_block "\v\[\s*[0-9]+\s*\]\s*" contained keepend
" Tough to highlight certain number inside a regex'd block, instead of a syntax region block"

" 'rt0' ADDR
" ADDR->rt0_hdr_field->'rt0'->rt0_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt0_hdr_field nftHL_Action
syn match nft_rt0_hdr_field "addr" skipwhite contained
\ nextgroup=
\    nft_rt0_hdr_field_addr_num_block,
\    nft_UnexpectedEmptyBrackets

" rt0_hdr_expr
" 'rt0'
" 'rt0'->rt0_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt0_hdr_expr nftHL_Statement
syn match nft_rt0_hdr_expr "rt0" skipwhite contained
\ nextgroup=
\    nft_rt0_hdr_field

" 'rt' 'nexthdr'
" 'nexthdr'->rt_hdr_field->'rt'->rt_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt_hdr_field_nexthdr nftHL_Action
syn match nft_rt_hdr_field_nexthdr "nexthdr" contained skipwhite

" 'rt' 'hdrlength'
" 'hdrlength'->rt_hdr_field->'rt'->rt_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt_hdr_field_hdrlength nftHL_Action
syn match nft_rt_hdr_field_hdrlength "hdrlength" contained skipwhite

" 'rt' 'type'
" 'type'->rt_hdr_field->'rt'->rt_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt_hdr_field_type nftHL_Action
syn match nft_rt_hdr_field_type "type" contained skipwhite

" 'rt' 'seg-left'
" 'seg-left'->rt_hdr_field->'rt'->rt_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt_hdr_field_seg_left nftHL_Action
syn match nft_rt_hdr_field_seg_left "\vseg\-left" contained skipwhite

syn cluster nft_c_rt_hdr_field
\ contains=
\    nft_rt_hdr_field_nexthdr,
\    nft_rt_hdr_field_hdrlength,
\    nft_rt_hdr_field_type,
\    nft_rt_hdr_field_seg_left

" rt_hdr_expr
" 'rt'
" 'rt'->rt_hdr_expr->exthdr_expr->primary_expr
hi link   nft_rt_hdr_expr nftHL_Statement
syn match nft_rt_hdr_expr "rt/ze " skipwhite contained
\ nextgroup=
\    @nft_c_rt_hdr_field

" hdh_hdr_field
" 'hbh' 'nexthdr'
" 'nexthdr'->hbh_hdr_field->'hbh'->hbh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_hbh_hdr_field_nexthdr nftHL_Action
syn match nft_hbh_hdr_field_nexthdr "nexthdr" contained skipwhite

" 'hbh' 'hdrlength'
" 'hdrlength'->hbh_hdr_field->'hbh'->hbh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_hbh_hdr_field_hdrlength nftHL_Action
syn match nft_hbh_hdr_field_hdrlength "hdrlength" contained skipwhite

syn cluster nft_c_hbh_hdr_field
\ contains=
\    nft_hbh_hdr_field_nexthdr,
\    nft_hbh_hdr_field_hdrlength

" 'hbh'
" 'hbh'->hbh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_hbh_hdr_expr nftHL_Statement
syn match nft_hbh_hdr_expr "hbh" skipwhite contained
\ nextgroup=
\    @nft_c_hbh_hdr_field

" exthdr_expr->primary_expr
syn cluster nft_c_exthdr_expr
\ contains=
\    nft_hbh_hdr_expr,
\    nft_rt0_hdr_expr,
\    nft_rt2_hdr_expr,
\    nft_rt4_hdr_expr,
\    nft_rt_hdr_expr,
\    nft_frag_hdr_expr,
\    nft_dst_hdr_expr,
\    nft_mh_hdr_expr

""""""""""""""" primary_expr """"""""""""""""""""""""
" primary_expr
syn cluster nft_c_primary_expr
\ contains=
\    nft_primary_stmt_expr_block_delimiters,
\    @nft_c_symbol_expr,
\    nft_integer_expr,
\    @nft_c_boolean_expr,
\    @nft_c_meta_expr,
\    nft_rt_expr,
\    nft_ct_expr,
\    nft_numgen_expr,
\    @nft_c_hash_expr,
\    payload_expr,
\    nft_keyword_expr,
\    nft_socket_expr,
\    nft_osf_expr,