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
RUN apt-get install libglib2.0-0 -y
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir /root/.conda \
    && bash Miniconda3-latest-Linux-x86_64.sh -b \
    && rm -f Miniconda3-latest-Linux-x86_64.sh 
RUN conda init && conda config --set always_yes yes --set changeps1 no
RUN conda --version
RUN pip install pycocotools
RUN pip install opencv-python
RUN pip install opencv-contrib-python -i https://pypi.tuna.tsinghua.edu.cn/simple
RUN pip install git+https://github.com/facebookresearch/fvcore
RUN pip install cython
RUN pip install git+https://github.com/philferriere/cocoapi.git#subdirectory=PythonAPI
RUN python -m pip install 'git+https://github.com/facebookresearch/detectron2.git'
RUN git clone https://github.com/WongKinYiu/yolov7.git
RUN pip install -r yolov7/requirements.txt

RUN pip install git+https://github.com/facebookresearch/segment-anything.git
RUN pip install -q git+https://github.com/huggingface/transformers.git
RUN pip install datasets
RUN pip install patchify
RUN pip install scipy
RUN pip install scikit-image
RUN pip install scikit-learn
RUN pip install tqdm
RUN pip install matplotlib

RUN pip install ipywidgets
RUN pip install jupyterlab
RUN pip install matplotlib
RUN jupyter nbextension enable --py widgetsnbextension
ENV JUPYTER_TOKEN=123456
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--allow-root", "--no-browser"]
