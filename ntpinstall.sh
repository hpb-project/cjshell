#!/bin/bash
wget http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p12.tar.gz
tar zxvf ntp-4.2.8p12.tar.gz 
cd ntp-4.2.8p12/
ls
./configure 
make -j8
make install
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
ntpdate cn.pool.ntp.org
hwclock --systohc
