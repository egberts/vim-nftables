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
hi link nftablesHL_Statement   Keyword
hi link nftablesHL_StatementL2 Label     " could use a 2nd color here
hi link nftablesHL_Type        Type
hi link nftablesHL_Operator    Operator  
hi link nftablesHL_Number      Number
hi link nftablesHL_String      String
hi link nftablesHL_Builtin     Special   " doesn't work, stuck on dark cyan
hi link nftablesHL_Underlined  Underlined
hi link nftablesHL_Error       Error

hi link nftables_ToDo nftablesHL_ToDo
syn keyword nftables_ToDo xxx contained XXX FIXME TODO TODO: FIXME:

hi link nftablesComment nftablesHL_Comment
syn region nftablesComment start=/#/ end=/$/ contains=nftables_ToDo



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

hi link nftablesAction nftablesHL_Builtin
syn keyword nftablesAction contained skipwhite
\    accept
\    reject
\    drop

syn match nftables_Semicolon contained /;/ skipwhite

"#################################################
"
hi link nftablesPriority_Value nftablesHL_Number
syn match nftablesPriority_Value contained /\-\{0,1}\d\{1,5}/ skipwhite
\ nextgroup=nftables_Semicolon
"
hi link nftablesPriorityKeyword nftablesHL_Statement
syn keyword nftablesPriorityKeyword contained priority skipwhite
\ nextgroup=nftablesPriority_Value

hi link nftablesHook_IpType nftablesHL_Type
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
hi link nftablesType_Filter nftablesHL_Builtin
syn keyword nftablesType_Filter contained filter skipwhite
\ nextgroup=nftablesHookKeyword

hi link nftablesType_Nat nftablesHL_Builtin
syn keyword nftablesType_Nat contained nat skipwhite
\ nextgroup=nftablesHookKeyword

hi link nftablesType_Route nftablesHL_Builtin
syn keyword nftablesType_Route contained route skipwhite
\ nextgroup=nftablesHookKeyword

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

hi link nftablesPolicy_Value nftablesHL_Builtin
syn keyword nftablesPolicy_Value contained skipwhite
\    accept
\    reject
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesPolicyKeyword nftablesHL_StatementL2
syn keyword nftablesPolicyKeyword contained policy skipwhite
\ nextgroup=nftablesPolicy_Value

hi link nftablesCounterKeyword nftablesHL_StatementL2
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

hi link nftablesLogKeyword nftablesHL_StatementL2
syn keyword nftablesLogKeyword contained log skipwhite
\ nextgroup=
\    nftablesLogPrefixKeyword,
\    nftablesLogLevelKeyword,
\    nftablesLogFlagsKeyword,
\    nftablesAction

hi link nftablesIifnameKeyword nftablesHL_StatementL2
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


hi link nftablesTArpChain_Name nftablesHL_Identifier
syn match nftablesTArpChain_Name contained /[A-Za-z0-9\_]\{1,64}/ skipwhite
\ nextgroup=
\    nftablesTArpChain_Section

hi link nftablesTArpChainKeyword nftablesHL_StatementL2
syn keyword nftablesTArpChainKeyword contained chain skipwhite skipempty
\ nextgroup=nftablesTArpChain_Name

syn region nftablesTArp_Section contained start=/{/ end=/}/ skipwhite
\ contains=
\    nftablesTArpChainKeyword

hi link nftablesTArp_Name nftablesHL_Identifier
syn match nftablesTArp_Name contained /[A-Za-z0-9\_]\{1,64}/ skipwhite
\ nextgroup=
\    nftablesTArp_Section

hi link nftablesTableFamily_Arp nftablesHL_Builtin
syn keyword nftablesTableFamily_Arp contained arp skipwhite
\ nextgroup=nftablesTArp_Name
" \    bridge
" \    netdev
" \    inet
" \    ip
" \    ip6


" Commands: Add, List, Flush

" Begin of 'create table ...'
hi link nftablesCmdCreateAddTable_FlagValue nftablesHL_Type
syn keyword nftablesCmdCreateAddTable_FlagValue contained dormant skipwhite

