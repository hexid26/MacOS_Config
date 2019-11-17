#!/bin/bash
# -----------------------------------------------------------------------------
# Filename:    AutoInstall.sh
# Revision:    None
# Date:        2019/11/15 - 12:55
# Author:      Haixiang HOU
# Email:       hexid26@outlook.com
# Website:     [NULL]
# Notes:       [NULL]
# -----------------------------------------------------------------------------
# Copyright:   2018 (c) Haixiang
# License:     GPL
# -----------------------------------------------------------------------------
# Version [1.0]
# MacOS 自动安装软件脚本

SCRIPT_NAME=$(basename ${0}) # 脚本名称
BASEPATH=$(
  cd $(dirname $0)
  pwd
) # 脚本所在目录
tput setaf 2
echo "# ${SCRIPT_NAME} Running"
tput sgr0
# 1 红 2 绿 3 黄 4 蓝 5 粉 6 青 7 白 8 灰 9 橙 10 墨绿

var=$@

if [ $# = 0 ]; then
  echo "没有参数可以使用，当前可以使用的参数如下"
  echo "AutoInstall.sh all -> 安装脚本内所有的程序"
  echo "或者输入支持的程序名称："
  echo "AutoInstall.sh homebrew mas neovim thefuck pyenv python R autojump proxychain"
  exit
fi

# * install XCode command line tool
xcode-select --install

# * Disable gatekeeper
sudo spctl --master-disable

# * install homebrew
if [[ $var =~ .*homebrew.* ]] || [[ $var =~ .*all.* ]]; then
  brewPath="/usr/local/bin/"
  brewFile="/usr/local/bin/brew"
  if [ ! -x "$brewFile" ]; then
    tput setaf 2
    echo "INFO: Installing brew!"
    tput sgr0
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  tput setaf 2
  echo "INFO: Brew already installed!"
  tput sgr0
fi

# * install mas
if [[ $var =~ .*mas.* ]] || [[ $var =~ .*all.* ]]; then
  masPath="/usr/local/bin/"
  masFile="/usr/local/bin/mas"
  if [ ! -x "$masFile" ]; then
    tput setaf 2
    echo "INFO: Installing mas!"
    tput sgr0
    brew install mas
  fi
  tput setaf 2
  echo "INFO: mas already installed!"
  tput sgr0
fi

# * install neovim
if [[ $var =~ .*neovim.* ]] || [[ $var =~ .*all.* ]]; then
  nvimPath="/usr/local/bin/"
  nvimFile="/usr/local/bin/nvim"
  if [ ! -x "$nvimFile" ]; then
    tput setaf 2
    echo "INFO: Installing neovim!"
    tput sgr0
    brew install neovim
  fi
  tput setaf 2
  echo "INFO: nvim already installed!"
  tput sgr0
fi

# * install thefuck
if [[ $var =~ .*thefuck.* ]] || [[ $var =~ .*all.* ]]; then
  fuckPath="/usr/local/bin/"
  fuckFile="/usr/local/bin/fuck"
  if [ ! -x "$fuckFile" ]; then
    tput setaf 2
    echo "INFO: Installing thefuck!"
    tput sgr0
    brew install thefuck
  fi
  tput setaf 2
  echo "INFO: thefuck already installed!"
  tput sgr0
fi

# * install pyenv
if [[ $var =~ .*pyenv.* ]] || [[ $var =~ .*all.* ]]; then
  pyenvPath="/usr/local/bin/"
  pyenvFile="/usr/local/bin/pyenv"
  if [ ! -x "$pyenvFile" ]; then
    tput setaf 2
    echo "INFO: Installing pyenv!"
    tput sgr0
    brew install pyenv
  fi
  tput setaf 2
  echo "INFO: pyenv already installed!"
  tput sgr0
  cp CFG_files/zshrc ~/.zshrc
  source ~/.zshrc
fi

# * install python 3.7.0
brew install zlib
if [[ $var =~ .*python.* ]] || [[ $var =~ .*all.* ]]; then
  echo "Warning: Make sure that the Xcode command line tools install correctly."
  echo "Warning: Python will be compiled and wait for moments."
  source ~/.zshrc
  ./shells/installPy.sh 3.7.0
fi

# * install R
if [[ $var =~ .*R.* ]] || [[ $var =~ .*all.* ]]; then
  rPath="/usr/local/bin/"
  rFile="/usr/local/bin/R"
  if [ ! -x "$rFile" ]; then
    tput setaf 2
    echo "INFO: Installing R!"
    tput sgr0
    brew tap homebrew/science
    brew install R
    brew tap homebrew/core
  fi
  tput setaf 2
  echo "INFO: R already installed!"
  tput sgr0
fi

# * install autojump
if [[ $var =~ .*autojump.* ]] || [[ $var =~ .*all.* ]]; then
  autojumpPath="/usr/local/bin/"
  autojumpFile="/usr/local/bin/autojump"
  if [ ! -x "$autojumpFile" ]; then
    tput setaf 2
    echo "INFO: Installing autojump!"
    tput sgr0
    brew install autojump
  fi
  tput setaf 2
  echo "INFO: autojump already installed!"
  tput sgr0
fi

# * install proxychain
if [[ $var =~ .*proxychain.* ]] || [[ $var =~ .*all.* ]]; then
  proxyPath="/usr/local/bin/"
  proxyFile="/usr/local/bin/proxychains4"
  if [ ! -x "$proxyFile" ]; then
    tput setaf 2
    echo "INFO: Installing proxychains-ng!"
    tput sgr0
    brew install proxychains-ng
  fi
  tput setaf 2
  echo "INFO: proxychain already installed!"
  tput sgr0
fi

# * Copy fonts
tput setaf 2
echo "Installing fonts"
tput sgr0
# * for Ubuntu
find ./Fonts -type f -name *.[ot]tf -exec cp "{}" ~/Library/Fonts/ \;

# * Update software
tput setaf 2
echo "Update Softwares"
tput sgr0
brew update
brew upgrade
brew cleanup
brew doctor
mas upgrade

# * Config for Components
tput setaf 2
echo "Config for Components"
tput sgr0
./AutoConfig.sh

tput setaf 2
echo "# ${SCRIPT_NAME} Done"
tput sgr0
