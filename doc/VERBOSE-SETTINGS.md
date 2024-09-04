
When setting verbosity for an edit session in `vim`, the level are described below:

```vim
:verbose 20
```

When bigger than zero, Vim will give messages about what it is doing.
        Currently, these messages are given:
        >= 1    When the viminfo file is read or written.
        >= 2    When a file is ":source"'ed.
        >= 4    Shell commands.
        >= 5    Every searched tags file and include file.
        >= 8    Files for which a group of autocommands is executed.
        >= 9    Every executed autocommand.
        >= 11   Finding items in a path
        >= 12   Every executed function.
        >= 13   When an exception is thrown, caught, finished, or discarded.
        >= 14   Anything pending in a ":finally" clause.
        >= 15   Every executed Ex command from a script (truncated at 200
                characters).
        >= 16   Every executed Ex command


