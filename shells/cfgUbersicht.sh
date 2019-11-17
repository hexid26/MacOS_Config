#!/bin/zsh
# 配置 Übersicht

if [ ! -x ~"/Library/Application Support/Übersicht/.git" ]; then
  echo "INFO: Get Übersicht sync config."
  rm -rfv ~/Library/Application\ Support/Übersicht
  mkdir -p ~/Library/Application\ Support/Übersicht
  cd ~/Library/Application\ Support/Übersicht
  git clone https://github.com/hexid26/Ubersicht_Widgets.git ./
fi
echo "INFO: Übersicht config downloaded!"