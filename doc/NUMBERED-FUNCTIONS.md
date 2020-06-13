
Get numbered function definition

:function {fnum}

It's documented at `:h numbered-function`


This will tell you where the functions are:

```vim
:verbose function {fnum}
```

Add breakpoint to numbered-function

```vim
:breakadd func lnum fnum
```

Note that everytime you sourced a numbered function, a new numbered function is created.
