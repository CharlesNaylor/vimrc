#!/bin/bash

ln .vim_as_ide ~/.vim_as_ide
cd ~/

# git config
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
brew install reattach-to-user-namespace
echo "
# Copy-paste integration
set-option -g default-command 'reattach-to-user-namespace -l bash'

# Use vim keybindings in copy mode
setw -g mode-keys vi

# Setup 'v' to begin selection as in Vim
bind-key -t vi-copy v begin-selection
bind-key -t vi-copy y copy-pipe 'reattach-to-user-namespace pbcopy'

# Update default binding of `Enter` to also use copy-pipe
unbind -t vi-copy Enter
bind-key -t vi-copy Enter copy-pipe 'reattach-to-user-namespace pbcopy'

# Bind ']' to use pbpaste
bind ] run 'reattach-to-user-namespace pbpaste | tmux load-buffer - && tmux paste-buffer'" >> ~/.tmux.conf

# Install VIM plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -u ~/.vim_as_ide +PluginInstall +qall

# Config pylint
# Ignore C0330 as Black is now handling it
echo "
[MESSAGES CONTROL]
disable=C0330" >> ~/.pylintrc

