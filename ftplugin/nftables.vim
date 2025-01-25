" Vim ftplugin file for nftables configuration file
" Language:     nftables configuration file
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
" ftplugin/nftables.vim is called after syntax/nftables.vim
" ftplugin/nftables.vim is called after colors/nftables.vim
" ftplugin/nftables.vim is called after ftdetect/nftables.vim
"
" ftplugin/nftables.vim is called before indent/nftables.vim

echomsg "ftplugin/nftables.vim: called."

if exists('b:did_ftplugin')
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

setlocal smartindent nocindent
setlocal commentstring=#%s
setlocal formatoptions-=t formatoptions+=croqnlj

setlocal comments=b:#

setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
setlocal textwidth=99

let b:undo_ftplugin = '
    \ setlocal formatoptions< comments< commentstring<
    \|setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth<
    \'

let &cpoptions = s:save_cpo
unlet s:save_cpo
