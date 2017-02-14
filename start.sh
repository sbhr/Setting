#!/bin/sh

ROOT=$(cd $(dirname $0);pwd)

vim --version | grep "+lua" > /dev/null
if [ $? -eq 0 ]; then
  ln -sf ${ROOT}/vimrc-lua ${HOME}/.vimrc
else
  ln -sf ${ROOT}/vimrc ${HOME}/.vimrc
fi
ln -sf ${ROOT}/gvimrc ${HOME}/.gvimrc
ln -sf ${ROOT}/bashrc ${HOME}/.bashrc
ln -sf ${ROOT}/bash_profile ${HOME}/.bash_profile
mkdir -p ${HOME}/.tmux.d
ln -sf ${ROOT}/tmux.conf ${HOME}/.tmux.conf
ln -sf ${ROOT}/tmux2.x.conf ${HOME}/.tmux.d/tmux2.x.conf
ln -sf ${ROOT}/tmux1.9.conf ${HOME}/.tmux.d/tmux1.9.conf
ln -sf ${ROOT}/gitconfig ${HOME}/.gitconfig
mkdir -p ${HOME}/.vim/rc
ln -sf ${ROOT}/dein.toml ${HOME}/.vim/rc/
ln -sf ${ROOT}/dein_lazy.toml ${HOME}/.vim/rc/

if [ "`uname`" == "Darwin" ]; then
  # Mac OS
  # Complement
  if [ ! -e /usr/local/etc/bash_completion.d ]; then
    brew install bash-completion
    brew install git
  fi
else
  # Others
  # Complement
  if [ ! -e /usr/local/share/bash-completion ]; then
    cd /tmp
    wget http://bash-completion.alioth.debian.org/files/bash-completion-2.1.tar.gz
    tar xvzf bash-completion-2.1.tar.gz
    cd bash-completion-2.1
    ./configure
    make
    sudo make install
    cd /tmp
    sudo wget -P /usr/local/share/bash-completion/ https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
    sudo wget -P /usr/local/share/bash-completion/ https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh
  fi
fi
