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
setlocal iskeyword=.,48-58,A-Z,a-z,\_,\/
setlocal isident=.,48-58,A-Z,a-z,\_,\/

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
hi link nftablesHL_Statement   Keyword
hi link nftablesHL_Option      Label     " could use a 2nd color here
hi link nftablesHL_Type        Type
hi link nftablesHL_Operator    Operator    " was Operator  
hi link nftablesHL_Underlined  Underlined
hi link nftablesHL_Error       Error

hi link nftablesHL_Family      Underlined   " doesn't work, stuck on dark cyan
hi link nftablesHL_Type        Type
hi link nftablesHL_Hook        Type    
hi link nftablesHL_Action      Special
hi link nftablesHL_Table       Identifier
hi link nftablesHL_Chain       Identifier
hi link nftablesHL_Map         Identifier
hi link nftablesHL_Set         Identifier
hi link nftablesHL_Element     Identifier
hi link nftablesHL_Handle      Identifier
hi link nftablesHL_Flowtable   Identifier

hi link nftables_ToDo nftablesHL_ToDo
syn keyword nftables_ToDo xxx contained XXX FIXME TODO TODO: FIXME: skipwhite

hi link nftables_Comment nftablesHL_Comment
syn region nftables_Comment start=/#/ end=/$/ contains=nftables_ToDo skipwhite

hi link nftables_EOS nftablesHL_Error
syn match nftables_EOS contained /[^ \t]*[^\n;# ]/ 

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
hi link nftables_Error nftablesHL_Error
syn match nftables_Error /[ \ta-zA-Z0-9_./]\{1,64}/

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

hi link nftablesAction nftablesHL_Action
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

" Begin of 'table arp ...'
hi link nftablesTArpC_Policy nftablesHL_Type
syn keyword nftablesTArpC_Policy contained skipwhite
\    accept
\    drop
\ nextgroup=nftables_Semicolon,nftables_EOS

hi link nftablesTArpC_PolicyKeyword nftablesHL_Statement
syn keyword nftablesTArpC_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesTArpC_Policy

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

syn region nftablesTArpChain_Section contained start=/{/ end=/}/ 
\ contains=
\    nftablesTArpC_TypeKeyword,
\    nftablesTArpC_PolicyKeyword,
\    nftablesCounterKeyword,
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,63}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

syn region nftablesCmdCreateTable_Section contained start=/{/ end=/}/ 
\ skipwhite
\ contains=
\    nftablesCmdCreateAddTable_Flags,
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdCreateTable_Name nftablesHL_Table
syn match nftablesCmdCreateTable_Name contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdCreateTable_Section,
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdCreateTable_Family nftablesHL_Family
syn keyword nftablesCmdCreateTable_Family contained skipwhite
\    netdev
\    bridge
\    arp
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdCreateTable_Name

hi link nftablesCmdCreate_TableKeyword nftablesHL_Statement
syn keyword nftablesCmdCreate_TableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdCreateTable_Family,
\    nftablesCmdCreateTable_Name
" End of 'create table ...'

" Begin of 'add table'
"   Performed by nftablesCmdCreate_TableKeyword
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
syn match nftablesCmdAddChainArp_Device contained /[A-Za-z0-9_./\-]\{1,256}/ skipwhite
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

hi link nftablesCmdAddChainArp_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainArp_Section,
\    nftables_EOS

hi link nftablesCmdAddChainArp_TableName nftablesHL_Table
syn match nftablesCmdAddChainArp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
syn match nftablesCmdAddChainBridge_Device contained /[A-Za-z0-9_.\-%]\{1,256}/ skipwhite
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

hi link nftablesCmdAddChainBridge_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainBridge_Section,
\    nftables_EOS

hi link nftablesCmdAddChainBridge_TableName nftablesHL_Table
syn match nftablesCmdAddChainBridge_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddChainBridge_ChainName
" End of 'add chain bridge <table_name> <chain_name> { ... }

