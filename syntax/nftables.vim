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

hi link nftablesHL_Comment     Comment
hi link nftablesHL_Include     Include
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
syn keyword nftables_ToDo xxx contained XXX FIXME TODO TODO: FIXME: skipwhite

hi link nftables_Comment nftablesHL_Comment
syn region nftables_Comment start=/#/ end=/$/ contains=nftables_ToDo skipwhite

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

hi link nftables_UnexpectedEOS namedHL_Error
syn match nftables_UnexpectedEOS contained /[;\n]\+/ skipwhite

syn match nftables_EOL contained /[\n\r]\{1,16}/ skipwhite

hi link nftables_Semicolon nftablesHL_Normal
syn match nftables_Semicolon contained /[;]\{1,15}/  skipwhite
\ nextgroup=nftables_EOL

syn cluster nftablesClu_EOS 
\ contains=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesType_BooleanMnemonic nftablesHL_Type
syn keyword nftablesType_BooleanMnemonic contained skipwhite
\    exists
\    missing

hi link nftablesType_BooleanLogic nftablesHL_Type
syn keyword nftablesType_BooleanMnemonic contained skipwhite
\    true
\    false
\    1
\    0

hi link nftablesType_PolicyType nftablesHL_Type
syn keyword nftablesType_PolicyType contained policy skipwhite
\    accept
\    drop

hi link nftablesType_EtherType nftablesHL_Statement
syn match nftablesType_EtherType contained skipwhite
\    /0x\x{1,4}/ 

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

hi link nftablesStmt_AhKeyword nftablesHL_Statement
syn keyword nftablesStmt_AhKeyword contained ah skipwhite
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

hi link nftablesStmt_EspKeyword nftablesHL_Statement
syn keyword nftablesStmt_EspKeyword contained esp skipwhite
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

hi link nftablesStmt_Igmp nftablesHL_Statement
syn keyword nftablesStmt_Igmp contained igmp skipwhite
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
hi link nftablesPriority_Value nftablesHL_Number
syn match nftablesPriority_Value contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftables_Semicolon
"
hi link nftablesPriorityKeyword nftablesHL_Statement
syn keyword nftablesPriorityKeyword contained priority skipwhite
\ nextgroup=nftablesPriority_Value

hi link nftablesHook_IpType nftablesHL_Hook
syn keyword nftablesHook_IpType contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=nftablesPriorityKeyword

hi link nftablesHookKeyword nftablesHL_Statement
syn keyword nftablesHookKeyword contained hook skipwhite
\ nextgroup=
\    nftablesHook_IpType,
\    nftablesHook_ArpType,
\    nftablesHook_BridgeType,
\    nftablesHook_NetdevType,
\    nftablesHook_InetType,
\    nftablesHook_Ip6Type,

" syn keyword Constant prerouting input forward output postrouting
hi link nftablesType_Filter nftablesHL_Type
syn keyword nftablesType_Filter contained filter skipwhite
\ nextgroup=nftablesHookKeyword

hi link nftablesType_Nat nftablesHL__Type
syn keyword nftablesType_Nat contained nat skipwhite
\ nextgroup=nftablesHookKeyword

hi link nftablesType_Route nftablesHL__Type
syn keyword nftablesType_Route contained route skipwhite
\ nextgroup=nftablesHookKeyword

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin of statements (inside table/chain)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Begin 'statement... comment \"<string>\"'
hi link nftablesStmt_CommentString nftablesHL_String
syn region nftablesStmt_CommentString contained skipwhite
\ start=/"/ skip=/\\"/ end=/"/ 

hi link nftablesStmt_CommentKeyword nftablesHL_Statement
syn keyword nftablesStmt_CommentKeyword contained comment skipwhite
\ nextgroup=nftablesStmt_CommentString
" End 'statement... comment \"<string>\"'

" Begin 'statement... counter ...'
hi link nftablesStmt_CounterKeyword nftablesHL_Statement
syn keyword nftablesStmt_CounterKeyword contained counter skipwhite
\ nextgroup=
\    nftablesStmt_LogKeyword,
\    nftablesStmt_ChainTarget,
\    nftables_Semicolon,
\    nftables_EOS
" End 'statement... counter ...'

" Begin 'statement... fwd to ...'  (only within Netdev family)
hi link nftablesStmtFwdTo_DeviceName nftablesHL_Device
syn match nftablesStmtFwdTo_DeviceName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 

hi link nftablesStmtFwd_ToKeyword nftablesHL_Expression
syn keyword nftablesStmtFwd_ToKeyword contained to skipwhite
\ nextgroup=nftablesStmtFwdTo_DeviceName

hi link nftablesStmt_FwdKeyword nftablesHL_Statement
syn keyword nftablesStmt_FwdKeyword contained fwd skipwhite
\ nextgroup=nftablesStmtFwd_ToKeyword
" End 'statement... fwd to ...' (only within Netdev family)

" Begin 'statement... log ...'
hi link nftablesStmt_LogKeyword nftablesHL_Statement
syn keyword nftablesStmt_LogKeyword contained log skipwhite
\ nextgroup=
\    nftablesStmtVerdicts_ChainTarget,
\    nftables_Semicolon,
\    nftables_EOS
" End 'statement... log ...'

