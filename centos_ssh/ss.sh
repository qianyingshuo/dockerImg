#!/usr/bin/env bash

SS_LIBEV_VERSION=3.0.6

KCP_VERSION=20170329 


yum -y install  python-setuptools-0.9.8-4.el7 \
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
curl -sSLO https://github.com/shadowsocks/shadowsocks-libev/releases/download/v$SS_LIBEV_VERSION/shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz 
tar -zxf shadowsocks-libev-$SS_LIBEV_VERSION.tar.gz 
cd shadowsocks-libev-$SS_LIBEV_VERSION && ./configure --prefix=/usr --disable-documentation && make install
curl -sSLO https://github.com/xtaci/kcptun/releases/download/v$KCP_VERSION/kcptun-linux-amd64-$KCP_VERSION.tar.gz 
tar -zxf kcptun-linux-amd64-$KCP_VERSION.tar.gz 
mv server_linux_amd64 /usr/bin/kcptun 

sspasswd="default"
kcpasswd=""

if [[ ${#} -gt 0 ]]
then
echo 'ss';
sspasswd=${1};
fi
if [[ ${#} -gt 1 ]]
then
echo 'kcp';
kcpasswd=${2}
fi
ssFlag=false;
kcpFlag=false;

while true;
do

echo "BEGIN WhileTrue";
if [ $(ps -ef | grep ss-server | grep -v grep | wc -l) -gt 0 ];then
    kcpFlag=true;
else
    if [ "${kcpasswd}" == "" ];then
        kcptun -t 127.0.0.1:6501 -l :6500 --mode fast2 &
    else
        kcptun -t 127.0.0.1:6501 -l :6500 --mode fast2 --key ${kcpasswd} &
    fi
fi

if [ $(ps -ef | grep ss-server | grep -v grep | wc -l) -gt 0 ];then
    ssFlag=true;
else
    ss-server -s :: -s 0.0.0.0 -p 6501 -m aes-256-cfb -k ${sspasswd} --fast-open &
fi


if ${ssFlag} && ${kcpasswd};then
    sleep 5;
fi
done
