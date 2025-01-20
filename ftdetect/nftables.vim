" Vim ftdetect file for nftables configuration file
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

if ! exists('b:nftables_delimiter') || ! b:nftables_delimiter
  finish
endif

" Detect file type by use of shebang
function! s:DetectFiletype()
    if getline(1) =~ '^#!\s*\%\(/\S\+\)\?/\%\(s\)\?bin/\%\(env\s\+\)\?nft\>'
        setfiletype nftables
    endif
endfunction

augroup nftables
    autocmd!
    " Detect file type by use of shebang
    autocmd BufRead,BufNewFile * call s:DetectFiletype()

    " Detect file type by its filetype
    autocmd BufRead,BufNewFile *.nft,nftables.conf setfiletype nftables
augroup END
