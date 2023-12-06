FROM ubuntu:22.04

LABEL maintainer="sebastian.sucker@googlemail.com"

ENV TZ=Europe/Berlin

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update

RUN apt install -y gcc-12=12.3.0-1ubuntu1~22.04 g++-12=12.3.0-1ubuntu1~22.04 cmake=3.22.1-1ubuntu1.22.04.1  doxygen=1.9.1-2ubuntu2 doxygen-doc=1.9.1-2ubuntu2 graphviz=2.42.2-6 texlive=2021.20220204-1 plantuml=1:1.2020.2+ds-1 libcrypto++-dev=8.6.0-2ubuntu1 libpqxx-dev=6.4.5-2build1 libqpid-proton-cpp12-dev=0.22.0-5.1ubuntu2 libjsoncpp-dev=1.9.5-3 jq=1.6-2.1ubuntu3

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 12
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-12 12

RUN apt install -y git

RUN apt-get -y --purge remove libboost-all-dev libboost-doc libboost-dev

RUN apt-get -y install python3-dev python-dev-is-python3 autotools-dev libicu-dev libbz2-dev wget

RUN mkdir /tmp/boost; cd /tmp/boost/; wget https://boostorg.jfrog.io/artifactory/main/release/1.83.0/source/boost_1_83_0.tar.gz; tar -zxvf boost_1_83_0.tar.gz
RUN cd /tmp/boost/boost_1_83_0; ./bootstrap.sh  --with-toolset=gcc; ./b2 --with=all -j4 install

RUN rm -rf /tmp/boost
