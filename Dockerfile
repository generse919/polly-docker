FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04
# パッケージのインストール
RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y git wget vim \
build-essential libbz2-dev libdb-dev \
libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
libncursesw5-dev libsqlite3-dev libssl-dev \
zlib1g-dev uuid-dev tk-dev libxkbcommon-x11-0

#pythonのインストール
RUN wget https://www.python.org/ftp/python/3.10.6/Python-3.10.6.tar.xz\
&& tar -xJf Python-3.10.6.tar.xz && cd Python-3.10.6 && ./configure && make && make install\
&& pip3 install --upgrade pip
RUN rm -rf Python-3.10.6*
#カスタムエイリアス(python, pipコマンドが使えるようにする)
RUN echo -e "alias python="python3"\nalias pip="pip3"" >> ~/.bash_aliases

# blenderのインストール
RUN wget https://mirrors.ocf.berkeley.edu/blender/release/Blender4.0/blender-4.0.1-linux-x64.tar.xz \
&& tar -xJf blender-4.0.1-linux-x64.tar.xz && mv blender-4.0.1-linux-x64 /opt/blender \
&& ln -sf /opt/blender/blender /usr/local/bin/blender \
&& rm -rf blender-4.0.1-linux*

#aptファイルを削除する(イメージファイルの大きさを減らす)
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

#作業ディレクトリ作成
WORKDIR /root/work/repos/
# COPY startup.sh ./startup.sh
# RUN chmod 744 /startup.sh
# CMD [ "./startup.sh" ]
CMD [ "/bin/bash" ]