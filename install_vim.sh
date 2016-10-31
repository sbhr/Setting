#!/bin/sh

askYesOrNo() {
  while true ; do
    read -p "$1 (y/n)?" answer
    case $answer in
      [yY] | [yY]es | YES )
        return 0;;
      [nN] | [nN]o | NO )
        return 1;;
      * ) echo "Please answer yes or no.";;
    esac
  done
}

askYesOrNo "nanika で vim を install しますか？"
if [ $? -eq 0 ]; then
  echo "しません"
  exit 1
else
  # とりあえずパッケージ
  sudo yum install lua lua-devel
  sudo yum install ncurses-devel perl-ExtUtils-Embed python-devel readline-devel gcc ruby-devel python-devel ruby

  # luajitのインストール
  sudo mkdir /usr/local/luajit
  sudo chown kshibaha /usr/local/luajit
  cd $HOME
  wget http://luajit.org/download/LuaJIT-2.0.3.tar.gz
  tar zxvf LuaJIT-2.0.3.tar.gz
  cd LuaJIT-2.0.3
  sed -i -e "s/^export PREFIX= \/usr\/local/export PREFIX= \/usr\/local\/luajit/" Makefile
  sed -i -e "s/\/luajit-\$(MAJVER.*$//" Makefile
  make
  make install
  export PATH="/usr/local/luajit/bin/:$PATH"

  # vimのビルド
  cd $HOME
  wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2
  tar jxvf vim-7.4.tar.bz2
  cd vim74
  ./configure \
  	--prefix=/usr/local \
  	--enable-fail-if-missing \
  	--enable-fontset \
  	--enable-perlinterp \
  	--enable-pythoninterp \
  	--enable-rubyinterp \
	--enable-gpm \
  	--enable-cscope \
  	--enable-luainterp=dynamic \
  	--with-lua-prefix=/usr \
  	--enable-luainterp \
  	--enable-multibyte \
  	--with-x=no \
  	--disable-gui \
  	--disable-xim \
  	--with-features=huge \
  	--disable-selinux \
  	--disable-gpm \
  	--disable-darwin
  make
  sudo make install

  vim --version
fi
