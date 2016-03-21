#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH
wget -q http://people.redhat.com/~rjones/virt-what/files/virt-what-1.12.tar.gz
tar zxvf virt-what-1.12.tar.gz 1>/dev/null 2>&1
cd virt-what-1.12/
./configure 1>/dev/null 2>&1
make 1>/dev/null 2>&1
make install 1>/dev/null 2>&1
virt-what
