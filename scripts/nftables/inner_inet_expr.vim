" File: inner_inet_expr.vim

" called by gre_hdr_expr
" called by inner_expr

source ~/.vim/scripts/nftables/ip_hdr_expr.vim
source ~/.vim/scripts/nftables/icmp_hdr_expr.vim
source ~/.vim/scripts/nftables/igmp_hdr_expr.vim
source ~/.vim/scripts/nftables/ip6_hdr_expr.vim
source ~/.vim/scripts/nftables/icmp6_hdr_expr.vim
source ~/.vim/scripts/nftables/auth_hdr_expr.vim
source ~/.vim/scripts/nftables/esp_hdr_expr.vim
source ~/.vim/scripts/nftables/comp_hdr_expr.vim
source ~/.vim/scripts/nftables/udp_hdr_expr.vim
source ~/.vim/scripts/nftables/tcp_hdr_expr.vim
source ~/.vim/scripts/nftables/dccp_hdr_expr.vim
source ~/.vim/scripts/nftables/sctp_hdr_expr.vim
source ~/.vim/scripts/nftables/th_hdr_expr.vim

syn cluster nft_c_inner_inet_expr
\ contains=
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
\    nft_th_hdr_expr

