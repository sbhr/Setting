#!/bin/sh

# とりあえずパッケージ
sudo apt install mercurial ncurses-dev lua5.2 lua5.2-dev luajit python-dev python3-dev

# vimのビルド
cd $HOME
wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
tar jxvf vim-7.4.tar.bz2
cd vim74
# ./configure \
#   --prefix=/usr/local \
#   --enable-fail-if-missing \
#   --enable-fontset \
#   --enable-perlinterp \
#   --enable-pythoninterp \
#   --enable-rubyinterp \
#   --enable-gpm \
#   --enable-cscope \
#   --enable-luainterp=dynamic \
#   --with-lua-prefix=/usr \
#   --enable-luainterp \
#   --enable-multibyte \
#   --with-x=no \
#   --disable-gui \
#   --disable-xim \
#   --with-features=huge \
#   --disable-selinux \
#   --disable-gpm \
#   --disable-darwin

./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-luainterp=dynamic \
  --enable-gpm \
  --enable-cscope \
  --enable-fontset \
  --enable-fail-if-missing \
  --prefix=/usr/local

make
sudo make install

vim --version

