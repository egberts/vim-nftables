
This is the `stmt` keyword list. This keyword list got extracted
from the nftables' Bison file (`parser_bison.y`).

`stmt` is the portion that is found AFTER many commands/statements 
and often found inside its accompanying code-blocks.

Such placement of `stmt` are given in this `nftables` example:
```
ip6 TableId ChainName { stmt }
rule TableId ChainName { stmt }
add rule bridge TableId ChainName { stmt }
```

Sidebar: When writing the syntax tree from a parser, repeated 
encounters of the same keyword by different Vim-syntax must be 
recouncil together to make the final keyword-specific syntax required 
by many Parser (and Vim-syntax).

Wow,  `base_cmd` `add_rule` Bison parser really has a long complex 
pattern (and recursive too).

We want our Vimscript syntax to tackle this by doing the known patterns 
firstly, then `$variables`, then identifiers lastly.  

First-encounter digit-only character gets ignored.

nftable's Bison `stmt` syntax has the following first-encountered keyword patterns:

Working on
===========
```csv
ICMP , icmp_hdr_expr -> payload_expr
```

TODO
====
```csv
<identifier>, concat_expr, verdict_map_stmt -> verdict_stmt -> stmt (everything you see here)
<$var>
<NUM>
ACCEPT, verdict_expr -> verdict_stmt -> stmt
ADD AT, map_stmt -> stmt
ADD AT, set_stmt -> stmt
AH , ah_hdr_expr -> payload_expr
ARP , arp_hdr_expr -> payload_expr
AT, payload_raw_expr -> payload_expr
CGROUP, meta_key_unqualified
CGROUP, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
COMP , comp_hdr_expr -> payload_expr
CONTINUE, verdict_expr -> verdict_stmt -> stmt
COUNTER, objref_stmt_counter -> objref_stmt -> stmt
COUNTER, stateful_stmt
CPU, meta_key_unqualified
CPU, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
CT, ct_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
CT, ct_stmt -> stmt
CT, objref_stmt_ct -> objref_stmt -> stmt
CT, stateful_stmt
DAY, meta_key_unqualified
DAY, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
DCCP , dccp_hdr_expr -> payload_expr
DELETE $var, map_stmt -> stmt
DELETE $var, set_stmt -> stmt
DELETE AT, map_stmt -> stmt
DELETE AT, set_stmt -> stmt
DROP, verdict_expr -> verdict_stmt -> stmt
DST, dst_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
DUP TO, dup_stmt -> stmt
ESP , esp_hdr_expr -> payload_expr
ETHER, eth_hdr_expr -> payload_expr
EXTHDR, exthdr_exists_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
FIB, fib_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
FLOW , meta_stmt
FRAG, frag_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
FWD TO, fwd_stmt -> stmt
GENEVE , geneve_hdr_expr -> payload_expr
GOTO, chain_stmt_type -> stmt
GOTO, verdict_expr -> verdict_stmt -> stmt
GRE , gre_hdr_expr -> payload_expr
GRETAP , gretap_hdr_expr -> payload_expr
HBH, hbh_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
HOUR, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IBRIDGENAME, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IBRIPORT, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
ICMP6 , icmp6_hdr_expr -> payload_expr
IGMP , igmp_hdr_expr -> payload_expr
IIFGROUP, meta_key_unqualified
IIFGROUP, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IIF, meta_key_unqualified
IIF, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IIFNAME, meta_key_unqualified
IIFNAME, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IIFTYPE, meta_key_unqualified
IIFTYPE, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IP6 , ip6_hdr_expr -> payload_expr
IP , ip_hdr_expr -> payload_expr
IPSEC, meta_key_unqualified
IPSEC, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
IPSEC, xfrm_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
JHASH, hash_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
JUMP, chain_stmt_type -> stmt
JUMP, verdict_expr -> verdict_stmt -> stmt
LAST, stateful_stmt
LIMIT, objref_stmt_limit -> objref_stmt -> stmt
LIMIT, stateful_stmt
LOG, log_stmt_alloc -> log_stmt -> stmt
MARK, meta_key_unqualified
MARK, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
MASQUERADE, masq_stmt_alloc -> masq_stmt -> stmt
META, meta_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
META, meta_stmt
METER , meter_stmt_alloc -> meter_stmt
MH, mh_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
NFTRACE, meta_key_unqualified
NFTRACE, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
NOTRACK, meta_stmt
NUMGEN, numgen_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OBRIDGENAME, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OBRIPORT, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OIFGROUP, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OIF, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OIFNAME, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OIFTYPE, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
OSF, osf_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
PKTTYPE, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
QUEUE FROM, queue_stmt -> stmt
QUEUE, queue_stmt_compat -> queue_stmt -> stmt
QUEUE TO, queue_stmt -> stmt
QUOTA, objref_stmt_quota -> objref_stmt -> stmt
QUOTA, stateful_stmt
REDIRECT, redir_stmt_alloc -> redir_stmt -> stmt
REJECT, reject_stmt_alloc -> reject_stmt -> stmt
RESET, optstrip_stmt -> stmt
RETURN, verdict_expr -> verdict_stmt -> stmt
RT0, rt0_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
RT2, rt2_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
RT4, rt4_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
RTCLASSID, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
RT, rt_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
RT, rt_hdr_expr -> exthdr_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
SCTP , sctp_hdr_expr -> payload_expr
SET ADD, set_stmt -> stmt
SET DELETE, set_stmt -> stmt
SET UPDATE, set_stmt -> stmt
SKGID, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
SKUID, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
SNAT, nat_stmt_alloc -> nat_stmt -> stmt
SOCKET, socket_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
SYMHASH, hash_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
SYNPROXY, objref_stmt_synproxy -> objref_stmt -> stmt
SYNPROXY, synproxy_stmt_alloc -> synproxy_stmt -> stmt
TCP , tcp_hdr_expr -> payload_expr
TH , th_hdr_expr -> payload_expr
TIME, meta_key_unqualified -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
TPROXY, tproxy_stmt -> stmt
UDPLITE , udplite_hdr_expr -> payload_expr
UDP , udp_hdr_expr -> payload_expr
UPDATE AT, map_stmt -> stmt
UPDATE AT, set_stmt -> stmt
VLAN , vlan_hdr_expr -> payload_expr
VXLAN , vxlan_hdr_expr -> payload_expr
XT, xt_stmt -> stmt
{}, basic_expr -> primary_expr -> basic_expr -> concat_expr -> expr -> relational_expr -> match_stmt
{}, concat_expr -> map_expr -> expr -> relational_expr -> match_stmt  (basically everything you see here)
{}, set_expr -> expr -> relational_expr -> match_stmt
```

