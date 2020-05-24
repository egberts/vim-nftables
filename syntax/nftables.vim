" Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Initial Date: 2020-04-24
" Last Change:  2020-05-13
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues

" quit when a syntax file was already loaded
if !exists('main_syntax')
  if exists('b:current_syntax')
    finish
  endif
  let main_syntax='nftables'
endif

syn case match

" iskeyword severly impacts '\<' and '\>' atoms
setlocal iskeyword=.,48-58,A-Z,a-z,\_,\/,-
setlocal isident=.,48-58,A-Z,a-z,\_,\/,-

set cpo&vim  " Line continuation '\' at EOL is used here

" syn sync match nftablesSync grouphere NONE \"^(table|chain|set)\"
syn sync fromstart

let s:save_cpo = &cpoptions
set cpoptions-=C

let s:deviceNameRegex = '[A-Za-z0-9\-_./]\{1,256}'
let s:tableNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'
let s:chainNameRegex =  '[A-Za-z0-9\-_./]\{1,64}'
hi link nftablesHL_Comment     Comment
hi link nftablesHL_Include     Preproc
hi link nftablesHL_ToDo        Todo
hi link nftablesHL_Identifier  Identifier
hi link nftablesHL_Variable    Variable  " doesn't work, stuck on dark cyan
hi link nftablesHL_Number      Number
hi link nftablesHL_String      String
hi link nftablesHL_Option      Label     " could use a 2nd color here
hi link nftablesHL_Operator    Operator    " was Operator  
hi link nftablesHL_Underlined  Underlined
hi link nftablesHL_Error       Error

hi link nftablesHL_Command     Statement
hi link nftablesHL_Statement   Statement
hi link nftablesHL_Expression  Statement
hi link nftablesHL_Type        Type

hi link nftablesHL_Family      Underlined   " doesn't work, stuck on dark cyan
hi link nftablesHL_Table       Identifier
hi link nftablesHL_Chain       Identifier
hi link nftablesHL_Rule        Identifier
hi link nftablesHL_Map         Identifier
hi link nftablesHL_Set         Identifier
hi link nftablesHL_Element     Identifier
hi link nftablesHL_Quota       Identifier
hi link nftablesHL_Limit       Identifier
hi link nftablesHL_Handle      Identifier
hi link nftablesHL_Flowtable   Identifier
hi link nftablesHL_Device      Identifier

hi link nftablesHL_Verdict     Underlined
hi link nftablesHL_Hook        Type    
hi link nftablesHL_Action      Special

hi link nftables_ToDo nftablesHL_ToDo
syn keyword nftables_ToDo xxx contained XXX FIXME TODO TODO: FIXME: TBS TBD TBA skipwhite

hi link nftables_InlineComment nftablesHL_Comment
syn region nftables_InlineComment start=/#/ end=/$/ contains=nftables_ToDo skipwhite

" hi link nftables_EOS nftablesHL_Error
" syn match nftables_EOS contained /[^ \t]*[^\n;# ]/ 

hi link nftables_UnexpectedSemicolon nftablesHL_Error
syn match nftables_UnexpectedSemicolon contained /;\+/ skipwhite skipempty

syn match nftablesSet contained /{.*}/ contains=nftablesSetEntry
syn match nftablesSetEntry contained /[a-zA-Z0-9]\+/ contained
hi def link nftablesSet nftablesHL_Keyword
hi def link nftablesSetEntry nftablesHL_Operator

" syn match nftablesNumber "\<[0-9A-Fa-f./:]\+\>" contains=nftablesMask,nftablesDelimiter
syn match nftablesHex "\<0x[0-9A-Fa-f]\+\>"
syn match nftablesDelimiter "[./:]" contained
syn match nftablesMask "/[0-9.]\+" contained contains=nftablesDelimiter
" hi def link nftablesNumber nftablesHL_Number
hi def link nftablesHex nftablesHL_Number
hi def link nftablesDelimiter nftablesHL_Operator
hi def link nftablesMask nftablesHL_Operator

" We'll do error RED highlighting on all statement firstly, then later on
" all the options, then all the clauses.
" Uncomment following two lines for RED highlight of typos (still Beta here)
" hi link nftables_Error nftablesHL_Error
" syn match nftables_Error /[ \ta-zA-Z0-9_./]\{1,64}/

hi link nftables_UnexpectedEOS nftablesHL_Error
syn match nftables_UnexpectedEOS contained /[;\n]\+/ skipwhite

syn match nftables_EOL contained /[\n\r]\{1,16}/ skipwhite

hi link nftables_Semicolon nftablesHL_Normal
syn match nftables_Semicolon contained /[;]\{1,15}/  skipwhite
\ nextgroup=nftables_EOL

hi link nftables_define nftablesHL_Command
syn keyword nftables_define contained define skipwhite 
\ nextgroup=nftables_define_Identifier

hi link nftables_redefine nftablesHL_Command
syn keyword nftables_redefine contained redefine skipwhite 
\ nextgroup=nftables_define_Identifier

hi link nftables_undefine nftablesHL_Command
syn keyword nftables_undefine contained undefine skipwhite 
\ nextgroup=nftables_undefine_Identifier

syn cluster  nftablesCluster_common_block
\ contains=
\    nftables_include,
\    nftables_define,
\    nftables_redefine,
\    nftables_undefine,
\    nftables_InlineComment,
\    nftables_Semicolon,
\    nftables_EOS


hi link nftablesType_BooleanMnemonic nftablesHL_Type
syn keyword nftablesType_BooleanMnemonic contained skipwhite
\    exists
\    missing

hi link nftablesType_BooleanLogic nftablesHL_Type
syn keyword nftablesType_BooleanLogic contained skipwhite
\    true
\    false
\    1
\    0

hi link nftablesType_PolicyType nftablesHL_Type
syn keyword nftablesType_PolicyType contained policy skipwhite
\    accept
\    drop

hi link nftablesType_EtherType nftablesHL_Number
syn match nftablesType_EtherType contained skipwhite
\    /0x\x\{1,4}/ 

" icmp_type_type
hi link nftablesIcmp_TypeInteger nftablesHL_Type
syn match nftablesIcmp_TypeInteger contained /\d\{1,5}/ skipwhite

" icmp_type_tbl
hi link nftablesIcmp_TypeMnemonic nftablesHL_Type
syn keyword nftablesIcmp_TypeMnemonic contained skipwhite
\    echo-reply
\    destination-unreachable
\    source-quench
\    redirect
\    echo-request
\    router-advertisement
\    router-solicitation
\    time-exceeded
\    parameter-problem
\    timestamp-request
\    timestamp-reply
\    info-request
\    info-reply
\    address-mask-request
\    address-mask-reply

" icmp_code_type
hi link nftablesIcmp_CodeInteger nftablesHL_Type
syn match nftablesIcmp_CodeInteger contained /\d\{1,5}/ skipwhite

" icmp_code_tbl
hi link nftablesIcmp_CodeMnemonic nftablesHL_Type
syn keyword nftablesIcmp_CodeMnemonic contained skipwhite
\    net-unreachable
\    host-unreachable
\    prot-unreachable
\    port-unreachable
\    net-prohibited
\    host-prohibited
\    admin-prohibited

" icmpv6_code_type
hi link nftablesIcmpV6_TypeInteger nftablesHL_Type
syn match nftablesIcmpV6_TypeInteger contained /\d\{1,5}/ skipwhite

" icmpv6_code_tbl
hi link nftablesIcmpV6_TypeMnemonic nftablesHL_Type
syn keyword nftablesIcmpV6_TypeMnemonic contained skipwhite
\    no-route
\    admin-prohibited
\    addr-unreachable
\    port-unreachable
\    policy-fail
\    reject-route

" begin proto_ah
hi link nftablesProtoAh_NextHdr nftablesHL_Statement
syn keyword nftablesProtoAh_NextHdr contained nexthdr skipwhite
hi link nftablesProtoAh_HdrLength nftablesHL_Statement
syn keyword nftablesProtoAh_HdrLength contained hdrlength skipwhite
hi link nftablesProtoAh_Reserved nftablesHL_Statement
syn keyword nftablesProtoAh_Reserved contained reserved skipwhite
hi link nftablesProtoAh_Spi nftablesHL_Statement
syn keyword nftablesProtoAh_Spi contained spi skipwhite
hi link nftablesProtoAh_Sequence nftablesHL_Statement
syn keyword nftablesProtoAh_Sequence contained sequence skipwhite

hi link nftables_rule_AhKeyword nftablesHL_Statement
syn keyword nftables_rule_AhKeyword contained ah skipwhite
\ nextgroup=
\    nftablesProtoAh_NextHdr,
\    nftablesProtoAh_HdrLength,
\    nftablesProtoAh_Reserved,
\    nftablesProtoAh_Spi,
\    nftablesProtoAh_Sequence
" end proto_ah

" begin proto_esp
hi link nftablesProtoEsp_Spi nftablesHL_Statement
syn keyword nftablesProtoEsp_Spi contained spi skipwhite
hi link nftablesProtoEsp_Sequence nftablesHL_Statement
syn keyword nftablesProtoEsp_Sequence contained sequence skipwhite

hi link nftables_rule_EspKeyword nftablesHL_Statement
syn keyword nftables_rule_EspKeyword contained esp skipwhite
\ nextgroup=
\    nftablesProtoEsp_Spi,
\    nftablesProtoEsp_Sequence,
" end proto_esp
"
" begin std_prios
hi link nftablesPriority_Integer nftablesHL_Number
syn match nftablesPriority_Integer contained /\d\{1,5}/ skipwhite

hi link nftablesPriority_Mnemonics nftablesHL_Type
syn keyword nftablesPriority_Mnemonics contained skipwhite
\    raw
\    mangle
\    dstnat
\    filter
\    security
\    srcnat
" end std_prios
" begin bridge_std_prios
hi link nftablesPriorityBridge_Integer nftablesHL_Number
syn match nftablesPriorityBridge_Integer contained /\d\{1,5}/ skipwhite

hi link nftablesPriorityBridge_Mnemonics nftablesHL_Type
syn keyword nftablesPriorityBridge_Mnemonics contained skipwhite
\    dstnat
\    filter
\    out
\    srcnat
" end bridge_std_prios

" begin proto_icmp
" begin proto_icmp icmp_type_type
hi link nftablesProtoIcmp_Type nftablesHL_Type
syn keyword nftablesProtoIcmp_Type contained type skipwhite
\ nextgroup=
\    nftablesIcmp_TypeMnemonic,
\    nftablesIcmp_TypeInteger
" end proto_icmp icmp_type_type

hi link nftablesProtoIcmp_Code nftablesHL_Type
syn keyword nftablesProtoIcmp_Code contained code skipwhite
\ nextgroup=
\    nftablesIcmp_CodeMnemonic,
\    nftablesIcmp_CodeInteger

hi link nftablesProto_Icmp nftablesHL_Type
syn keyword nftablesProto_Icmp contained icmp skipwhite
\ nextgroup=
\    nftablesProtoIcmp_Type,
\    nftablesProtoIcmp_Code,
\    nftablesProtoIcmp_Checksum,
\    nftablesProtoIcmp_Id,
\    nftablesProtoIcmp_Sequence,
\    nftablesProtoIcmp_Gateway,
\    nftablesProtoIcmp_mtu
" end proto_icmp
"
" begin proto_igmp
hi link nftablesProtoIgmp_Type nftablesHL_Expression
syn keyword nftablesProtoIgmp_Type contained type skipwhite
\ nextgroup=
\    nftablesIgmp_TypeMnemonic,
\    nftablesIgmp_TypeInteger
" end proto_icmp icmp_type_type

hi link nftablesProtoIgmp_Mrt nftablesHL_Expression
syn keyword nftablesProtoIgmp_Mrt contained mrt skipwhite
\ nextgroup=
\    nftablesIgmp_MrtMnemonic,
\    nftablesIgmp_MrtInteger

hi link nftablesProtoIgmp_Checksum nftablesHL_Expression
syn keyword nftablesProtoIgmp_Checksum contained checksum skipwhite
\ nextgroup=
\    nftablesIgmp_Checksum

hi link nftables_rule_Igmp nftablesHL_Statement
syn keyword nftables_rule_Igmp contained igmp skipwhite
\ nextgroup=
\    nftablesProtoIgmp_Type,
\    nftablesProtoIgmp_Mrt,
\    nftablesProtoIgmp_Checksum,
\    nftablesProtoIgmp_Group
" end proto_igmp

" syn region String start=/"/ end=/"/
" syn keyword Function flush
" syn keyword Function table chain
" syn keyword Statement type hook
" syn keyword Type ip ip6 inet arp bridge
" syn keyword Type filter nat route
" syn keyword Type ether vlan arp ip icmp igmp ip6 icmpv6 tcp udp udplite sctp dccp ah esp comp icmpx
" syn keyword Type ct
" syn keyword Type length protocol priority mark iif iifname iiftype oif oifname oiftype skuid skgid rtclassid
" syn keyword Constant prerouting input forward output postrouting
" 
" syn keyword Special snat dnat masquerade redirect
" syn keyword Special accept drop reject queue
" syn keyword Keyword continue return jump goto
" syn keyword Keyword counter log

syn match nftables_E_Filespec_SC contained /"[ a-zA-Z\]\-\[0-9\._,:\;\/?<>|'`~!@#$%\^&*\\(\\)=\+ {}]\{1,1024}"/hs=s+1,he=e-1 skipwhite skipempty skipnl 

" Begin  <common_block> (Vim most-prioritized pattern yet 'contained')
" begin of 'include "filespec"' 
hi link nftablesInclude_Filespec nftablesHL_String
syn match nftablesInclude_Filespec contained /\"[ a-zA-Z\]\-\[0-9\._,:\;\/?<>|\'`~!@#$%\^&*\\(\\)=\+ {}]\{1,1024}\"/
\ skipwhite 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesInclude nftablesHL_Include
syn match nftablesInclude /^\s*include/ skipwhite
\ nextgroup=nftablesInclude_Filespec
" end of 'include \"filespec\"'
" End  <common_block> (Vim most-prioritized pattern yet 'contained')

hi link nftablesAction nftablesHL_Verdict
syn keyword nftablesAction contained skipwhite
\    accept
\    drop

"#################################################
"
hi link nftables_hook_spec_prio_spec nftablesHL_Number
syn match nftables_hook_spec_prio_spec contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftables_Semicolon
"
hi link nftables_hook_spec_PRIORITY nftablesHL_Statement
syn keyword nftables_hook_spec_PRIORITY contained priority skipwhite
\ nextgroup=nftables_hook_spec_prio_spec

" syn keyword Constant prerouting input forward output postrouting

