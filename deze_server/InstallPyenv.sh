#!/bin/bash

# install pyenv
if [[ $var =~ .*pyenv.* ]] || [[ $var =~ .*all.* ]]; then
  echo "Install pyenv"
  curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | zsh
  pyenv update
fi

echo "确保 bash 配置文件中有如下几行"
echo 'export PATH="${HOME}/.pyenv/bin:$PATH"'
echo 'eval "$(pyenv init -)"'
echo 'eval "$(pyenv virtualenv-init -)"'
echo "重新 login 确保 pyenv 可以正常工作后，用 pyenv install 安装 Python 指定版本，例如："
echo "pyenv install 3.7.0"
