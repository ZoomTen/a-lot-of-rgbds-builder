FROM muslcc/x86_64:x86_64-linux-musl

RUN apk update && \
    apk add \
        make \
        m4 \
        patch \
        pkgconfig \
        bash

RUN mkdir -p /tools

RUN cd /tools && \
    wget http://ftp.gnu.org/gnu/bison/bison-2.6.tar.gz && \
    wget http://ftp.gnu.org/gnu/bison/bison-3.7.6.tar.gz && \
    wget https://www.zlib.net/fossils/zlib-1.2.10.tar.gz && \
    wget https://download.sourceforge.net/libpng/libpng-1.6.28.tar.gz && \
    wget https://github.com/westes/flex/releases/download/v2.6.3/flex-2.6.3.tar.gz

RUN cd /tools && \
    tar xvf bison-2.6.tar.gz && \
    tar xvf bison-3.7.6.tar.gz && \
    tar xvf zlib-1.2.10.tar.gz && \
    tar xvf libpng-1.6.28.tar.gz && \
    tar xvf flex-2.6.3.tar.gz

RUN \
    echo -e '#!/bin/sh\ngcc -std=c99 ${1+"$@"}' > /usr/bin/c99 && \
    chmod +x /usr/bin/c99

ENV CFLAGS="-static -D_GNU_SOURCE -L/usr/local/lib/ -I/usr/local/include/ "
ENV CXXFLAGS="-static -D_GNU_SOURCE -L/usr/local/lib/ -I/usr/local/include/ "
ENV CPPFLAGS="-static -D_GNU_SOURCE -L/usr/local/lib/ -I/usr/local/include/ "
ENV PKG_CONFIG_PATH="/usr/local/lib/pkgconfig"

RUN mkdir /work
WORKDIR /work
CMD ["bash"]