hi link nftables_EtherMAC nftablesHL_String
syn match nftables_EtherMAC contained skipwhite
\    /\x\{1,2}:\x\{1,2}:\x\{1,2}:\x\{1,2}:\x\{1,2}:\x\{1,2}/

" Begin <HANDLE> <NUM>
hi link nftables_HANDLE_NUM_HandleId nftablesHL_Handle
syn match nftables_HANDLE_NUM_HandleId contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_HANDLE_NUM nftablesHL_Option
syn keyword nftables_HANDLE_NUM contained handle skipwhite
\ nextgroup=
\    nftables_HANDLE_NUM_HandleId
\    nftables_UnexpectedEOS
" End <HANDLE> <NUM>

" begin <ruleset_spec>
hi link nftables_ruleset_spec_Family nftablesHL_Family
syn keyword nftables_ruleset_spec_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_EOS

syn cluster nftablesCluster_ruleset_spec
\ contains=
\    nftables_ruleset_spec_Family,
\    nftables_EOS
" End <rulset_spec>

" Begin '<rulset_spec>' or 'table <table_spec>'
syn cluster nftablesCluster_ruleset_or_TABLE_table_spec
\ contains=
\    nftables_ruleset_spec_Family,
\    nftables_TABLE_table_spec,
\    nftables_EOS
" End '<rulset_spec>' or 'table <table_spec>'

" Begin 'table <table_spec>' or 'table <table_id_spec>'
syn cluster nftablesCluster_TABLE_table_and_tableid_specs
\ contains=
\    nftables_TABLE_table_spec,
\    nftables_TABLE_table_id_spec,
\    nftables_EOS
" End 'table <table_spec>' or 'table <table_id_spec>'

