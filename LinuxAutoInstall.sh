#!/bin/zsh
# -----------------------------------------------------------------------------
# Filename:    LinuxAutoInstall.sh
# Revision:    None
# Date:        2019/11/15 - 12:57
# Author:      Haixiang HOU
# Email:       hexid26@outlook.com
# Website:     [NULL]
# Notes:       [NULL]
# -----------------------------------------------------------------------------
# Copyright:   2018 (c) Haixiang
# License:     GPL
# -----------------------------------------------------------------------------
# Version 1.0
# Linux 自动配置脚本

SCRIPT_NAME=$(basename ${0}) # 脚本名称
BASEPATH=$(
  cd $(dirname $0)
  pwd
) # 脚本所在目录
tput setaf 2
echo "# ${SCRIPT_NAME} Running"
tput sgr0
# 1 红 2 绿 3 黄 4 蓝 5 粉 6 青 7 白 8 灰 9 橙 10 墨绿

CURRENT_OS="" #centos | ubuntu | osx and other valid options
OS_TYPE=""    #Darwin | Linux
function findCurrentOS() {
  tput setaf 2
  echo "Finding the current os type..."
  tput sgr0
  OS_TYPE=$(uname)
  case "$OS_TYPE" in
    "Darwin")
      {
        # echo "Running on Mac OSX."
        CURRENT_OS="osx"
      }
      ;;
    "Linux")
      { 
        # If available, use LSB to identify distribution
        if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
          DISTRO=$(gawk -F= '/^ID=/{print $2}' /etc/os-release)
        else
          DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
        fi
        CURRENT_OS=$DISTRO
      }
      ;;
    *)
      {
        tput setaf 1
        echo "Unsupported OS, exiting"
        tput sgr0
        exit
      }
      ;;
  esac
}
findCurrentOS
CURRENT_OS=$(echo $CURRENT_OS | tr 'A-Z' 'a-z')
OS_TYPE=$(echo $OS_TYPE | tr 'A-Z' 'a-z')

var=$@

