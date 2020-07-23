FROM cimg/base:2020.01
RUN sudo apt-get update && sudo apt-get upgrade -y
RUN sudo apt-get install -y build-essential libncursesw5-dev libreadline-gplv2-dev libssl-dev libgdbm-dev libc6-dev libsqlite3-dev libbz2-dev libffi-dev zlib1g-dev
RUN sudo apt-get install -y vim

WORKDIR /home/circleci

RUN curl -O https://nodejs.org/dist/v12.18.3/node-v12.18.3-linux-x64.tar.xz \
  && tar xf node-v12.18.3-linux-x64.tar.xz \
  && mv node-v12.18.3-linux-x64 node-v12

ENV PATH "/home/circleci/node-v12/bin:$PATH"

RUN node --version

RUN git clone https://github.com/python/cpython.git --depth 1 --branch v3.6.9

WORKDIR /home/circleci/cpython
RUN ./configure && make && sudo make install

WORKDIR /home/circleci
RUN python3 -m venv venv
ENV PATH "/home/circleci/venv/bin:$PATH"

RUN python --version

WORKDIR /home/circleci/project

RUN npm install -g yarn
RUN pip install -U pip
