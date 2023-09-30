# 使用官方的PyTorch镜像作为基础镜像
FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-runtime

# 暴露Jupyter Lab需要的端口
EXPOSE 8888

# 更新系统并安装必要的工具
RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    git \
    wget \
    gcc \
    g++ \
    libsm6 \
    libxext6 \
    libgl1-mesa-glx

# 创建Python虚拟环境
RUN python -m venv /venv

# 激活虚拟环境并安装必要的Python包
RUN /bin/bash -c "source /venv/bin/activate && \
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

# 设置Jupyter Lab的启动命令
ENV JUPYTER_TOKEN=nngeo.net
CMD ["/bin/bash", "-c", "source /venv/bin/activate && jupyter lab --ip=0.0.0.0 --port=8888 --allow-root --no-browser --notebook-dir=/root/workspace"]

