FROM docker.oa.com:8080/public/ailab-py3-torch:latest AS base

RUN wget https://storage.googleapis.com/bert_models/2018_11_03/chinese_L-12_H-768_A-12.zip -qO temp.zip; unzip temp.zip; rm temp.zip

RUN wget https://gnes-1252847528.cos.ap-guangzhou.myqcloud.com/zhs.model.tar.bz2 -qO zhs.model.tar.bz2; tar -xvjf zhs.model.tar.bz2; rm zhs.model.tar.bz2

RUN wget https://gnes-1252847528.cos.ap-guangzhou.myqcloud.com/openai_gpt.tar.bz2 -qO openai_gpt.tar.bz2; tar -xvjf openai_gpt.tar.bz2; rm openai_gpt.tar.bz2

RUN wget https://gnes-1252847528.cos.ap-guangzhou.myqcloud.com/openai_gpt2.tar.bz2 -qO openai_gpt2.tar.bz2; tar -xvjf openai_gpt2.tar.bz2; rm openai_gpt2.tar.bz2

RUN wget https://s3.eu-central-1.amazonaws.com/alan-nlp/resources/embeddings-v0.4/lm-multi-forward-fast-v0.1.pt; mkdir -p /root/.flair/embeddings/; mv lm-multi-forward-fast-v0.1.pt /root/.flair/embeddings/

WORKDIR /nes/

ADD . ./
RUN pip install -U -e .

FROM base AS encoder

ENTRYPOINT ["gnes", "encode"]

FROM base AS indexer

ENTRYPOINT ["gnes", "index"]