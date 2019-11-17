#!/bin/bash

pyenv install 3.6.7
pyenv global 3.6.7
python -m pip install tf-nightly
python -m pip install tf-nightly-gpu

echo "添加下行到 bash 配置文件中"
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64"
echo "重新 login 以正确加载 TensorFlow"
