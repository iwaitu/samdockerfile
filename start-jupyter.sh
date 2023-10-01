#!/bin/bash

# 激活你的 conda 环境
source /opt/conda/bin/activate

# 启动 Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --notebook-dir=/root/workspace --ServerApp.iopub_msg_rate_limit=1000000000
