#
# Detect file type by use of shebang
function! s:DetectFiletype()
    if getline(1) =~# '^#!\s*\%\(/\S\+\)\?/\%\(s\)\?bin/\%\(env\s\+\)\?nft\>'
        setfiletype nftables
    endif
endfunction

augroup nftables
    autocmd!
    # Detect file type by use of shebang
    autocmd BufRead,BufNewFile * call s:DetectFiletype()

    # Detect file type by its filetype
    autocmd BufRead,BufNewFile *.nft,nftables.conf setfiletype nftables
augroup END
