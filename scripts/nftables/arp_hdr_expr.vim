" File:  arp_hdr_expr.vim
" base_cmd Vim syntax file for nftables configuration file
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
" Called by: payload_expr
" Called by: inner_inet_expr
"


" arp_hdr_expr->inner_eth_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
" arp_hdr_field_addr_ether (via arp_hdr_field)
hi link   nft_arp_hdr_field_addr_ether nftHL_Action
syn match nft_arp_hdr_field_addr_ether "ether" skipwhite contained

" arp_hdr_field_ip_ether (via arp_hdr_field)
hi link   nft_arp_hdr_field_addr_ip nftHL_Action
syn match nft_arp_hdr_field_addr_ip "ip" skipwhite contained

" arp_hdr_field_addrs 'saddr'/'daddr' (via arp_hdr_field)
hi link   nft_arp_hdr_field_addrs nftHL_Action
syn match nft_arp_hdr_field_addrs "\v(saddr|daddr)" skipwhite contained
\ nextgroup=
\    nft_arp_hdr_field_addr_ether,
\    nft_arp_hdr_field_addr_ip

" arp_hdr_field_keywords (via arp_hdr_field)
hi link   nft_arp_hdr_field_keywords nftHL_Action
syn match nft_arp_hdr_field_keywords "\v(htype|ptype|hlen|plen|operation)" skipwhite contained

" arp_hdr_field (via arp_hdr_expr)
syn cluster nft_c_arp_hdr_field
\ contains=
\    nft_arp_hdr_field_keywords,
\    nft_arp_hdr_field_addrs

" arp_hdr_expr 'arp' (via inner_eth_expr, payload_expr)
hi link   nft_arp_hdr_expr nftHL_Statement
syn match nft_arp_hdr_expr "arp" skipwhite contained
\ nextgroup=
\    @nft_c_arp_hdr_field