" Begin of 'add chain netdev <table_name> <chain_name> { ... }
hi link nftablesCmdAddChainNetdev_Priority nftablesHL_Number
syn match nftablesCmdAddChainNetdev_Priority contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainNetdev_PriorityKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainNetdev_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainNetdev_Priority

hi link nftablesCmdAddChainNetdev_Device  nftablesHL_String
syn match nftablesCmdAddChainNetdev_Device contained /[A-Za-z0-9_.\-%]\{1,256}/ skipwhite
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

hi link nftablesCmdAddChainNetdev_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainNetdev_Section,
\    nftables_EOS

hi link nftablesCmdAddChainNetdev_TableName nftablesHL_Table
syn match nftablesCmdAddChainNetdev_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
syn match nftablesCmdAddChainIp_Device contained /[A-Za-z0-9_.\-%]\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_PriorityKeyword

hi link nftablesCmdAddChainIp_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp_Device

hi link nftablesCmdAddChainIp_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftablesCmdAddChainIp_PriorityKeyword 

hi link nftablesCmdAddChainIp_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainIp_DeviceKeyword,
\    nftablesCmdAddChainIp_PriorityKeyword 

hi link nftablesCmdAddChainIp_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp_RouteHook contained skipwhite
\    output
\ nextgroup=
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

hi link nftablesCmdAddChainIp_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainIp_Section,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddChainIp_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
syn match nftablesCmdAddChainIp6_Device contained /[A-Za-z0-9_.\-%]\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp6_PriorityKeyword

hi link nftablesCmdAddChainIp6_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainIp6_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainIp6_Device

hi link nftablesCmdAddChainIp6_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainIp6_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
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

hi link nftablesCmdAddChainIp6_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainIp6_Section,
\    nftables_EOS

hi link nftablesCmdAddChainIp6_TableName nftablesHL_Table
syn match nftablesCmdAddChainIp6_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
syn match nftablesCmdAddChainInet_Device contained /[A-Za-z0-9_.\-%]\{1,256}/ skipwhite
\ nextgroup=nftablesCmdAddChainInet_PriorityKeyword

hi link nftablesCmdAddChainInet_DeviceKeyword nftablesHL_Option
syn keyword nftablesCmdAddChainInet_DeviceKeyword contained device skipwhite
\ nextgroup=nftablesCmdAddChainInet_Device

hi link nftablesCmdAddChainInet_FilterHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_FilterHook contained skipwhite
\    prerouting
\    input
\    forward
\    output
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_NatHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_NatHook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=
\    nftablesCmdAddChainInet_DeviceKeyword,
\    nftablesCmdAddChainInet_PriorityKeyword 

hi link nftablesCmdAddChainInet_RouteHook nftablesHL_Hook
syn keyword nftablesCmdAddChainInet_RouteHook contained skipwhite
\    output
\ nextgroup=
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

hi link nftablesCmdAddChainInet_Policy nftablesHL_Action
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddChainInet_Section,
\    nftables_EOS

hi link nftablesCmdAddChainInet_TableName nftablesHL_Table
syn match nftablesCmdAddChainInet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

hi link nftablesCmdAdd_ChainKeyword nftablesHL_Option
syn keyword nftablesCmdAdd_ChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdAddChainFamily,
\    nftablesCmdAddChainIp_TableName
" Defaults to 'ip' family, if no family is given
"
" End of 'add chain ...'

" Begin of 'add set [<family>] <table_id> <set_id>'
hi link nftablesAddSet_Type nftablesHL_Type
syn keyword nftablesAddSet_Type contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_TypeKeyword nftablesHL_Statement
syn keyword nftablesAddSet_TypeKeyword contained type skipwhite
\ nextgroup=nftablesAddSet_Type

hi link nftablesAddSet_Flags nftablesHL_Type
syn keyword nftablesAddSet_Flags contained skipwhite
\    constant
\    interval
\    timeout
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_FlagsKeyword nftablesHL_Statement
syn keyword nftablesAddSet_FlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesAddSet_Flags