hi link nftablesCmdCreateAddTable_Flags nftablesHL_StatementL2
syn keyword nftablesCmdCreateAddTable_Flags contained flags skipwhite
\ nextgroup=nftablesCmdCreateAddTable_FlagValue

syn region nftablesCmdCreateTable_Section contained start=/{/ end=/}/ skipwhite
\ contains=nftablesCmdCreateAddTable_Flags

hi link nftablesCmdCreateTable_Name nftablesHL_Identifier
syn match nftablesCmdCreateTable_Name contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdCreateTable_Section

hi link nftablesCmdCreateTableFamily nftablesHL_Builtin
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
hi link nftablesCmdAddTableName nftablesHL_Identifier
syn match nftablesCmdAddTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdCreateTable_Section


hi link nftablesCmdAddTableFamily nftablesHL_Builtin
syn keyword nftablesCmdAddTableFamily contained skipwhite
\    netdev
\    arp
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdAddTableName

hi link nftablesCmdAddTable nftablesHL_StatementL2
syn keyword nftablesCmdAddTable contained table skipwhite
\ nextgroup=
\    nftablesCmdAddTableFamily,
\    nftablesCmdAddTableName
" End of 'add table ...'

" Begin of 'add chain ...'
" Begin of 'add chain arp <table_name> <chain_name> { ... }
" End of 'add chain arp <table_name> <chain_name> { ... }

" Begin of 'add chain bridge <table_name> <chain_name> { ... }
" End of 'add chain bridge <table_name> <chain_name> { ... }

" Begin of 'add chain netdev <table_name> <chain_name> { ... }
" End of 'add chain netdev <table_name> <chain_name> { ... }

" Begin of 'add chain inet <table_name> <chain_name> { ... }
" End of 'add chain inet <table_name> <chain_name> { ... }

" Begin of 'add chain ip <table_name> <chain_name> { ... }

syn region nftablesCmdAddChainIp_Section contained start=/{/ end=/}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon
\ contains=
\    nftablesCmdAddChainIp_Type,
\    nftablesCmdAddChainIp_Policy

hi link nftablesCmdAddChainIp_ChainName nftablesHL_Identifier
syn match nftablesCmdAddChainIp_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_Section

hi link nftablesCmdAddChainIp_TableName nftablesHL_Identifier
syn match nftablesCmdAddChainIp_TableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainIp_ChainName
" End of 'add chain ip <table_name> <chain_name> { ... }

" Begin of 'add chain ip6 <table_name> <chain_name> { ... }
" End of 'add chain ip6 <table_name> <chain_name> { ... }

" Begin of 'add chain <table_name>...' (generic, no family)
hi link nftablesCmdAddChainGen_Priority nftablesHL_Number
syn match nftablesCmdAddChainGen_Priority contained /[\-0-9]\{1,5}/ skipwhite
\ nextgroup=nftablesOpt_Semicolon

hi link nftablesCmdAddChainGen_PriorityKeyword nftablesHL_StatementL2
syn keyword nftablesCmdAddChainGen_PriorityKeyword contained priority skipwhite
\ nextgroup=nftablesCmdAddChainGen_Priority

hi link nftablesCmdAddChainGen_Hook nftablesHL_Type
syn keyword nftablesCmdAddChainGen_Hook contained skipwhite
\    input
\    output
\    prerouting
\    postrouting
\ nextgroup=nftablesCmdAddChainGen_PriorityKeyword nftablesHL_Identifier

hi link nftablesCmdAddChainGen_HookKeyword nftablesHL_StatementL2
syn keyword nftablesCmdAddChainGen_HookKeyword contained hook skipwhite
\ nextgroup=nftablesCmdAddChainGen_Hook

hi link nftablesCmdAddChainGen_Type nftablesHL_Type
syn keyword nftablesCmdAddChainGen_Type contained skipwhite
\    filter
\    nat
\    route
\    inet
\ nextgroup=nftablesCmdAddChainGen_HookKeyword nftablesHL_StatementL2

