
Hooks by family and chain type

The following table lists available hooks by family and chain type. 

Minimum nftables and Linux kernel versions are 1.0.1/5.16

Chain type 	      Hooks
           ingress         prerouting        forward          input           output         postrouting        egress

                  inet family
filter      Yes              Yes              Yes              Yes              Yes              Yes              No
nat 	    No               Yes              No               Yes              Yes              Yes              No
route 	    No               No               No               No               Yes              No               No

                  ip6 family
filter 	    No               Yes              Yes              Yes              Yes              Yes              No
nat 	    No               Yes              No               Yes              Yes              Yes              No
route 	    No               No               No               No               Yes              No               No

                  ip family
filter 	    No               Yes              Yes              Yes              Yes              Yes              No
nat 	    No               Yes              No               Yes              Yes              Yes              No
route 	    No               No               No               No               Yes              No               No

                  arp family
filter 	    No 	             No               No               Yes              Yes              No               No
nat 	    No               No               No               No               No               No               No
route 	    No               No               No               No               No               No               No

                  bridge family
filter 	    No               Yes              Yes              Yes              Yes              Yes              No
nat 	    No               No               No               No               No               No               No
route 	    No               No               No               No               No               No               No

                  netdev family
filter 	    Yes              No               No               No               No               No               Yes
nat 	    No               No               No               No               No               No               No
route 	    No               No               No               No               No               No               No 


Source: [https://wiki.nftables.org/wiki-nftables/index.php/Netfilter\_hooks](https://wiki.nftables.org/wiki-nftables/index.php/Netfilter_hooks)
