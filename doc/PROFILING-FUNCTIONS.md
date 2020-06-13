To profile Vim script functions,

execute:

```vim
:profile start myfile.profile.log
:profile func *
```
Then run your script.

When done, execute:
```vim
:profile pause
:noautocmd qall!
```