" Begin 'statement... map'
hi link nftablesStmtMap_MapName nftablesHL_Map
syn match nftablesStmtMap_MapName contained skipwhite
\    /[@\$]\{0,1}[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesStmt_TcpKeyword,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesStmt_MapKeyword nftablesHL_Statement
syn keyword nftablesStmt_MapKeyword contained map skipwhite
\ nextgroup=
\    nftablesStmtMap_MapName
" End 'statement... map'

" Begin of 'statement... quota'
hi link nftablesStmtQuota_Unit nftablesHL_Type
syn keyword nftablesStmtQuota_Unit contained skipwhite
\    bytes
\    kbytes
\    mbytes
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesStmtQuota_Amount nftablesHL_Number
syn match nftablesStmtQuota_Amount contained /\d\{1,11}/ skipwhite
\ nextgroup=nftablesStmtQuota_Unit

hi link nftablesStmtQuota_Ceiling nftablesHL_Type
syn keyword nftablesStmtQuota_Ceiling contained skipwhite
\    until
\    over
\ nextgroup=nftablesStmtQuota_Amount

hi link nftablesStmtQuota_QuotaName nftablesHL_Quota
syn match nftablesStmtQuota_QuotaName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesStmtQuota_Ceiling,
\    nftablesStmtQuota_Amount

hi link nftablesStmt_QuotaKeyword nftablesHL_Statement
syn keyword nftablesStmt_QuotaKeyword contained quota skipwhite
\ nextgroup=nftablesStmtQuota_QuotaName
" End 'add rule ... quota'

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
\    nftablesStmt_MapKeyword,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesStmt_TcpKeyword nftablesHL_Statement
syn keyword nftablesStmt_TcpKeyword contained tcp skipwhite
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
\    nftablesExprUdp_PortNumber

syn region nftablesExprUdp_Section contained start=/\s/ end=/;/ skipwhite
\ contains=
\    nftablesExprUdp_PortsKeyword,
\    nftablesExprUdp_LengthKeyword,
\    nftablesExprUdp_ChecksumKeyword,
\    nftablesExprUdp_EtherKeyword,
\    nftables_Semicolon

hi link nftablesStmt_UdpKeyword nftablesHL_Statement
syn keyword nftablesStmt_UdpKeyword contained udp skipwhite
\ nextgroup=nftablesExprUdp_Section
" End 'statement... udp'

" Begin 'statement... verdict'
hi link nftablesStmtVerdicts_ChainTarget nftablesHL_Chain
syn match nftablesStmtVerdicts_ChainTarget contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftablesStmt_VerdictKeywords nftablesHL_Statement
syn keyword nftablesStmt_VerdictKeywords contained skipwhite
\    accept
\    drop
\    continue
\    return
\    queue

hi link nftablesStmt_VerdictTargetKeywords nftablesHL_Statement
syn keyword nftablesStmt_VerdictTargetKeywords contained skipwhite
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
\ nextgroup=nftablesPriorityKeyword

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
\    nftablesStmt_CounterKeyword,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftables_Comment,
\    nftablesInclude
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesTArp_Name nftablesHL_Identifier
syn match nftablesTArp_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesTArp_Section

hi link nftablesTableFamily_Arp nftablesHL_Family
syn keyword nftablesTableFamily_Arp contained arp skipwhite
\ nextgroup=nftablesTArp_Name
" End 'table arp ...'

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

hi link nftablesTNetdevC_Device nftablesHL_Type
syn match nftablesTNetdevC_Device contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftablesTNetdevC_PriorityKeyword,
\    nftables_Semicolon

hi link nftablesTNetdevC_DeviceKeyword nftablesHL_Statement
syn keyword nftablesTNetdevC_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesTNetdevC_Device

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
syn keyword nftablesTNetdevC_TypeKeyword contained type skipwhite
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
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_UdpKeyword,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftables_Comment,
\    nftablesInclude
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesTNetdev_Name nftablesHL_Identifier
syn match nftablesTNetdev_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesTNetdev_Section

hi link nftablesTableFamily_Netdev nftablesHL_Family
syn keyword nftablesTableFamily_Netdev contained netdev skipwhite
\ nextgroup=nftablesTNetdev_Name
" End of 'table netdev ...'


" Begin of 'add chain ...'
" Begin of 'add chain arp <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainArp_Priority nftablesHL_Number
syn match nftablesCmdAddChainArp_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainArp_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainArp_Priority

hi link nftablesCmdAddChainArp_Device  nftablesHL_String
syn match nftablesCmdAddChainArp_Device contained skipwhite 
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftablesCmdAddChainArp_PriorityKeyword

hi link nftablesCmdAddChainArp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainArp_Device

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
\ contains=nftablesCmdAddChainArpDevice_Element
\ nextgroup=nftablesCmdAddChainArp_PriorityKeyword

hi link nftablesCmdAddChainArp_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainArp_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainArp_DeviceSection

hi link nftablesCmdAddChainArp_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainArp_DeviceEqual

hi link nftablesCmdAddChainArp_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainArp_Hook contained skipwhite
\    input
\    output
\ nextgroup=
\    nftablesCmdAddChainArp_DevicesKeyword,
\    nftablesCmdAddChainArp_DeviceKeyword,
\    nftablesCmdAddChainArp_PriorityKeyword 

hi link nftablesCmdAddChainArp_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainArp_Hook

hi link nftablesCmdAddChainArp_Type nftablesHL_Type
syn keyword nftablesCmdAddChainArp_Type contained skipwhite
\    filter
\ nextgroup=nftablesCmdAddChainArp_HookKeyword nftablesHL_Option

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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
" Begin of 'add chain ip6 <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainBridge_Priority nftablesHL_Number
syn match nftablesCmdAddChainBridge_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainBridge_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Priority

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
\ contains=nftablesCmdAddChainBridgeDevice_Element
\ nextgroup=nftablesCmdAddChainBridge_PriorityKeyword

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
\    nftablesCmdAddChainBridge_PriorityKeyword 

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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
hi link nftablesCmdAddChainNetdev_Priority nftablesHL_Number
syn match nftablesCmdAddChainNetdev_Priority contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainNetdev_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Priority

hi link nftablesCmdAddChainNetdev_Device  nftablesHL_String
syn match nftablesCmdAddChainNetdev_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftablesCmdAddChainNetdev_PriorityKeyword

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
\ contains=nftablesCmdAddChainNetdevDevice_Element
\ nextgroup=nftablesCmdAddChainNetdev_PriorityKeyword

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
\    nftablesCmdAddChainNetdev_PriorityKeyword

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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
hi link nftablesCmdAddChainIp_Priority nftablesHL_Number
syn match nftablesCmdAddChainIp_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainIp_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainIp_Priority

hi link nftablesCmdAddChainIp_Device  nftablesHL_String
syn match nftablesCmdAddChainIp_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftablesCmdAddChainIp_PriorityKeyword

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
\ contains=nftablesCmdAddChainIpDevice_Element
\ nextgroup=nftablesCmdAddChainIp_PriorityKeyword

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
\    nftablesCmdAddChainIp_PriorityKeyword 

hi link nftablesCmdAddChainIp_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_NatHook contained skipwhite
\    prerouting
\    input
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DevicesKeyword,
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftablesCmdAddChainIp_PriorityKeyword 

hi link nftablesCmdAddChainIp_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftablesCmdAddChainIp_DevicesKeyword,
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftablesCmdAddChainIp_PriorityKeyword 

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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
hi link nftablesCmdAddChainIp6_Priority nftablesHL_Number
syn match nftablesCmdAddChainIp6_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainIp6_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Priority

hi link nftablesCmdAddChainIp6_Device  nftablesHL_String
syn match nftablesCmdAddChainIp6_Device contained skipwhite 
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftablesCmdAddChainIp6_PriorityKeyword

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
\ contains=nftablesCmdAddChainIp6Device_Element
\ nextgroup=nftablesCmdAddChainIp6_PriorityKeyword

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
\    nftablesCmdAddChainIp6_PriorityKeyword 

hi link nftablesCmdAddChainIp6_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp6_DevicesKeyword,
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftablesCmdAddChainIp6_PriorityKeyword 

hi link nftablesCmdAddChainIp6_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftablesCmdAddChainIp6_DevicesKeyword,
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftablesCmdAddChainIp6_PriorityKeyword 

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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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
hi link nftablesCmdAddChainInet_Priority nftablesHL_Number
syn match nftablesCmdAddChainInet_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainInet_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainInet_Priority

hi link nftablesCmdAddChainInet_Device  nftablesHL_String
syn match nftablesCmdAddChainInet_Device contained skipwhite
\    /[A-Za-z0-9_.\-%]\{1,256}/ 
\ nextgroup=nftablesCmdAddChainInet_PriorityKeyword

hi link nftablesCmdAddChainInet_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_DeviceKeyword contained device skipwhite
\ nextgroup=
\    nftablesCmdAddChainInet_Device

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

hi link nftablesCmdAddChainInet_DeviceSection  nftablesHL_String
syn region nftablesCmdAddChainInet_DeviceSection start=/{/ end=/}/
\ contains=nftablesCmdAddChainInetDevice_Element
\ nextgroup=nftablesCmdAddChainInet_PriorityKeyword

hi link nftablesCmdAddChainInet_DeviceEqual  nftablesHL_Operator
syn match nftablesCmdAddChainInet_DeviceEqual contained /=/ skipwhite
\ nextgroup=nftablesCmdAddChainInet_DeviceSection

hi link nftablesCmdAddChainInet_DevicesKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_DevicesKeyword contained devices skipwhite
\ nextgroup=
\    nftablesCmdAddChainInet_DeviceEqual

hi link nftablesCmdAddChainInet_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainInet_DevicesKeyword,
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainInet_DevicesKeyword,
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_RouteHook contained skipwhite
\    output
\ nextgroup=
\    nftablesCmdAddChainInet_DevicesKeyword,
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_FilterHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_FilterHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainInet_FilterHook
hi link nftablesCmdAddChainInet_NatHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_NatHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainInet_NatHook
hi link nftablesCmdAddChainInet_RouteHookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_RouteHookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainInet_RouteHook

hi link nftablesCmdAddChainInet_Type nftablesHL_Type
syn keyword nftablesCmdAddChainInet_Type contained filter skipwhite
\ nextgroup=nftablesCmdAddChainInet_FilterHookKeyword 
syn keyword nftablesCmdAddChainInet_Type contained nat skipwhite
\ nextgroup=nftablesCmdAddChainInet_NatHookKeyword 
syn keyword nftablesCmdAddChainInet_Type contained route skipwhite
\ nextgroup=nftablesCmdAddChainInet_RouteHookKeyword 

hi link nftablesCmdAddChainInet_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainInet_Type

hi link nftablesCmdAddChainInet_Policy nftablesHL_Verdict
syn keyword nftablesCmdAddChainInet_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainInet_PolicyKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesCmdAddChainInet_Policy


syn region nftablesCmdAddChainInet_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainInet_TypeKeyword,
\    nftablesCmdAddChainInet_PolicyKeyword,
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdAddChainInet_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainInet_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainInet_Section,
\    nftables_EOS

hi link nftablesCmdAddChainInet_TableName nftablesHL_Table
syn match nftablesCmdAddChainInet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainInet_ChainName
" End of 'add chain inet <table_name>...' 

" Begin of 'add chain <family> <table_name>...' 
hi link nftablesCmdAddChainFamily nftablesHL_Family
syn keyword nftablesCmdAddChainFamily contained netdev skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_TableName

syn keyword nftablesCmdAddChainFamily contained arp skipwhite
\ nextgroup=nftablesCmdAddChainArp_TableName

syn keyword nftablesCmdAddChainFamily contained bridge skipwhite
\ nextgroup=nftablesCmdAddChainBridge_TableName

syn keyword nftablesCmdAddChainFamily contained ip skipwhite
\ nextgroup=nftablesCmdAddChainIp_TableName

syn keyword nftablesCmdAddChainFamily contained ip6 skipwhite
\ nextgroup=nftablesCmdAddChainIp6_TableName

syn keyword nftablesCmdAddChainFamily contained inet skipwhite
\ nextgroup=nftablesCmdAddChainInet_TableName
" End of 'add chain <family> <table_name>...' 

hi link nftablesCmdAdd_ChainKeyword nftablesHL_Option
syn keyword nftablesCmdAdd_ChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdAddChainFamily,
\    nftablesCmdAddChainIp_TableName
" End of 'add chain ...'

" Begin of 'add table ...'/'create table ...'
hi link nftablesCmdAddCreateTable_FlagValue nftablesHL_Type
syn keyword nftablesCmdAddCreateTable_FlagValue contained dormant skipwhite

hi link nftablesCmdAddCreateTable_Flags nftablesHL_Option
syn keyword nftablesCmdAddCreateTable_Flags contained flags skipwhite
\ nextgroup=nftablesCmdAddCreateTable_FlagValue

syn region nftablesCmdAddCreateTable_Section contained start=/{/ end=/}/ 
\ skipwhite
\ contains=
\    nftablesCmdAddCreateTable_Flags,
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdAddCreateTable_Name nftablesHL_Table
syn match nftablesCmdAddCreateTable_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddCreateTable_Section,
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdAddCreateTable_Family nftablesHL_Family
syn keyword nftablesCmdAddCreateTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddCreateTable_Name

hi link nftablesCmdAddCreate_TableKeyword nftablesHL_Statement
syn keyword nftablesCmdAddCreate_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdAddCreateTable_Family,
\    nftablesCmdAddCreateTable_Name
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
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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

hi link nftablesCmdAdd_SetKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_SetKeyword contained set skipwhite
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
\    nftables_Comment

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
\    nftables_Comment,
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

hi link nftablesCmdAdd_ElementKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_ElementKeyword contained element skipwhite
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
\    nftables_Comment,
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
\    nftables_Comment,
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

hi link nftablesCmdAdd_FlowtableKeyword nftablesHL_Option
syn keyword nftablesCmdAdd_FlowtableKeyword contained flowtable skipwhite
\ nextgroup=
\    nftablesCmdAddFT_Family,
\    nftablesCmdAddFT_TableName
" End 'add flowtable ...'

" Begin 'add limit ...'
hi link nftablesCmdAddLimit_LimitName nftablesHL_Limit
syn match nftablesCmdAddLimit_LimitName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddLimit_Section

hi link nftablesCmdAddLimit_TableName nftablesHL_Table
syn match nftablesCmdAddLimit_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddLimit_LimitName

hi link nftablesCmdAddLimit_Family nftablesHL_Family
syn keyword nftablesCmdAddLimit_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet

" Generic boilerplate for all-family limit 
" TODO break-out for family-specifics
hi link nftablesCmdAdd_LimitKeyword nftablesHL_Option
syn keyword nftablesCmdAdd_LimitKeyword contained limit skipwhite
\ nextgroup=
\    nftablesCmdAddLimit_Family,
\    nftablesCmdAddLimit_TableName
" End 'add limit ...'

" Begin 'add map ...'
hi link nftablesCmdAddMapVerdict_TargetName nftablesHL_Type
syn match nftablesCmdAddMapVerdict_TargetName contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/

hi link nftablesCmdAddMap_VerdictTargetKeywords nftablesHL_Type
syn keyword nftablesCmdAddMap_VerdictTargetKeywords contained skipwhite
\    jump
\    goto 
\ nextgroup=nftablesCmdAddMapVerdict_TargetName

hi link nftablesCmdAddMap_VerdictKeywords nftablesHL_Type
syn keyword nftablesCmdAddMap_VerdictKeywords contained skipwhite
\    drop
\    accept
\    queue
\    continue
\    return
\    counter
\    quota

hi link nftablesCmdAddMap_Colon nftablesHL_Operator
syn match nftablesCmdAddMap_Colon contained /:\s*/ skipwhite
\ nextgroup=
\    nftablesCmdAddMap_VerdictTargetKeywords,
\    nftablesCmdAddMap_VerdictKeywords,
\    nftables_Error

hi link nftablesCmdAddMap_TypeNth nftablesHL_Option
syn keyword nftablesCmdAddMap_TypeNth contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=
\    nftablesCmdAddMap_Colon,
\    nftablesCmdAddMap_Concat,
\    nftables_Semicolon,

hi link nftablesCmdAddMap_Concat nftablesHL_Operator
syn match nftablesCmdAddMap_Concat contained /\./ skipwhite
\ nextgroup=nftablesCmdAddMap_TypeNth

hi link nftablesCmdAddMap_Type nftablesHL_Type
syn keyword nftablesCmdAddMap_Type contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\    counter
\    quota
\ nextgroup=
\    nftablesCmdAddMap_Concat,
\    nftablesCmdAddMap_Colon,
\    nftables_Semicolon

hi link nftablesCmdAddMap_TypeKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddMap_Type

hi link nftablesCmdAddMap_Flags nftablesHL_Type
syn keyword nftablesCmdAddMap_Flags contained skipwhite
\    constant
\    interval
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddMap_FlagsKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_FlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesCmdAddMap_Flags

hi link nftablesCmdAddMap_Timeout nftablesHL_Integer
syn match nftablesCmdAddMap_Timeout /\d\{1,11}/

hi link nftablesCmdAddMap_TimeoutKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_TimeoutKeyword contained timeout skipwhite
\ nextgroup=nftablesCmdAddMap_Timeout

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

syn region nftablesCmdAddMap_ElementsSection contained start=/=/ end=/;/ skipwhite
\ contains=nftablesCmdAddMapElements_Element
\ nextgroup=
\    nftables_Semicolon

hi link nftablesCmdAddMap_ElementsKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_ElementsKeyword contained elements skipwhite
\ nextgroup=
\    nftablesCmdAddMap_ElementsSection

hi link nftablesCmdAddMap_Size nftablesHL_Type
syn match nftablesCmdAddMap_Size contained /\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddMap_SizeKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_SizeKeyword contained size skipwhite
\ nextgroup=
\    nftablesCmdAddMap_Size

hi link nftablesCmdAddMap_Policy nftablesHL_Type
syn keyword nftablesCmdAddMap_Policy contained skipwhite
\    performance
\    memory
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddMap_PolicyKeyword nftablesHL_Statement
syn keyword nftablesCmdAddMap_PolicyKeyword contained policy skipwhite
\ nextgroup=
\    nftablesCmdAddMap_Policy

syn region nftablesCmdAddMap_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesCmdAddMap_TypeKeyword,
\    nftablesCmdAddMap_FlagsKeyword,
\    nftablesCmdAddMap_ElementsKeyword,
\    nftablesCmdAddMap_SizeKeyword,
\    nftablesCmdAddMap_PolicyKeyword,
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdAddMap_MapName nftablesHL_Map
syn match nftablesCmdAddMap_MapName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddMap_Section

hi link nftablesCmdAddMap_TableName nftablesHL_Table
syn match nftablesCmdAddMap_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddMap_MapName

hi link nftablesCmdAddMap_Family nftablesHL_Family
syn keyword nftablesCmdAddMap_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddMap_TableName

hi link nftablesCmdAdd_MapKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_MapKeyword contained map skipwhite
\ nextgroup=
\    nftablesCmdAddMap_Family,
\    nftablesCmdAddMap_TableName
" End 'add map ...'

" Begin 'add quota ...'
hi link nftablesCmdAddQuota_TableName nftablesHL_Table
syn match nftablesCmdAddQuota_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesStmtQuota_QuotaName

hi link nftablesCmdAddQuota_Family nftablesHL_Family
syn keyword nftablesCmdAddQuota_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddQuota_TableName

hi link nftablesCmdAdd_QuotaKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_QuotaKeyword contained quota skipwhite
\ nextgroup=
\    nftablesCmdAddQuota_Family,
\    nftablesCmdAddQuota_TableName
" End 'add quota ...'

" Begin 'add rule ...'
" begin 'add rule netdev <table> ...'
syn region nftablesCmdAddRuleNetdev_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,
\    nftablesStmt_FwdKeyword,

hi link nftablesCmdAddRuleNetdev_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleNetdev_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleNetdev_Section

hi link nftablesCmdAddRuleNetdev_TableName nftablesHL_Table
syn match nftablesCmdAddRuleNetdev_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleNetdev_RuleName

hi link nftablesCmdAddRuleNetdev_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleNetdev_Family contained netdev skipwhite
\ nextgroup=nftablesCmdAddRuleNetdev_TableName
" end 'add rule netdev <table> ...'

" begin 'add rule bridge <table> ...'
syn region nftablesCmdAddRuleBridge_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,

hi link nftablesCmdAddRuleBridge_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleBridge_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleBridge_Section

hi link nftablesCmdAddRuleBridge_TableName nftablesHL_Table
syn match nftablesCmdAddRuleBridge_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleBridge_RuleName

hi link nftablesCmdAddRuleBridge_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleBridge_Family contained bridge skipwhite
\ nextgroup=nftablesCmdAddRuleBridge_TableName
" end 'add rule bridge <table> ...'

" begin 'add rule arp <table> ...'
syn region nftablesCmdAddRuleArp_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,

hi link nftablesCmdAddRuleArp_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleArp_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleArp_Section

hi link nftablesCmdAddRuleArp_TableName nftablesHL_Table
syn match nftablesCmdAddRuleArp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleArp_RuleName

hi link nftablesCmdAddRuleArp_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleArp_Family contained arp skipwhite
\ nextgroup=nftablesCmdAddRuleArp_TableName
" end 'add rule arp <table> ...'

" begin 'add rule ip <table> ...'
syn region nftablesCmdAddRuleIp_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,
\    nftablesStmt_UdpKeyword,

hi link nftablesCmdAddRuleIp_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleIp_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp_Section

hi link nftablesCmdAddRuleIp_TableName nftablesHL_Table
syn match nftablesCmdAddRuleIp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp_RuleName

hi link nftablesCmdAddRuleIp_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleIp_Family contained ip skipwhite
\ nextgroup=nftablesCmdAddRuleIp_TableName
" end 'add rule ip <table> ...'

" begin 'add rule ip6 <table> ...'
syn region nftablesCmdAddRuleIp6_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,
\    nftablesStmt_UdpKeyword,

hi link nftablesCmdAddRuleIp6_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleIp6_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp6_Section

hi link nftablesCmdAddRuleIp6_TableName nftablesHL_Table
syn match nftablesCmdAddRuleIp6_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleIp6_RuleName

hi link nftablesCmdAddRuleIp6_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleIp6_Family contained ip6 skipwhite
\ nextgroup=nftablesCmdAddRuleIp6_TableName
" end 'add rule ip6 <table> ...'

" begin 'add rule inet <table> ...'
syn region nftablesCmdAddRuleInet_Section contained start="\s" end="[\n;]" 
\ contains=
\    nftablesStmt_VerdictTargetKeywords,
\    nftablesStmt_CounterKeyword,
\    nftablesStmt_VerdictKeywords,
\    nftablesStmt_QuotaKeyword,
\    nftablesStmt_CommentKeyword,
\    nftablesStmt_UdpKeyword,

hi link nftablesCmdAddRuleInet_RuleName nftablesHL_Rule
syn match nftablesCmdAddRuleInet_RuleName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleInet_Section

hi link nftablesCmdAddRuleInet_TableName nftablesHL_Table
syn match nftablesCmdAddRuleInet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddRuleInet_RuleName

hi link nftablesCmdAddRuleInet_Family nftablesHL_Family
syn keyword nftablesCmdAddRuleInet_Family contained inet skipwhite
\ nextgroup=nftablesCmdAddRuleInet_TableName
" end 'add rule inet <table> ...'

hi link nftablesCmdAddRule_Family nftablesHL_Family
syn keyword nftablesCmdAddRule_Family contained skipwhite
\    bridge
\    arp
\    ip6
\    inet
\ nextgroup=nftablesCmdAddRule_TableName

hi link nftablesCmdAdd_RuleKeyword nftablesHL_Statement
syn keyword nftablesCmdAdd_RuleKeyword contained rule skipwhite
\ nextgroup=
\    nftablesCmdAddRuleNetdev_Family,
\    nftablesCmdAddRuleBridge_Family,
\    nftablesCmdAddRuleArp_Family,
\    nftablesCmdAddRuleIp_Family,
\    nftablesCmdAddRuleIp6_Family,
\    nftablesCmdAddRuleInet_Family,
\    nftablesCmdAddRuleIp_TableName
" End 'add rule ...'

" Begin 'add type ...'
hi link nftablesCmdAddType_TypeName nftablesHL_Type
syn match nftablesCmdAddType_TypeName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddType_Section

hi link nftablesCmdAddType_TableName nftablesHL_Table
syn match nftablesCmdAddType_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddType_TypeName

hi link nftablesCmdAddType_Family nftablesHL_Family
syn keyword nftablesCmdAddType_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddType_TableName

hi link nftablesCmdAdd_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAdd_TypeKeyword contained type skipwhite
\ nextgroup=
\    nftablesCmdAddType_Family,
\    nftablesCmdAddType_TableName
" End 'add type ...'

" Begin command 'ct ...'
hi link nftablesCmdCT_L3protocolIdentifier nftablesHL_Identifier
syn keyword nftablesCmdCT_L3protocolIdentifier contained skipwhite
\    ip
\    ip6
\    inet
\ nextgroup=nftables_Semicolon

hi link nftablesCmdCT_L3protocolKeyword nftablesHL_Option
syn keyword nftablesCmdCT_L3protocolKeyword contained l3proto skipwhite
\ nextgroup=nftablesCmdCT_L3protocolIdentifier

hi link nftablesCmdCT_ProtocolIdentifier nftablesHL_Identifier
syn keyword nftablesCmdCT_ProtocolIdentifier contained skipwhite
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

hi link nftablesCmdCT_ProtocolKeyword nftablesHL_Option
syn keyword nftablesCmdCT_ProtocolKeyword contained protocol skipwhite
\ nextgroup=nftablesCmdCT_ProtocolIdentifier

hi link nftablesCmdCT_TypeIdentifier nftablesHL_Identifier
syn match nftablesCmdCT_TypeIdentifier contained skipwhite
\    /\"[A-Za-z][A-Za-z0-9\-_./]\{0,64}\"/ 
\ nextgroup=nftablesCmdCT_ProtocolKeyword

hi link nftablesCmdCT_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdCT_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdCT_TypeIdentifier

syn region nftablesCmdCT_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdCT_TypeKeyword,
\    nftablesCmdCT_L3protocolKeyword 
\ nextgroup=nftables_EOS

hi link nftablesCmdCT_HelperName nftablesHL_Chain
syn match nftablesCmdCT_HelperName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdCT_Section

hi link nftablesCmdCT_HelperKeyword nftablesHL_Option
syn keyword nftablesCmdCT_HelperKeyword contained helper skipwhite
\ nextgroup=nftablesCmdCT_HelperName
" End command 'ct ...'

" Begin of 'delete chain ...'
hi link nftablesCmdDeleteChain_ChainName nftablesHL_Chain
syn match nftablesCmdDeleteChain_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteChain_Handle nftablesHL_Handle
syn match nftablesCmdDeleteChain_Handle contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteChain_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdDeleteChain_HandleKeyword contained handle skipwhite
\ nextgroup=nftablesCmdDeleteChain_Handle
\ nextgroup=
\    nftables_UnexpectedEOS

hi link nftablesCmdDeleteChainTableName nftablesHL_Table
syn match nftablesCmdDeleteChainTableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdDeleteChain_HandleKeyword,
\    nftablesCmdFlushChain_ChainName

hi link nftablesCmdDeleteChainFamily nftablesHL_Family
syn keyword nftablesCmdDeleteChainFamily contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdDeleteChainTableName

hi link nftablesCmdDelete_ChainKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_ChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdDeleteChainFamily,
\    nftablesCmdDeleteChainTableName
" End of 'delete chain ...'

" Begin 'delete flowtable ...'
hi link nftablesCmdDeleteFT_FlowtableName nftablesHL_Flowtable
syn match nftablesCmdDeleteFT_FlowtableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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

" Begin of 'delete set ...'
hi link nftablesCmdDeleteSet_SetName nftablesHL_Set
syn match nftablesCmdDeleteSet_SetName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteSet_Handle nftablesHL_Handle
syn match nftablesCmdDeleteSet_Handle contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteSet_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdDeleteSet_HandleKeyword contained handle skipwhite
\ nextgroup=
\    nftablesCmdDeleteSet_Handle
\    nftables_UnexpectedEOS

hi link nftablesCmdDeleteSet_TableName nftablesHL_Table
syn match nftablesCmdDeleteSet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdDeleteSet_HandleKeyword,
\    nftablesCmdDeleteSet_SetName

hi link nftablesCmdDeleteSet_Family nftablesHL_Family
syn keyword nftablesCmdDeleteSet_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdDeleteSet_TableName

hi link nftablesCmdDelete_SetKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_SetKeyword contained set skipwhite
\ nextgroup=
\    nftablesCmdDeleteSet_Family,
\    nftablesCmdDeleteSet_TableName
" End of 'delete set ...'

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
\ nextgroup=
\    nftablesCmdDeleteTable_Name,
\    nftablesCmdDeleteTable_Family,
\    nftablesCmdDeleteTable_HandleKeyword
" End of 'delete table ...'
"
" Begin of 'delete type ...'
hi link nftablesCmdDeleteType_TypeName nftablesHL_Chain
syn match nftablesCmdDeleteType_TypeName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteType_Handle nftablesHL_Handle
syn match nftablesCmdDeleteType_Handle contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdDeleteType_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdDeleteType_HandleKeyword contained handle skipwhite
\ nextgroup=nftablesCmdDeleteType_Handle
\ nextgroup=
\    nftables_UnexpectedEOS

hi link nftablesCmdDeleteType_TableName nftablesHL_Table
syn match nftablesCmdDeleteType_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdDeleteType_HandleKeyword,
\    nftablesCmdDeleteType_TypeName

hi link nftablesCmdDeleteType_Family nftablesHL_Family
syn keyword nftablesCmdDeleteType_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdDeleteType_TableName

hi link nftablesCmdDelete_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdDelete_TypeKeyword contained type skipwhite
\ nextgroup=
\    nftablesCmdDeleteType_Family,
\    nftablesCmdDeleteType_TableName
" End of 'delete type ...'

" Begin of 'describe ...'
hi link nftablesCmdDescribe_String nftablesHL_String
syn match nftablesCmdDescribe_String contained /[^;\n]*/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
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

" Begin of 'flush ruleset ...'
hi link nftablesCmdFlushRulesetFamilies nftablesHL_Family
syn keyword nftablesCmdFlushRulesetFamilies contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdFlush_RulesetKeyword nftablesHL_Option
syn keyword nftablesCmdFlush_RulesetKeyword contained ruleset skipwhite
\ nextgroup=
\    nftablesCmdFlushRulesetFamilies,
\    nftables_Semicolon,
\    nftables_EOS
" End of 'flush ruleset ...'

" Begin of 'flush table ...'
hi link nftablesCmdFlush_TableName nftablesHL_Table
syn match nftablesCmdFlush_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdFlushTable_Family nftablesHL_Family
syn keyword nftablesCmdFlushTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdFlush_TableName 

hi link nftablesCmdFlush_TableKeyword nftablesHL_Option
syn keyword nftablesCmdFlush_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdFlushTable_Family,
\    nftablesCmdFlush_TableName
" End of 'flush table ...'

" Begin of 'flush chain ...'
hi link nftablesCmdFlushChain_ChainName nftablesHL_Chain
syn match nftablesCmdFlushChain_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdFlushChain_Handle nftablesHL_Handle
syn match nftablesCmdFlushChain_Handle contained /[0-9]\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdFlushChain_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdFlushChain_HandleKeyword contained handle skipwhite
\ nextgroup=
\    nftablesCmdFlushChain_Handle
\    nftables_UnexpectedEOS

hi link nftablesCmdFlushChainTableName nftablesHL_Table
syn match nftablesCmdFlushChainTableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdFlushChain_HandleKeyword,
\    nftablesCmdFlushChain_ChainName

hi link nftablesCmdFlushChainFamily nftablesHL_Family
syn keyword nftablesCmdFlushChainFamily contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdFlushChainTableName

hi link nftablesCmdFlush_ChainKeyword nftablesHL_Option
syn keyword nftablesCmdFlush_ChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdFlushChainFamily,
\    nftablesCmdFlushChainTableName
" End 'flush chain ...'

" Begin 'list <no_arg>'
hi link nftablesCmdList_NoArg nftablesHL_Option
syn keyword nftablesCmdList_NoArg contained skipwhite
\    tables
\    chains
\    sets
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS
" End 'list <no_arg>'

" Begin 'list counters'
hi link nftablesCmdListCounters_TableName nftablesHL_Table
syn match nftablesCmdListCounters_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftablesCmdListCounters_TableFamily nftablesHL_Family
syn keyword nftablesCmdListCounters_TableFamily contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdListCounters_TableName

hi link nftablesCmdListCounters_TableKeyword nftablesHL_Statement
syn keyword nftablesCmdListCounters_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdListCounters_TableFamily,
\    nftablesCmdListCounters_TableName

hi link nftablesCmdListCounters_Family nftablesHL_Family
syn keyword nftablesCmdListCounters_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet

hi link nftablesCmdList_CountersKeyword nftablesHL_Option
syn keyword nftablesCmdList_CountersKeyword contained counters skipwhite
\ nextgroup=
\    nftablesCmdListCounters_Family,
\    nftablesCmdListCounters_TableKeyword
" End 'list counters'

" Begin 'list limits'
hi link nftablesCmdListLimits_TableName nftablesHL_Table
syn match nftablesCmdListLimits_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 

hi link nftablesCmdListLimits_TableFamily nftablesHL_Family
syn keyword nftablesCmdListLimits_TableFamily contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdListLimits_TableName

hi link nftablesCmdListLimits_TableKeyword nftablesHL_Statement
syn keyword nftablesCmdListLimits_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdListLimits_TableFamily,
\    nftablesCmdListLimits_TableName

hi link nftablesCmdListLimits_Family nftablesHL_Family
syn keyword nftablesCmdListLimits_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet

hi link nftablesCmdList_LimitsKeyword nftablesHL_Option
syn keyword nftablesCmdList_LimitsKeyword contained limits skipwhite
\ nextgroup=
\    nftablesCmdListLimits_Family,
\    nftablesCmdListLimits_TableKeyword
" End 'list limits'

" Begin 'list map [<family>] <table_name> <map>' 
hi link nftablesCmdList_MapName nftablesHL_Map
syn match nftablesCmdList_MapName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdListMap_TableName nftablesHL_Table
syn match nftablesCmdListMap_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdList_MapName 

hi link nftablesCmdListMap_Family nftablesHL_Family
syn keyword  nftablesCmdListMap_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdListMap_TableName

hi link nftablesCmdList_MapKeyword nftablesHL_Statement
syn keyword nftablesCmdList_MapKeyword contained map skipwhite
\ nextgroup=
\    nftablesCmdListMap_Family,
\    nftablesCmdListMap_TableName
" End of 'list map [<family>] <table_name> <map>' 

" Begin of 'list ruleset [family]'
hi link nftablesCmdListRuleset_Family nftablesHL_Family
syn keyword nftablesCmdListRuleset_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftables_EOS

hi link nftablesCmdList_Ruleset nftablesHL_Option
syn keyword nftablesCmdList_Ruleset contained ruleset skipwhite
\ nextgroup=
\    nftablesCmdListRuleset_Family,
\    nftables_EOS
" End of 'list ruleset [<family>]'

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

hi link nftablesCmdList_SetKeyword nftablesHL_Statement
syn keyword nftablesCmdList_SetKeyword contained set skipwhite
\ nextgroup=
\    nftablesCmdListSet_Family,
\    nftablesCmdListSet_TableName
" End of 'list set [<family>] <table_name> <set_name>' 
"
" Begin of 'list table [<family>] <table_name>' 
hi link nftablesCmdListTable_Name nftablesHL_Table
syn match nftablesCmdListTable_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdListTable_Family nftablesHL_Family
syn keyword nftablesCmdListTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdListTable_Name,
\    nftables_EOS

hi link nftablesCmdListTableKeyword nftablesHL_Statement
syn keyword nftablesCmdListTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdListTable_Name,
\    nftablesCmdListTable_Family
" End of 'list table [<family>] <table_name>' 
" End of 'list set ...'

" Begin 'monitor'
hi link nftablesCmdMonitor_Format nftablesHL_Builtin
syn keyword nftablesCmdMonitor_Format contained skipwhite
\    nft
\    xml
\    json
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdMonitor_Object nftablesHL_Type
syn keyword nftablesCmdMonitor_Object contained skipwhite
\    tables
\    chains
\    sets
\    rules
\    elements
\    ruleset
\    trace
\ nextgroup=
\    nftablesCmdMonitor_Format,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdMonitor_Action nftablesHL_Statement
syn match nftablesCmdMonitor_Action contained /\(new\|destroy\)/ skipwhite
\ nextgroup=
\    nftablesCmdMonitor_Object,
\    nftables_UnexpectedEOS,
\    nftables_UnexpectedSemicolon,
" End 'monitor'

" Start of 'rename [family] <table_name> <chain_name> <new_chain_name>
hi link nftablesCmdRenameChain_NewChain nftablesHL_Chain
syn match nftablesCmdRenameChain_NewChain contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdRenameChain_ChainName nftablesHL_Chain
syn match nftablesCmdRenameChain_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdRenameChain_NewChain

hi link nftablesCmdRenameChain_TableName nftablesHL_Table
syn match nftablesCmdRenameChain_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesCmdRenameChain_ChainName

hi link nftablesCmdRenameChain_Family nftablesHL_Family
syn keyword nftablesCmdRenameChain_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdRenameChain_TableName

hi link nftablesCmdRenameChainKeyword nftablesHL_Statement
syn keyword nftablesCmdRenameChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdRenameChain_Family,
\    nftablesCmdRenameChain_TableName
" End of 'rename [family] <table_name> <chain_name> <new_chain_name>

" Begin 'reset ...'
" Begin 'reset counter...' via <obj_spec>/<objid_spec>
hi link nftablesCmdResetCounter_HandleId nftablesHL_Number
syn match nftablesCmdResetCounter_HandleId contained /\d\{1,5}/ skipwhite

hi link nftablesCmdResetCounter_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdResetCounter_HandleKeyword contained handle skipwhite
\ nextgroup=nftables_HandleId

hi link nftablesCmdResetCounter_TableName nftablesHL_Table
syn match nftablesCmdResetCounter_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdResetCounter_HandleKeyword,

hi link nftablesCmdResetCounter_TableFamily nftablesHL_Family
syn keyword nftablesCmdResetCounter_TableFamily contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdResetCounter_TableName

hi link nftablesCmdResetCounter_Family nftablesHL_Family
syn keyword nftablesCmdResetCounter_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdResetCounter_TableName

hi link nftablesCmdReset_CounterKeyword nftablesHL_Option
syn keyword nftablesCmdReset_CounterKeyword contained counter skipwhite
\ nextgroup=
\    nftablesCmdResetCounter_Family,
\    nftablesCmdResetCounter_TableName
" End 'reset counters...' via <obj_spec>/<objid_spec>

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

hi link nftablesCmdReset_QuotaKeyword nftablesHL_Statement
syn keyword nftablesCmdReset_QuotaKeyword contained quota skipwhite
\ nextgroup=
\    nftablesCmdResetQuota_Family,
\    nftablesCmdResetQuota_TableName,
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS
" End 'reset quota...'

" Begin 'reset quotas...'
hi link nftablesCmdResetQuotas_TableName nftablesHL_Table
syn match nftablesCmdResetQuotas_TableName contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdResetQuotasTable_Family nftablesHL_Family
syn keyword nftablesCmdResetQuotasTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdResetQuotas_TableName

hi link nftablesCmdResetQuotas_TableKeyword nftablesHL_Statement
syn keyword nftablesCmdResetQuotas_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdResetQuotasTable_Family,
\    nftablesCmdResetQuotas_TableName

hi link nftablesCmdResetQuotas_Family nftablesHL_Family
syn keyword nftablesCmdResetQuotas_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdReset_QuotasKeyword nftablesHL_Statement
syn keyword nftablesCmdReset_QuotasKeyword contained quotas skipwhite
\ nextgroup=
\    nftablesCmdResetQuotas_TableKeyword,
\    nftablesCmdResetQuotas_Family,
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS
" End 'reset quotas...'
" End 'reset ...'

""""""""""""""""""""""""""""""""""""""
" Base commands
""""""""""""""""""""""""""""""""""""""
" Begin <base_cmd> (Vim least-prioritized pattern yet 'not contained')
" Begin 'add ' <add_cmd>
hi link nftablesCmd_AddKeyword nftablesHL_Command
syn keyword nftablesCmd_AddKeyword skipwhite add skipempty 
\ nextgroup=
\    nftablesCmdAdd_ChainKeyword,
\    nftablesCmdAdd_ElementKeyword,
\    nftablesCmdAdd_FlowtableKeyword,
\    nftablesCmdAdd_LimitKeyword,
\    nftablesCmdAdd_MapKeyword,
\    nftablesCmdAdd_QuotaKeyword,
\    nftablesCmdAdd_SetKeyword,
\    nftablesCmdAdd_RuleKeyword,
\    nftablesCmdAddCreate_TableKeyword,
\    nftablesCmdAdd_TypeKeyword
" End 'add ' <add_cmd>

hi link nftablesCmd_Create nftablesHL_Command
syn keyword nftablesCmd_Create skipwhite create skipempty 
\ nextgroup=
\    nftablesCmdAddCreate_TableKeyword,
\    nftablesCmdAdd_ChainKeyword,
\    nftablesCmdAdd_FlowtableKeyword

hi link nftablesCmd_CTKeyword nftablesHL_Command
syn keyword nftablesCmd_CTKeyword skipwhite ct skipempty 
\ nextgroup=nftablesCmdCT_HelperKeyword

hi link nftablesCmd_Delete nftablesHL_Command
syn keyword nftablesCmd_Delete skipwhite delete skipempty 
\ nextgroup=
\    nftablesCmdDelete_TableKeyword,
\    nftablesCmdDelete_ChainKeyword,
\    nftablesCmdDelete_SetKeyword,
\    nftablesCmdAdd_ElementKeyword,
\    nftablesCmdAdd_MapKeyword,
\    nftablesCmdDelete_FlowtableKeyword,
\    nftablesCmdDelete_TypeKeyword

hi link nftablesCmd_Describe nftablesHL_Command
syn keyword nftablesCmd_Describe describe skipwhite 
\ nextgroup=
\    nftablesCmdDescribe_String,

hi link nftablesCmdExportKeyword nftablesHL_Command
syn keyword nftablesCmdExportKeyword export skipwhite 
\ nextgroup=
\    nftablesCmdExportRulesetKeyword,
\    nftablesCmdExport_Format

hi link nftablesCmdFlushKeyword nftablesHL_Command
syn keyword nftablesCmdFlushKeyword flush skipwhite
\ nextgroup=
\    nftablesCmdFlush_RulesetKeyword,
\    nftablesCmdFlush_TableKeyword,
\    nftablesCmdFlush_ChainKeyword,
\    nftablesCmdList_SetKeyword,
\    nftablesCmdList_MapKeyword,

hi link nftablesCmdGetKeyword nftablesHL_Command
syn keyword nftablesCmdGetKeyword get skipwhite
\ nextgroup=
\    nftablesCmdGet_Keyword

hi link nftablesCmdImportKeyword nftablesHL_Command
syn keyword nftablesCmdImportKeyword import skipwhite
\ nextgroup=
\    nftablesCmdImport_Keyword

hi link nftablesCmdInsertKeyword nftablesHL_Command
syn keyword nftablesCmdInsertKeyword insert skipwhite
\ nextgroup=
\    nftablesCmdInsert_Keyword

hi link nftablesCmdListKeyword nftablesHL_Command
syn keyword nftablesCmdListKeyword list skipwhite
\ nextgroup=
\    nftablesCmdList_NoArg,
\    nftablesCmdFlush_ChainKeyword,
\    nftablesCmdList_CountersKeyword,
\    nftablesCmdDelete_FlowtableKeyword,
\    nftablesCmdList_LimitsKeyword,
\    nftablesCmdList_MapKeyword,
\    nftablesCmdFlush_RulesetKeyword,
\    nftablesCmdList_SetKeyword,
\    nftablesCmdListTableKeyword,
\    nftablesCmdAdd_TypeKeyword,
\    nftables_UnexpectedEOS

hi link nftablesCmdMonitorKeyword nftablesHL_Command
syn keyword nftablesCmdMonitorKeyword monitor skipwhite
\ nextgroup=
\    nftablesCmdMonitor_Action,
\    nftablesCmdMonitor_Object,
\    nftables_EOS

hi link nftablesCmdRenameKeyword nftablesHL_Command
syn keyword nftablesCmdRenameKeyword rename skipwhite
\ nextgroup=
\    nftablesCmdRenameChainKeyword

hi link nftablesCmdReplaceKeyword nftablesHL_Command
syn keyword nftablesCmdReplaceKeyword replace skipwhite
\ nextgroup=
\    nftablesCmdReplace_Keyword

hi link nftablesCmd_ResetKeyword nftablesHL_Command
syn keyword nftablesCmd_ResetKeyword reset skipwhite
\ nextgroup=
\    nftablesCmdList_CountersKeyword,
\    nftablesCmdReset_CounterKeyword,
\    nftablesCmdReset_QuotasKeyword,
\    nftablesCmdReset_QuotaKeyword,
\    nftablesCmdAdd_TypeKeyword,
" End <base_cmd> (Vim least-prioritized pattern yet 'not contained')

" Start of 'define <var_name> = <var_value>'
hi link nftablesDefine_ElementNthValue nftablesHL_String
syn match nftablesDefine_ElementNthValue contained skipwhite
\    /[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftablesDefine_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftablesDefine_ElementNthVariable nftablesHL_Identifier
syn match nftablesDefine_ElementNthVariable contained skipwhite
\    /\$[A-Za-z0-9\-_./]\{1,256}/ 
\ nextgroup=
\    nftablesDefine_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftablesDefine_ElementSeparator nftablesHL_Operator
syn match nftablesDefine_ElementSeparator contained /,/ skipwhite
\ nextgroup=
\    nftablesDefine_ElementNthVariable,
\    nftablesDefine_ElementNthValue,

hi link nftablesDefine_ElementVariable nftablesHL_Identifier
syn match nftablesDefine_ElementVariable contained /\$[A-Za-z0-9\-_./]\{1,256}/ skipwhite
\ nextgroup=
\    nftablesDefine_ElementSeparator,
\    nftables_ExpectedRBrace

hi link nftablesDefine_ElementValue nftablesHL_String
syn match nftablesDefine_ElementValue contained /[A-Za-z0-9\-_./]\{1,256}/ skipwhite
\ nextgroup=
\    nftablesDefine_ElementSeparator,
\    nftables_ExpectedRBrace

syn region nftablesDefine_Elements contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesDefine_ElementValue,
\    nftablesDefine_ElementVariable
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesDefine_Value nftablesHL_String
syn match nftablesDefine_Value contained /[A-Za-z0-9\-_./]\{1,256}/ skipwhite

hi link nftablesDefine_Variable nftablesHL_Identifier
syn match nftablesDefine_Variable contained /\$[A-Za-z0-9\-_./]\{1,256}/ skipwhite

hi link nftablesDefineOp_Equal nftablesHL_Operator
syn match nftablesDefineOp_Equal contained /=/ skipwhite
\ nextgroup=
\    nftablesDefine_Elements,
\    nftablesDefine_Variable,
\    nftablesDefine_Value

hi link nftablesDefine_Identifier nftablesHL_Identifier
syn match nftablesDefine_Identifier contained skipwhite
\    /[A-Za-z][A-Za-z0-9\-_./]\{0,64}/ 
\ nextgroup=nftablesDefineOp_Equal
" End of 'define <var_name> = <var_value>'

" Begin of Command-less actions

" Start of '$<variable_name>'
hi link nftablesVariableName Type
syn match nftablesVariableName skipwhite
\    /\$[A-Za-z][A-Za-z0-9\-_\./]\{0,64}/ 
" End of '$<variable_name>'

" Begin <common_block> (Vim least prioritized pattern yet 'not contained')
" Begin of Command-less actions: define
hi link nftablesDefineKeyword nftablesHL_Command
syn match nftablesDefineKeyword /^\s*define/ skipwhite skipempty
\ nextgroup=nftablesDefine_Identifier
" End of Command-less actions: define

" Begin Command-less actions: redefine
" End Command-less actions: redefine

" Begin Command-less actions: undefine
" End Command-less actions: undefine
" End  <common_block> (Vim least prioritized pattern yet 'not contained')

" Begin of Command-less actions: table
hi link nftablesTableKeyword nftablesHL_Command
syn match nftablesTableKeyword /^\s*table/ skipwhite skipempty
\ nextgroup=
\    nftablesTableFamily_Netdev,
\    nftablesTableFamily_Bridge,
\    nftablesTableFamily_Arp,
\    nftablesTableFamily_Inet,
\    nftablesTableFamily_Ip,
\    nftablesTableFamily_Ip6,
\    nftablesTIp_Name
" table [ip] <table_name>  #  nftablesTIp_Name is default family name
" End of Command-less actions: table
" End of Command-less actions


let b:current_syntax = 'nftables'

let &cpoptions = s:save_cpo
unlet s:save_cpo

if main_syntax ==# 'nftables'
  unlet main_syntax
endif

" Google Vimscript style guide
" vim: ts=2 sts=2 ts=80

