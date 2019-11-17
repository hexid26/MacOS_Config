#!/bin/bash

echo "添加用户 $1"
sudo adduser $1
sudo adduser $1 cdrom
sudo adduser $1 dip
sudo adduser $1 plugdev
sudo adduser $1 sambashare
sudo adduser $1 nogroup
sudo adduser $1 lpadmin
sudo chsh $1 -s /bin/bash

echo "添加到管理员请手动执行命令"
echo "sudo adduser $1 adm"
echo "添加到 sudo 请手动执行命令"
echo "sudo adduser $1 sudo"