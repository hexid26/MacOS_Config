# MacOS/Linux config scripts

## What to Install / Config

This is the list what to do.  

●　**INSTALL**

**For MacOS**

- Install `homebrew`
- Install `mas`via `brew`
- Install `neovim`via `brew`
- Install `thefuck`via `brew`
- Install `pyenv`via `brew`
- Install `python`via `pyenv`
- Install `R` via `brew`
- Install `autojump`via `brew`
- Install `proxychain`via `brew`
- Install `VSCode`for`Linux`
- Install `Shadowsocks`for`Linux`

**For Linux (CentOS/Ubuntu)**

```
build-essential bzip2 bzip2-devel clang cmake curl exfat-utils freeglut3-dev fuse-exfat g++ gcc git libbz2-dev libglu1-mesa libglu1-mesa-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev libssl-dev libx11-dev libxi-dev libxmu-dev llvm openssh openssh-server openssl-devel qt5-qtwebkit readline-devel sqlite sqlite-devel tk-dev wget xz xz-devel xz-utils zlib-devel zlib1g-dev zsh 
v
```

●　**CONFIGURATION**

- Install `oh-my-zsh`
- Install `powerlevel10k`
- Config `oh-my-zsh`
- Config `Vim|Neovim`
- Config `Übersicht`
- Config `bash`
- Config `zsh`
- Config `iterm2`
- Shutdown `iptables`
- Install fonts for `Linux`

●　**NOTICE**

`iTerm2` need to be installed manually.
`Fonts` folder contains the fonts needed in configuration.

On linux, the color theme of `Terminals` should be set to `solarized` to display correct colors.

## HOW TO USE

Creat a shell file below and run it.

```shell
mkdir ./MacOS_Config
cd MacOS_Config
git clone https://github.com/hexid26/MacOS_Config.git
./AutoInstall.sh all
# ./LinuxAutoInstall.sh
cd ..
# rm -rfv MacOS_Config
```

----

## UPDATE
### 2019-11-16
- Add `proxychain` for `Linux`

### 2019-11-15
- Merge shell for CentOS and Ubuntu
- Add `proxychain` for `MacOS`
- Add `neovim`
- Rewrite the code

### 2018-06-22
- Add Ubuntu config

### 2018/04/21
- Add `AutoInstall.sh` to install programs.
- Use `AutoConfig.sh` for config.
- Add `Disable GateKeeper` in `AutoInstall.sh`

### 2017/05/17
- Add `thefuck` install to AutoConfig.sh

### 2017/04/05
- Modify the theme `agnoster`
- Fix python install issue.
- Fix `profile` destination filename to `bash_profile`.
- Update iTerm2 dynamic config.

### 2017/04/04
- Add alias to delete all ‘.DS_Store’ files on disk.
