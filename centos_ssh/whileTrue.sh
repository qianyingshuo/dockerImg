#!/usr/bin/env bash
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
