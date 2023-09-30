#!/bin/bash

# 激活你的 conda 环境
source /opt/conda/bin/activate

pip install --no-cache-dir \
    pycocotools \
    opencv-python \
    opencv-contrib-python \
    git+https://github.com/facebookresearch/fvcore \
    cython \
    git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI \
    git+https://github.com/facebookresearch/detectron2.git \
    git+https://github.com/facebookresearch/segment-anything.git \
    git+https://github.com/huggingface/transformers.git \
    datasets \
    patchify \
    scipy \
    scikit-image \
    scikit-learn \
    tqdm \
    tensorflow \
    jupyterlab \
    notebook \
    matplotlib"
    
pip install --upgrade jupyter ipywidgets

# 启动 Jupyter Lab
jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --notebook-dir=/root/workspace
