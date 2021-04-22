FROM dorowu/ubuntu-desktop-lxde-vnc:latest

EXPOSE 8555
EXPOSE 8444

ENV keys="generate"
ENV harvester="false"
ENV farmer="false"
ENV plots_dir="/plots"
ENV farmer_address="null"
ENV farmer_port="null"
ENV testnet="false"
ENV full_node_port="null"
ARG BRANCH=main

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y curl jq ansible tar bash ca-certificates git openssl unzip wget sudo acl build-essential python3-dev apt nfs-common vim

RUN echo "cloning ${BRANCH}"
RUN git clone --branch ${BRANCH} https://github.com/Chia-Network/chia-blockchain.git \
&& cd chia-blockchain \
&& git submodule update --init mozilla-ca \
&& chmod +x install.sh \
&& echo "deactivate" >> install.sh \
&& echo "exit 0" >> install.sh \
&& /usr/bin/sh ./install.sh \
&& . ./activate \
&& chmod +x install-gui.sh \
&& echo "deactivate" >> install-gui.sh \
&& echo "exit 0" >> install-gui.sh \
&& /usr/bin/sh ./install-gui.sh

WORKDIR /chia-blockchain
RUN mkdir /plots
#ADD ./entrypoint.sh entrypoint.sh
#WORKDIR /root
#ENTRYPOINT ["bash", "./entrypoint.sh"]