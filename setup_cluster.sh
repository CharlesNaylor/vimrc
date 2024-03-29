#!/bin/bash

ln .vim_as_ide ~/.vim_as_ide
cd ~/

# git config
if [ -n "$ZSH_VERSION" ]; then
	echo 'autoload -Uz compinit && compinit' >> ~/.zshrc && . ~/.zshrc
else
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
	echo "source ~/git-completion.bash" >> .bashrc
	source ~/git-completion.bash

# enable conflict resolution recording
git config --global rerere.enabled true

# Add git hooks for Ctags config, cf. tbaggery.com/2011/08/08/effortless-ctags-with-git.html
#sudo snap install universal-ctags
mkdir -p ~/.git_template/hooks
git config --global init.templatedir '~/.git_template'
cp ctags ~/.git_template/hooks
git config --global alias.ctags '!.git/hooks/ctags'

echo "
#!/bin/sh
.git/hooks/ctags > /dev/null 2>&1 &" > ~/.git_template/hooks/post-commit
cp ~/.git_template/hooks/post-commit ~/.git_template/hooks/post-merge
cp ~/.git_template/hooks/post-commit ~/.git_template/hooks/post-checkout
chmod -R a+x ~/.git_template/hooks

# bash additions
echo "
alias ide='vim -u ~/.vim_as_ide'
alias ide_git=\"/usr/local/bin/vim -u ~/.vim_as_ide -o $(git status --porcelain | awk '{print $2}')\"
# avoid duplicates..
export HISTCONTROL=ignoredups:erasedups
" >> ~/.bashrc

# Tmux conf
echo "setw -g mode-keys vi" >> ~/.tmux.conf

# Install VIM plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -u ~/.vim_as_ide +PluginInstall +qall

# Config pylint
# Ignore C0330 as Black is now handling it
echo "
[MESSAGES CONTROL]
disable=C0330" >> ~/.pylintrc