hi link nftablesAddSet_Timeout nftablesHL_Type
syn match nftablesAddSet_Timeout contained /\d\{1,11}[HhDdMmSs]\?/
\ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_TimeoutKeyword nftablesHL_Statement
syn keyword nftablesAddSet_TimeoutKeyword contained timeout skipwhite
\ nextgroup=nftablesAddSet_Timeout

hi link nftablesAddSet_GcInterval nftablesHL_Type
syn match nftablesAddSet_GcInterval contained /\d\{1,11}[DdHhMmSs]\?/
\ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddSet_GcIntervalKeyword nftablesHL_String
syn keyword nftablesAddSet_GcIntervalKeyword contained gc-interval skipwhite
\ nextgroup=
\    nftablesAddSet_GcInterval,
\    nftables_EOS

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

hi link nftablesAddSet_Size nftablesHL_Type
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddSet_Section,
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdAddSet_TableName nftablesHL_Table
syn match nftablesCmdAddSet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftablesCmdAddElement_Section

hi link nftablesCmdAddElement_TableName nftablesHL_Table
syn match nftablesCmdAddElement_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[a-zA-Z0-9\-_]\{1,64}/
\ nextgroup=
\    nftablesAddFTDev_Separator

" TODO Why does a space first device and first comma separate causes error here?
hi link nftablesAddFTDev_Separator nftablesHL_Operator
syn match nftablesAddFTDev_Separator contained /,/ skipwhite
\ nextgroup=
\    nftablesAddFTDev_DeviceNth,
\    nftables_Error

hi link nftablesAddFTDev_Device nftablesHL_String
syn match nftablesAddFTDev_Device contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddFT_Section

hi link nftablesCmdAddFT_TableName nftablesHL_Table
syn match nftablesCmdAddFT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

" Begin 'add map ...'
hi link nftablesAddMap_Type nftablesHL_Type
syn keyword nftablesAddMap_Type contained skipwhite
\    ipv4_addr
\    ipv6_addr
\    ether_addr
\    inet_proto
\    inet_service
\    mark
\    counter
\    quota
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddMap_TypeKeyword nftablesHL_Statement
syn keyword nftablesAddMap_TypeKeyword contained type skipwhite
\ nextgroup=nftablesAddMap_Type

hi link nftablesAddMap_Flags nftablesHL_Type
syn keyword nftablesAddMap_Flags contained skipwhite
\    constant
\    interval
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddMap_FlagsKeyword nftablesHL_Statement
syn keyword nftablesAddMap_FlagsKeyword contained flags skipwhite
\ nextgroup=
\    nftablesAddMap_Flags

hi link nftablesAddMap_TimeoutKeyword nftablesHL_Statement
syn keyword nftablesAddMap_TimeoutKeyword contained timeout skipwhite
\ nextgroup=nftablesAddMap_Timeout

hi link nftablesAddMapElements_ElementNth nftablesHL_Type
syn match nftablesAddMapElements_ElementNth contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/
\ nextgroup=
\    nftablesAddMapElements_Separator

hi link nftablesAddMapElements_Separator nftablesHL_Operator
syn match nftablesAddMapElements_Separator contained /,/ skipwhite
\ nextgroup=
\    nftablesAddMapElements_ElementNth,
\    nftables_Error

hi link nftablesAddMapElements_Element nftablesHL_Type
syn match nftablesAddMapElements_Element contained skipwhite
\    /[a-zA-Z0-9\-_]\{1,64}/
\ nextgroup=nftablesAddMapElements_Separator

syn region nftablesAddMap_ElementsSection contained start=/=/ end=/;/ skipwhite
\ contains=nftablesAddMapElements_Element
\ nextgroup=
\    nftables_Semicolon

hi link nftablesAddMap_ElementsKeyword nftablesHL_Statement
syn keyword nftablesAddMap_ElementsKeyword contained elements skipwhite
\ nextgroup=
\    nftablesAddMap_ElementsSection

hi link nftablesAddMap_Size nftablesHL_Type
syn match nftablesAddMap_Size contained /\d\{1,11}/ skipwhite
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddMap_SizeKeyword nftablesHL_Statement
syn keyword nftablesAddMap_SizeKeyword contained size skipwhite
\ nextgroup=
\    nftablesAddMap_Size

