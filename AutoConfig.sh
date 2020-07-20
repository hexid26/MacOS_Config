#!/bin/zsh
# -----------------------------------------------------------------------------
# Filename:    AutoConfig.sh
# Revision:    None
# Date:        2019/11/15 - 12:41
# Author:      Haixiang HOU
# Email:       hexid26@outlook.com
# Website:     [NULL]
# Notes:       [NULL]
# -----------------------------------------------------------------------------
# Copyright:   2018 (c) Haixiang
# License:     GPL
# -----------------------------------------------------------------------------
# Version [1.0]
# 配置 MacOS

SCRIPT_NAME=$(basename ${0}) # 脚本名称
BASEPATH=$(
  cd $(dirname $0)
  pwd
) # 脚本所在目录
tput setaf 2
echo "# ${SCRIPT_NAME} Running"
tput sgr0

# * install oh-my-zsh
omzFolder=".oh-my-zsh"
if [ ! -x ~/"$omzFolder" ]; then
  tput setaf 2
  echo "Installing oh-my-zsh"
  tput sgr0
  sh -c "CHSH=no RUNZSH=no KEEP_ZSHRC=no $(http_proxy=socks5://127.0.0.1:1086 https_proxy=socks5://127.0.0.1:1086 curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
fi
if [ ! -d "~/.oh-my-zsh/custom/themes/powerlevel10k/" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
else
  cd ~/.oh-my-zsh/custom/themes/powerlevel10k/ && git pull
  cd $BASEPATH
fi
cp -f -v ./CFG_files/bash_profile ~/.bash_profile
cp -f -v ./CFG_files/zshrc ~/.zshrc
cp -f -v ./CFG_files/p10k.zsh ~/.p10k.zsh
source ~/.zshrc

# * Config for vim&neovim
tput setaf 4
echo "Config for vim&neovim"
tput sgr0
./shells/cfgVim.sh

# * Config for Übersicht
tput setaf 4
echo "Config for Übersicht"
tput sgr0
./shells/cfgUbersicht.sh

tput setaf 4
echo "默认 sh 修改为 zsh"
tput sgr0
chsh -s /bin/zsh
source ~/.zshrc

# * Config for iTerm2
tput setaf 4
echo "Config for iTerm2"
tput sgr0
# mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles/
# cp -f -v ./CFG_files/hexid26_iTerm2_config ~/Library/Application\ Support/iTerm2/DynamicProfiles/

# * Config for Proxychains-Ng
tput setaf 4
echo "Config for proxychains-ng"
tput sgr0
mkdir ~/.proxychains
cp CFG_files/proxychains.conf ~/.proxychains/

# * Notication
tput setaf 2
echo "Install [iTerm2] [MacTex] for best experience"
tput sgr0

tput setaf 2
echo "# ${SCRIPT_NAME} Done"
tput sgr0
