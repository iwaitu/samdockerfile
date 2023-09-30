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
RUN python -m venv /opt/venv

COPY requirements.txt .
RUN /opt/venv/bin/activate && pip install -r requirements.txt

ENV JUPYTER_TOKEN=nngeo.net
COPY start-jupyter.sh /usr/local/bin/start-jupyter.sh
RUN chmod +x /usr/local/bin/start-jupyter.sh
CMD ["/usr/local/bin/start-jupyter.sh"]

