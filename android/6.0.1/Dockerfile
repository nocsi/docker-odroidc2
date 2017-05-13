FROM registry.nocsi.org/ubuntu:trusty
MAINTAINER nocsi <l@nocsi.com>

ENV LANG en_US.UTF-8
RUN locale-gen $LANG

ENV DEBIAN_FRONTEND noninteractive

RUN rm -rf /var/lib/apt/lists/*

RUN apt-get update \
  && apt-get install -y ca-certificates apt-transport-https
  # Unset the sed commands. Unless for some reason you're
  # on nocnet and can reach the offline apt-get mirror
RUN echo nameserver 10.100.35.1 > /etc/resolve.conf \
  && sed 's@http://archive.ubuntu.com@https://apt.nocsi.org@' -i /etc/apt/sources.list \
  && sed 's@http://security.ubuntu.com@https://apt.nocsi.org@' -i /etc/apt/sources.list \
  && apt-get update \
  && apt-get dist-upgrade -y

RUN apt-get install -y \
  autoconf \
  build-essential \
  bzip2 \
  curl \
  gcc \
  git \
  groff \
  lib32stdc++6 \
  lib32z1 \
  lib32z1-dev \
  lib32ncurses5 \
  lib32bz2-1.0 \
  libc6-dev \
  libgmp-dev \
  libmpc-dev \
  libmpfr-dev \
  libxslt-dev \
  libxml2-dev \
  libunwind8 \
  m4 \
  make \
  ncurses-dev \
  ocaml \
  openssh-client \
  pkg-config \
  python-software-properties \
  rsync \
  software-properties-common \
  uuid-runtime \
  unzip \
  wget \
  zip \
  zlib1g-dev \
  --no-install-recommends

# Toolchain for U-Boot
RUN wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64-elf/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf.tar.xz && \
    mkdir -p /opt/toolchains && \
    tar xvf gcc-linaro-4.9-2016.02-x86_64_aarch64-elf.tar.xz -C /opt/toolchains/ && \
    echo "export ARCH=arm \         export CROSS_COMPILE=aarch64-none-elf- \        export PATH=/opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf/bin/:$PATH" >> ~/.bashrc && \
    rm -f gcc-linaro-*
ENV PATH /opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf/bin/:$PATH

# Toolchain for Kernel
RUN wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64-linux-gnu/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz && \
    tar xvf gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz -C /opt/toolchains && \
    echo "export ARCH=arm64 \
    export CROSS_COMPILE=aarch64-linux-gnu- \
    export PATH=/opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu/bin/:$PATH" >> ~/.bashrc && \
    rm -f gcc-linaro-*
ENV PATH /opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu/bin/:$PATH

# Android AOSP
RUN curl -O http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre-headless_8u45-b14-1_amd64.deb && \
    curl -O http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jre_8u45-b14-1_amd64.deb && \
    curl -O http://archive.ubuntu.com/ubuntu/pool/universe/o/openjdk-8/openjdk-8-jdk_8u45-b14-1_amd64.deb && \
    apt-get update -y && \
    dpkg -i *.deb ; exit 0 
RUN apt-get -f -y install && \
    rm -f *.deb

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

ADD docker-entrypoint.sh /usr/bin/
RUN chmod a+x /usr/bin/docker-entrypoint.sh
RUN mkdir -p /android/src && \
    mkdir -p /android/bin

VOLUME ["/android/src"]

WORKDIR /android
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /android/bin/repo && \
    chmod a+x /android/bin/repo
ENV PATH "$PATH:/android/bin"
ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
