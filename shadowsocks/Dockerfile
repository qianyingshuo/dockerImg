# ss
# default ss password 'default'
# kcppasswd KCPPASS
# ss password SSPASS
# tcp 6501
# udp 6500

FROM centos:7.3.1611

ENV SS_LIBEV_VERSION 3.0.6

ENV KCP_VERSION 20170329 

RUN rpm --rebuilddb 
RUN	rpm --import http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 
RUN	rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 
RUN	rpm --import https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY 
RUN	yum -y install \
		centos-release-scl \
		centos-release-scl-rh \
		epel-release \
		https://centos7.iuscommunity.org/ius-release.rpm 
RUN yum -y install  python-setuptools-0.9.8-4.el7 \
        bash.x86_64 \
        tzdata \
        libsodium \
        autoconf \
        build-base \
        curl \
        libev-devel \
        libtool \
        kernel-headers\
        udns-devel \
        libsodium-devel \
        mbedtls-devel \
        pcre-devel \
        tar \
        mbedtls.x86_64 \
        mbedtls-devel.x86_64 \
        make.x86_64
RUN curl -sSLO https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_LIBEV_VERSION/shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz 
RUN tar -zxf shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz 
RUN cd shadowsocks-libev-$SS_LIBEV_VERSION && ./configure --prefix=/usr --disable-documentation && make install
RUN curl -sSLO https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz 
RUN tar -zxf kcptun-linux-amd64-$KCP_VERSION.tar.gz 
RUN mv server_linux_amd64 /usr/bin/kcptun 

EXPOSE 6501
EXPOSE 6500

ADD whileTrue.sh /usr/bin/whileTrue.sh
RUN chmod +x /usr/bin/whileTrue.sh
# ENTRYPOINT ["/usr/bin/whileTrue.sh"]
CMD ["/usr/bin/whileTrue.sh"]
