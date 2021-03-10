FROM ubuntu:18.04
RUN mkdir -p /env
RUN apt-get clean
RUN apt-get upgrade
RUN apt-get update
RUN apt-get -y install python3
RUN apt-get -y install python3-pip
RUN apt-get -y install curl git wget zip
RUN pip3 install conan
# install clang
RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic main" >> /etc/apt/sources.list
RUN echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main" >> /etc/apt/sources.list
RUN echo "deb-src http://apt.llvm.org/bionic/ llvm-toolchain-bionic-9 main" >> /etc/apt/sources.list
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt update
RUN apt-get -qq install -y --no-install-recommends --allow-unauthenticated clang-9 python-lldb-9 lldb-9
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/clang-9 100
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/clang++-9 100
RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-9 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-9 100
# install cmake
RUN mkdir -p ~/env
WORKDIR /root/env
COPY ./cmake.zip ./
RUN unzip ./cmake.zip -d /root/env/cmake
RUN ln -s /root/env/cmake/bin/cmake /usr/bin/cmake
WORKDIR /root