Installing Vim Syntax File for NFTABLES
=======================================

Of all the things that I have tried to do in order to debug a brand 
new syntax file for Vim editor, the following steps are my best and 
easiest to use and I hope they are to you as well.

Preparing Your Home Settings
----------------------------

If you do not have a `.vim` subdirectory in your `$HOME` directory, 
create that subdirectory:

```bash
mkdir $HOME/.vim
````
If you do not have a `syntax` or `ftdetect` subdirectory under that `.vim` directory, create them as needed:

```bash
mkdir $HOME/.vim/indent
mkdir $HOME/.vim/ftdetect
mkdir $HOME/.vim/ftplugin
mkdir $HOME/.vim/syntax
```

Copying Vim Syntax Files
------------------------
Copy the Vim syntax files from my github repository into your Vim local
settings:

```bash
cd $HOME/myworkspace
git clone https://github.com/egberts/vim-nftables
cp -R vim-nftables/indent/* ~/.vim/indent/
cp -R vim-nftables/ftdetect/* ~/.vim/ftdetect/
cp -R vim-nftables/ftplugin/* ~/.vim/ftplugin/
cp -R vim-nftables/syntax/* ~/.vim/syntax/
```

See the Highlightings
---------------------
To see highlighting in action, use the enclosed test file for highlighting of `nftables` configuration file:

```bash
vim vim-nftables/test/all-syntaxes-good.nft
```


