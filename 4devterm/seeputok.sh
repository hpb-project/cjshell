./seeerrscp.sh
./seeshftp.sh
ps -ef |grep expect
hxl=`wc -l command.txt|awk '{print $1}'`
hxl1=`cat ./logs/*.log|grep "100%"|wc -l`
hxl2=`expr $hxl - 2`
if [ $hxl1 = $hxl2 ];then
	echo "command rows send ok" $hxl1 == $hxl2
else
	echo "command rows send error" $hxl1 != $hxl2
        tmprow=`expr $hxl2 - $hxl1`
        errrow=`expr $tmprow + 1`
        echo "ping ip ======================error====================================="
        ls -ltrh ./logs/|head -n $errrow|awk -F'-' '{print $6}'|awk -F'put' '{print $2}'
        echo "ping ip ======================error====================================="
	exit
fi
