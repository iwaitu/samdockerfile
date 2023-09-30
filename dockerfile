FROM pytorch/pytorch:2.0.1-cuda11.7-cudnn8-runtime

EXPOSE 8888


RUN apt-get update && apt-get install -y \
    apt-utils \
    vim \
    git 
RUN apt-get install wget gcc g++ -y
RUN apt-get install libsm6 libxext6 -y
RUN apt-get update
RUN apt-get install -y libgl1-mesa-glx

# 避免 debconf 报错
ENV DEBIAN_FRONTEND=noninteractive

# 安装需要的软件包
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN mkdir -p /root/.cache/torch/hub/checkpoints
RUN wget -P /root/.cache/torch/hub/checkpointsr https://github.com/huggingface/pytorch-image-models/releases/download/v0.1-weights/tf_efficientnet_b7_aa-076e3472.pth

RUN /bin/bash -c "source /root/miniconda3/bin/activate && \
    pip install pycocotools opencv-python opencv-contrib-python \
    git+https://github.com/facebookresearch/fvcore \
    cython git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI \
    git+https://github.com/facebookresearch/detectron2.git \
    git+https://github.com/facebookresearch/segment-anything.git \
    git+https://github.com/huggingface/transformers.git \
    datasets patchify scipy scikit-image scikit-learn tqdm tensorflow \
    jupyterlab notebook matplotlib datasets patchify scipy scikit-image scikit-learn \
    tqdm tensorflow jupyter-tensorboard matplotlib"

ENV JUPYTER_TOKEN=nngeo.net
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser", "--notebook-dir=/root/workspace"]
