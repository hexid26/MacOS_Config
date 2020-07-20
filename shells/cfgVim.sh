#!/bin/bash
# -----------------------------------------------------------------------------Ï
# Filename:    cfgVim.sh
# Revision:    None
# Date:        2019/11/15 - 02:12
# Author:      Haixiang HOU
# Email:       hexid26@outlook.com
# Website:     [NULL]
# Notes:       [NULL]
# -----------------------------------------------------------------------------
# Copyright:   2018 (c) Haixiang
# License:     GPL
# -----------------------------------------------------------------------------
# Version [1.0]
# 自动配置 Vim

SCRIPT_NAME=$(basename ${0}) # 脚本名称
BASEPATH=$(
  cd $(dirname $0)
  pwd
) # 脚本所在目录
tput setaf 2
echo "# ${SCRIPT_NAME} Running"
tput sgr0
# 1 红 2 绿 3 黄 4 蓝 5 粉 6 青 7 白 8 灰 9 橙 10 墨绿

# brew install coreutils
# pyenv global 3.8.1
# pip install --user powerline-status
# * Plugins Manager for vim
http_proxy=socks5://127.0.0.1:1086 https_proxy=socks5://127.0.0.1:1086 curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# * Plugins Manager for neovim
http_proxy=socks5://127.0.0.1:1086 https_proxy=socks5://127.0.0.1:1086 curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp -f -v ./CFG_files/vimrc ~/.vimrc
if [ ! -f "~/.config/nvim/init.vim" ]; then
  mkdir -p ~/.config/nvim
  ln -s ~/.vimrc ~/.config/nvim/init.vim
fi

tput setaf 2
echo "# ${SCRIPT_NAME} Done"
tput sgr0