hi link nftablesAddMap_Policy nftablesHL_Type
syn keyword nftablesAddMap_Policy contained skipwhite
\    performance
\    memory
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesAddMap_PolicyKeyword nftablesHL_Statement
syn keyword nftablesAddMap_PolicyKeyword contained policy skipwhite
\ nextgroup=
\    nftablesAddMap_Policy

syn region nftablesCmdAddMap_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesAddMap_TypeKeyword,
\    nftablesAddMap_FlagsKeyword,
\    nftablesAddMap_ElementsKeyword,
\    nftablesAddMap_SizeKeyword,
\    nftablesAddMap_PolicyKeyword,
\    nftables_Comment
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdAddMap_MapName nftablesHL_Map
syn match nftablesCmdAddMap_MapName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddMap_Section

hi link nftablesCmdAddMap_TableName nftablesHL_Table
syn match nftablesCmdAddMap_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
"
" Begin 'add type ...'
hi link nftablesCmdAddType_TypeName nftablesHL_Type
syn match nftablesCmdAddType_TypeName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesCmdAddType_Section

hi link nftablesCmdAddType_TableName nftablesHL_Table
syn match nftablesCmdAddType_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

" Begin of 'delete chain ...'
hi link nftablesCmdDeleteChain_ChainName nftablesHL_Chain
syn match nftablesCmdDeleteChain_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_Comment,
\    nftables_EOS

hi link nftablesCmdDeleteFT_TableName nftablesHL_Table
syn match nftablesCmdDeleteFT_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
" End of 'flush chain ...'

hi link nftablesCmdList_NoArg nftablesHL_Option
syn keyword nftablesCmdList_NoArg contained skipwhite
\    tables
\    chains
\    sets
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

" Begin of 'list map [<family>] <table_name> <map>' 
hi link nftablesCmdList_MapName nftablesHL_Map
syn match nftablesCmdList_MapName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdListMap_TableName nftablesHL_Table
syn match nftablesCmdListMap_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdListSet_TableName nftablesHL_Table
syn match nftablesCmdListSet_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

hi link nftablesCmdListTableKeyword nftablesHL_Option
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
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=
\    nftables_Semicolon,
\    nftables_EOS

hi link nftablesCmdRenameChain_ChainName nftablesHL_Chain
syn match nftablesCmdRenameChain_ChainName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesCmdRenameChain_NewChain

hi link nftablesCmdRenameChain_TableName nftablesHL_Table
syn match nftablesCmdRenameChain_TableName contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
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

""""""""""""""""""""""""""""""""""""""
" Base commands
" Uncontained (free-floating) patterns
""""""""""""""""""""""""""""""""""""""
hi link nftablesCmdAddKeyword nftablesHL_Statement
syn keyword nftablesCmdAddKeyword add skipwhite skipempty 
\ nextgroup=
\    nftablesCmdCreate_TableKeyword,
\    nftablesCmdAdd_ChainKeyword,
\    nftablesCmdAdd_SetKeyword,
\    nftablesCmdAdd_ElementKeyword,
\    nftablesCmdAdd_MapKeyword,
\    nftablesCmdAdd_FlowtableKeyword,
\    nftablesCmdAdd_TypeKeyword

hi link nftablesCmd_Create nftablesHL_Statement
syn keyword nftablesCmd_Create skipwhite create skipempty 
\ nextgroup=
\    nftablesCmdCreate_TableKeyword,
\    nftablesCmdAdd_ChainKeyword,
\    nftablesCmdAdd_FlowtableKeyword

hi link nftablesCmd_Delete nftablesHL_Statement
syn keyword nftablesCmd_Delete skipwhite delete skipempty 
\ nextgroup=
\    nftablesCmdDelete_TableKeyword,
\    nftablesCmdDelete_ChainKeyword,
\    nftablesCmdDelete_SetKeyword,
\    nftablesCmdAdd_ElementKeyword,
\    nftablesCmdAdd_MapKeyword,
\    nftablesCmdDelete_FlowtableKeyword,
\    nftablesCmdDelete_TypeKeyword