" begin '<table_spec> <EOS>'
hi link nftables_id_TableName nftablesHL_Table
syn match nftables_id_TableName contained skipwhite
\    /[@\$]\{0,1}[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftables_family_spec_identifier nftablesHL_Family
syn keyword nftables_family_spec_identifier contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=
\    nftables_id_TableName,
\    nftables_EOS

" '[ <family_spec> ] <identifier_TableName>'
syn cluster nftablesCluster_family_spec_identifier 
\ contains=
\    nftables_family_spec_identifier,
\    nftables_id_TableName
" end '<table_spec> <EOS>'

" Begin '<table_spec>'
syn cluster nftablesCluster_table_spec 
\ contains=
\    @nftablesCluster_family_spec_identifier

" Begin 'table <table_spec> { <table_block> }'
hi link nftables_TABLE_table_spec_block nftablesHL_Statement
syn keyword nftables_TABLE_table_spec_block contained table skipwhite
\ nextgroup=
\    nftables_table_spec_NETDEV_table_block,
\    nftables_table_spec_BRIDGE_table_block,
\    nftables_table_spec_ARP_table_block,
\    nftables_table_spec_IP_table_block,
\    nftables_table_spec_IP6_table_block,
\    nftables_table_spec_INET_table_block,
\    nftables_Semicolon,
\    nftables_EOS

" begin 'table <table_spec>'
hi link nftables_TABLE_table_spec nftablesHL_Statement
syn keyword nftables_TABLE_table_spec contained table skipwhite
\ nextgroup=@nftablesCluster_table_spec
" end 'table <table_spec>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin of expression (inside table/chain)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" End  Expression... ether ...
hi link nftablesExprEther_SetKeyword nftablesHL_Type
syn keyword nftablesExprEther_SetKeyword contained set skipwhite
\ nextgroup=
\    nftables_EtherMAC,
\    nftablesExpr_NumGen

hi link nftablesExprEther_AddrKeywords nftablesHL_Expression
syn keyword nftablesExprEther_AddrKeywords contained saddr daddr skipwhite
\ nextgroup=
\    nftablesExprEther_SetKeyword

hi link nftablesExprEther_TypeKeyword nftablesHL_Type
syn keyword nftablesExprEther_TypeKeyword contained type skipwhite
\ nextgroup=
\    nftablesType_EtherType
" End  Expression... ether ...

" Begin Expression... fwd ... (only within Netdev family)
hi link nftablesExprFwdTo_DeviceName nftablesHL_Device
execute 'syn match nftablesExprFwdTo_DeviceName contained '.string(s:deviceNameRegex).' skipwhite'

hi link nftablesStmtFwd_ToKeyword nftablesHL_Expression
syn keyword nftablesStmtFwd_ToKeyword contained to skipwhite
\ nextgroup=nftablesExprFwdTo_DeviceName
" End  Expression... fwd ... (only within Netdev family)

" Begin expression '... jhash ...'
hi link nftablesExpr_JhashKeyword nftablesHL_Expression
syn keyword nftablesExpr_JhashKeyword contained jhash skipwhite
" End  expression '... jhash ...'

" Begin 'expression... map'
" Begin expression 'map <symbol_expr>'
" Begin expression 'map <string>'
hi link nftablesExprMap_Symbol nftablesHL_String
syn match nftablesExpr_Symbol contained /[a-zA-Z0-9\._\-]\{1,64}/  skipwhite
" End expression 'map <string>'

" Begin expression 'map <variable_expr>'
hi link nftablesExprMap_VarExpr nftablesHL_Identifier
syn match nftablesExpr_VarExpr contained /\$[a-zA-Z0-9\._\-]\{1,64}/  skipwhite
" End expression 'map <variable_expr>'
" End expression 'map <symbol_expr>'

"
" Begin expression 'map <set_expr>'
syn region nftablesExprMap_Section contained start=/{/ end=/}/ skipwhite
" End expression 'map <set_expr>'

hi link nftablesExpr_MapKeyword nftablesHL_Statement
syn keyword nftablesExpr_MapKeyword contained map skipwhite
\ nextgroup=
\    nftablesExprMap_Section,
\    nftablesExprMap_VarExpr,
\    nftablesExprMap_Symbol,
" End expression 'map <set_expr>'

" Begin Expression... numgen ...
hi link nftablesExprNumGen_OffsetNumber nftablesHL_Number
syn match nftablesExprNumGen_OffsetNumber contained /\d\{1,5}/ skipwhite
\ nextgroup=
\    nftablesExpr_MapKeyword,
\    nftables_EOS

hi link nftablesExprNumGen_Offset nftablesHL_Type
syn keyword nftablesExprNumGen_Offset contained offset skipwhite
\ nextgroup=nftablesExprNumGen_OffsetNumber

hi link nftablesExprNumGen_Number nftablesHL_Number
syn match nftablesExprNumGen_Number contained /\d\{1,5}/ skipwhite
\ nextgroup=
\    nftablesExpr_MapKeyword,
\    nftablesExprNumGen_Offset,
\    nftables_EOS

hi link nftablesExprNumGen_Mod nftablesHL_Type
syn keyword nftablesExprNumGen_Mod contained mod skipwhite
\ nextgroup=nftablesExprNumGen_Number

hi link nftablesExprNumGen_Type nftablesHL_Operator
syn keyword nftablesExprNumGen_Type contained inc random skipwhite
\ nextgroup=nftablesExprNumGen_Mod

hi link nftablesExpr_NumGen nftablesHL_String
syn keyword nftablesExpr_NumGen contained numgen skipwhite
\ nextgroup=nftablesExprNumGen_Type
" End Expression... numgen ...


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin of statements (inside table/chain)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin 'statement... comment \"<string>\"'
hi link nftables_rule_CommentString nftablesHL_String
syn region nftables_rule_CommentString contained skipwhite
\ start=/"/ skip=/\\"/ end=/"/ 
\ nextgroup=
\    nftables_EOS,
\    nftables_Error

hi link nftables_rule_CommentKeyword nftablesHL_Statement
syn keyword nftables_rule_CommentKeyword contained comment skipwhite
\ nextgroup=nftables_rule_CommentString
" End 'statement... comment \"<string>\"'

" Begin 'statement... counter ...'
hi link nftables_rule_COUNTER nftablesHL_Statement
syn keyword nftables_rule_COUNTER contained counter skipwhite
\ nextgroup=
\    nftables_rule_LogKeyword,
\    nftables_rule_ChainTarget,
\    nftables_Semicolon,
\    nftables_EOS
" End 'statement... counter ...'

" Begin 'statement... ether <eth_hdr_field>...' 
hi link nftables_rule_EtherKeyword nftablesHL_Statement
syn keyword nftables_rule_EtherKeyword contained ether skipwhite
\ nextgroup=
\    nftablesExprEther_AddrKeywords,
\    nftablesExprEther_TypeKeyword
" End 'statement... ether ...'

" Begin 'statement... fwd to ...'  (only within Netdev family)
hi link nftables_rule_FwdKeyword nftablesHL_Statement
syn keyword nftables_rule_FwdKeyword contained fwd skipwhite
\ nextgroup=nftablesStmtFwd_ToKeyword
" End 'statement... fwd to ...' (only within Netdev family)

" Begin 'statement... log ...'
hi link nftables_rule_LogKeyword nftablesHL_Statement
syn keyword nftables_rule_LogKeyword contained log skipwhite
\ nextgroup=
\    nftablesStmtVerdicts_ChainTarget,
\    nftables_Semicolon,
\    nftables_EOS
" End 'statement... log ...'

" Begin 'statement... map'
hi link nftablesStmtMap_MapName nftablesHL_Map
" Begin 'map <set_spec> { <map_block> }
syn match nftablesStmtMap_MapName contained skipwhite
\    /[@\$]\{0,1}[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_rule_TcpKeyword,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_rule_MapKeyword nftablesHL_Statement
syn keyword nftables_rule_MapKeyword contained map skipwhite
\ nextgroup=
\    nftablesStmtMap_MapName
" End 'statement... map'

" Begin of 'statement... quota'
hi link nftables_quota_used nftablesHL_Type
syn keyword nftables_quota_used contained skipwhite
\    /\d\{1,11}/

hi link nftables_quota_unit nftablesHL_Type
syn keyword nftables_quota_unit contained skipwhite
\    bytes kbytes mbytes
\ nextgroup=
\    nftables_quota_used,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_quota_bytes nftablesHL_Number
syn match nftables_quota_bytes contained /\d\{1,11}/ skipwhite
\ nextgroup=nftables_quota_unit

hi link nftables_quota_mode nftablesHL_Type
syn keyword nftables_quota_mode contained skipwhite
\    until over
\ nextgroup=nftables_quota_bytes

" [ over | until ] <bytes>
syn cluster nftablesCluster_quota_config
\ contains=
\    nftables_quota_mode,
\    nftables_quota_bytes

hi link nftables_quota_stmt_QUOTA nftablesHL_Statement
syn keyword nftables_quota_stmt_QUOTA contained quota skipwhite
\ nextgroup=@nftablesCluster_quota_config

" statement stmt stmt_list rule_alloc rule
syn cluster nftablesCluster_stmt 
\ contains=
\    @nftablesCluster_quota_stmt

syn cluster nftablesCluster_stmt_list
\ contains=@nftablesCluster_stmt  " this needs to be inside a _Section

syn cluster nftablesCluster_rule_alloc
\ contains=@nftablesCluster_stmt_list

syn cluster nftablesCluster_rule
\ contains=@nftablesCluster_rule_alloc  " this needs to add an named_Comment

" Begin 'add rule ... tcp'
hi link nftablesStmtTcp_TcpTypes nftablesHL_Expression
syn keyword nftablesStmtTcp_TcpTypes contained skipwhite
\    ackseq
\    checksum
\    doff
\    dport
\    flags
\    reserved
\    sequence
\    sport
\    urgptr
\    window
\ nextgroup=
\    nftables_rule_MapKeyword,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_rule_TcpKeyword nftablesHL_Statement
syn keyword nftables_rule_TcpKeyword contained tcp skipwhite
\ nextgroup=nftablesStmtTcp_TcpTypes
" End 'statement... tcp'

" End 'statement... udp'
hi link nftablesExprUdp_EtherOffset nftablesHL_Expression
syn keyword nftablesExprUdp_EtherOffset contained skipwhite
\    saddr
\    daddr
\ nextgroup=nftablesExprUdp_MAC

hi link nftablesExprUdp_EtherKeyword nftablesHL_Statement
syn keyword nftablesExprUdp_EtherKeyword contained ether skipwhite
\ nextgroup=
\    nftablesExprUdp_EtherOffset

hi link nftablesExprUdp_Checksum nftablesHL_Number
syn match nftablesExprUdp_Checksum contained /\d\{1,5}/ skipwhite

hi link nftablesExprUdp_ChecksumKeyword nftablesHL_Statement
syn keyword nftablesExprUdp_ChecksumKeyword contained checksum skipwhite
\ nextgroup=
\    nftablesExprUdp_Checksum

hi link nftablesExprUdp_Length nftablesHL_Number
syn match nftablesExprUdp_Length contained /\d\{1,5}/ skipwhite

hi link nftablesExprUdp_LengthKeyword nftablesHL_Statement
syn keyword nftablesExprUdp_LengthKeyword contained length skipwhite
\ nextgroup=
\    nftablesExprUdp_Length

hi link nftablesExprUdp_PortNumber nftablesHL_Number
syn match nftablesExprUdp_PortNumber contained /\d\{1,5}/ skipwhite

hi link nftablesExprUdp_PortName nftablesHL_Type
syn keyword nftablesExprUdp_PortName contained skipwhite
\    http https smtp smtps submission ftp dns

hi link nftablesExprUdp_PortsKeyword nftablesHL_Expression
syn keyword nftablesExprUdp_PortsKeyword contained skipwhite
\    dport
\    sport
\ nextgroup=
\    nftablesExprUdp_PortName,
\    nftablesExprUdp_PortNumber,
\    nftables_Error

syn region nftablesExprUdp_Section contained start=/\s\zs\s/ end=/;/ skipwhite
\ contains=
\    nftablesExprUdp_PortsKeyword,
\    nftablesExprUdp_LengthKeyword,
\    nftablesExprUdp_ChecksumKeyword,
\    nftablesExprUdp_EtherKeyword,
\    nftables_Semicolon

hi link nftables_rule_UDP nftablesHL_Statement
syn keyword nftables_rule_UDP contained udp tcp skipwhite
\ nextgroup=
\    nftablesExprUdp_PortsKeyword,
\    nftablesExprUdp_LengthKeyword,
\    nftablesExprUdp_ChecksumKeyword,
\    nftablesExprUdp_EtherKeyword,
\    nftables_Semicolon
" nftablesExprUdp_Section
" End 'statement... udp'

" Begin 'statement... verdict'
hi link nftablesStmtVerdicts_ChainTarget nftablesHL_Chain
syn match nftablesStmtVerdicts_ChainTarget contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_rule_CommentKeyword,
\    nftables_EOS

function NftablesCreateStmtKeywords(mylabel, kywds, hlite, hi_opt)
  exec 'hi link '.a:mylabel.' nftablesHL_'.a:hlite
  exec 'syntax keyword nftables_rule_'.a:mylabel.' contained skipwhite '.a:kywds.' '.a:hi_opt
endfunction

call NftablesCreateStmtKeywords( 'VerdictKeywords', 
\  ' accept drop continue return queue ', 'Statement',
\  ' nextgroup=nftables_rule_CommentKeyword,nftables_EOS' )

" hi link nftables_rule_VerdictKeywords nftablesHL_Statement
" syn keyword nftables_rule_VerdictKeywords contained skipwhite
" \    accept
" \    drop
" \    continue
" \    return
" \    queue

hi link nftables_rule_VerdictTargetKeywords nftablesHL_Statement
syn keyword nftables_rule_VerdictTargetKeywords contained skipwhite
\    jump
\    goto 
\ nextgroup=
\    nftablesStmtVerdicts_ChainTarget
" End of statements (inside table/chain)

" Begin 'table arp ...'
hi link nftablesTArpC_Policy nftablesHL_Type
syn keyword nftablesTArpC_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon,nftables_EOS

hi link nftablesTArpC_PolicyKeyword nftablesHL_Statement
syn keyword nftablesTArpC_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesTArpC_Policy

hi link nftablesTArpC_Hook_Type nftablesHL_Hook
syn keyword nftablesTArpC_Hook_Type contained skipwhite
\    input
\    output
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesTArpC_HookKeyword nftablesHL_Statement
syn keyword nftablesTArpC_HookKeyword contained hook skipwhite
\ nextgroup=
\    nftablesTArpC_Hook_Type

hi link nftablesTArpC_Type_Filter nftablesHL_Type
syn keyword nftablesTArpC_Type_Filter contained filter skipwhite
\ nextgroup=nftablesTArpC_HookKeyword

hi link nftablesTArpC_Type_Nat nftablesHL__Type
syn keyword nftablesTArpC_Type_Nat contained nat skipwhite
\ nextgroup=nftablesTArpC_HookKeyword

hi link nftablesTArpC_Type_Route nftablesHL__Type
syn keyword nftablesTArpC_Type_Route contained route skipwhite
\ nextgroup=nftablesTArpC_HookKeyword

hi link nftablesTArpC_TypeKeyword nftablesHL_Statement
syn keyword nftablesTArpC_TypeKeyword contained type skipwhite
\ nextgroup=
\    nftablesTArpC_Type_Filter,
\    nftablesTArpC_Type_Nat,
\    nftablesTArpC_Type_Route

hi link nftablesLogFlagsStr nftablesHL_String
syn match nftablesLogFlagSstr contained /[A-Za-z0-9 \t]\{1,64}/ skipwhite

hi link nftablesLogFlagsKeyword nftablesHL_String
syn keyword nftablesLogFlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesLogFlagstr

hi link nftablesLogLevelStr nftablesHL_String
syn keyword nftablesLogLevelStr contained skipwhite
\    emerg
\    alert
\    crit
\    err
\    warn
\    default
\    notice
\    info
\    debug  

hi link nftablesLogLevelKeyword nftablesHL_String
syn keyword nftablesLogLevelKeyword contained level skipwhite
\ nextgroup=
\    nftablesLogLevelStr

hi link nftablesLogPrefixStr nftablesHL_String
syn match nftablesLogPrefixStr contained /[A-Za-z0-9 \t]\{1,64}/ skipwhite

hi link nftablesLogPrefixKeyword nftablesHL_String
syn keyword nftablesLogPrefixKeyword contained prefix skipwhite
\ nextgroup=
\    nftablesLogPrefixStr

hi link nftablesLogKeyword nftablesHL_Option
syn keyword nftablesLogKeyword contained log skipwhite
\ nextgroup=
\    nftablesLogPrefixKeyword,
\    nftablesLogLevelKeyword,
\    nftablesLogFlagsKeyword,
\    nftablesAction

hi link nftablesIifnameKeyword nftablesHL_Option
syn keyword nftablesIifnameKeyword contained skipwhite
\    meter
\    fib
\    iifname
\    iif
\    oifname
\    oif

syn region nftablesTArpChain_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesTArpC_TypeKeyword,
\    nftablesTArpC_PolicyKeyword,
\    nftables_rule_COUNTER,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftables_InlineComment,
\    nftablesInclude
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS


hi link nftablesTArpChain_Name nftablesHL_Chain
syn match nftablesTArpChain_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,63}/ 
\ nextgroup=
\    nftablesTArpChain_Section

hi link nftablesTArpChainKeyword nftablesHL_Option
syn keyword nftablesTArpChainKeyword contained chain skipwhite skipempty
\ nextgroup=nftablesTArpChain_Name

syn region nftablesTArp_Section contained start=/{/ end=/}/ 
\ contains=
\    nftablesTArpChainKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesTArp_Name nftablesHL_Identifier
syn match nftablesTArp_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesTArp_Section

hi link nftables_add_table_arp nftablesHL_Family
syn keyword nftables_add_table_arp contained arp skipwhite
\ nextgroup=nftablesTArp_Name
" End 'table arp ...'


" Begin of 'add chain ...'
" Begin of 'add chain arp <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainArpDevice_NthElement  nftablesHL_String
syn match nftablesCmdAddChainArpDevice_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainArpDevice_Comma

hi link nftablesCmdAddChainArpDevice_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainArpDevice_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainArpDevice_NthElement

hi link nftablesCmdAddChainArpDevice_Element  nftablesHL_String
syn match nftablesCmdAddChainArpDevice_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainArpDevice_Comma

syn region nftablesCmdAddChainArp_DeviceSection start=/{/ end=/}/ 
\ contained skipwhite
\ contains=nftablesCmdAddChainArpDevice_Element
\ nextgroup=nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainArp_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainArp_DeviceEqual contained /=\s*/ skipwhite
\ nextgroup=nftablesCmdAddChainArp_DeviceSection

hi link nftablesCmdAddChainArp_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainArp_DeviceEqual

hi link nftablesCmdAddChainArp_DeviceName  nftablesHL_String
execute 'syn match nftablesCmdAddChainArp_DeviceName contained '.string(s:deviceNameRegex).' skipwhite nextgroup=nftables_hook_spec_PRIORITY'

hi link nftablesCmdAddChainArp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainArp_DeviceName

hi link nftablesCmdAddChainArp_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainArp_Hook contained skipwhite
\    input
\    output
\ nextgroup=
\    nftablesCmdAddChainArp_DevicesKeyword,
\    nftablesCmdAddChainArp_DeviceKeyword,
\    nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainArp_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainArp_Hook

hi link nftablesCmdAddChainArp_Type nftablesHL_Type
syn keyword nftablesCmdAddChainArp_Type contained skipwhite
\    filter
\ nextgroup=nftablesCmdAddChainArp_HookKeyword 

hi link nftablesCmdAddChainArp_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainArp_Type

hi link nftablesCmdAddChainArp_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainArp_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainArp_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainArp_Policy

syn region nftablesCmdAddChainArp_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddChainArp_TypeKeyword,
\    nftablesCmdAddChainArp_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddChainArp_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainArp_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainArp_Section,
\    nftables_EOS

hi link nftablesCmdAddChainArp_TableName nftablesHL_Table
syn match nftablesCmdAddChainArp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainArp_ChainName
" End of 'add chain arp <table_name> <chain_name> { ... }

" Begin of 'add chain bridge <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainBridge_Priority nftablesHL_Number
syn match nftablesCmdAddChainBridge_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainBridge_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_DeviceKeyword contained device skipwhite
\ nextgroup=
\    nftablesCmdAddChainBridge_Device

hi link nftablesCmdAddChainBridgeDevice_NthElement  nftablesHL_String
syn match nftablesCmdAddChainBridgeDevice_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainBridgeDevice_Comma

hi link nftablesCmdAddChainBridgeDevice_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainBridgeDevice_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainBridgeDevice_NthElement

hi link nftablesCmdAddChainBridgeDevice_Element  nftablesHL_String
syn match nftablesCmdAddChainBridgeDevice_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainBridgeDevice_Comma

syn region nftablesCmdAddChainBridge_DeviceSection start=/{/ end=/}/ 
\ contained skipwhite
\ contains=nftablesCmdAddChainBridgeDevice_Element
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainBridge_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainBridge_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainBridge_DeviceSection

hi link nftablesCmdAddChainBridge_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainBridge_DeviceEqual

hi link nftablesCmdAddChainBridge_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainBridge_Hook contained skipwhite
\    prerouting
\    input
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainBridge_DevicesKeyword,
\    nftablesCmdAddChainBridge_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainBridge_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Hook

hi link nftablesCmdAddChainBridge_Type nftablesHL_Type
syn keyword nftablesCmdAddChainBridge_Type contained skipwhite
\    filter
\ nextgroup=nftablesCmdAddChainBridge_HookKeyword nftablesHL_Option

hi link nftablesCmdAddChainBridge_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Type

hi link nftablesCmdAddChainBridge_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainBridge_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainBridge_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Policy

syn region nftablesCmdAddChainBridge_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddChainBridge_TypeKeyword,
\    nftablesCmdAddChainBridge_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddChainBridge_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainBridge_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainBridge_Section,
\    nftables_EOS

hi link nftablesCmdAddChainBridge_TableName nftablesHL_Table
syn match nftablesCmdAddChainBridge_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainBridge_ChainName
" End of 'add chain bridge <table_name> <chain_name> { ... }

" Begin of 'add chain netdev <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainNetdev_Device  nftablesHL_String
syn match nftablesCmdAddChainNetdev_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainNetdev_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_DeviceKeyword contained device skipwhite
\ nextgroup=
\    nftablesCmdAddChainNetdev_Device

hi link nftablesCmdAddChainNetdevDevice_NthElement  nftablesHL_String
syn match nftablesCmdAddChainNetdevDevice_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainNetdevDevice_Comma

hi link nftablesCmdAddChainNetdevDevice_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainNetdevDevice_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainNetdevDevice_NthElement

hi link nftablesCmdAddChainNetdevDevice_Element  nftablesHL_String
syn match nftablesCmdAddChainNetdevDevice_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainNetdevDevice_Comma

syn region nftablesCmdAddChainNetdev_DeviceSection start=/{/ end=/}/
\ contained skipwhite
\ contains=nftablesCmdAddChainNetdevDevice_Element
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainNetdev_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainNetdev_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_DeviceSection

hi link nftablesCmdAddChainNetdev_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainNetdev_DeviceEqual

hi link nftablesCmdAddChainNetdev_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainNetdev_Hook contained skipwhite
\    ingress
\ nextgroup=
\    nftablesCmdAddChainNetdev_DeviceKeyword,
\    nftablesCmdAddChainNetdev_DevicesKeyword,
\    nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainNetdev_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Hook

hi link nftablesCmdAddChainNetdev_Type nftablesHL_Type
syn keyword nftablesCmdAddChainNetdev_Type contained skipwhite
\    filter
\ nextgroup=nftablesCmdAddChainNetdev_HookKeyword nftablesHL_Option

hi link nftablesCmdAddChainNetdev_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Type

hi link nftablesCmdAddChainNetdev_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainNetdev_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainNetdev_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Policy

syn region nftablesCmdAddChainNetdev_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddChainNetdev_TypeKeyword,
\    nftablesCmdAddChainNetdev_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddChainNetdev_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainNetdev_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainNetdev_Section,
\    nftables_EOS

hi link nftablesCmdAddChainNetdev_TableName nftablesHL_Table
syn match nftablesCmdAddChainNetdev_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainNetdev_ChainName
" End of 'add chain netdev <table_name> <chain_name> { ... }

" Begin of 'add chain ip <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainIp_Device  nftablesHL_String
syn match nftablesCmdAddChainIp_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainIp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp_Device

hi link nftablesCmdAddChainIpDevice_NthElement  nftablesHL_String
syn match nftablesCmdAddChainIpDevice_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainIpDevice_Comma

hi link nftablesCmdAddChainIpDevice_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainIpDevice_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainIpDevice_NthElement

hi link nftablesCmdAddChainIpDevice_Element  nftablesHL_String
syn match nftablesCmdAddChainIpDevice_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainIpDevice_Comma

syn region nftablesCmdAddChainIp_DeviceSection start=/{/ end=/}/
\ contained skipwhite
\ contains=nftablesCmdAddChainIpDevice_Element
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainIp_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainIp_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_DeviceSection

hi link nftablesCmdAddChainIp_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainIp_DeviceEqual

hi link nftablesCmdAddChainIp_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DevicesKeyword,
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_NatHook contained skipwhite
\    prerouting
\    input
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DevicesKeyword,
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftablesCmdAddChainIp_DevicesKeyword,
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp_FilterHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_FilterHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp_FilterHook
hi link nftablesCmdAddChainIp_NatHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_NatHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp_NatHook
hi link nftablesCmdAddChainIp_RouteHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_RouteHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp_RouteHook

hi link nftablesCmdAddChainIp_Type nftablesHL_Type
syn keyword nftablesCmdAddChainIp_Type contained filter skipwhite
\ nextgroup=nftablesCmdAddChainIp_FilterHookKeyword 
syn keyword nftablesCmdAddChainIp_Type contained nat skipwhite
\ nextgroup=nftablesCmdAddChainIp_NatHookKeyword 
syn keyword nftablesCmdAddChainIp_Type contained route skipwhite
\ nextgroup=nftablesCmdAddChainIp_RouteHookKeyword 

hi link nftablesCmdAddChainIp_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainIp_Type

hi link nftablesCmdAddChainIp_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainIp_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainIp_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainIp_Policy

syn region nftablesCmdAddChainIp_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddChainIp_TypeKeyword,
\    nftablesCmdAddChainIp_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddChainIp_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainIp_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainIp_Section,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddChainIp_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainIp_ChainName
" End of 'add chain ip <table_name> <chain_name> { ... }

" Begin of 'add chain ip6 <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainIp6_Device  nftablesHL_String
syn match nftablesCmdAddChainIp6_Device contained skipwhite 
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainIp6_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Device

hi link nftablesCmdAddChainIp6Device_NthElement  nftablesHL_String
syn match nftablesCmdAddChainIp6Device_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainIp6Device_Comma

hi link nftablesCmdAddChainIp6Device_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainIp6Device_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainIp6Device_NthElement

hi link nftablesCmdAddChainIp6Device_Element  nftablesHL_String
syn match nftablesCmdAddChainIp6Device_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainIp6Device_Comma

syn region nftablesCmdAddChainIp6_DeviceSection start=/{/ end=/}/
\ contained skipwhite
\ contains=nftablesCmdAddChainIp6Device_Element
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftablesCmdAddChainIp6_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainIp6_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainIp6_DeviceSection

hi link nftablesCmdAddChainIp6_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainIp6_DeviceEqual

hi link nftablesCmdAddChainIp6_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp6_DevicesKeyword,
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp6_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp6_DevicesKeyword,
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp6_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftablesCmdAddChainIp6_DevicesKeyword,
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftablesCmdAddChainIp6_FilterHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_FilterHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp6_FilterHook
hi link nftablesCmdAddChainIp6_NatHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_NatHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp6_NatHook
hi link nftablesCmdAddChainIp6_RouteHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_RouteHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp6_RouteHook

hi link nftablesCmdAddChainIp6_Type nftablesHL_Type
syn keyword nftablesCmdAddChainIp6_Type contained filter skipwhite
\ nextgroup=nftablesCmdAddChainIp6_FilterHookKeyword 
syn keyword nftablesCmdAddChainIp6_Type contained nat skipwhite
\ nextgroup=nftablesCmdAddChainIp6_NatHookKeyword 
syn keyword nftablesCmdAddChainIp6_Type contained route skipwhite
\ nextgroup=nftablesCmdAddChainIp6_RouteHookKeyword 

hi link nftablesCmdAddChainIp6_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Type

hi link nftablesCmdAddChainIp6_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainIp6_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainIp6_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Policy

syn region nftablesCmdAddChainIp6_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddChainIp6_TypeKeyword,
\    nftablesCmdAddChainIp6_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddChainIp6_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainIp6_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainIp6_Section,
\    nftables_EOS

hi link nftablesCmdAddChainIp6_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp6_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainIp6_ChainName
" End of 'add chain ip6 <table_name> <chain_name> { ... }
"
" Begin of 'add chain inet <table_name> <chain_name> { ... }
hi link nftables_chain_spec_block_Inet_Device  nftablesHL_String
syn match nftables_chain_spec_block_Inet_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftables_chain_spec_block_Inet_DeviceKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_DeviceKeyword contained skipwhite
\    device
\ nextgroup=
\    nftables_chain_spec_block_Inet_Device

hi link nftablesCmdAddChainInetDevice_NthElement  nftablesHL_String
syn match nftablesCmdAddChainInetDevice_NthElement contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainInetDevice_Comma

hi link nftablesCmdAddChainInetDevice_Comma  nftablesHL_Operator
syn match nftablesCmdAddChainInetDevice_Comma contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddChainInetDevice_NthElement

hi link nftablesCmdAddChainInetDevice_Element  nftablesHL_String
syn match nftablesCmdAddChainInetDevice_Element contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=
\    nftablesCmdAddChainInetDevice_Comma

syn region nftables_chain_spec_block_Inet_DeviceSection start=/{/ end=/}/
\ contained skipwhite
\ contains=nftablesCmdAddChainInetDevice_Element
\ nextgroup=nftables_hook_spec_PRIORITY

hi link nftables_chain_spec_block_Inet_DeviceEqual  nftablesHL_Operator
syn match nftables_chain_spec_block_Inet_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_DeviceSection

hi link nftables_chain_spec_block_Inet_DevicesKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_DevicesKeyword contained skipwhite
\    devices
\ nextgroup=
\    nftables_chain_spec_block_Inet_DeviceEqual

hi link nftables_chain_spec_block_Inet_FilterHook nftablesHL_Hook
syn keyword nftables_chain_spec_block_Inet_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftables_chain_spec_block_Inet_DevicesKeyword,
\    nftables_chain_spec_block_Inet_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftables_chain_spec_block_Inet_NatHook nftablesHL_Hook
syn keyword nftables_chain_spec_block_Inet_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftables_chain_spec_block_Inet_DevicesKeyword,
\    nftables_chain_spec_block_Inet_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftables_chain_spec_block_Inet_RouteHook nftablesHL_Hook
syn keyword nftables_chain_spec_block_Inet_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftables_chain_spec_block_Inet_DevicesKeyword,
\    nftables_chain_spec_block_Inet_DeviceKeyword,
\    nftables_hook_spec_PRIORITY 

hi link nftables_chain_spec_block_Inet_FilterHookKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_FilterHookKeyword contained
\    hook
\ skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_FilterHook
hi link nftables_chain_spec_block_Inet_NatHookKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_NatHookKeyword contained 
\    hook
\ skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_NatHook
hi link nftables_chain_spec_block_Inet_RouteHookKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_RouteHookKeyword contained 
\    hook
\ skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_RouteHook

hi link nftables_chain_spec_block_Inet_Type nftablesHL_Type
syn keyword nftables_chain_spec_block_Inet_Type contained filter skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_FilterHookKeyword 
syn keyword nftables_chain_spec_block_Inet_Type contained nat skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_NatHookKeyword 
syn keyword nftables_chain_spec_block_Inet_Type contained route skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_RouteHookKeyword 

hi link nftables_chain_spec_block_Inet_TypeKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_TypeKeyword contained type skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_Type

hi link nftables_chain_spec_block_Inet_Policy nftablesHL_Verdict
syn keyword nftables_chain_spec_block_Inet_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftables_chain_spec_block_Inet_PolicyKeyword nftablesHL_Option
syn keyword nftables_chain_spec_block_Inet_PolicyKeyword contained 
\    policy
\ skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_Policy


syn region nftables_chain_spec_block_Inet_Section contained start=/{/ end=/}/
\ contains=
\    nftables_chain_spec_block_Inet_TypeKeyword,
\    nftables_chain_spec_block_Inet_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftables_chain_spec_block_Inet_ChainName nftablesHL_Chain
syn match nftables_chain_spec_block_Inet_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_chain_spec_block_Inet_Section,
\    nftables_EOS

hi link nftables_chain_spec_block_Inet_TableName nftablesHL_Table
syn match nftables_chain_spec_block_Inet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_chain_spec_block_Inet_ChainName
" End of 'add chain inet <table_name>...' 

" Begin 'add chain <chain_spec> [<chain_block>]'
hi link nftables_chain_spec_block_Family nftablesHL_Family
syn keyword nftables_chain_spec_block_Family contained netdev skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_TableName

syn keyword nftables_chain_spec_block_Family contained arp skipwhite
\ nextgroup=nftablesCmdAddChainArp_TableName

syn keyword nftables_chain_spec_block_Family contained bridge skipwhite
\ nextgroup=nftablesCmdAddChainBridge_TableName

syn keyword nftables_chain_spec_block_Family contained ip skipwhite
\ nextgroup=nftablesCmdAddChainIp_TableName

syn keyword nftables_chain_spec_block_Family contained ip6 skipwhite
\ nextgroup=nftablesCmdAddChainIp6_TableName

syn keyword nftables_chain_spec_block_Family contained inet skipwhite
\ nextgroup=nftables_chain_spec_block_Inet_TableName

hi link nftables_CHAIN_chain_spec_block nftablesHL_Option
syn keyword nftables_CHAIN_chain_spec_block contained chain skipwhite
\ nextgroup=
\    nftables_chain_spec_block_Family,
\    nftablesCmdAddChainIp_TableName
" End 'add chain <chain_spec> [<chain_block>]'


" Begin command 'ct ...'
hi link nftablesCmdAddCT_L3protocolIdentifier nftablesHL_Identifier
syn keyword nftablesCmdAddCT_L3protocolIdentifier contained skipwhite
\    ip
\    ip6
\    inet
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddCT_L3protocolKeyword nftablesHL_Option
syn keyword nftablesCmdAddCT_L3protocolKeyword contained l3proto skipwhite
\ nextgroup=nftablesCmdAddCT_L3protocolIdentifier

hi link nftablesCmdAddCT_ProtocolIdentifier nftablesHL_Identifier
syn keyword nftablesCmdAddCT_ProtocolIdentifier contained skipwhite
\    icmp
\    igmp
\    ipencap
\    tcp
\    egp
\    igp
\    udp
\    dccp
\    ddp
\    ipv6
\    gre
\    esp
\    ah
\    eigrp
\    ospf
\    ipip
\    etherip
\    l2tp
\    sctp
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddCT_ProtocolKeyword nftablesHL_Option
syn keyword nftablesCmdAddCT_ProtocolKeyword contained protocol skipwhite
\ nextgroup=nftablesCmdAddCT_ProtocolIdentifier

hi link nftablesCmdAddCT_TypeIdentifier nftablesHL_Identifier
syn match nftablesCmdAddCT_TypeIdentifier contained skipwhite
\    /\"[A-Za-z][A-Za-z0-9\-_./]\{0,64}\"/ 
\ nextgroup=nftablesCmdAddCT_ProtocolKeyword

hi link nftablesCmdAddCT_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddCT_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddCT_TypeIdentifier

syn region nftablesCmdAddCT_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddCT_TypeKeyword,
\    nftablesCmdAddCT_L3protocolKeyword,
\    nftables_Semicolon
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddCT_HelperName nftablesHL_Chain
syn match nftablesCmdAddCT_HelperName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddCT_Section,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddCT_TableName nftablesHL_Table
syn match nftablesCmdAddCT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddCT_HelperName

hi link nftablesCmdAddCT_Family nftablesHL_Family
syn keyword nftablesCmdAddCT_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=
\    nftablesCmdAddCT_TableName

hi link nftablesCmdAddCT_HelperKeyword nftablesHL_Option
syn keyword nftablesCmdAddCT_HelperKeyword contained helper skipwhite
\ nextgroup=
\    nftablesCmdAddCT_Family,
\    nftablesCmdAddCT_TableName

" End command 'ct ...'

" Begin of 'add table ...'/'create table ...'
hi link nftables_table_option_dormant nftablesHL_Type
syn keyword nftables_table_option_dormant contained dormant skipwhite

hi link nftables_table_options_flags nftablesHL_Option
syn keyword nftables_table_options_flags contained flags skipwhite
\ nextgroup=nftables_table_option_dormant

syn region nftables_table_block_Section contained start=/{/ end=/}/ 
\ skipwhite
\ contains=
\    nftables_table_options_flags,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftables_table_name_table_block  nftablesHL_Table
syn match nftables_table_name_table_block  contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_table_block_Section,
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftables_family_spec_explicit_table_name_table_block nftablesHL_Family
syn keyword nftables_family_spec_explicit_table_name_table_block contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_table_name_table_block

syn cluster nftablesCluster_table_spec_table_block
\ contains=
\    nftables_family_spec_explicit_table_name_table_block,
\    nftables_table_name_table_block

hi link nftables_TABLE_table_spec_table_block  nftablesHL_Statement
syn keyword nftables_TABLE_table_spec_table_block contained table skipwhite
\ nextgroup=
\    @nftablesCluster_table_spec_table_block,
" End of 'add table ...'/'create table ...'

" Begin of 'add set [<family>] <table_id> <set_id>'
hi link nftablesAddSetType_Concatenate nftablesHL_Operator
syn match nftablesAddSetType_Concatenate contained /\./ skipwhite
\ nextgroup=nftablesAddSet_Type

hi link nftablesAddSet_Type nftablesHL_Type
syn keyword nftablesAddSet_Type contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=
\    nftablesAddSetType_Concatenate,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_TypeKeyword nftablesHL_Statement
syn keyword nftablesAddSet_TypeKeyword contained type skipwhite
\ nextgroup=nftablesAddSet_Type

hi link nftablesAddSetFlags_Concatenate nftablesHL_Operator
syn match nftablesAddSetFlags_Concatenate contained /\./ skipwhite
\ nextgroup=nftablesAddSet_Flags

hi link nftablesAddSet_Flags nftablesHL_Type
syn keyword nftablesAddSet_Flags contained skipwhite
\    constant
\    interval
\    timeout
\    dynamic
\ nextgroup=
\    nftablesAddSetFlags_Concatenate,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_FlagsKeyword nftablesHL_Statement
syn keyword nftablesAddSet_FlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesAddSet_Flags,
\    nftablesAddSetFlags_Concatenate

hi link nftablesAddSet_Timeout nftablesHL_Number
syn match nftablesAddSet_Timeout contained /\d\{1,11}[HhDdMmSs]\?/
\ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_TimeoutKeyword nftablesHL_Statement
syn keyword nftablesAddSet_TimeoutKeyword contained timeout skipwhite
\ nextgroup=nftablesAddSet_Timeout

hi link nftablesAddSet_GcInterval nftablesHL_Number
syn match nftablesAddSet_GcInterval contained /\d\{1,11}[DdHhMmSs]\?/
\ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_GcIntervalKeyword nftablesHL_Option
syn keyword nftablesAddSet_GcIntervalKeyword contained gc-interval skipwhite
\ nextgroup=
\    nftablesAddSet_GcInterval

hi link nftablesAddSetElements_ElementNth nftablesHL_Type
syn keyword nftablesAddSetElements_ElementNth contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=
\    nftablesAddSetElements_Separator

hi link nftablesAddSetElements_Separator nftablesHL_Operator
syn match nftablesAddSetElements_Separator contained /,/ skipwhite
\ nextgroup=
\    nftablesAddSetElements_ElementNth,
\    nftables_Error

hi link nftablesAddSetElements_Element nftablesHL_Type
syn keyword nftablesAddSetElements_Element contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=nftablesAddSetElements_Separator

syn region nftablesAddSet_ElementsSection contained start=/=/ end=/;/ skipwhite
\ contains=nftablesAddSetElements_Element
\ nextgroup=
\    nftables_Semicolon

hi link nftablesAddSet_ElementsKeyword nftablesHL_Statement
syn keyword nftablesAddSet_ElementsKeyword contained elements skipwhite
\ nextgroup=
\    nftablesAddSet_ElementsSection

hi link nftablesAddSet_Size nftablesHL_Number
syn match nftablesAddSet_Size contained /\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_SizeKeyword nftablesHL_Statement
syn keyword nftablesAddSet_SizeKeyword contained size skipwhite
\ nextgroup=
\    nftablesAddSet_Size

hi link nftablesAddSet_Policy nftablesHL_Type
syn keyword nftablesAddSet_Policy contained skipwhite
\    performance
\    memory
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_PolicyKeyword nftablesHL_Statement
syn keyword nftablesAddSet_PolicyKeyword contained policy skipwhite
\ nextgroup=
\    nftablesAddSet_Policy

hi link nftablesAddSet_AutoMergeKeyword nftablesHL_Statement
syn keyword nftablesAddSet_AutoMergeKeyword contained auto-merge skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

syn region nftablesCmdAddSet_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesAddSet_TypeKeyword,
\    nftablesAddSet_FlagsKeyword,
\    nftablesAddSet_TimeoutKeyword,
\    nftablesAddSet_GcIntervalKeyword,
\    nftablesAddSet_ElementsKeyword,
\    nftablesAddSet_SizeKeyword,
\    nftablesAddSet_PolicyKeyword,
\    nftablesAddSet_AutoMergeKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddSet_SetName nftablesHL_Set
syn match nftablesCmdAddSet_SetName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddSet_Section,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddSet_TableName nftablesHL_Table
syn match nftablesCmdAddSet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddSet_SetName

hi link nftablesCmdAddSet_Family nftablesHL_Family
syn keyword nftablesCmdAddSet_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddSet_TableName

hi link nftables_SET_set_spec_block nftablesHL_Statement
syn keyword nftables_SET_set_spec_block contained set skipwhite
\ nextgroup=
\    nftablesCmdAddSet_Family,
\    nftablesCmdAddSet_TableName
" End of 'add set [<family>] <table_id> <set_id>'

" Begin of 'add table'
"   Performed by nftablesCmdAddCreate_TableKeyword
" End of 'add table ...'

" Begin of 'add element [<family>] <table_id> <set_id>'
hi link nftablesAddElement_ElementNth nftablesHL_Type
syn keyword nftablesAddElement_ElementNth contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\    counter
\    quota
\ nextgroup=
\    nftablesAddElement_Separator

hi link nftablesAddElement_Separator nftablesHL_Operator
syn match nftablesAddElement_Separator contained /,/ skipwhite
\ nextgroup=
\    nftablesAddElement_ElementNth

hi link nftablesAddElement_SetElements nftablesHL_Type
syn keyword nftablesAddElement_SetElements contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\    counter
\    quota
\ nextgroup=nftablesAddElement_Separator

syn region nftablesAddElement_MapSection contained start=/{/ end=/}/ skipwhite
\ contains=nftablesAddElement_SetElements
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment

hi link nftablesAddElementMap_Equal nftablesHL_Operator
syn match nftablesAddElementMap_Equal contained /=/ skipwhite
\ nextgroup=nftablesAddElement_MapSection

hi link nftablesAddElement_MapElements nftablesHL_Option
syn keyword nftablesAddElement_MapElements contained elements skipwhite
\ nextgroup=nftablesAddElementMap_Equal

syn region nftablesCmdAddElement_Section contained start=/{/ end=/}/
\ skipwhite
\ contains=
\    nftablesAddElement_MapElements,
\    nftablesAddElement_SetElements
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddElement_SetName nftablesHL_Set
syn match nftablesCmdAddElement_SetName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddElement_Section

hi link nftablesCmdAddElement_TableName nftablesHL_Table
syn match nftablesCmdAddElement_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddElement_SetName,
\    nftables_UnexpectedEOS

hi link nftablesCmdAddElement_Family nftablesHL_Type
syn keyword nftablesCmdAddElement_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddElement_TableName

hi link nftables_ELEMENT_set_spec_set_block_expr nftablesHL_Statement
syn keyword nftables_ELEMENT_set_spec_set_block_expr contained element skipwhite
\ nextgroup=
\    nftablesCmdAddElement_Family,
\    nftablesCmdAddElement_TableName
" End 'add element [<family>] <table_id> <set_id>'

" Begin 'add flowtable ...'
hi link nftablesAddFTDev_DeviceNth nftablesHL_String
syn match nftablesAddFTDev_DeviceNth contained skipwhite
\    /[a-zA-Z0-9\-_%]\{1,64}/
\ nextgroup=
\    nftablesAddFTDev_Separator

" TODO Why does a space first device and first comma separate causes error here?
hi link nftablesAddFTDev_Separator nftablesHL_Operator
syn match nftablesAddFTDev_Separator contained /,\s*/ skipwhite
\ nextgroup=
\    nftablesAddFTDev_DeviceNth,
\    nftables_Error

hi link nftablesAddFTDev_Device nftablesHL_String
syn match nftablesAddFTDev_Device contained skipwhite
\    /[a-zA-Z0-9\-_%]\{1,64}/
\ nextgroup=nftablesAddFTDev_Separator

syn region nftablesCmdAddFTDev_Section contained start=/{/ end=/}/ skipwhite
\ contains=nftablesAddFTDev_Device
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdAddFTDev_Equal nftablesHL_Operator
syn match nftablesCmdAddFTDev_Equal contained /=/ skipwhite
\ nextgroup=nftablesCmdAddFtDev_Section

hi link nftablesCmdAddFT_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddFT_DevicesKeyword contained devices skipwhite
\ nextgroup=nftablesCmdAddFtDev_Equal

hi link nftablesCmdAddFTHook_Priority nftablesHL_Number
syn match nftablesCmdAddFTHook_Priority contained /[\-]\?[0-9]\{1,5}/
\ skipwhite
\ nextgroup=
\    nftables_Semicolon

hi link nftablesCmdAddFTHook_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddFTHook_PriorityKeyword contained priority skipwhite
\ nextgroup=
\    nftablesCmdAddFTHook_Priority

hi link nftablesCmdAddFTHook_HookType nftablesHL_Type
syn keyword nftablesCmdAddFTHook_HookType contained skipwhite
\    input
\    filter
\    nat
\ nextgroup=
\    nftablesCmdAddFTHook_PriorityKeyword

hi link nftablesCmdAddFT_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddFT_HookKeyword contained hook skipwhite
\ nextgroup=
\    nftablesCmdAddFTHook_HookType

syn region nftablesCmdAddFT_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddFT_HookKeyword,
\    nftablesCmdAddFT_DevicesKeyword
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS
hi link nftablesCmdAddFT_FlowtableName nftablesHL_Flowtable
syn match nftablesCmdAddFT_FlowtableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddFT_Section

hi link nftablesCmdAddFT_TableName nftablesHL_Table
syn match nftablesCmdAddFT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddFT_FlowtableName

hi link nftablesCmdAddFT_Family nftablesHL_Family
syn keyword nftablesCmdAddFT_Family contained skipwhite
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddFT_TableName

hi link nftables_FLOWTABLE_spec_block nftablesHL_Option
syn keyword nftables_FLOWTABLE_spec_block contained flowtable skipwhite
\ nextgroup=
\    nftablesCmdAddFT_Family,
\    nftablesCmdAddFT_TableName
" End 'add flowtable ...'

" Begin 'add limit ...'
hi link nftables_limit_burst_type nftablesHL_Type
syn keyword nftables_limit_burst_type contained packets bytes skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_limit_burst_num nftablesHL_Number
syn match nftables_limit_burst_num contained /\d\{1,11}/ skipwhite
\ nextgroup=nftables_limit_burst_type

hi link nftables_limit_burst nftablesHL_Option
syn keyword nftables_limit_burst contained burst skipwhite
\ nextgroup=
\    nftables_limit_burst_num

hi link nftables_limit_string nftablesHL_Type
syn keyword nftables_limit_unit contained skipwhite
\    bytes kbytes mbytes
\ nextgroup=
\    nftables_limit_burst,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_limit_time_unit nftablesHL_Type
syn match nftables_limit_time_unit contained 
\    /\(second\)\|\(minute\)\|\(hour\)\|\(day\)\|\(week\)/
\ skipwhite skipempty skipnl
\ nextgroup=
\    nftables_limit_burst,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_limit_slash nftablesHL_Operator
syn match nftables_limit_slash contained "/" skipwhite skipempty skipnl
\ nextgroup=nftables_limit_time_unit

hi link nftables_limit_num nftablesHL_Number
syn match nftables_limit_num contained /\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_limit_slash,
\    nftables_limit_string,

hi link nftables_limit_mode nftablesHL_Type
syn keyword nftables_limit_mode contained 
\    until over
\ nextgroup=nftables_limit_num

hi link nftables_limit_config nftablesHL_Option
syn keyword nftables_limit_config contained rate skipwhite
\ nextgroup=
\    nftables_limit_mode,
\    nftables_limit_num

syn cluster nftablesCluster_limit_obj
\ contains=nftables_limit_config

hi link nftables_obj_spec_limit_obj_LimitName nftablesHL_Limit
syn match nftables_obj_spec_limit_obj_LimitName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=@nftablesCluster_limit_obj

hi link nftables_obj_spec_limit_obj_TableName nftablesHL_Table
syn match nftables_obj_spec_limit_obj_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_obj_spec_limit_obj_LimitName

hi link nftables_obj_spec_limit_obj_Family nftablesHL_Family
syn keyword nftables_obj_spec_limit_obj_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_obj_spec_limit_obj_TableName

" Generic boilerplate for all-family limit 
hi link nftables_LIMITS_obj_spec_limit_obj nftablesHL_Option
syn keyword nftables_LIMITS_obj_spec_limit_obj contained limit skipwhite
\ nextgroup=
\    nftables_obj_spec_limit_obj_Family,
\    nftables_obj_spec_limit_obj_TableName
" End 'add limit ...'

" Begin 'add map <set_spec> { <map_block> }'
hi link nftablesCmdAddMapVerdict_TargetName nftablesHL_Type
syn match nftablesCmdAddMapVerdict_TargetName contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/

hi link nftables_map_block_VerdictTargetKeywords nftablesHL_Type
syn keyword nftables_map_block_VerdictTargetKeywords contained skipwhite
\    jump
\    goto 
\ nextgroup=nftablesCmdAddMapVerdict_TargetName

hi link nftables_map_block_VerdictKeywords nftablesHL_Type
syn keyword nftables_map_block_VerdictKeywords contained skipwhite
\    drop
\    accept
\    queue
\    continue
\    return
\    counter
\    quota

hi link nftables_map_block_Colon nftablesHL_Operator
syn match nftables_map_block_Colon contained /:\s*/ skipwhite
\ nextgroup=
\    nftables_map_block_VerdictTargetKeywords,
\    nftables_map_block_VerdictKeywords,
\    nftables_Error

hi link nftables_map_block_TypeNth nftablesHL_Option
syn keyword nftables_map_block_TypeNth contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=
\    nftables_map_block_Colon,
\    nftables_map_block_Concat,
\    nftables_Semicolon,

hi link nftables_map_block_Concat nftablesHL_Operator
syn match nftables_map_block_Concat contained /\./ skipwhite
\ nextgroup=nftables_map_block_TypeNth

hi link nftables_map_block_Type nftablesHL_Type
syn keyword nftables_map_block_Type contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\    counter
\    quota
\ nextgroup=
\    nftables_map_block_Concat,
\    nftables_map_block_Colon,
\    nftables_Semicolon

hi link nftables_map_block_TypeKeyword nftablesHL_Statement
syn keyword nftables_map_block_TypeKeyword contained type skipwhite
\ nextgroup=nftables_map_block_Type

hi link nftables_map_block_Flags nftablesHL_Type
syn keyword nftables_map_block_Flags contained skipwhite
\    constant
\    interval
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_map_block_FlagsKeyword nftablesHL_Statement
syn keyword nftables_map_block_FlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftables_map_block_Flags

hi link nftables_map_block_Timeout nftablesHL_Integer
syn match nftables_map_block_Timeout /\d\{1,11}/

hi link nftables_map_block_TimeoutKeyword nftablesHL_Statement
syn keyword nftables_map_block_TimeoutKeyword contained timeout skipwhite
\ nextgroup=nftables_map_block_Timeout

hi link nftablesCmdAddMapElements_ElementNth nftablesHL_Type
syn match nftablesCmdAddMapElements_ElementNth contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/
\ nextgroup=
\    nftablesCmdAddMapElements_Separator

hi link nftablesCmdAddMapElements_Separator nftablesHL_Operator
syn match nftablesCmdAddMapElements_Separator contained /,/ skipwhite
\ nextgroup=
\    nftablesCmdAddMapElements_ElementNth,
\    nftables_Error

hi link nftablesCmdAddMapElements_Element nftablesHL_Type
syn match nftablesCmdAddMapElements_Element contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/
\ nextgroup=nftablesCmdAddMapElements_Separator

syn region nftables_map_block_ElementsSection contained start=/=/ end=/;/ skipwhite
\ contains=nftablesCmdAddMapElements_Element
\ nextgroup=
\    nftables_Semicolon

hi link nftables_map_block_ElementsKeyword nftablesHL_Statement
syn keyword nftables_map_block_ElementsKeyword contained elements skipwhite
\ nextgroup=
\    nftables_map_block_ElementsSection

hi link nftables_map_block_Size nftablesHL_Type
syn match nftables_map_block_Size contained /\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_map_block_SizeKeyword nftablesHL_Statement
syn keyword nftables_map_block_SizeKeyword contained size skipwhite
\ nextgroup=
\    nftables_map_block_Size

hi link nftables_map_block_Policy nftablesHL_Type
syn keyword nftables_map_block_Policy contained skipwhite
\    performance
\    memory
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_map_block_PolicyKeyword nftablesHL_Statement
syn keyword nftables_map_block_PolicyKeyword contained policy skipwhite
\ nextgroup=
\    nftables_map_block_Policy

syn region nftables_map_block_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftables_map_block_TypeKeyword,
\    nftables_map_block_FlagsKeyword,
\    nftables_map_block_ElementsKeyword,
\    nftables_map_block_SizeKeyword,
\    nftables_map_block_PolicyKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftables_set_spec_map_block_MapName nftablesHL_Map
syn match nftables_set_spec_map_block_MapName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_map_block_Section

hi link nftables_set_spec_map_block_TableName nftablesHL_Table
syn match nftables_set_spec_map_block_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_set_spec_map_block_MapName

hi link nftables_set_spec_map_block_Family nftablesHL_Family
syn keyword nftables_set_spec_map_block_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftables_set_spec_map_block_TableName

syn cluster nftablesCLuster_set_spec_map_block
\ contains=
\    nftables_set_spec_map_block_Family,
\    nftables_set_spec_map_block_TableName

hi link nftables_MAP_set_spec_map_block nftablesHL_Statement
syn keyword nftables_MAP_set_spec_map_block contained map skipwhite
\ nextgroup=@nftablesCluster_set_spec_map_block
" End 'add map <set_spec> { <map_block> }'

hi link nftables_MAP_set_spec nftablesHL_Statement
syn keyword nftables_MAP_set_spec contained map skipwhite
\ nextgroup=@nftablesCluster_set_spec
" End 'add map ...'


" Begin 'add quota ...'
syn cluster nftablesCluster_quota_obj
\ contains=@nftablesCluster_quota_config

hi link nftables_obj_spec_quota_obj_QuotaName nftablesHL_Quota
syn match nftables_obj_spec_quota_obj_QuotaName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=@nftablesCluster_quota_config

hi link nftables_obj_spec_quota_obj_TableName nftablesHL_Table
syn match nftables_obj_spec_quota_obj_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_obj_spec_quota_obj_QuotaName

hi link nftables_obj_spec_quota_obj_Family nftablesHL_Family
syn keyword nftables_obj_spec_quota_obj_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_obj_spec_quota_obj_TableName

hi link nftables_add_QUOTA_obj_spec_quota_obj nftablesHL_Option
syn keyword nftables_add_QUOTA_obj_spec_quota_obj contained quota skipwhite
\ nextgroup=
\    nftables_obj_spec_quota_obj_Family,
\    nftables_obj_spec_quota_obj_TableName

" End 'add quota ...'

" Begin 'add rule ...'
" begin 'add rule netdev <table> ...'
syn region nftablesCmdAddRuleNetdev_Section contained start="\s\zs" end="[\n;]"  skipwhite
\ contains=
\    nftables_rule_FwdKeyword,
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,

hi link nftablesCmdAddRuleNetdev_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleNetdev_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleNetdev_Section

hi link nftablesCmdAddRuleNetdev_TableName nftablesHL_Table
syn match nftablesCmdAddRuleNetdev_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleNetdev_ChainName

hi link nftablesCmdAddRuleNetdev_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleNetdev_Family contained netdev skipwhite
\ nextgroup=nftablesCmdAddRuleNetdev_TableName
" end 'add rule netdev <table> ...'

" begin 'add rule bridge <table> ...'
syn region nftablesCmdAddRuleBridge_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,

hi link nftablesCmdAddRuleBridge_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleBridge_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleBridge_Section

hi link nftablesCmdAddRuleBridge_TableName nftablesHL_Table
syn match nftablesCmdAddRuleBridge_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleBridge_ChainName

hi link nftablesCmdAddRuleBridge_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleBridge_Family contained bridge skipwhite
\ nextgroup=nftablesCmdAddRuleBridge_TableName
" end 'add rule bridge <table> ...'

" begin 'add rule arp <table> ...'
syn region nftablesCmdAddRuleArp_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,

hi link nftablesCmdAddRuleArp_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleArp_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleArp_Section

hi link nftablesCmdAddRuleArp_TableName nftablesHL_Table
syn match nftablesCmdAddRuleArp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleArp_ChainName

hi link nftablesCmdAddRuleArp_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleArp_Family contained arp skipwhite
\ nextgroup=nftablesCmdAddRuleArp_TableName
" end 'add rule arp <table> ...'

" begin 'add rule ip <table> ...'
syn region nftablesCmdAddRuleIp_Section contained start="\s\{0,5}\zs" end="[\n;]" 
\ contains=
\    nftables_rule_UDP,
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,

hi link nftablesCmdAddRuleIp_Offset nftablesHL_Handle
syn match nftablesCmdAddRuleIp_Offset contained /\d\{1,5}/ skipwhite
\ nextgroup=nftablesCmdAddRuleIp_Section

hi link nftablesCmdAddRuleIp_Position nftablesHL_Type
syn keyword nftablesCmdAddRuleIp_Position contained skipwhite
\    position index handle
\ nextgroup=nftablesCmdAddRuleIp_Offset

hi link nftablesCmdAddRuleIp_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleIp_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddRuleIp_Position,
\    nftablesCmdAddRuleIp_Section,

hi link nftables_family_spec_IP_TableName nftablesHL_Table
syn match nftables_family_spec_IP_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp_ChainName

hi link nftables_rule_Family_IP nftablesHL_Family
syn keyword nftables_rule_Family_IP contained ip skipwhite
\ nextgroup=nftables_family_spec_IP_TableName
" end 'add rule ip <table> ...'

" begin 'add rule ip6 <table> ...'
syn region nftablesCmdAddRuleIp6_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,
\    nftables_rule_UDP,

hi link nftablesCmdAddRuleIp6_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleIp6_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp6_Section

hi link nftablesCmdAddRuleIp6_TableName nftablesHL_Table
syn match nftablesCmdAddRuleIp6_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp6_ChainName

hi link nftablesCmdAddRuleIp6_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleIp6_Family contained ip6 skipwhite
\ nextgroup=nftablesCmdAddRuleIp6_TableName
" end 'add rule ip6 <table> ...'

" begin 'add rule inet <table> ...'
syn region nftablesCmdAddRuleInet_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftables_rule_VerdictTargetKeywords,
\    nftables_rule_COUNTER,
\    nftables_rule_VerdictKeywords,
\    nftables_quota_stmt_QUOTA,
\    nftables_rule_UDP,

hi link nftablesCmdAddRuleInet_ChainName nftablesHL_Rule
syn match nftablesCmdAddRuleInet_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleInet_Section

hi link nftablesCmdAddRuleInet_TableName nftablesHL_Table
syn match nftablesCmdAddRuleInet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleInet_ChainName

hi link nftablesCmdAddRuleInet_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleInet_Family contained inet skipwhite
\ nextgroup=nftablesCmdAddRuleInet_TableName
" end 'add rule inet <table> ...'
"
syn cluster nftablesCluster_rule_Family_specific
\ contains=
\    nftablesCmdAddRuleNetdev_Family,
\    nftablesCmdAddRuleBridge_Family,
\    nftablesCmdAddRuleArp_Family,
\    nftables_rule_Family_IP,
\    nftablesCmdAddRuleIp6_Family,
\    nftablesCmdAddRuleInet_Family,
\    nftables_family_spec_IP_TableName  " last one defaults to IP if missing 'ip'

syn cluster nftablesCluster_rule_position_rule
\ contains=
\    nftables_chain_spec_rule,
\    nftables_chain_spec_position_spec_rule,
\    nftables_chain_spec_handle_spec_rule,
\    nftables_chain_spec_index_spec_rule

hi link nftablesCmdAdd_RuleKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_RuleKeyword contained rule skipwhite
\ nextgroup=@nftablesCluster_rule_Family_specific
" End 'add rule ...'

" Begin 'delete ct ...'
hi link nftablesCmdDeleteCT_ChainName nftablesHL_Chain
syn match nftablesCmdDeleteCT_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteCT_TableName nftablesHL_Table
syn match nftablesCmdDeleteCT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdDeleteCT_ChainName

hi link nftablesCmdDeleteCT_Family nftablesHL_Family
syn keyword nftablesCmdDeleteCT_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdDeleteCT_TableName

hi link nftablesCmdDeleteCT_SubKeywords nftablesHL_Expression
syn keyword nftablesCmdDeleteCT_SubKeywords contained skipwhite
\    helper
\    timeout
\    expectation
\ nextgroup=
\    nftablesCmdDeleteCT_Family,
\    nftablesCmdDeleteCT_TableName

hi link nftablesCmdDelete_CTKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_CTKeyword contained ct skipwhite
\ nextgroup=
\    nftablesCmdDeleteCT_SubKeywords
" End of 'delete ct ...'

" Begin 'delete flowtable ...'
hi link nftablesCmdDeleteFT_FlowtableName nftablesHL_Flowtable
syn match nftablesCmdDeleteFT_FlowtableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesCmdDeleteFT_TableName nftablesHL_Table
syn match nftablesCmdDeleteFT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdDeleteFT_FlowtableName

hi link nftablesCmdDeleteFT_Family nftablesHL_Family
syn keyword nftablesCmdDeleteFT_Family contained skipwhite
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdDeleteFT_TableName

hi link nftablesCmdDelete_FlowtableKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_FlowtableKeyword contained flowtable skipwhite
\ nextgroup=
\    nftablesCmdDeleteFT_Family,
\    nftablesCmdDeleteFT_TableName
" End 'delete flowtable ...'

" Begin 'set <set_spec>' and 'set <setid_spec>'
hi link nftablesCmdDeleteSet_SetName nftablesHL_Set
syn match nftablesCmdDeleteSet_SetName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_table_spec_handle_num_TableName nftablesHL_Table
syn match nftables_table_spec_handle_num_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_HANDLE_NUM,
\    @nftablesCluster_table_spec_identifier

hi link nftables_table_spec_handle_num_Family nftablesHL_Family
syn keyword nftables_table_spec_handle_num_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftables_table_spec_handle_num_TableName

syn cluster nftablesCluster_table_spec_and_handle_num
\ contains=
\    nftables_table_spec_handle_num_Family,
\    nftables_table_spec_handle_num_TableName

hi link nftables_SET_set_and_setid_spec nftablesHL_Option
syn keyword nftables_SET_set_and_setid_spec contained set skipwhite
\ nextgroup=@nftablesCluster_table_spec_and_handle_num
" End 'set <set_spec>' and 'set <setid_spec>'

" Begin of 'delete table ...'
hi link nftablesCmdDeleteTable_Handle nftablesHL_Handle
syn match nftablesCmdDeleteTable_Handle contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS,

hi link nftablesCmdDeleteTable_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdDeleteTable_HandleKeyword contained handle skipwhite
\ nextgroup=nftablesCmdDeleteTable_Handle

hi link nftablesCmdDeleteTable_Name nftablesHL_Table
syn match nftablesCmdDeleteTable_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS,

hi link nftablesCmdDeleteTable_Family nftablesHL_Family
syn keyword nftablesCmdDeleteTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdDeleteTable_HandleKeyword,
\    nftablesCmdDeleteTable_Name

hi link nftablesCmdDelete_TableKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_TableKeyword contained table skipwhite
\ nextgroup=@nftablesCluster_table_spec
\    nftablesCmdDeleteTable_Name,
\    nftablesCmdDeleteTable_Family,
\    nftablesCmdDeleteTable_HandleKeyword
" End of 'delete table ...'
"
" Begin of 'describe ...'
hi link nftablesCmdDescribe_String nftablesHL_String
syn match nftablesCmdDescribe_String contained /[^;\n]*/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS
" End of 'describe ...'

" Begin of 'export table ...'
hi link nftablesCmdExport_Format nftablesHL_Type
syn keyword nftablesCmdExport_Format contained skipwhite
\    xml
\    json

hi link nftablesCmdExportRulesetKeyword nftablesHL_Option
syn keyword nftablesCmdExportRulesetKeyword contained ruleset skipwhite
\ nextgroup=nftablesCmdExport_Format
" End of 'export table'

" Begin 'import ruleset <markup_format>'
hi link nftables_markup_format nftablesHL_Type
syn match nftables_markup_format contained skipwhite
\    /\(xml\)\|\(json\)\|\(vm json\)/

hi link nftables_dnu_RULESET_markup_format nftablesHL_Option
syn keyword nftables_dnu_RULESET_markup_format contained ruleset skipwhite
\ nextgroup=nftables_markup_format

syn cluster nftablesCluster_RULESET_markup_format
\ contains=
\    nftables_dnu_RULESET_markup_format,
\    nftables_markup_format
" End 'import ruleset <markup_format>'

" Begin <chain_spec> and <chainid_spec>
hi link nftables_chain_and_chainid_spec_ChainName nftablesHL_Chain
syn match nftables_chain_and_chainid_spec_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_chain_and_chainid_spec_TableName nftablesHL_Table
syn match nftables_chain_and_chainid_spec_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_HANDLE_NUM,
\    nftables_chain_and_chainid_spec_ChainName

hi link nftables_chain_and_chainid_spec_Family nftablesHL_Family
syn keyword nftables_chain_and_chainid_spec_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_chain_and_chainid_spec_TableName

syn cluster nftablesCluster_chain_and_chainid_spec
\ contains=
\    nftables_chain_and_chainid_spec_Family,
\    nftables_chain_and_chainid_spec_TableName

hi link nftables_CHAIN_chain_and_chainid_spec nftablesHL_Option
syn keyword nftables_CHAIN_chain_and_chainid_spec contained chain skipwhite
\ nextgroup=@nftablesCluster_chain_and_chainid_spec
" End <chain_spec> and <chainid_spec>

" Begin <chain_spec>
hi link nftables_table_spec_id_ChainName nftablesHL_Table
syn match nftables_table_spec_id_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftables_table_spec_id_TableName nftablesHL_Table
syn match nftables_table_spec_id_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_table_spec_id_ChainName

hi link nftables_table_spec_id_Family nftablesHL_Family
syn keyword nftables_table_spec_id_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_table_spec_id_TableName

syn cluster nftablesCluster_table_spec_identifier
\ contains=
\    nftables_table_spec_id_Family,
\    nftables_table_spec_id_TableName

syn cluster nftablesCluster_set_spec
\ contains=@nftablesCluster_table_spec_identifier

syn cluster nftablesCluster_flowtable_spec
\ contains=@nftablesCluster_table_spec_identifier

syn cluster nftablesCluster_obj_spec
\ contains=@nftablesCluster_table_spec_identifier

hi link nftables_CHAIN_chain_spec nftablesHL_Option
syn keyword nftables_CHAIN_chain_spec contained chain skipwhite
\ nextgroup=@nftablesCluster_table_spec_identifier
" End <chain_spec>

" Begin 'counter <obj_spec> <counter_obj>'
" used in 'add counter'
" used in 'create counter'
hi link nftables_table_spec_id_counter_obj_ChainName nftablesHL_Table
syn match nftables_table_spec_id_counter_obj_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_counter_obj  " XYZ

hi link nftables_table_spec_id_counter_obj_TableName nftablesHL_Table
syn match nftables_table_spec_id_counter_obj_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_table_spec_id_counter_obj_ChainName

hi link nftables_table_spec_id_counter_obj_Family nftablesHL_Family
syn keyword nftables_table_spec_id_counter_obj_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_table_spec_id_TableName

syn cluster nftablesCluster_obj_spec_counter_obj
\ contains=
\    nftables_table_spec_id_counter_obj_Family,
\    nftables_table_spec_id_counter_obj_TableName
" End 'counter <obj_spec> <counter_obj>'


syn keyword nftables_table_spec_id_quota_obj_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_table_spec_id_TableName

" End 'counter <obj_spec> <counter_obj>'



" Begin 'list chains <ruleset_spec>'
hi link nftables_CHAINS_ruleset_spec nftablesHL_Statement
syn keyword nftables_CHAINS_ruleset_spec contained chains skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list chains <ruleset_spec>'

" Begin 'add counter'
" Begin 'create counter'
hi link nftables_COUNTER_obj_spec_counter_obj nftablesHL_Option
syn keyword nftables_COUNTER_obj_spec_counter_obj contained skipwhite
\    counter
\ nextgroup=
\    @nftablesCluster_obj_spec_counter_obj
" End 'create counter'
" End 'add counter'

" Begin 'reset counter <obj_spec>'
" Begin 'list counter <obj_spec>'
hi link nftables_COUNTER_obj_spec nftablesHL_Option
syn keyword nftables_COUNTER_obj_spec contained counter skipwhite
\ nextgroup=
\    @nftablesCluster_obj_spec
" End 'list counter <obj_spec>'
" End 'reset counter <obj_spec>'

" Begin 'delete counter ( <obj_spec> | <objid_spec> )'
syn cluster nftablesCluster_obj_spec_objid_spec
\ contains=@nftablesCluster_table_spec_and_handle_num

hi link nftables_COUNTER_obj_spec_objid_spec nftablesHL_Option
syn keyword nftables_COUNTER_obj_spec_objid_spec contained counter skipwhite
\ nextgroup=
\    @nftablesCluster_obj_spec_objid_spec
" End 'delete counter ( <obj_spec> | <objid_spec> )'

" Begin 'delete quota ( <obj_spec> | <objid_spec> )'
hi link nftables_QUOTA_obj_spec_objid_spec nftablesHL_Option
syn keyword nftables_QUOTA_obj_spec_objid_spec contained counter skipwhite
\ nextgroup=
\    @nftablesCluster_obj_spec_objid_spec
" End 'delete quota ( <obj_spec> | <objid_spec> )'
"
" Begin 'list ct helpers table <table_spec>'
hi link nftables_CT_HELPERS_TABLE_table_spec_HelpersKeyword nftablesHL_Option
syn keyword nftables_CT_HELPERS_TABLE_table_spec_HelpersKeyword
\ contained skipwhite
\    helpers
\ nextgroup=nftables_TABLE_table_spec


hi link nftables_CT_HELPERS_TABLE_table_spec nftablesHL_Option
syn keyword nftables_CT_HELPERS_TABLE_table_spec contained skipwhite
\    ct
\ nextgroup= nftables_CT_HELPERS_TABLE_table_spec_HelpersKeyword
" End 'list ct helpers table <table_spec>'

" Begin 'list flow table <set_spec>'
hi link nftables_TABLE_set_spec  nftablesHL_Statement
syn keyword nftables_TABLE_set_spec  contained table skipwhite
\ nextgroup=@nftablesCluster_set_spec
" End 'list flow tables <ruleset_spec>'

" Begin 'list flow tables <ruleset_spec>'
hi link nftables_TABLES_ruleset_spec  nftablesHL_Statement
syn keyword nftables_TABLES_ruleset_spec  contained tables skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec

" Begin 'list flowtables <ruleset_spec>'
hi link nftables_FLOWTABLES_ruleset_spec nftablesHL_Option
syn keyword nftables_FLOWTABLES_ruleset_spec contained flowtables skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list flowtables <ruleset_spec>'
"
" Begin 'list flow ....'
hi link nftables_list_FLOW nftablesHL_Option
syn keyword nftables_list_FLOW contained flow skipwhite
\ nextgroup=
\    nftables_TABLES_ruleset_spec,
\    nftables_TABLE_set_spec 

hi link nftables_FLOW_TABLE_set_spec nftablesHL_Option
syn keyword nftables_FLOW_TABLE_set_spec contained flow skipwhite
\ nextgroup= nftables_TABLE_set_spec 
" End 'list flow table <set_spec>'
"
hi link nftables_LIMIT_obj_spec nftablesHL_Option
syn keyword nftables_LIMIT_obj_spec contained limit skipwhite
\ nextgroup=@nftablesCluster_obj_spec

" Begin 'list limits'
hi link nftables_LIMITS_ruleset_or_TABLE_table_spec nftablesHL_Option
syn keyword nftables_LIMITS_ruleset_or_TABLE_table_spec contained limits skipwhite
\ nextgroup=@nftablesCluster_ruleset_or_TABLE_table_spec
" End 'list limits'

" Begin 'list map <set_spec>'
hi link nftables_MAP_set_spec nftablesHL_Statement
syn keyword nftables_MAP_set_spec contained map skipwhite
\ nextgroup=@nftablesCluster_set_spec
" End of 'list map <set_spec>'

" Begin 'list maps <ruleset_spec>'
hi link nftables_MAPS_ruleset_spec nftablesHL_Option
syn keyword nftables_MAPS_ruleset_spec contained maps skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list maps <ruleset_spec>'

" Begin 'list meters <ruleset_spec>'
hi link nftables_METERS_ruleset_spec nftablesHL_Option
syn keyword nftables_METERS_ruleset_spec contained meters skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list meters <ruleset_spec>'

" Begin 'list meter <ruleset_spec>'
hi link nftables_METER_ruleset_spec nftablesHL_Option
syn keyword nftables_METER_ruleset_spec contained meter skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list meter <ruleset_spec>'

"
" Begin 'list quota <obj_spec>'
hi link nftables_QUOTA_obj_spec nftablesHL_Statement
syn keyword nftables_QUOTA_obj_spec contained quota skipwhite
\ nextgroup=@nftablesCluster_obj_spec
" End 'list quota <obj_spec>'

" Begin 'list quotas <ruleset_spec>' and 'list quotas table <table_spec>'
hi link nftables_QUOTAS_ruleset_or_TABLE_table_spec nftablesHL_Statement
syn keyword nftables_QUOTAS_ruleset_or_TABLE_table_spec contained skipwhite
\    quotas
\ nextgroup=@nftablesCluster_ruleset_or_TABLE_table_spec

hi link nftables_SETS_ruleset_or_TABLE_table_spec nftablesHL_Statement
syn keyword nftables_SETS_ruleset_or_TABLE_table_spec contained skipwhite
\    sets
\ nextgroup=@nftablesCluster_ruleset_or_TABLE_table_spec
" End 'list sets <ruleset_spec>' and 'list sets table <table_spec>'

" Begin 'rule <ruleid_spec>'
hi link nftables_ruleid_spec_table_spec_id_ChainName nftablesHL_Table
syn match nftables_ruleid_spec_table_spec_id_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftables_table_spec_id_TableName nftablesHL_Table
syn match nftables_table_spec_id_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_ruleid_spec_table_spec_id_ChainName

hi link nftables_table_spec_id_Family nftablesHL_Family
syn keyword nftables_table_spec_id_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_table_spec_id_TableName

syn cluster nftablesCluster_chain_spec_handle_spec
\ contains=
\    nftables_table_spec_id_Family,
\    nftables_table_spec_id_TableName

hi link nftables_RULE_ruleid_spec nftablesHL_Option
syn keyword nftables_RULE_ruleid_spec contained rule skipwhite
\ nextgroup=@nftablesCluster_chain_spec_handle_spec
" End 'rule <ruleid_spec>'

" Begin 'ruleset <ruleset_spec>'
hi link nftables_RULESET_ruleset_spec nftablesHL_Option
syn keyword nftables_RULESET_ruleset_spec contained ruleset skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'ruleset <ruleset_spec>'

" Begin of 'list set [<family>] <table_name> <set_name>' 
hi link nftablesCmdList_SetName nftablesHL_Set
syn match nftablesCmdList_SetName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdListSet_TableName nftablesHL_Table
syn match nftablesCmdListSet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdList_SetName 

hi link nftablesCmdListSet_Family nftablesHL_Family
syn keyword  nftablesCmdListSet_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdListSet_TableName

" SET_set_spec used by 'list set' and 'flush set'
" FLOWTABLE_set_spec used by 'list flowtable' and 'flush flowtable'
" METER_set_spec used by 'list meter' and 'flush meter'
" MAP used by 'list MAP' and 'flush MAP'
hi link nftables_SET_set_spec nftablesHL_Statement
syn keyword nftables_SET_set_spec contained set skipwhite
\ nextgroup=@nftablesCluster_set_spec
" End of 'list set [<family>] <table_name> <set_name>' 
"
hi link nftables_METER_set_spec nftablesHL_Statement
syn keyword nftables_METER_set_spec contained meter skipwhite
\ nextgroup=@nftablesCluster_set_spec

" Begin 'list tables <ruleset_spec>'
hi link nftables_TABLES_ruleset_spec nftablesHL_Statement
syn keyword nftables_TABLES_ruleset_spec contained tables skipwhite
\ nextgroup=@nftablesCluster_ruleset_spec
" End 'list tables <ruleset_spec>'

" Begin 'monitor <monitor_event> <monitor_object> <monitor_format>'
hi link nftables_monitor_format nftablesHL_Type
syn match nftables_monitor_format contained skipwhite
\    /\(xml\)\|\(json\)\|\(vm json\)/
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

" Begin 'monitor <monitor_event> <monitor_object>'
hi link nftables_monitor_object nftablesHL_Type
syn keyword nftables_monitor_object contained skipwhite
\    tables chains sets rules elements ruleset trace
\ nextgroup=
\    nftables_monitor_format,
\    nftables_Semicolon,
\    nftables_EOS
" End 'monitor <monitor_event> <monitor_object>'

" monitor <monitor_event>
hi link nftables_monitor_event nftablesHL_Statement
syn match nftables_monitor_event contained /\(new\|destroy\)/ skipwhite
\ nextgroup=
\    nftables_monitor_object,
\    nftables_UnexpectedEOS,
\    nftables_UnexpectedSemicolon,
" End 'monitor <monitor_event> <monitor_object> <monitor_format>'

" Begin 'monitor_cmd'
syn cluster nftablesCluster_monitor_cmd
\ contains=
\    nftables_monitor_event,
\    nftables_monitor_object
" End 'monitor_cmd'

" Begin 'table bridge ...'
hi link nftablesTBridgeC_Policy nftablesHL_Type
syn keyword nftablesTBridgeC_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=
\    nftables_Semicolon

hi link nftablesTBridgeC_PolicyKeyword nftablesHL_Statement
syn keyword nftablesTBridgeC_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesTBridgeC_Policy

hi link nftablesTBridgeC_Priority nftablesHL_Number
syn match nftablesTBridgeC_Priority contained /\-\{0,1}\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon

hi link nftablesTBridgeC_PriorityKeyword nftablesHL_Statement
syn keyword nftablesTBridgeC_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesTBridgeC_Priority

hi link nftablesTBridgeC_DeviceName nftablesHL_Type
syn match nftablesTBridgeC_DeviceName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftablesTBridgeC_PriorityKeyword,
\    nftables_Semicolon

hi link nftablesTBridgeC_DeviceKeyword nftablesHL_Statement
syn keyword nftablesTBridgeC_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesTBridgeC_DeviceName

hi link nftablesTBridgeC_Hook_Type nftablesHL_Hook
syn keyword nftablesTBridgeC_Hook_Type contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesTBridgeC_DeviceKeyword,
\    nftablesTBridgeC_PriorityKeyword

hi link nftablesTBridgeC_HookKeyword nftablesHL_Statement
syn keyword nftablesTBridgeC_HookKeyword contained hook skipwhite
\ nextgroup=
\    nftablesTBridgeC_Hook_Type

hi link nftablesTBridgeC_Type_Filter nftablesHL_Type
syn keyword nftablesTBridgeC_Type_Filter contained skipwhite
\    filter
\ nextgroup=nftablesTBridgeC_HookKeyword

hi link nftablesTBridgeC_TypeKeyword nftablesHL_Statement
syn match nftablesTBridgeC_TypeKeyword contained /{\s*\zstype/ skipwhite 
\ nextgroup=
\    nftablesTBridgeC_Type_Filter
syn match nftablesTBridgeC_TypeKeyword contained /\_^\s*type/ skipwhite 
\ nextgroup=
\    nftablesTBridgeC_Type_Filter

syn region nftablesTBridgeChain_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesTBridgeC_TypeKeyword,
\    nftablesTBridgeC_PolicyKeyword,
\    nftables_rule_FwdKeyword,
\    nftables_rule_COUNTER,
\    nftables_rule_UDP,
\    nftables_rule_EtherKeyword,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftables_InlineComment,
\    nftablesInclude
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS


hi link nftablesTBridgeChain_Name nftablesHL_Chain
syn match nftablesTBridgeChain_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,63}/ 
\ nextgroup=
\    nftablesTBridgeChain_Section

hi link nftablesTBridgeChainKeyword nftablesHL_Option
syn keyword nftablesTBridgeChainKeyword contained chain skipwhite skipempty
\ nextgroup=nftablesTBridgeChain_Name

syn region nftablesTBridge_Section contained start=/{/ end=/}/ 
\ contains=
\    nftablesTBridgeChainKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesTBridge_Name nftablesHL_Identifier
syn match nftablesTBridge_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesTBridge_Section

hi link nftables_table_spec_BRIDGE_table_block nftablesHL_Family
syn keyword nftables_table_spec_BRIDGE_table_block contained bridge skipwhite
\ nextgroup=nftablesTBridge_Name
" End of 'table bridge ...'
"
" Begin 'table netdev ...'
hi link nftablesTNetdevC_Policy nftablesHL_Type
syn keyword nftablesTNetdevC_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=
\    nftables_Semicolon

hi link nftablesTNetdevC_PolicyKeyword nftablesHL_Statement
syn keyword nftablesTNetdevC_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesTNetdevC_Policy

hi link nftablesTNetdevC_Priority nftablesHL_Number
syn match nftablesTNetdevC_Priority contained /\-\{0,1}\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon

hi link nftablesTNetdevC_PriorityKeyword nftablesHL_Statement
syn keyword nftablesTNetdevC_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesTNetdevC_Priority

hi link nftablesTNetdevC_DeviceName nftablesHL_Type
syn match nftablesTNetdevC_DeviceName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftablesTNetdevC_PriorityKeyword,
\    nftables_Semicolon

hi link nftablesTNetdevC_DeviceKeyword nftablesHL_Statement
syn keyword nftablesTNetdevC_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesTNetdevC_DeviceName

hi link nftablesTNetdevC_Hook_Type nftablesHL_Hook
syn keyword nftablesTNetdevC_Hook_Type contained skipwhite
\    ingress
\ nextgroup=
\    nftablesTNetdevC_DeviceKeyword,
\    nftablesTNetdevC_PriorityKeyword

hi link nftablesTNetdevC_HookKeyword nftablesHL_Statement
syn keyword nftablesTNetdevC_HookKeyword contained hook skipwhite
\ nextgroup=
\    nftablesTNetdevC_Hook_Type

hi link nftablesTNetdevC_Type_Filter nftablesHL_Type
syn keyword nftablesTNetdevC_Type_Filter contained skipwhite
\    filter
\ nextgroup=nftablesTNetdevC_HookKeyword

hi link nftablesTNetdevC_TypeKeyword nftablesHL_Statement
syn match nftablesTNetdevC_TypeKeyword contained /{\s*\zstype/ skipwhite 
\ nextgroup=
\    nftablesTNetdevC_Type_Filter
syn match nftablesTNetdevC_TypeKeyword contained /\_^\s*type/ skipwhite 
\ nextgroup=
\    nftablesTNetdevC_Type_Filter

hi link nftablesLogFlagsStr nftablesHL_String
syn match nftablesLogFlagSstr contained /[A-Za-z0-9 \t]\{1,64}/ skipwhite

hi link nftablesLogFlagsKeyword nftablesHL_String
syn keyword nftablesLogFlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesLogFlagstr

hi link nftablesLogLevelStr nftablesHL_String
syn keyword nftablesLogLevelStr contained skipwhite
\    emerg
\    alert
\    crit
\    err
\    warn
\    default
\    notice
\    info
\    debug  

hi link nftablesLogLevelKeyword nftablesHL_String
syn keyword nftablesLogLevelKeyword contained level skipwhite
\ nextgroup=
\    nftablesLogLevelStr

hi link nftablesLogPrefixStr nftablesHL_String
syn match nftablesLogPrefixStr contained /[A-Za-z0-9 \t]\{1,64}/ skipwhite

hi link nftablesLogPrefixKeyword nftablesHL_String
syn keyword nftablesLogPrefixKeyword contained prefix skipwhite
\ nextgroup=
\    nftablesLogPrefixStr

hi link nftablesLogKeyword nftablesHL_Option
syn keyword nftablesLogKeyword contained log skipwhite
\ nextgroup=
\    nftablesLogPrefixKeyword,
\    nftablesLogLevelKeyword,
\    nftablesLogFlagsKeyword,
\    nftablesAction

hi link nftablesIifnameKeyword nftablesHL_Option
syn keyword nftablesIifnameKeyword contained skipwhite
\    meter
\    fib
\    iifname
\    iif
\    oifname
\    oif

syn region nftablesTNetdevChain_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesTNetdevC_TypeKeyword,
\    nftablesTNetdevC_PolicyKeyword,
\    nftables_rule_FwdKeyword,
\    nftables_rule_COUNTER,
\    nftables_rule_UDP,
\    nftables_rule_EtherKeyword,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftables_InlineComment,
\    nftablesInclude
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS


hi link nftablesTNetdevChain_Name nftablesHL_Chain
syn match nftablesTNetdevChain_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,63}/ 
\ nextgroup=
\    nftablesTNetdevChain_Section

hi link nftablesTNetdevChainKeyword nftablesHL_Option
syn keyword nftablesTNetdevChainKeyword contained chain skipwhite skipempty
\ nextgroup=nftablesTNetdevChain_Name

syn region nftablesTNetdev_Section contained start=/{/ end=/}/ 
\ contains=
\    nftablesTNetdevChainKeyword,
\    nftables_InlineComment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS

hi link nftablesTNetdev_Name nftablesHL_Identifier
syn match nftablesTNetdev_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesTNetdev_Section

hi link nftables_TABLE_Family_Netdev nftablesHL_Family
syn keyword nftables_TABLE_Family_Netdev contained netdev skipwhite
\ nextgroup=nftablesTNetdev_Name
" End of 'table netdev ...'

" Start of 'rename [family] <table_name> <chain_name> <new_chain_name>
hi link nftables_CHAIN_chain_spec_id_NewChain nftablesHL_Chain
syn match nftables_CHAIN_chain_spec_id_NewChain contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_CHAIN_chain_spec_id_ChainName nftablesHL_Chain
syn match nftables_CHAIN_chain_spec_id_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_CHAIN_chain_spec_id_NewChain

hi link nftables_CHAIN_chain_spec_id_TableName nftablesHL_Table
syn match nftables_CHAIN_chain_spec_id_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_CHAIN_chain_spec_id_ChainName

hi link nftables_CHAIN_chain_spec_id_Family nftablesHL_Family
syn keyword nftables_CHAIN_chain_spec_id_Family contained skipwhite
\    netdev bridge arp ip ip6 inet
\ nextgroup=nftables_CHAIN_chain_spec_id_TableName

hi link nftables_CHAIN_chain_spec_identifier nftablesHL_Statement
syn keyword nftables_CHAIN_chain_spec_identifier contained chain skipwhite
\ nextgroup=
\    nftables_CHAIN_chain_spec_id_Family,
\    nftables_CHAIN_chain_spec_id_TableName
" End '<chain_spec> <identifier>

" Begin 'reset ...'
" End 'reset counters...' via '<ruleset_spec> or 'table <table_spec>'
hi link nftables_COUNTERS_ruleset_or_TABLE_table_spec nftablesHL_Option
syn keyword nftables_COUNTERS_ruleset_or_TABLE_table_spec contained skipwhite
\    counters
\ nextgroup=@nftablesCluster_ruleset_or_TABLE_table_spec
" End 'reset counters...' via '<ruleset_spec> or 'table <table_spec>'

" Begin 'reset quota...'
hi link nftablesCmdResetQuota_QuotaName nftablesHL_Quota
syn match nftablesCmdResetQuota_QuotaName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdResetQuota_TableName nftablesHL_Table
syn match nftablesCmdResetQuota_TableName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=nftablesCmdResetQuota_QuotaName

hi link nftablesCmdResetQuota_Family nftablesHL_Family
syn keyword nftablesCmdResetQuota_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdResetQuota_TableName

hi link nftables_RESET_QUOTA nftablesHL_Statement
syn keyword nftables_RESET_QUOTA contained quota skipwhite
\ nextgroup=
\    nftablesCmdResetQuota_Family,
\    nftablesCmdResetQuota_TableName,
\    nftables_Semicolon,
\    nftables_InlineComment,
\    nftables_EOS
" End 'reset quota...'

" Begin 'reset quotas ...' via '<ruleset_spec>' or 'table <table_spec>'
hi link nftables_RESET_QUOTAS nftablesHL_Option
syn keyword nftables_RESET_QUOTAS contained quotas skipwhite
\ nextgroup=@nftablesCluster_ruleset_or_TABLE_table_spec
" End 'reset quotas ...' via '<ruleset_spec>' or 'table <table_spec>'

" End 'reset ...'

""""""""""""""""""""""""""""""""""""""
" Base commands
""""""""""""""""""""""""""""""""""""""
" Begin <base_cmd> (Vim least-prioritized pattern yet 'not contained')
" Begin 'add ' <add_cmd>
hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd skipwhite add skipempty 
\ nextgroup=
\    nftables_TABLE_table_spec_table_block,
\    nftables_CHAIN_chain_spec_block,
\    nftablesCmdAdd_RuleKeyword,
\    nftables_SET_set_spec_block,
\    nftables_MAP_set_spec_map_block,
\    nftables_ELEMENT_set_spec_set_block_expr,
\    nftables_FLOWTABLE_spec_block,
\    nftables_COUNTER_obj_spec_counter_obj,
\    nftables_add_QUOTA_obj_spec_quota_obj,
\    nftables_CT_HELPER_obj_spec_ct_helper_block,
\    nftables_LIMITS_obj_spec_limit_obj,
\    nftablesCmdAdd_TypeKeyword,
\    @nftablesCluster_TABLE_table_spec_block  " this is the last one
" End 'add ' <add_cmd>
" \    nftablesCmdAddRuleNetdev_Family,
" \    nftablesCmdAddRuleBridge_Family,
" \    nftablesCmdAddRuleArp_Family,
" \    nftables_rule_Family_IP,
" \    nftablesCmdAddRuleIp6_Family,
" \    nftablesCmdAddRuleInet_Family,

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd skipwhite create skipempty 
\ nextgroup=
\    nftables_CHAIN_chain_spec_block,
\    nftables_SET_set_spec_block,
\    nftables_MAP_set_spec_map_block,
\    nftables_ELEMENT_set_spec_set_block_expr,
\    nftables_FLOWTABLE_spec_block,
\    nftables_COUNTER_obj_spec_counter_obj,
\    nftables_add_QUOTA_obj_spec_quota_obj,
\    nftables_CT_HELPER_obj_spec_ct_helper_block,
\    nftables_LIMITS_obj_spec_limit_obj,
\    nftables_TABLE_table_spec_table_block,
" \    @nftablesCluster_table_spec_table_block  " this is the last one

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd skipwhite ct skipempty 
\ nextgroup=nftablesCmdAddCT_HelperKeyword

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd skipwhite delete skipempty 
\ nextgroup=
\    nftables_TABLE_table_and_tableid_spec,
\    nftables_CHAIN_chain_and_chainid_spec,
\    nftables_RULE_ruleid_spec,
\    nftables_SET_set_and_setid_spec,
\    nftables_COUNTER_obj_spec_objid_spec,
\    nftablesCmdDelete_CTKeyword,
\    nftables_ELEMENT_set_spec_set_block_expr,
\    nftables_MAP_set_spec,
\    nftablesCmdDelete_FlowtableKeyword,
\    nftablesCmdDelete_TypeKeyword,

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd describe skipwhite 
\ nextgroup=
\    nftablesCmdDescribe_String,

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd export skipwhite 
\ nextgroup=
\    nftablesCmdExportRulesetKeyword,
\    nftablesCmdExport_Format

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd flush skipwhite
\ nextgroup=
\    nftables_CHAIN_chain_spec,
\    nftables_SET_set_spec,
\    nftables_MAP_set_spec,
\    nftables_FLOW_TABLE_set_spec,
\    nftables_METER_set_spec,
\    nftables_RULESET_ruleset_spec,
\    nftables_TABLE_table_spec

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd get skipwhite
\ nextgroup=
\    nftablesCmdGet_Keyword

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd import skipwhite
\ nextgroup=
\    @nftablesCluster_RULESET_markup_format

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd insert skipwhite
\ nextgroup=
\    nftablesCmdInsert_Keyword

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd list skipwhite
\ nextgroup=
\    nftables_TABLE_table_spec,  
\    nftables_TABLES_ruleset_spec,
\    nftables_CHAIN_chain_spec,
\    nftables_CHAINS_ruleset_spec,
\    nftables_SETS_ruleset_or_TABLE_table_spec,
\    nftables_SET_set_spec,
\    nftables_COUNTERS_ruleset_or_TABLE_table_spec,
\    nftables_COUNTER_obj_spec,
\    nftables_QUOTAS_ruleset_or_TABLE_table_spec,
\    nftables_QUOTA_obj_spec,
\    nftables_LIMITS_ruleset_or_TABLE_table_spec,
\    nftables_LIMIT_obj_spec,
\    nftables_RULESET_ruleset_spec,
\    nftables_list_FLOW,
\    nftables_METERS_ruleset_spec,
\    nftables_METER_set_spec,
\    nftables_FLOWTABLES_ruleset_spec,
\    nftables_MAPS_ruleset_spec,
\    nftables_MAP_set_spec,
\    nftables_CT_HELPERS_TABLE_table_spec,
\    nftables_CT_ct_obj_type_obj_spec,
\    nftablesCmdAdd_TypeKeyword,
\    nftables_UnexpectedEOS

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd monitor skipwhite
\ nextgroup=@nftablesCluster_monitor_cmd
\    nftables_EOS

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd rename skipwhite
\ nextgroup=
\    nftables_CHAIN_chain_spec_identifier

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd replace skipwhite
\ nextgroup=
\    nftables_RULE_ruleid_spec_rule

syn cluster nftablesCluster_reset_cmd
\ contains=
\    nftables_COUNTERS_ruleset_or_TABLE_table_spec,
\    nftables_COUNTER_obj_spec,
\    nftables_RESET_QUOTAS,
\    nftables_RESET_QUOTA,

hi link nftables_base_cmd nftablesHL_Command
syn keyword nftables_base_cmd reset skipwhite
\ nextgroup=@nftablesCluster_reset_cmd

hi link nftables_base_cmd nftablesHL_Command
syn match nftables_base_cmd /^\s*table/ skipwhite skipempty
\ nextgroup=
\    @nftablesCluster_table_spec_table_block,
\    nftables_table_name_table_block
" table [ip] <table_name>

" End <base_cmd> (Vim least-prioritized pattern yet 'not contained')

" Start of 'define <var_name> = <var_value>'
hi link nftables_define_ElementNthValue nftablesHL_String
syn match nftables_define_ElementNthValue contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftables_define_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftables_define_ElementNthVariable nftablesHL_Identifier
syn match nftables_define_ElementNthVariable contained skipwhite
\    /\$[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftables_define_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftables_define_ElementSeparator nftablesHL_Operator
syn match nftables_define_ElementSeparator contained /,/ skipwhite
\ nextgroup=
\    nftables_define_ElementNthVariable,
\    nftables_define_ElementNthValue,

hi link nftables_define_ElementVariable nftablesHL_Identifier
syn match nftables_define_ElementVariable contained /\$[A-Za-z0-9\-_./]\{1,256}/ skipwhite
\ nextgroup=
\    nftables_define_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftables_define_ElementValue nftablesHL_String
syn match nftables_define_ElementValue contained /[A-Za-z0-9\-_./]\{1,256}/ skipwhite
\ nextgroup=
\    nftables_define_ElementSeparator,
\    nftables_ExpectedRBrace

syn region nftables_define_Elements contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftables_define_ElementValue,
\    nftables_define_ElementVariable
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftables_define_Value nftablesHL_String
syn match nftables_define_Value contained /[A-Za-z0-9\-_./]\{1,256}/ skipwhite

hi link nftables_define_Variable nftablesHL_Identifier
syn match nftables_define_Variable contained /\$[A-Za-z0-9\-_./]\{1,256}/ skipwhite

hi link nftables_define_OpEqual nftablesHL_Operator
syn match nftables_define_OpEqual contained /=/ skipwhite
\ nextgroup=
\    nftables_define_Elements,
\    nftables_define_Variable,
\    nftables_define_Value

hi link nftables_define_Identifier nftablesHL_Identifier
syn match nftables_define_Identifier contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftables_define_OpEqual
" End of 'define <var_name> = <var_value>'

" Begin of Command-less actions

" Start of '$<variable_name>'
hi link nftablesVariableName Type
syn match nftablesVariableName skipwhite
\    /\$[A-Za-z][A-Za-z0-9\-_\./]\{0,64}/ 
" End of '$<variable_name>'

" Begin <common_block> (Vim least prioritized pattern yet 'not contained')
" Begin of Command-less actions: define
hi link nftables_defineKeyword nftablesHL_Command
syn match nftables_defineKeyword /^\s*define/ skipwhite skipempty
\ nextgroup=nftables_define_Identifier
" End of Command-less actions: define

" Begin Command-less actions: redefine
hi link nftables_redefineKeyword nftablesHL_Command
syn match nftables_redefineKeyword /^\s*redefine/ skipwhite skipempty
\ nextgroup=nftables_define_Identifier
" End Command-less actions: redefine

" Begin Command-less actions: undefine
hi link nftables_undefine_Variable nftablesHL_Identifier
syn match nftables_undefine_Variable contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/
\ nextgroup=@nftablesCluster_common_block

hi link nftablesUndefineKeyword nftablesHL_Command
syn match nftablesUndefineKeyword /^\s*undefine/ skipwhite skipempty
\ nextgroup=
\    nftablesUndefine_Variable
" End Command-less actions: undefine
" End  <common_block> (Vim least prioritized pattern yet 'not contained')


let b:current_syntax = 'nftables'

let &cpoptions = s:save_cpo
unlet s:save_cpo

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

