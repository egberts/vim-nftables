" Vim syntax file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Initial Date: 2020-04-24
" Last Change:  2020-05-13
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables

" quit when a syntax file was already loaded
if !exists('main_syntax')
  if exists('b:current_syntax')
    finish
  endif
  let main_syntax='nftables'
endif

syn case match

" iskeyword severly impacts '\<' and '\>' atoms
setlocal iskeyword=.,-,48-58,A-Z,a-z,_
setlocal isident=.,-,48-58,A-Z,a-z,_

" syn sync match nftablesSync grouphere NONE "^(table|chain|set)"
syn sync fromstart

let s:save_cpo = &cpoptions
set cpoptions-=C

hi link nftablesHL_Comment     Comment
hi link nftablesHL_Include     Preproc
hi link nftablesHL_ToDo        Todo
hi link nftablesHL_Identifier  Identifier
hi link nftablesHL_Variable    Variable  " doesn't work, stuck on dark cyan
hi link nftablesHL_Number      Number
hi link nftablesHL_String      String
hi link nftablesHL_Statement   Keyword
hi link nftablesHL_Option      Label     " could use a 2nd color here
hi link nftablesHL_Type        Type
hi link nftablesHL_Operator    Normal    " was Operator  
hi link nftablesHL_Underlined  Underlined
hi link nftablesHL_Error       Error

hi link nftablesHL_Family      Underlined   " doesn't work, stuck on dark cyan
hi link nftablesHL_Type        Type
hi link nftablesHL_Hook        Type    
hi link nftablesHL_Action      Special
hi link nftablesHL_Table       Identifier
hi link nftablesHL_Chain       Identifier

hi link nftables_ToDo nftablesHL_ToDo
syn keyword nftables_ToDo xxx contained XXX FIXME TODO TODO: FIXME:

hi link nftablesComment nftablesHL_Comment
syn region nftablesComment start=/#/ end=/$/ contains=nftables_ToDo

hi link nftables_Policy nftablesHL_Action
syn keyword nftables_Policy contained skipwhite
\    accept
\    reject
\    drop
\ nextgroup=nftables_Semicolon

hi link nftables_PolicyKeyword nftablesHL_Option
syn keyword nftables_PolicyKeyword contained policy skipwhite
\ nextgroup=nftables_Policy



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

hi link nftables_E_Filespec_SC nftablesHL_Filespec
syn match nftables_E_Filespec_SC contained /\'[ a-zA-Z\]\-\[0-9\._,:\;\/?<>|"`~!@#$%\^&*\\(\\)=\+ {}]\{1,1024}\'/hs=s+1,he=e-1 skipwhite skipempty skipnl 
syn match nftables_E_Filespec_SC contained /"[ a-zA-Z\]\-\[0-9\._,:\;\/?<>|'`~!@#$%\^&*\\(\\)=\+ {}]\{1,1024}"/hs=s+1,he=e-1 skipwhite skipempty skipnl 

hi link nftablesInclude nftablesHL_Include
syn match nftablesInclude /\s*include/ 
\ nextgroup=nftables_E_Filespec_SC
\ skipwhite skipnl skipempty

hi link nftablesAction nftablesHL_Action
syn keyword nftablesAction contained skipwhite
\    accept
\    reject
\    drop

syn match nftables_Semicolon contained /;/ skipwhite

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