hi link nftablesCmd_Describe nftablesHL_Statement
syn keyword nftablesCmd_Describe describe skipwhite 
\ nextgroup=
\    nftablesCmdDescribe_String,

hi link nftablesCmdExportKeyword nftablesHL_Statement
syn keyword nftablesCmdExportKeyword export skipwhite 
\ nextgroup=
\    nftablesCmdExportRulesetKeyword,
\    nftablesCmdExport_Format

hi link nftablesCmdFlushKeyword nftablesHL_Statement
syn keyword nftablesCmdFlushKeyword flush skipwhite
\ nextgroup=
\    nftablesCmdFlush_RulesetKeyword,
\    nftablesCmdFlush_TableKeyword,
\    nftablesCmdFlush_ChainKeyword,
\    nftablesCmdList_SetKeyword,
\    nftablesCmdList_MapKeyword,

hi link nftablesCmdGetKeyword nftablesHL_Statement
syn keyword nftablesCmdGetKeyword get skipwhite
\ nextgroup=
\    nftablesCmdGet_Keyword

hi link nftablesCmdImportKeyword nftablesHL_Statement
syn keyword nftablesCmdImportKeyword import skipwhite
\ nextgroup=
\    nftablesCmdImport_Keyword

hi link nftablesCmdInsertKeyword nftablesHL_Statement
syn keyword nftablesCmdInsertKeyword insert skipwhite
\ nextgroup=
\    nftablesCmdInsert_Keyword

hi link nftablesCmdListKeyword nftablesHL_Statement
syn keyword nftablesCmdListKeyword list skipwhite
\ nextgroup=
\    nftablesCmdList_NoArg,
\    nftablesCmdFlush_RulesetKeyword,
\    nftablesCmdListTableKeyword,
\    nftablesCmdFlush_ChainKeyword,
\    nftablesCmdList_SetKeyword,
\    nftablesCmdList_MapKeyword,
\    nftablesCmdDelete_FlowtableKeyword,
\    nftablesCmdAdd_TypeKeyword,
\    nftables_UnexpectedEOS

hi link nftablesCmdMonitorKeyword nftablesHL_Statement
syn keyword nftablesCmdMonitorKeyword monitor skipwhite
\ nextgroup=
\    nftablesCmdMonitor_Action,
\    nftablesCmdMonitor_Object,
\    nftables_EOS

hi link nftablesCmdRenameKeyword nftablesHL_Statement
syn keyword nftablesCmdRenameKeyword rename skipwhite
\ nextgroup=
\    nftablesCmdRenameChainKeyword

hi link nftablesCmdReplaceKeyword nftablesHL_Statement
syn keyword nftablesCmdReplaceKeyword replace skipwhite
\ nextgroup=
\    nftablesCmdReplace_Keyword

hi link nftablesCmdResetKeyword nftablesHL_Statement
syn keyword nftablesCmdResetKeyword reset skipwhite
\ nextgroup=
\    nftablesCmdAdd_TypeKeyword
" End of base commands

" Start of 'define <var_name> = <var_value>'
hi link nftablesDefine_Value nftablesHL_String
syn match nftablesDefine_Value contained /[A-Za-z0-9_./]\{1,256}/ skipwhite

hi link nftablesOp_Equal nftablesHL_Operator
syn match nftablesOp_Equal contained /=/ skipwhite
\ nextgroup=nftablesDefine_Value

hi link nftablesDefine_Identifier nftablesHL_Identifier
syn match nftablesDefine_Identifier contained skipwhite
\    /[A-Za-z][A-Za-z0-9_./]\{0,64}/ 
\ nextgroup=nftablesOp_Equal
" End of 'define <var_name> = <var_value>'

" Begin of Command-less actions

" Start of '$<variable_name>'
hi link nftablesVariableName Type
syn match nftablesVariableName skipwhite
\    /\$[A-Za-z][A-Za-z0-9\/]\{0,64}/ 
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

