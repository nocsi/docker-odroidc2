FROM nocsigroup/archlinux-aur:latest
MAINTAINER nocsi <l@nocsi.com>

RUN pacman -Sy --noconfirm --noprogress && pacman -S --noconfirm --noprogress --needed wget bc
RUN mkdir -p /opt/toolchains
#RUN curl -O http://dn.odroid.com/toolchains/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz
RUN wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64-elf/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf.tar.xz
RUN tar xvf gcc-linaro-4.9-2016.02-x86_64_aarch64-elf.tar.xz -C /opt/toolchains
#RUN tar xvf gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz -C /opt/toolchains

#ENV PATH /opt/toolchains/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux/bin/:$PATH
ENV PATH /opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf/bin/:$PATH
RUN echo "export ARCH=arm \
		export CROSS_COMPILE=aarch64-none-elf- \
		export PATH=/opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-elf/bin/:$PATH" >> ~/.bashrc

ADD docker-entrypoint.sh /usr/bin/
RUN chmod a+x /usr/bin/docker-entrypoint.sh
RUN mkdir -p /uboot/{out,src}

VOLUME ["/uboot/out"]

WORKDIR /uboot

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
