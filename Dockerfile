FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-runtime
# hadolint ignore=DL3008,DL3015,DL4006
RUN apt-get update && \
    apt-get install -y git curl software-properties-common && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3.12 python3-distutils && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /root/indic_translate_server
#RUN pip3.12 install --no-cache-dir --no-deps git+https://github.com/huggingface/parler-tts.git 
#COPY ./model_requirements.txt .
#RUN pip3.12 install --no-cache-dir -r model_requirements.txt
#COPY ./server_requirements.txt .
#RUN pip3.12 install --no-cache-dir -r server_requirements.txt
COPY ./requirements.txt .
RUN pip3.12 install --no-cache-dir -r requirements.txt

COPY ./indic_translate_server ./indic_translate_server
CMD ["uvicorn", "indic_translate_server.translate_api:app"]
ENV UVICORN_HOST=0.0.0.0
ENV UVICORN_PORT=8000
