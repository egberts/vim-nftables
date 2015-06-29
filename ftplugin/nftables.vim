if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

let s:save_cpo = &cpo
set cpo&vim

setlocal smartindent nocindent
setlocal commentstring=#%s
setlocal formatoptions-=t formatoptions+=croqnlj

setlocal comments=b:#

setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
setlocal textwidth=99

setlocal foldmethod=syntax

let b:undo_ftplugin = "
    \ setlocal formatoptions< comments< commentstring<
    \|setlocal tabstop< shiftwidth< softtabstop< expandtab< textwidth<
    \"

let &cpo = s:save_cpo
unlet s:save_cpo