
To buffer debug login for later examination,

Add the following vim functions:
```vim
function! DebugMsg(msg) abort
    if !exists("g:DebugMessages")
        let g:DebugMessages = []
    endif
    call add(g:DebugMessages, a:msg)
endfunction

function! PrintDebugMsgs() abort
  if empty(get(g:, "DebugMessages", []))
    echo "No debug messages."
    return
  endif
  for ln in g:DebugMessages
    echo "- " . ln
  endfor
endfunction

command DebugStatus call PrintDebugMsgs()
```

and then insert debug message throughout your code by using:

```vim
call DebugMsg("Doing this")
" ...
call DebugMsg("Doing")
```

To display the messages at any time,  execute the command

```vim
:DebugStatus
```

