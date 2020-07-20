#!/bin/zsh
# Install python with PYENV via shell
# 可以在 pip 命令后添加需要安装的其他模块
# 尽量用 sudo 命令执行

version=$1

function installPy() {
  check_version=$(uname -s)
  if [[ $check_version == "Darwin" ]]; then
    # MacOS
    tput setaf 1
    echo "System is MacOS"
    tput sgr0
    export LDFLAGS="-L/usr/local/opt/sqlite/lib -L/usr/local/opt/zlib/lib"
    export CPPFLAGS="-I/usr/local/opt/sqlite/include -I/usr/local/opt/zlib/include"
    tput setaf 2
    echo "Installing Python $version"
    tput sgr0
    PYTHON_CONFIGURE_OPTS="--enable-framework" pyenv install $version
  else
    # Not MacOS
    tput setaf 1
    echo "System is $check_version"
    tput sgr0
    tput setaf 2
    echo "Installing Python $version"
    tput sgr0
    pyenv install -v $version
  fi
  pyenv rehash
  pyenv global $version
  pyenv version
  pyenv rehash
  # 可以自行改变需要安装的插件
  tput setaf 2
  echo "Installing pip and components"
  tput sgr0
  pip install --upgrade pip
  python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --trusted-host pypi.tuna.tsinghua.edu.cn pylint numpy threadpool thefuck scipy yapf matplotlib networkx neovim
}

installPy