" Begin of 'table arp ...'
hi link nftablesTArpC_TypeKeyword nftablesHL_Statement
syn match nftablesTArpC_TypeKeyword contained /;\s*type/ skipwhite
\ nextgroup=
\    nftablesType_Filter,
\    nftablesType_Nat,
\    nftablesType_Route
syn match nftablesTArpC_TypeKeyword contained /^\s*type/ skipwhite
\ nextgroup=
\    nftablesType_Filter,
\    nftablesType_Nat,
\    nftablesType_Route
syn match nftablesTArpC_TypeKeyword contained /{\s*type/ skipwhite
\ nextgroup=
\    nftablesType_Filter,
\    nftablesType_Nat,
\    nftablesType_Route

hi link nftablesCounterKeyword nftablesHL_Option
syn keyword nftablesCounterKeyword contained counter skipwhite

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
\    nftablesPolicyKeyword,
\    nftablesCounterKeyword,
\    nftablesLogKeyword,
\    nftablesIifnameKeyword,
\    nftablesIifnameKeyword,
\    nftablesOifnameKeyword,
\    nftablesFibKeyword,
\    nftablesMeterKeyword,
\    nftablesComment,
\    nftablesInclude


hi link nftablesTArpChain_Name nftablesHL_Chain
syn match nftablesTArpChain_Name contained /[A-Za-z0-9\_]\{1,64}/ skipwhite
\ nextgroup=
\    nftablesTArpChain_Section

hi link nftablesTArpChainKeyword nftablesHL_Option
syn keyword nftablesTArpChainKeyword contained chain skipwhite skipempty
\ nextgroup=nftablesTArpChain_Name

syn region nftablesTArp_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesTArpChainKeyword

hi link nftablesTArp_Name nftablesHL_Identifier
syn match nftablesTArp_Name contained /[A-Za-z0-9\_]\{1,64}/ skipwhite
\ nextgroup=
\    nftablesTArp_Section

hi link nftablesTableFamily_Arp nftablesHL_Family
syn keyword nftablesTableFamily_Arp contained arp skipwhite
\ nextgroup=nftablesTArp_Name
" End of 'table arp ...'


" Begin of 'create table ...'
hi link nftablesCmdCreateAddTable_FlagValue nftablesHL_Type
syn keyword nftablesCmdCreateAddTable_FlagValue contained dormant skipwhite

hi link nftablesCmdCreateAddTable_Flags nftablesHL_Option
syn keyword nftablesCmdCreateAddTable_Flags contained flags skipwhite
\ nextgroup=nftablesCmdCreateAddTable_FlagValue

syn region nftablesCmdCreateTable_Section contained start=/{/ end=/}/ skipwhite
\ contains=nftablesCmdCreateAddTable_Flags

hi link nftablesCmdCreateTable_Name nftablesHL_Table
syn match nftablesCmdCreateTable_Name contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdCreateTable_Section

hi link nftablesCmdCreateTableFamily nftablesHL_Family
syn keyword nftablesCmdCreateTableFamily contained skipwhite
\    netdev
\    arp
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdCreateTable_Name

hi link nftablesCmdCreateTableKeyword nftablesHL_Statement
syn keyword nftablesCmdCreateTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdCreateTableFamily,
\    nftablesCmdCreateTable_Name
" End of 'create table ...'

" Begin of 'add table'
hi link nftablesCmdAddTableName nftablesHL_Table
syn match nftablesCmdAddTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdCreateTable_Section


hi link nftablesCmdAddTableFamily nftablesHL_Family
syn keyword nftablesCmdAddTableFamily contained skipwhite
\    netdev
\    arp
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddTableName

hi link nftablesCmdAddTable nftablesHL_Option
syn keyword nftablesCmdAddTable contained table skipwhite
\ nextgroup=
\    nftablesCmdAddTableFamily,
\    nftablesCmdAddTableName
" End of 'add table ...'

" Begin of 'add chain ...'
" Begin of 'add chain arp <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainArp_Priority nftablesHL_Number
syn match nftablesCmdAddChainArp_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainArp_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainArp_Priority

hi link nftablesCmdAddChainArp_Device  nftablesHL_String
syn match nftablesCmdAddChainArp_Device contained /\S\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainArp_PriorityKeyword

hi link nftablesCmdAddChainArp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainArp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainArp_Device

hi link nftablesCmdAddChainArp_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainArp_Hook contained skipwhite
\    input
\    output
\ nextgroup=
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

syn region nftablesCmdAddChainArp_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainArp_TypeKeyword,
\    nftables_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainArp_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainArp_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainArp_Section

hi link nftablesCmdAddChainArp_TableName nftablesHL_Table
syn match nftablesCmdAddChainArp_TableName contained /\S\{1,64}/ skipwhite
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

hi link nftablesCmdAddChainBridge_Device  nftablesHL_String
syn match nftablesCmdAddChainBridge_Device contained /\S\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainBridge_PriorityKeyword

hi link nftablesCmdAddChainBridge_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainBridge_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Device

hi link nftablesCmdAddChainBridge_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainBridge_Hook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
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

syn region nftablesCmdAddChainBridge_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainBridge_TypeKeyword,
\    nftables_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainBridge_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainBridge_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainBridge_Section

hi link nftablesCmdAddChainBridge_TableName nftablesHL_Table
syn match nftablesCmdAddChainBridge_TableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainBridge_ChainName
" End of 'add chain bridge <table_name> <chain_name> { ... }

" Begin of 'add chain netdev <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainNetdev_Priority nftablesHL_Number
syn match nftablesCmdAddChainNetdev_Priority contained /[\-]\?\d\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainNetdev_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Priority

hi link nftablesCmdAddChainNetdev_Device  nftablesHL_String
syn match nftablesCmdAddChainNetdev_Device contained /\S\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_PriorityKeyword

hi link nftablesCmdAddChainNetdev_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Device

hi link nftablesCmdAddChainNetdev_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainNetdev_Hook contained skipwhite
\    ingress
\ nextgroup=nftablesCmdAddChainNetdev_DeviceKeyword

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

syn region nftablesCmdAddChainNetdev_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainNetdev_TypeKeyword,
\    nftables_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainNetdev_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainNetdev_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Section

hi link nftablesCmdAddChainNetdev_TableName nftablesHL_Table
syn match nftablesCmdAddChainNetdev_TableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_ChainName
" End of 'add chain netdev <table_name> <chain_name> { ... }

" Begin of 'add chain ip <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainIp_Priority nftablesHL_Number
syn match nftablesCmdAddChainIp_Priority contained /[\-]\?\d\{1,5}/

hi link nftablesCmdAddChainIp_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainIp_Priority

hi link nftablesCmdAddChainIp_Device nftablesHL_String
syn match nftablesCmdAddChainIp_Device contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_PriorityKeyword

hi link nftablesCmdAddChainIp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp_Device

hi link nftablesCmdAddChainIp_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_Hook contained skipwhite
\    prerouting
\    input
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftablesCmdAddChainIp_PriorityKeyword

hi link nftablesCmdAddChainIp_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainIp_Hook

hi link nftablesCmdAddChainIp_Type nftablesHL_Type
syn keyword nftablesCmdAddChainIp_Type contained skipwhite
\    filter
\    nat
\    route
\ nextgroup=nftablesCmdAddChainIp_HookKeyword

hi link nftablesCmdAddChainIp_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainIp_Type

syn region nftablesCmdAddChainIp_Section contained start=/{/ end=/}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon
\ contains=
\    nftablesCmdAddChainIp_TypeKeyword,
\    nftables_PolicyKeyword

hi link nftablesCmdAddChainIp_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainIp_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_Section

hi link nftablesCmdAddChainIp_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp_TableName contained /\S\{1,64}/ skipwhite
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
syn match nftablesCmdAddChainIp6_Device contained /\S\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp6_PriorityKeyword

hi link nftablesCmdAddChainIp6_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Device

hi link nftablesCmdAddChainIp6_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_FilterHook contained skipwhite
\    all
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftablesCmdAddChainIp6_PriorityKeyword 

hi link nftablesCmdAddChainIp6_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp6_DeviceKeyword,
\    nftablesCmdAddChainIp6_PriorityKeyword 

hi link nftablesCmdAddChainIp6_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_RouteHook contained skipwhite
\    output
\ nextgroup=
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

syn region nftablesCmdAddChainIp6_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainIp6_TypeKeyword,
\    nftables_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainIp6_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainIp6_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Section

hi link nftablesCmdAddChainIp6_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp6_TableName contained /\S\{1,64}/ skipwhite
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
syn match nftablesCmdAddChainInet_Device contained /\S\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainInet_PriorityKeyword

hi link nftablesCmdAddChainInet_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainInet_Device

hi link nftablesCmdAddChainInet_Hook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_Hook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_HookKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainInet_Hook

hi link nftablesCmdAddChainInet_Type nftablesHL_Type
syn keyword nftablesCmdAddChainInet_Type contained skipwhite
\    filter
\    nat
\    route
\ nextgroup=nftablesCmdAddChainInet_HookKeyword nftablesHL_Option

hi link nftablesCmdAddChainInet_TypeKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainInet_Type

syn region nftablesCmdAddChainInet_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainInet_TypeKeyword,
\    nftables_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainInet_ChainName nftablesHL_Chain
syn match nftablesCmdAddChainInet_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainInet_Section

hi link nftablesCmdAddChainInet_TableName nftablesHL_Table
syn match nftablesCmdAddChainInet_TableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainInet_ChainName
" End of 'add chain inet <table_name>...' 

" Begin of 'add chain <family> <table_name>...' 
hi link nftablesCmdAddChainFamily nftablesHL_Family
syn keyword nftablesCmdAddChainFamily contained skipwhite
\    netdev
\ nextgroup=nftablesCmdAddChainNetdev_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    arp
\ nextgroup=nftablesCmdAddChainArp_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    bridge
\ nextgroup=nftablesCmdAddChainBridge_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    ip
\ nextgroup=nftablesCmdAddChainIp_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    ip6
\ nextgroup=nftablesCmdAddChainIp6_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    inet
\ nextgroup=nftablesCmdAddChainInet_TableName
" End of 'add chain <family> <table_name>...' 

hi link nftablesCmdAddChainKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdAddChainFamily,
\    nftablesCmdAddChainIp_TableName
" Defaults to 'ip' family, if no family is given
"
" End of 'add chain ...'

hi link nftablesCmdAddSetElementName nftablesHL_String
syn match nftablesCmdAddSetElementName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdAddSetElementTableName nftablesHL_Table
syn match nftablesCmdAddSetElementTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddSetElementName

hi link nftablesCmdAddSetElement nftablesHL_Statement
syn keyword nftablesCmdAddSetElement contained skipwhite
\    set
\    element
\ nextgroup=nftablesCmdAddSetElementTableName  nftablesHL_Identifier

hi link nftablesCmdAddMapTableName nftablesHL_Table
syn match nftablesCmdAddMapTableName contained /\S\{1,64}/ skipwhite


hi link nftablesCmdAddMap nftablesHL_Statement
syn keyword nftablesCmdAddMap contained map skipwhite
\ nextgroup=nftablesCmdAddMapTableName
" End of 'add map ...'
"
" Begin of 'delete table ...'
hi link nftablesCmdDeleteTable_Handle nftablesHL_String
syn match nftablesCmdDeleteTable_Handle contained /\S\{1,64}/ skipwhite

hi link nftablesCmdDeleteTableHandleKeyword nftablesHL_Statement
syn keyword nftablesCmdDeleteTableHandleKeyword contained skipwhite
\    handle
\ nextgroup=nftablesCmdDeleteTable_Handle

hi link nftablesCmdDeleteTable_Name nftablesHL_Table
syn match nftablesCmdDeleteTable_Name contained /\S\{1,64}/ skipwhite

hi link nftablesCmdDeleteTable_Family nftablesHL_Family
syn keyword nftablesCmdDeleteTable_Family contained skipwhite
\    arp
\    bridge
\    netdev
\    ip
\    ip6
\    inet
\ nextgroup=
\    nftablesCmdDeleteTableHandleKeyword,
\    nftablesCmdDeleteTable_Name

hi link nftablesCmdDeleteTableKeyword nftablesHL_Option
syn keyword nftablesCmdDeleteTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdDeleteTable_Name,
\    nftablesCmdDeleteTable_Family,
\    nftablesCmdDeleteTableHandleKeyword
" End of 'delete table ...'

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
\    arp
\    netdev
\    bridge
\    inet
\    ip
\    ip6

hi link nftablesCmdFlushRulesetKeyword nftablesHL_Option
syn keyword nftablesCmdFlushRulesetKeyword contained ruleset skipwhite
\ nextgroup=nftablesCmdFlushRulesetFamilies
" End of 'flush ruleset ...'

" Begin of 'flush table ...'
hi link nftablesCmdFlushTableName nftablesHL_Table
syn match nftablesCmdFlushTableName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdFlushTableFamily nftablesHL_Family
syn keyword nftablesCmdFlushTableFamily contained skipwhite
\    arp
\    netdev
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdFlushTableName 

hi link nftablesCmdFlushTableKeyword nftablesHL_Option
syn keyword nftablesCmdFlushTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdFlushTableFamily,
\    nftablesCmdFlushTableName
" End of 'flush table ...'

" Begin of 'flush chain ...'

hi link nftablesCmdFlushChain_ChainName nftablesHL_Chain
syn match nftablesCmdFlushChain_ChainName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdFlushChain_Handle nftablesHL_Identifier
syn match nftablesCmdFlushChain_Handle contained /\S\{1,64}/ skipwhite

hi link nftablesCmdFlushChain_HandleKeyword nftablesHL_Option
syn keyword nftablesCmdFlushChain_HandleKeyword contained handle skipwhite
\ nextgroup=nftablesCmdFlushChain_Handle

hi link nftablesCmdFlushChainTableName nftablesHL_Table
syn match nftablesCmdFlushChainTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=
\    nftablesCmdFlushChain_HandleKeyword,
\    nftablesCmdFlushChain_ChainName

hi link nftablesCmdFlushChainFamily nftablesHL_Family
syn keyword nftablesCmdFlushChainFamily contained skipwhite
\    arp
\    bridge
\    netdev
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdFlushChainTableName

hi link nftablesCmdFlushChainKeyword nftablesHL_Option
syn keyword nftablesCmdFlushChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdFlushChainFamily,
\    nftablesCmdFlushChainTableName
" End of 'flush chain ...'

hi link nftablesCmdListNoArg nftablesHL_Option
syn keyword nftablesCmdListNoArg contained skipwhite
\    tables
\    chains
\    sets

hi link nftablesCmdListRulesetFamily nftablesHL_Family
syn keyword nftablesCmdListRulesetFamily contained skipwhite
\    arp
\    bridge
\    netdev
\    ip
\    ip6
\    inet

" list ruleset [family]
hi link nftablesCmdListRuleset nftablesHL_Option
syn keyword nftablesCmdListRuleset contained ruleset skipwhite
\ nextgroup=nftablesCmdListRulesetFamily

hi link nftablesCmdListTable_Name nftablesHL_Table
syn match nftablesCmdListTable_Name contained /\S\{1,64}/ skipwhite

hi link nftablesCmdListTable_Family nftablesHL_Family
syn keyword nftablesCmdListTable_Family contained skipwhite
\    arp
\    netdev
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdListTable_Name 

hi link nftablesCmdListTableKeyword nftablesHL_Option
syn keyword nftablesCmdListTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdListTable_Name,
\    nftablesCmdListTable_Family
    
hi link nftablesCmdListSetName nftablesHL_String
syn match nftablesCmdListSetName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdListSetTableName nftablesHL_Table
syn match nftablesCmdListSetTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdListSetName 

hi link nftablesCmdListSetKeyword nftablesHL_Statement
syn keyword nftablesCmdListSetKeyword contained set skipwhite
\ nextgroup=nftablesCmdListSetTableName

" Start of 'rename [family] <table_name> <chain_name> <new_chain_name>
hi link nftablesCmdRenameChain_ChainName nftablesHL_Chain
syn match nftablesCmdRenameChain_ChainName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdRenameChain_TableName nftablesHL_Table
syn match nftablesCmdRenameChain_TableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdRenameChain_ChainName

hi link nftablesCmdRenameChain_Family nftablesHL_Family
syn keyword nftablesCmdRenameChain_Family contained skipwhite
\    arp
\    bridge
\    netdev
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

""""""""""""""""""""""""""""""""""""""
" Uncontained (free-floating) patterns
""""""""""""""""""""""""""""""""""""""

hi link nftablesCmdAddKeyword nftablesHL_Statement
syn keyword nftablesCmdAddKeyword add skipwhite skipempty 
\ nextgroup=
\    nftablesCmdAddTable,
\    nftablesCmdAddChainKeyword,
\    nftablesCmdAddSetElement,
\    nftablesCmdAddMap

hi link nftablesCmdCreateTable nftablesHL_Statement
syn keyword nftablesCmdCreateTable skipwhite create skipempty 
\ nextgroup=
\    nftablesCmdCreateTableKeyword,
\    nftablesCmdAddChainKeyword,

hi link nftablesCmdDeleteTable nftablesHL_Statement
syn keyword nftablesCmdDeleteTable skipwhite delete skipempty 
\ nextgroup=
\    nftablesCmdDeleteTableKeyword,
\    nftablesCmdFlushChainKeyword

hi link nftablesCmdExportKeyword nftablesHL_Statement
syn keyword nftablesCmdExportKeyword export skipwhite 
\ nextgroup=
\    nftablesCmdExportRulesetKeyword,
\    nftablesCmdExport_Format

hi link nftablesCmdFlushKeyword nftablesHL_Statement
syn keyword nftablesCmdFlushKeyword flush skipwhite
\ nextgroup=
\    nftablesCmdFlushRulesetKeyword,
\    nftablesCmdFlushTableKeyword,
\    nftablesCmdFlushChainKeyword

hi link nftablesCmdListKeyword nftablesHL_Statement
syn keyword nftablesCmdListKeyword list skipwhite
\ nextgroup=
\    nftablesCmdListTableKeyword,
\    nftablesCmdFlushChainKeyword
" \    nftablesCmdListSetKeyword,
" \    nftablesCmdListRuleset,
" \    nftablesCmdListNoArg,

hi link nftablesCmdRenameKeyword nftablesHL_Statement
syn keyword nftablesCmdRenameKeyword rename skipwhite
\ nextgroup=
\    nftablesCmdRenameChainKeyword

" Start of 'define <var_name> = <var_value>'
hi link nftablesDefine_Value nftablesHL_String
syn match nftablesDefine_Value contained /\S\{1,256}/ skipwhite

hi link nftablesOp_Equal nftablesHL_Operator
syn match nftablesOp_Equal contained /=/ skipwhite
\ nextgroup=nftablesDefine_Value

hi link nftablesDefine_Identifier nftablesHL_Identifier
syn match nftablesDefine_Identifier contained /\i\{1,64}/ skipwhite
\ nextgroup=nftablesOp_Equal
" End of 'define <var_name> = <var_value>'

" Begin of Command-less actions

" Start of '$<variable_name>'
hi link nftablesVariableName Type
syn match nftablesVariableName /\$\S\{1,64}/ skipwhite
" End of '$<variable_name>'

" Begin of Command-less actions: define
hi link nftablesDefineKeyword nftablesHL_Statement
syn match nftablesDefineKeyword /^\s*define/ skipwhite skipempty
\ nextgroup=nftablesDefine_Identifier
" End of Command-less actions: define

" Begin of Command-less actions: table
hi link nftablesTableKeyword nftablesHL_Statement
syn match nftablesTableKeyword /^\s*table/ skipwhite skipempty
\ nextgroup=
\    nftablesTableFamily_Arp,
\    nftablesTableFamily_Bridge,
\    nftablesTableFamily_Netdev,
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