hi link nftablesCmdAddChainGen_TypeKeyword nftablesHL_StatementL2
syn keyword nftablesCmdAddChainGen_TypeKeyword contained type skipwhite
\ nextgroup=nftablesCmdAddChainGen_Type

hi link nftablesPolicyGen_Value nftablesHL_Builtin
syn keyword nftablesPolicyGen_Value contained skipwhite
\    accept
\    reject
\    drop
\ nextgroup=nftables_Semicolon

hi link nftablesCmdAddChainGen_PolicyKeyword nftablesHL_StatementL2
syn keyword nftablesCmdAddChainGen_PolicyKeyword contained policy skipwhite
\ nextgroup=nftablesPolicyGen_Value

syn region nftablesCmdAddChainGen_Section contained start=/{/ end=/}/
\ contains=
\    nftablesCmdAddChainGen_TypeKeyword,
\    nftablesCmdAddChainGen_PolicyKeyword,
\    nftablesOpt_Semicolon

hi link nftablesCmdAddChainGenTable_ChainName nftablesHL_Identifier
syn match nftablesCmdAddChainGenTable_ChainName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainGen_Section

hi link nftablesCmdAddChainGenTableName nftablesHL_Identifier
syn match nftablesCmdAddChainGenTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddChainGenTable_ChainName
" End of 'add chain <table_name>...' (generic, no family)

" Begin of 'add chain <family> <table_name>...' 
hi link nftablesCmdAddChainFamily nftablesHL_Builtin
syn keyword nftablesCmdAddChainFamily contained skipwhite
\    netdev
\ nextgroup=nftablesCmdAddChainNetdevTableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    arp
\ nextgroup=nftablesCmdAddChainArpTableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    bridge
\ nextgroup=nftablesCmdAddChainBridgeTableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    ip
\ nextgroup=nftablesCmdAddChainIp_TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    ip6
\ nextgroup=nftablesCmdAddChainIp6TableName

syn keyword nftablesCmdAddChainFamily contained skipwhite
\    inet
\ nextgroup=nftablesCmdAddChainInetTableName
" End of 'add chain <family> <table_name>...' 

hi link nftablesCmdAddChainKeyword nftablesHL_StatementL2
syn keyword nftablesCmdAddChainKeyword contained chain skipwhite
\ nextgroup=
\    nftablesCmdAddChainFamily,
\    nftablesCmdAddChainGenTableName
" End of 'add chain ...'

hi link nftablesCmdAddSetElementName nftablesHL_String
syn match nftablesCmdAddSetElementName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdAddSetElementTableName nftablesHL_Identifier
syn match nftablesCmdAddSetElementTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdAddSetElementName

hi link nftablesCmdAddSetElement nftablesHL_Statement
syn keyword nftablesCmdAddSetElement contained skipwhite
\    set
\    element
\ nextgroup=nftablesCmdAddSetElementTableName  nftablesHL_Identifier

hi link nftablesCmdAddMapTableName nftablesHL_Identifier
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

hi link nftablesCmdDeleteTable_Name nftablesHL_Identifier
syn match nftablesCmdDeleteTable_Name contained /\S\{1,64}/ skipwhite

hi link nftablesCmdDeleteTable_Family nftablesHL_Builtin
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

hi link nftablesCmdDeleteTableKeyword nftablesHL_StatementL2
syn keyword nftablesCmdDeleteTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdDeleteTable_Name,
\    nftablesCmdDeleteTable_Family,
\    nftablesCmdDeleteTableHandleKeyword
" End of 'delete table ...'

" Begin of 'export table ...'
hi link nftablesCmdExport_Format nftablesHL_Builtin
syn keyword nftablesCmdExport_Format contained skipwhite
\    xml
\    json

hi link nftablesCmdExportRulesetKeyword nftablesHL_StatementL2
syn keyword nftablesCmdExportRulesetKeyword contained ruleset skipwhite
\ nextgroup=nftablesCmdExport_Format
" End of 'export table'

