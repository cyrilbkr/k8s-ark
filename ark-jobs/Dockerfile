FROM debian:9

RUN apt-get update ; apt-get install -y wget 

WORKDIR /root

RUN wget https://github.com/itzg/rcon-cli/releases/download/1.4.7/rcon-cli_1.4.7_linux_amd64.tar.gz
RUN tar -xvf rcon-cli_1.4.7_linux_amd64.tar.gz 
RUN mv rcon-cli /usr/local/bin/
RUN rm -rf * 


RUN mkdir /opt/ark

COPY ark-jobs/jobs /opt/ark/

WORKDIR /opt/ark
