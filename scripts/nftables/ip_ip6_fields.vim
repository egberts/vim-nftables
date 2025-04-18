

hi link   nft_ip_ip6_fields nftHL_Number
syn match nft_ip_ip6_fields "\v1?[0-9]?[0-9]\.1?[0-9]?[0-9]\.1?[0-9]?[0-9]\.1?[0-9]?[0-9](\/2?[0-5]?[0-9])?" skipwhite contained

" syn match nft_ip_ip6_fields "\v\b(?:[0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}\b” skipwhite contained