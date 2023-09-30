# 使用官方的PyTorch镜像作为基础镜像
FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

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
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

RUN pip install git+https://github.com/facebookresearch/fvcore
RUN pip install cython
RUN pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI
#RUN pip install git+https://github.com/facebookresearch/detectron2.git
RUN pip install git+https://github.com/facebookresearch/segment-anything.git
RUN pip install git+https://github.com/huggingface/transformers.git

COPY requirements.txt .
RUN pip install -r requirements.txt

ENV JUPYTER_TOKEN=nngeo.net
COPY start-jupyter.sh /usr/local/bin/start-jupyter.sh
RUN chmod +x /usr/local/bin/start-jupyter.sh
CMD ["/usr/local/bin/start-jupyter.sh"]

