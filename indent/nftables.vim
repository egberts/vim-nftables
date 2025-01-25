" Vim indent configuration file for nftables
" Language:     nftables indent in Vimscript
" Maintainer:   egberts <egberts@github.com>
" Revision:     1.0
" Initial Date: 2020-04-24
" Last Change:  2025-01-19
" Filenames:    nftables.conf, *.nft
" Location:     https://github.com/egberts/vim-nftables
" License:      MIT license
" Remarks:
" Bug Report:   https://github.com/egberts/vim-nftables/issues
"
" indent/nftables.vim is called after syntax/nftables.vim
" indent/nftables.vim is called after color/nftables.vim
" indent/nftables.vim is called after ftdetect/nftables.vim
" indent/nftables.vim is called after ftplugin/nftables.vim

echomsg "indent/nftables.vim: called."

if ! exists('b:nftables_disable') || ! b:nftables_disable
  finish
endif

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
  finish
endif
let b:did_indent = 1

setlocal cindent
setlocal cinoptions=L0,(0,Ws,J1,j1,+N
setlocal cinkeys=0{,0},!^F,o,O,0[,0]
" Don't think cinwords will actually do anything at all... never mind
setlocal cinwords=table,chain

" Some preliminary settings
setlocal nolisp         " Make sure lisp indenting doesn't supersede us
setlocal autoindent     " indentexpr isn't much help otherwise
" Also do indentkeys, otherwise # gets shoved to column 0 :-/
setlocal indentkeys=0{,0},!^F,o,O,0[,0]
