#!/bin/bash

cp .vim_as_ide ~/
cd ~/

# git config
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
echo "source ~/git-completion.bash" >> .bashrc
source ~/git-completion.bash

#tmux
sudo yum install tmux

# bash additions
echo "alias ide='vim -u ~/.vim_as_ide'
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
# append history entries..
shopt -s histappend
# After each command, save and reload history
export PROMPT_COMMAND='history -a; history -c; history -r; $PROMPT_COMMAND' " >> ~/.bashrc

# Install VIM plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -u ~/.vim_as_ide +PluginInstall +qall
sudo yum install cmake
cd ~/.vim/bundle/YouCompleteMe
python install.py
