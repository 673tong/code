#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
export PATH

#======以下配置根据实际情况修改=========
#备份哪些文件夹,多个文件夹用英文逗号","分隔,文件夹需要时绝对路径
folder="/home/wwwwroot/www.91yun.org"
#备份那些数据库（数据库的备份原理：导出成sql文件，备份这个sql文件，到时要恢复，需要手动导入这个sql文件）,多个数据库用英文逗号分隔",",如果多个数据库权限不同，就填root的用户名和密码
db="91yun"
#数据库的用户名和密码，需要确保这个账号的权限可以操作以上所有数据库
username="91yun"
password="www.91yun.org!@##@!"
#数据库导出的sql保存在哪个目录
bakfolder=/home/bak/
#远程备份机用于同步的密码
rsyncpassword="rongdedewordpress"
#=======配置修改完毕，下面的代码如果看不懂尽量不要乱动==========


#服务器环境搭配，生成rsync的备份配置文件
function rsyncinstall()
{
	yum -y install xinetd rsync wget vim curl
	wget https://download.samba.org/pub/rsync/src-previews/rsync-3.1.2pre1.tar.gz
	wget https://download.samba.org/pub/rsync/src-previews/rsync-patches-3.1.2pre1.tar.gz
	tar -zxvf rsync-3.1.2pre1.tar.gz
	tar -zxvf rsync-patches-3.1.2pre1.tar.gz
	cd rsync-3.1.2pre1
	./configure
	make
	make install
	sed -i 's/disable\s=\syes/disable = no/g' /etc/xinetd.d/rsync
	service xinetd restart
	chkconfig xinetd on
	iptables -A INPUT -p tcp -m tcp --dport 873 -j ACCEPT
	service iptables save 
	service iptables restart
	echo "root:"$rsyncpassword >> /etc/rsyncd.secrets
	chown root:root /etc/rsyncd.secrets
	chmod 600 /etc/rsyncd.secrets	
}

function check_rsycn_conf()
{
	if [ ! -a "/etc/rsyncd.conf" ]; then
		wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/code/master/rsyncd.conf 
		mv rsyncd.conf /etc/
	fi	
}

#以上，服务器的rsync的环境配备完毕。

#以下，开始循环备份目录，以及生成目录相关的配置文件
function rsync_conf()
{
	#创建备份目录
	folder_name = `echo $folder | awk -F '/' '{print $NF}'`
}

第三部，生成服务器端备份的定时脚本（导出sql）
第四部，把定时脚本写入服务器端的crontab
第五步，生成客户端的执行脚本
生成2个基本文件
1.服务器定时备份脚本
	
2.远程备份机定时备份脚本
