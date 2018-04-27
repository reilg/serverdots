Server Dotfiles
===

What it is.
---
Simple configs to vim and bashrc to make server life prettier.

*Warning*: This will overwrite your `.vimrc` and `.bashrc` files. Install at your own risk.

Installation
---
This setup uses [vim-plug](https://github.com/junegunn/vim-plug) to manage vim plugins.

Run this to install `vim-plug`.
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Run this to install the dotfiles.
```
sh <(curl -sL https://raw.githubusercontent.com/reilg/serverdots/master/install.sh)
```
