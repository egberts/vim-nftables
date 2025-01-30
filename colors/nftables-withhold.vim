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
" Requirement:  a ISO-8613-3 compatible terminal.
"
" colors/nftables.vim is called after syntax/nftables.vim
"
" colors/nftables.vim is called before ftdetect/nftables.vim
" colors/nftables.vim is called before ftplugin/nftables.vim
" colors/nftables.vim is called before indent/nftables.vim

if exists('g:nft_debug') && nft_debug == 1
  echomsg "colors/nftables.vim: called."
endif

" quit color if Vim is too old
if version < 580
  finish
endif

" quit if terminal is a black and white
if &t_Co <= 1
  finish
endif

hi clear
let g:colors_name = 'nftables'

" let s:t_Co = exists('&t_Co') && !has('gui_running') ? (&t_Co ?? 0) : -1

if &t_Co <= 2
  hi Comment        cterm=bold            ctermfg=NONE
  hi Constant       cterm=underline       ctermfg=NONE
  hi Error          cterm=reverse         ctermfg=NONE
  hi ErrorMsg       cterm=standout        ctermfg=NONE
  hi Identifier     cterm=underline       ctermfg=NONE
  hi Ignore         cterm=bold            ctermfg=NONE
  hi PreProc        cterm=underline       ctermfg=NONE
  hi Special        cterm=bold            ctermfg=NONE
  hi Statement      cterm=bold            ctermfg=NONE
  hi Todo           cterm=standout        ctermfg=NONE
  hi Type           cterm=underline       ctermfg=NONE
  hi Underlined     cterm=underline       ctermfg=NONE
elseif &t_Co <= 16
  if &background == 'light'
    hi Comment        cterm=bold            ctermfg=Cyan
    hi Constant       cterm=underline       ctermfg=Magenta
    hi Error          cterm=reverse         ctermfg=NONE
    hi ErrorMsg       cterm=standout        ctermfg=Red
    hi Identifier     cterm=underline       ctermfg=NONE
    hi Ignore         cterm=bold            ctermfg=NONE
    hi Number         cterm=underline       ctermfg=Magenta
    hi PreProc        cterm=underline       ctermfg=NONE
    hi Special        cterm=bold            ctermfg=NONE
    hi Statement      cterm=bold            ctermfg=NONE
    hi String         cterm=underline       ctermfg=Magenta
    hi Todo           cterm=standout        ctermfg=Yellow
    hi Type           cterm=underline       ctermfg=Green
    hi Underlined     cterm=underline       ctermfg=White
  elseif &background == 'light'
    hi Comment        cterm=                ctermfg=Cyan
    hi Constant       cterm=                ctermfg=Magenta
    hi Error          cterm=reverse         ctermfg=Red
    hi ErrorMsg       cterm=standout        ctermfg=Red
    hi Identifier     cterm=                ctermfg=Black
    hi Ignore         cterm=bold            ctermfg=Black
    hi Number         cterm=                ctermfg=Magenta
    hi PreProc        cterm=                ctermfg=Black
    hi Special        cterm=bold            ctermfg=Black
    hi Statement      cterm=bold            ctermfg=Black
    hi String         cterm=                ctermfg=Magenta
    hi Todo           cterm=standout        ctermfg=Yellow
    hi Type           cterm=                ctermfg=Green
    hi Underlined     cterm=underline       ctermfg=Black
  endif
elseif &t_Co <= 88
    hi Comment        cterm=                ctermfg=Cyan
    hi Constant       cterm=underline       ctermfg=Magenta
    hi Error          cterm=reverse         ctermfg=Black
    hi ErrorMsg       cterm=standout        ctermfg=Red
    hi Identifier     cterm=underline       ctermfg=Black
    hi Ignore         cterm=bold            ctermfg=Black
    hi Number         cterm=underline       ctermfg=Magenta
    hi PreProc        cterm=underline       ctermfg=Black
    hi Special        cterm=bold            ctermfg=Black
    hi Statement      cterm=bold            ctermfg=Black
    hi String         cterm=underline       ctermfg=Magenta
    hi Todo           cterm=standout        ctermfg=Yellow
    hi Type           cterm=underline       ctermfg=Green
    hi Underlined     cterm=underline       ctermfg=Black
elseif &t_Co <= 0x100000  " with $TERM=xterm-direct
    hi Comment        cterm=                ctermfg=Cyan
    hi Constant       cterm=underline       ctermfg=Magenta
    hi Error          cterm=reverse         ctermfg=Black
    hi ErrorMsg       cterm=standout        ctermfg=Red
    hi Identifier     cterm=underline       ctermfg=Black
    hi Ignore         cterm=bold            ctermfg=Black
    hi Number         cterm=underline       ctermfg=Magenta
    hi PreProc        cterm=underline       ctermfg=Black
    hi Special        cterm=bold            ctermfg=Black
    hi Statement      cterm=bold            ctermfg=Black
    hi String         cterm=underline       ctermfg=Magenta
    hi Todo           cterm=standout        ctermfg=Yellow
    hi Type           cterm=underline       ctermfg=Green
    hi Underlined     cterm=underline       ctermfg=Black
endif


  hi def nftHL_Include      ctermfg=DarkCyan ctermbg=Black cterm=NONE guifg=DarkCyan guibg=Black gui=NONE
  hi def nftHL_ToDo         ctermfg=Black ctermbg=Yellow cterm=NONE guifg=Black guibg=Yellow gui=NONE
  "hi link nftHL_Identifier  Identifier
  hi nftHL_Identifier  cterm=NONE ctermfg=Blue ctermbg=NONE gui=NONE guifg=LightBlue guibg=NONE
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