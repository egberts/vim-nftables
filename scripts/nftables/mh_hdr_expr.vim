

" 'mh' 'hdrlength'
" 'hdrlength'->mh_hdr_field->'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_field_hdrlength nftHL_Action
syn match nft_mh_hdr_field_hdrlength "hdrlength" contained skipwhite

" 'mh' 'type'
" 'type'->mh_hdr_field->'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_field_type nftHL_Action
syn match nft_mh_hdr_field_type "type" contained skipwhite

" 'mh' 'reserved'
" 'reserved'->mh_hdr_field->'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_field_reserved nftHL_Action
syn match nft_mh_hdr_field_reserved "reserved" contained skipwhite

" 'mh' 'checksum'
" 'checksum'->mh_hdr_field->'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_field_checksum nftHL_Action
syn match nft_mh_hdr_field_checksum "checksum" contained skipwhite

syn cluster nft_c_mh_hdr_field
\ contains=
\    nft_mh_hdr_field_nexthdr,
\    nft_mh_hdr_field_hdrlength,
\    nft_mh_hdr_field_type,
\    nft_mh_hdr_field_reserved,
\    nft_mh_hdr_field_checksum,

" mh_hdr_expr
" 'mh'
" 'mh'->mh_hdr_expr->exthdr_expr->primary_expr
hi link   nft_mh_hdr_expr nftHL_Statement
syn match nft_mh_hdr_expr "mh" skipwhite contained
\ nextgroup=
\    @nft_c_mh_hdr_field
