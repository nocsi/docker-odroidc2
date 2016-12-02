FROM nocsigroup/archlinux-aur:latest
MAINTAINER nocsi <l@nocsi.com>

RUN sed -i '/#\[multilib\]/,/#Include = \/etc\/pacman.d\/mirrorlist/ s/#//' /etc/pacman.conf
RUN sed -i '/#\[multilib\]/,/#Include = \/etc\/pacman.d\/mirrorlist/ s/#//' /etc/pacman.conf
RUN sed -i 's/#\[multilib\]/\[multilib\]/g' /etc/pacman.conf

RUN pacman -Syy --noconfirm --noprogress && pacman -S --noconfirm --noprogress --needed wget bc ncurses glibc lib32-zlib lib32-libstdc++5 lzop
RUN mkdir -p /opt/toolchains
#RUN curl -O http://dn.odroid.com/toolchains/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux.tar.xz
RUN wget https://releases.linaro.org/components/toolchain/binaries/4.9-2016.02/aarch64-linux-gnu/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz
RUN tar xvf gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu.tar.xz -C /opt/toolchains
ENV PATH /opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu/bin/:$PATH

RUN echo "export ARCH=arm64 \
		export CROSS_COMPILE=aarch64-linux-gnu- \
		export PATH=/opt/toolchains/gcc-linaro-4.9-2016.02-x86_64_aarch64-linux-gnu/bin/:$PATH" >> ~/.bashrc

ADD docker-entrypoint.sh /usr/bin/
RUN chmod a+x /usr/bin/docker-entrypoint.sh
RUN mkdir -p /linux/src

VOLUME ["/linux/src"]

WORKDIR /linux

ENTRYPOINT ["/usr/bin/docker-entrypoint.sh"]
