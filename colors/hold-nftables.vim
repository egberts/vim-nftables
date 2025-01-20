" Vim colors file for nftables configuration file
" Language:     nftables configuration file
" Maintainer:   egberts <egberts@github.com>
" Revision:     1.0
" Initial Date: 2020-04-24
" Last Change:  2024-08-28
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues

" quit color if Vim is too old
if version < 580
  finish
endif

" quit if terminal is a black and white
if &t_Co <= 1
  finish
endif

if &background is v:null
  " If end-user did not specify a dark background, go with 'light'
  set background=light
endif

hi clear
let g:colors_name = 'nftables'

let s:t_Co = exists('&t_Co') && !has('gui_running') ? (&t_Co ?? 0) : -1


  echo "NFT: TrueColor mode"
  hi def nftHL_Include      ctermfg=DarkCyan ctermbg=Black cterm=NONE guifg=DarkCyan guibg=Black gui=NONE
  hi def nftHL_ToDo         ctermfg=Black ctermbg=Yellow cterm=NONE guifg=Black guibg=Yellow gui=NONE
  hi link nftHL_Identifier  Identifier
  hi link nftHL_Number      Number
  hi link nftHL_Option      Label     " could use a 2nd color here
  hi link nftHL_Operator    Conditional
  hi link nftHL_Underlined  Underlined
  hi link nftHL_Error       Error
  hi link nftHL_Constant    Constant

  hi link nftHL_Command     Statement
  hi link nftHL_Statement   Statement
  hi link nftHL_Expression  Conditional
  hi link nftHL_Type        Type

  hi link nftHL_Family      Underlined   " doesn't work, stuck on dark cyan
  hi link nftHL_Table       Identifier
  hi link nftHL_Chain       Identifier
  hi link nftHL_Rule        Identifier
  hi link nftHL_Map         Identifier
  hi link nftHL_Set         Identifier
  hi link nftHL_Element     Identifier
  hi link nftHL_Quota       Identifier
  hi link nftHL_Position    Number
  hi link nftHL_Limit       Number
  hi link nftHL_Handle      Number
  hi link nftHL_Flowtable   Identifier
  hi link nftHL_Device      Identifier
  hi link nftHL_Member      Identifier

  hi link nftHL_Verdict     Underlined
  hi link nftHL_Hook        Type
  hi link nftHL_Action      Special
  hi link nftHL_BlockDelimiters  Normal

  hi nftHL_String      guifg=LightMagenta guibg=Black ctermbg=Black cterm=NONE  " String is too DarkMagenta
  hi nftHL_Variable    guifg=LightBlue guibg=Black cterm=NONE  " Variable doesn't work, stuck on dark cyan
  hi nftHL_Comment     ctermfg=Blue ctermbg=NONE guifg=#00eeee guibg=Black cterm=NONE
  hi nftHL_BlockDelimitersTable  ctermfg=LightRed ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersChain  ctermfg=LightGreen ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersSet  ctermfg=LightBlue ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersMap  ctermfg=LightCyan ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersFlowTable  ctermfg=LightMagenta ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersCounter  ctermfg=LightYellow ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersQuota  ctermfg=DarkGrey ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersCT  ctermfg=Red ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersLimit  ctermfg=Red ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersSecMark  ctermfg=Red ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersSynProxy  ctermfg=Red ctermbg=Black cterm=NONE
  hi nftHL_BlockDelimitersMeter  ctermfg=Red ctermbg=Black cterm=NONE