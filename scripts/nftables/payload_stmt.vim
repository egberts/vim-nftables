

" payload_stmt <payload_expr> 'set' (via payload_stmt <payload_expr>)
hi link   nft_payload_stmt_before_set nftHL_Statement
syn match nft_payload_stmt_before_set "set" skipwhite contained
\ nextgroup=
\    @nft_c_stmt_expr


" payload_stmt <payload_expr> (via payload_stmt)
syn cluster nft_c_payload_expr_via_payload_stmt
\ contains=
\    nft_icmp_hdr_expr_via_payload_expr,
\    nft_payload_raw_expr_via_payload_expr_set,
\    nft_eth_hdr_expr_via_payload_expr_set,
\    nft_vlan_hdr_expr_via_payload_expr_set,
\    nft_arp_hdr_expr_via_payload_expr_set,
\    nft_ip_hdr_expr_via_payload_expr_set,
\    nft_igmp_hdr_expr_via_payload_expr_set,
\    nft_ip6_hdr_expr_via_payload_expr_set,
\    nft_icmp6_hdr_expr_via_payload_expr_set,
\    nft_auth_hdr_expr_via_payload_expr_set,
\    nft_esp_hdr_expr_via_payload_expr_set,
\    nft_comp_hdr_expr_via_payload_expr_set,
\    nft_udp_hdr_expr_via_payload_expr_set,
\    nft_udplite_hdr_expr_via_payload_expr_set,
\    nft_tcp_hdr_expr_via_payload_expr_set,
\    nft_dccp_hdr_expr_via_payload_expr_set,
\    nft_sctp_hdr_expr_via_payload_expr_set,
\    nft_th_hdr_expr_via_payload_expr_set,
\    nft_vxlan_hdr_expr_via_payload_expr_set,
\    nft_geneve_hdr_expr_via_payload_expr_set,
\    nft_gre_hdr_expr_via_payload_expr_set,
\    nft_gretap_hdr_expr_via_payload_expr_set
" TODO: undefined nft_arp_hdr_expr_via_payload_expr_set

" payload_stmt <payload_expr> (via payload_stmt)
syn cluster nft_c_payload_stmt
\ contains=
\    nft_icmp_hdr_expr,
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr,
\    nft_vxlan_hdr_expr,
\    nft_geneve_hdr_expr,
\    nft_gre_hdr_expr,
\    nft_gretap_hdr_expr