" Begin of 'flush ruleset ...'
hi link nftablesCmdFlushRulesetFamilies nftablesHL_Builtin
syn keyword nftablesCmdFlushRulesetFamilies contained skipwhite
\    arp
\    netdev
\    bridge
\    inet
\    ip
\    ip6

hi link nftablesCmdFlushRulesetKeyword nftablesHL_StatementL2
syn keyword nftablesCmdFlushRulesetKeyword contained ruleset skipwhite
\ nextgroup=nftablesCmdFlushRulesetFamilies
" End of 'flush ruleset ...'

" Begin of 'flush table ...'
hi link nftablesCmdFlushTableName nftablesHL_Identifier
syn match nftablesCmdFlushTableName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdFlushTableFamily nftablesHL_Builtin
syn keyword nftablesCmdFlushTableFamily contained skipwhite
\    arp
\    netdev
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdFlushTableName nftablesHL_Identifier

hi link nftablesCmdFlushTableKeyword nftablesHL_StatementL2
syn keyword nftablesCmdFlushTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdFlushTableFamily,
\    nftablesCmdFlushTableName
" End of 'flush table ...'

hi link nftablesCmdListNoArg nftablesHL_StatementL2
syn keyword nftablesCmdListNoArg contained skipwhite
\    tables
\    chains
\    sets

hi link nftablesCmdListRulesetFamily nftablesHL_Builtin
syn keyword nftablesCmdListRulesetFamily contained skipwhite
\    arp
\    bridge
\    netdev
\    ip
\    ip6
\    inet

" list ruleset [family]
hi link nftablesCmdListRuleset nftablesHL_StatementL2
syn keyword nftablesCmdListRuleset contained ruleset skipwhite
\ nextgroup=nftablesCmdListRulesetFamily

" \    arp
" \    bridge
" \    netdev
" \    ip
" \    ip6
" \    inet
"
hi link nftablesCmdListTable_Name nftablesHL_Identifier
syn match nftablesCmdListTable_Name contained /\S\{1,64}/ skipwhite

hi link nftablesCmdListTable_Family nftablesHL_Builtin
syn keyword nftablesCmdListTable_Family contained skipwhite
\    arp
\    netdev
\    bridge
\    ip
\    ip6
\    inet
\ nextgroup=nftablesCmdListTable_Name 

hi link nftablesCmdListTableKeyword nftablesHL_StatementL2
syn keyword nftablesCmdListTableKeyword contained table skipwhite
\ nextgroup=
\    nftablesCmdListTable_Name,
\    nftablesCmdListTable_Family
    
hi link nftablesCmdListSetName nftablesHL_String
syn match nftablesCmdListSetName contained /\S\{1,64}/ skipwhite

hi link nftablesCmdListSetTableName nftablesHL_Identifier
syn match nftablesCmdListSetTableName contained /\S\{1,64}/ skipwhite
\ nextgroup=nftablesCmdListSetName 

hi link nftablesCmdListSetKeyword nftablesHL_Builtin
syn keyword nftablesCmdListSetKeyword contained set skipwhite
\ nextgroup=nftablesCmdListSetTableName

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
\    nftablesCmdDeleteTableKeyword

hi link nftablesCmdExportKeyword nftablesHL_Statement
syn keyword nftablesCmdExportKeyword export skipwhite 
\ nextgroup=
\    nftablesCmdExportRulesetKeyword,
\    nftablesCmdExport_Format

hi link nftablesCmdFlushKeyword nftablesHL_Statement
syn keyword nftablesCmdFlushKeyword flush skipwhite
\ nextgroup=
\    nftablesCmdFlushRulesetKeyword,
\    nftablesCmdFlushTableKeyword

hi link nftablesCmdListKeyword nftablesHL_Statement
syn keyword nftablesCmdListKeyword list skipwhite
\ nextgroup=
\    nftablesCmdListTableKeyword,
" \    nftablesCmdListSetKeyword,
" \    nftablesCmdListRuleset,
" \    nftablesCmdListNoArg,

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
"
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

