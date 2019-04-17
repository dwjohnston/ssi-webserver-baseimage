# build environment
FROM ubuntu:18.04 as builder
RUN mkdir /usr/src//app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
ENV GENESIS_PATH /usr/src/app/config/genesis.txn

COPY . /usr/src/app

# Install libindy
RUN apt-get update && apt-get install -y gnupg2
RUN apt install software-properties-common -y
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 68DB5E88
RUN add-apt-repository "deb https://repo.sovrin.org/sdk/deb xenial stable"
RUN apt-get update
RUN apt-get install -y libindy=1.6.8

# Install evernyn packages
RUN dpkg -i deb/libsovtoken_0.9.6_amd64.deb
RUN dpkg -i deb/libvcx_0.1.27328536-fb7b7b6_amd64.deb
RUN apt-get install -f

# Install node
RUN apt install nodejs -y 
RUN apt install npm -y
#WARN - SHOULD INSTALL FIXED VERSION OF NODE

