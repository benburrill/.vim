# My vim configuration

The first step in my attempt to make a dotfiles repo for myself.  This
repo works quite well on its own due to its very simple installation.

## Installation
Clone this to `~/.vim` (or `%USERPROFILE%\vimfiles` on windows)

## Usage
Plugins are installed and handled by [pathogen](https://github.com/tpope/vim-pathogen).  Use `repo-to-submodule.sh` to convert plugins into git submodules of this configuration repo.  Ideally, you should remember to use `git submodule add` each time instead of `git clone`, but `repo-to-submodule.sh` will fix that when you inevitably forget.

Platform-specific settings can be added in `~/.vimrc` or `~/.gvimrc`.  However, they must source their counterpart in this configuration directory or they will completely override it.

That's pretty much it!
