# ss
# default ss password 'default'
# tcp 6501
# udp 6500

FROM centos:7.3.1611

ENV SS_LIBEV_VERSION 3.0.6

ENV KCP_VERSION 20170329 

RUN rpm --rebuilddb \
	&& rpm --import \
		http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-7 \
	&& rpm --import \
		https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7 \
	&& rpm --import \
		https://dl.iuscommunity.org/pub/ius/IUS-COMMUNITY-GPG-KEY \
	&& yum -y install \
		centos-release-scl \
		centos-release-scl-rh \
		epel-release \
		https://centos7.iuscommunity.org/ius-release.rpm \
		vim-minimal-7.4.160-1.el7_3.1 \
        python-setuptools-0.9.8-4.el7 \
        bash.x86_64 \
        tzdata \
        libsodium \
        autoconf \
        build-base \
        curl \
        libev-devel \
        libtool \
        linux-headers \
        udns-devel \
        libsodium-devel \
        mbedtls-devel \
        pcre-devel \
        tar \
        mbedtls.x86_64 \
        mbedtls-devel.x86_64 \
    && curl -sSLO https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_LIBEV_VERSION/shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
    && tar -zxf shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz \
    && cd shadowsocks-libev-$SS_LIBEV_VERSION \
    && ./configure --prefix=/usr --disable-documentation \
    && make install && cd ../ \
    && curl -sSLO https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz \
    && tar -zxf kcptun-linux-amd64-$KCP_VERSION.tar.gz \
    && mv server_linux_amd64 /usr/bin/kcptun 

ADD whileTrue.sh /whileTrue.sh
ENTRYPOINT ["/whileTrue.sh"]