if [ $# = 0 ]; then
  echo "没有参数可以使用，当前可以使用的参数如下"
  echo "AutoInstall.sh all -> 安装脚本内所有的程序"
  echo "或者输入支持的程序名称："
  echo "AutoInstall.sh EPEL devtools pyenv python thefuck vscode autojump Shadowsocks proxychain"
  exit
fi

sys_install=""
sys_update=""
if [ "$CURRENT_OS"x = "ubuntu"x ]; then
  sys_install="sudo apt-get install -y -q"
  sys_update="sudo apt-get update"
elif [ "$CURRENT_OS"x = "centos"x ]; then
  sys_install="sudo yum install -y"
  sys_update="sudo yum update"
elif [ "$CURRENT_OS"x = "uos"x ]; then
  sys_install="sudo apt-get install -y -q"
  sys_update="sudo apt-get update"
else
  tput setaf 1
  echo "Unsupport OS, EXIT"
  tput sgr0
  exit
fi

# * 查看是否有 zsh，没有则安装，有则提示在 zsh 下运行脚本
zshpath1="/usr/bin/zsh"
zshpath2="/bin/zsh"
if [ ! -x "$zshpath1" ] && [ ! -x "$zshpath2" ]; then
  tput setaf 1
  echo "WARNING :: zsh not installed, install zsh now"
  tput sgr0
  eval "$sys_install zsh > /dev/null 2>&1"
  tput setaf 1
  echo "Using zsh and redo this command again!"
  tput sgr0
  exit
fi

# * install EPEL repo
if [[ $var =~ .*EPEL.* ]] || [[ $var =~ .*all.* ]]; then
  if [ "$CURRENT_OS" = "centos" ]; then
    wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    sudo rpm -ivh epel-release-latest-7.noarch.rpm
    eval "$sys_install http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-1.el7.nux.noarch.rpm > /dev/null 2>&1"
  fi
fi

# * install necessary packages
if [[ $var =~ .*devtools.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing packages for dev"
  tput sgr0
  echo "Installing: "
  eval "$sys_install software-properties-common python-software-properties > /dev/null 2>&1"
  eval "$sys_update"
  for idx in automake build-essential bzip2 bzip2-devel clang cmake curl exfat-utils freeglut3-dev fuse-exfat gawk g++ gcc gettext git htop libbz2-dev libffi-devel libffi-dev libglu1-mesa libglu1-mesa-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libtool libtool-bin libtool-doc libx11-dev libxi-dev libxmu-dev llvm openssh openssh-server openssl-devel qt5-qtwebkit readline-devel sqlite sqlite-devel tk-dev unzip vim wget xz xz-devel xz-utils zlib-devel zlib1g-dev zsh; do
    echo -e "$idx \c"
    eval "$sys_install $idx > /dev/null 2>&1"
  done
  echo "done"
fi

# * 关闭防火墙
tput setaf 2
echo "Shutdown Firewall"
tput sgr0
if [ "$CURRENT_OS"x = "ubuntu"x ]; then
  sudo ufw disable
elif [ "$CURRENT_OS"x = "centos"x ]; then
  sudo systemctl stop firewalld.service
  sudo systemctl disable firewalld.service
fi

# * install oh-my-zsh
omzFolder=".oh-my-zsh"
if [ ! -x ~/"$omzFolder" ]; then
  tput setaf 2
  echo "Installing oh-my-zsh"
  tput sgr0
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
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

# * install pyenv
if [[ $var =~ .*pyenv.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing pyenv and python 3.7.0"
  tput sgr0
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
  cp CFG_files/zshrc ~/.zshrc
  source ~/.zshrc
  pyenv update
  if [ "$CURRENT_OS"x = "uos"x ]; then 
    CFLAGS=-I/usr/include/openssl LDFLAGS=-L/usr/lib pyenv install -v 3.7.0
  else
    ./shells/installPy.sh 3.7.0
  fi
fi

# * install thefuck
if [[ $var =~ .*thefuck.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing thefuck"
  tput sgr0
  pip install thefuck
fi

# * install Shadowsocks-Qt5
if [[ $var =~ .*Shadowsocks.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing Shadowsocks-Qt5"
  tput sgr0
  if [ "$CURRENT_OS"x = "ubuntu"x ]; then
    sudo add-apt-repository -y ppa:hzwhuang/ss-qt5
    sudo apt-get update -y
    eval "$sys_install libappindicator1 libindicator7 > /dev/null 2>&1"
    eval "$sys_install shadowsocks-qt5 > /dev/null 2>&1"
  elif [ "$CURRENT_OS"x = "centos"x ]; then
    wget https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo
    sudo mv librehat-shadowsocks-epel-7.repo /etc/yum.repos.d/
    sudo yum update
    eval "$sys_install shadowsocks-qt5 > /dev/null 2>&1"
  fi
fi

# * install VSCode
if [[ $var =~ .*Shadowsocks.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing VSCode"
  tput sgr0
  if [ "$CURRENT_OS"x = "ubuntu"x ]; then
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt-get update -y
    eval "$sys_install code > /dev/null 2>&1"
  elif [ "$CURRENT_OS"x = "centos"x ]; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    eval "$sys_install code > /dev/null 2>&1"
  fi
fi

# * install autojump
if [[ $var =~ .*autojump.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing autojump"
  tput sgr0
  if [ "$CURRENT_OS"x = "ubuntu"x ]; then
    eval "$sys_install autojump > /dev/null 2>&1"
    echo "INFO: autojump already installed!"
  elif [ "$CURRENT_OS"x = "centos"x ]; then
    eval "$sys_install autojump_zsh"
  fi
fi

# * install proxychains4
if [[ $var =~ .*proxychain.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing proxychains & SSR"
  tput sgr0
  # eval "$sys_install shadowsocks"
  # eval "$sys_install shadowsocks-libev"
  eval "$sys_install proxychains4 > /dev/null 2>&1"
  eval "$sys_install proxychains > /dev/null 2>&1"
  git clone -b manyuser https://github.com/shadowsocksrr/shadowsocksr.git ~/shadowsocksr
  sudo cp -n CFG_files/proxychains.conf /etc/
  sudo cp -n CFG_files/ssr_client.json /etc/shadowsocks.json
  # TODO ssr 的 client 需要配置
fi

# * Installing (config) vim&neovim
# eval "$sys_install neovim"
if [[ $var =~ .*neovim.* ]] || [[ $var =~ .*all.* ]]; then
  tput setaf 2
  echo "Installing (config) vim&neovim"
  tput sgr0
  cd ~
  tput setaf 1
  echo "!!! Git clone may need proxy and good network condition"
  tput sgr0
  git clone --depth 1 https://github.com/neovim/neovim.git ~/neovim
  cd ~/neovim
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
  cd ..
  # sudo rm -rf neovim
  if [ "$CURRENT_OS"x = "ubuntu"x ]; then
    sudo add-apt-repository ppa:jonathonf/vim
    eval "$sys_update"
    eval "$sys_install vim > /dev/null 2>&1"
  fi
  cd $BASEPATH
fi
./shells/cfgVim.sh

# * Copy fonts
tput setaf 2
echo "Installing fonts"
tput sgr0
# * for Ubuntu
find ./Fonts -type f -name *.[ot]tf -exec sudo cp "{}" /usr/local/share/fonts \;

# * Set zsh as default shell
tput setaf 2
echo "Set zsh as default shell"
tput sgr0
if [ "$CURRENT_OS"x = "ubuntu"x ]; then
  chsh -s /usr/bin/zsh
elif [ "$CURRENT_OS"x = "centos"x ]; then
  chsh -s /usr/zsh
fi

# * Something else
tput setaf 2
echo "Additional steps"
tput sgr0
pip install genpac

tput setaf 2
echo "# ${SCRIPT_NAME} Done"
tput sgr0
