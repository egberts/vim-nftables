


" th_hdr_field (via th_hdr_expr)
" 'sport'->th_hdr_field->'transport-hdr'->payload_expr
" 'sport'->th_hdr_field->'transport-hdr'->inner_inet_expr
hi link   nft_th_hdr_field_sport nftHL_Action
syn match nft_th_hdr_field_sport "sport" skipwhite contained

hi link   nft_th_hdr_field_dport nftHL_Action
syn match nft_th_hdr_field_dport "dport" skipwhite contained

syn cluster nft_c_th_hdr_field
\ contains=
\    nft_th_hdr_field_sport,
\    nft_th_hdr_field_dport

" th_hdr_expr (via payload_expr, inner_inet_expr)
hi link   nft_th_hdr_expr nftHL_Statement
syn match nft_th_hdr_expr "[ \t]\zsth" skipwhite contained
\ nextgroup=
\    @nft_c_th_hdr_field


" dccp_hdr_field (via nft_dccp_hdr_expr)
hi link   nft_dccp_hdr_field nftHL_Action
syn match nft_dccp_hdr_field "\v(sport|dport|type)" skipwhite contained
\ nextgroup=
\    nft_EOS

" nft_dccp_hdr_expr 'option' <NUM> (via nft_dccp_hdr_expr)
hi link   nft_dccp_hdr_expr_option_num nftHL_Number
syn match nft_dccp_hdr_expr_option_num "\v\d{1,11}" skipwhite contained
\ nextgroup=
\    nft_EOS

" nft_dccp_hdr_expr 'option num' (via nft_dccp_hdr_expr)
hi link   nft_dccp_hdr_expr_option nftHL_Action
syn match nft_dccp_hdr_expr_option "option" skipwhite contained
\ nextgroup=
\    nft_dccp_hdr_expr_option_num

" dccp_hdr_expr->gre_hdr_expr->payload_expr->(payload_stmt|primary_expr|primary_stmt_expr)
" dccp_hdr_expr->inner_expr->(vxlan_hdr_expr|gretap_hdr_expr|geneve_hdr_expr)
hi link   nft_dccp_hdr_expr nftHL_Statement
syn match nft_dccp_hdr_expr "dccp" skipwhite contained
\ nextgroup=
\    nft_dccp_hdr_field,
\    nft_dccp_hdr_expr_option



source ~/.vim/scripts/nftables/sctp_hdr_expr.vim
source ~/.vim/scripts/nftables/eth_hdr_expr.vim
source ~/.vim/scripts/nftables/vlan_hdr_expr.vim
source ~/.vim/scripts/nftables/arp_hdr_expr.vim
source ~/.vim/scripts/nftables/ip6_hdr_expr.vim
source ~/.vim/scripts/nftables/ip_hdr_expr.vim
source ~/.vim/scripts/nftables/icmp_hdr_expr.vim
source ~/.vim/scripts/nftables/icmp6_hdr_expr.vim
source ~/.vim/scripts/nftables/igmp_hdr_expr.vim
source ~/.vim/scripts/nftables/auth_hdr_expr.vim
source ~/.vim/scripts/nftables/esp_hdr_expr.vim
source ~/.vim/scripts/nftables/comp_hdr_expr.vim
source ~/.vim/scripts/nftables/udp_hdr_expr.vim
source ~/.vim/scripts/nftables/tcp_hdr_expr.vim
source ~/.vim/scripts/nftables/dccp_hdr_expr.vim
source ~/.vim/scripts/nftables/sctp_hdr_expr.vim
source ~/.vim/scripts/nftables/th_hdr_expr.vim
source ~/.vim/scripts/nftables/vxlan_hdr_expr.vim
source ~/.vim/scripts/nftables/geneve_hdr_expr.vim
source ~/.vim/scripts/nftables/gre_hdr_expr.vim
source ~/.vim/scripts/nftables/gretap_hdr_expr.vim

" NEED TO DUPLICATE in payload_stmt but without nextgroup='set'
" Add 'nextgroup=nft_payload_stmt_set' toward each here
" payload_expr (via payload_stmt, *primary_expr*, primary_stmt_expr)
syn cluster nft_c_payload_expr_via_primary_expr
\ contains=
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip6_hdr_expr,
\    nft_icmp6_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_icmp_hdr_expr,
\    nft_igmp_hdr_expr,
\    nft_auth_hdr_expr,
\    nft_esp_hdr_expr,
\    nft_comp_hdr_expr,
\    nft_udplite_hdr_expr,
\    nft_udp_hdr_expr,
\    nft_tcp_hdr_expr,
\    nft_dccp_hdr_expr,
\    nft_sctp_hdr_expr,
\    nft_th_hdr_expr,
\    nft_vxlan_hdr_expr,
\    nft_geneve_hdr_expr,
\    nft_gre_hdr_expr,
\    nft_gretap_hdr_expr

" NEED TO DUPLICATE in primary_stmt but without nextgroup='set'
" Add 'nextgroup=nft_payload_stmt_set' toward each here
" payload_expr (via payload_stmt, primary_expr, *primary_stmt_expr*)
syn cluster nft_c_payload_expr
\ contains=
\    nft_payload_raw_expr,
\    nft_eth_hdr_expr,
\    nft_vlan_hdr_expr,
\    nft_arp_hdr_expr,
\    nft_ip_hdr_expr,
\    nft_icmp_hdr_expr,
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

