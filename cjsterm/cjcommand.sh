#!/usr/bin/env bash
#####./cjscpput.sh 39.104.149.174 root Hpb123456  ghpb.20180817.0.tar.gz
rm -rf ./logs
mkdir ./logs

######################################################################################
## scpput #scpput	默认上传/root/目录下	支付6个附件同时上传
######################################################################################

inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep scpput`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "scpput" && "$inum" != "0" ]];then
     	echo $i
	echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31 
	nohup ./cjscpput.sh $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9  $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31 >>./logs/scpput$k1-$date.log &
	inum=0 
	sleep 2
	cat ./logs/scpput$k1-$date.log
   fi
   inum=`expr $inum + 1`
   echo $inum
done

######################################################################################
### sftpput	上传配置目录	支持6个附件同时上传
######################################################################################
inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep sftpput`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "sftpput" && "$inum" != "0" ]];then
     	echo $i
	echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31
	./cjsftpput.sh $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31 >>./logs/sftpput$k1-$date.log
	inum=0 
	#sleep 2
	cat ./logs/sftpput$k1-$date.log
   fi
   inum=`expr $inum + 1`
   echo $inum
done

######################################################################################
### ssh	
######################################################################################
inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep ssh`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "ssh" && "$inum" != "0" ]];then
        echo $i
        echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31
        echo "nohup ./cjsssh.sh \"$k1\" \"$k2\" \"$k3\" \"$k4\" \"$k5\" \"$k6\" \"$k7\"  \"$k8\" \"$k9\" \"$k10\" \"$k11\" \"$k12\" \"$k13\" \"$k14\"  \"$k15\" \"$k16\" \"$k17\" \"$k18\" \"$k19\" \"$k20\" \"$k21\"  \"$k22\" \"$k23\" \"$k24\" \"$k25\" \"$k26\" \"$k27\" \"$k28\"  \"$k29\" \"$k30\" \"$k31\" >>./logs/ssh$k1-$date.log & "|sed "s/@/ /g" >>./$$.sh
        chmod +x ./$$.sh
        ./$$.sh
        chmod 644 ./$$.sh
        mv ./$$.sh ./logs/$k1.$$.sh.$inum.log
        inum=0 
        sleep 2
        cat ./logs/ssh$k1-$date.log
   fi  
   inum=`expr $inum + 1`
   echo $inum
done

######################################################################################
### sshinteract  依次执行ssh远程命令，可手工控制远程服务器20180830	
######################################################################################
inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep sshinteract`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "sshinteract" && "$inum" != "0" ]];then
        echo $i
        echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31
        echo "./cjsshinteract.sh \"$k1\" \"$k2\" \"$k3\" \"$k4\" \"$k5\" \"$k6\" \"$k7\"  \"$k8\" \"$k9\" \"$k10\" \"$k11\" \"$k12\" \"$k13\" \"$k14\"  \"$k15\" \"$k16\" \"$k17\" \"$k18\" \"$k19\" \"$k20\" \"$k21\"  \"$k22\" \"$k23\" \"$k24\" \"$k25\" \"$k26\" \"$k27\" \"$k28\"  \"$k29\" \"$k30\" \"$k31\" "|sed "s/@/ /g" >>./$$.sh
        chmod +x ./$$.sh
        ./$$.sh
        chmod 644 ./$$.sh
        mv ./$$.sh ./logs/$k1-$k4.$$.sh.$inum.log
        inum=0 
        sleep 2
        #cat ./logs/ssh$k1-$k4-$date.log
   fi  
   inum=`expr $inum + 1`
   echo $inum
done

rm -rf ./hpnodelog
mkdir ./hpnodelog

######################################################################################
####scpget	/root/kk1.txt	下载绝对路经文件名   ./表示把服务器内容下载到当前目录
######################################################################################

inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep scpget`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "scpget" && "$inum" != "0" ]];then
     	echo $i
	echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31
	nohup ./cjscpget.sh $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31 >>./logs/scpget$k1-$date.log &
	inum=0 
	sleep 2
	cat ./logs/scpget$k1-$date.log
   fi

   inum=`expr $inum + 1`
   echo $inum
done

########################################################################################
####sftpget配置远程服务器下载目录,下载文件名1至5个附件  ./表示把服务器内容下载到当前目录
########################################################################################

inum=0
date=`date "+%Y-%m-%d-%H"`
for i in `cat ./command.txt|grep -v "#"|grep sftpget`
do 
	if [ $inum = "1" ];then
		k1=$i
	elif [ $inum = "2" ];then
		k2=$i
	elif [ $inum = "3" ];then
		k3=$i
	elif [ $inum = "4" ];then
		k4=$i
	elif [ $inum = "5" ];then
		k5=$i
	elif [ $inum = "6" ];then
		k6=$i
	elif [ $inum = "7" ];then
		k7=$i
	elif [ $inum = "8" ];then
		k8=$i
	elif [ $inum = "9" ];then
		k9=$i
	elif [ $inum = "10" ];then
		k10=$i
	elif [ $inum = "11" ];then
		k11=$i
	elif [ $inum = "12" ];then
		k12=$i
	elif [ $inum = "13" ];then
		k13=$i
	elif [ $inum = "14" ];then
		k14=$i
	elif [ $inum = "15" ];then
		k15=$i
	elif [ $inum = "16" ];then
		k16=$i
	elif [ $inum = "17" ];then
		k17=$i
	elif [ $inum = "18" ];then
		k18=$i
	elif [ $inum = "19" ];then
		k19=$i
	elif [ $inum = "20" ];then
		k20=$i
	elif [ $inum = "21" ];then
		k21=$i
	elif [ $inum = "22" ];then
		k22=$i
	elif [ $inum = "23" ];then
		k23=$i
	elif [ $inum = "24" ];then
		k24=$i
	elif [ $inum = "25" ];then
		k25=$i
	elif [ $inum = "26" ];then
		k26=$i
	elif [ $inum = "27" ];then
		k27=$i
	elif [ $inum = "28" ];then
		k28=$i
	elif [ $inum = "29" ];then
		k29=$i
	elif [ $inum = "30" ];then
		k30=$i
	elif [ $inum = "31" ];then
		k31=$i
	else
		echo "I'm not"
	fi

   if [[ "$i" == "sftpget" && "$inum" != "0" ]];then
     	echo $i
	echo $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31
	./cjsftpget.sh $k1 $k2 $k3 $k4 $k5 $k6 $k7 $k8 $k9 $k10 $k11 $k12 $k13 $k14 $k15 $k16 $k17 $k18 $k19 $k20 $k21 $k22 $k23 $k24 $k25 $k26 $k27 $k28 $k29 $k30 $k31 >>./logs/sftpget$k1-$date.log 
	inum=0 
	#sleep 2
	cat ./logs/sftpget$k1-$date.log
   fi

   inum=`expr $inum + 1`
   echo $inum
done
