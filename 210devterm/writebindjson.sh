>boebinding.json
echo "[" >> boebinding.json
for k in `seq 40`
do
        num=0
	for i in `cat ./logs/hardware$k.txt|awk -F':' '{print $2}'`
	do
           num=`expr $num + 1`
	   if [ $num = "1" ];then
		     a=$i
		echo $num $a
	   elif [ $num = "2" ];then
		     b=$i
		echo $num $b
	   elif [ $num = "3" ];then
		     c=$i
		echo $num $c
	        echo "{\"coinbase\":\""$a"\",\"cid\":\"$c\",\"hid\":\""$b"\"}," >>boebinding.json
	   fi
	done
done
echo "]" >> boebinding.json
####################################
##自动boebinding.json delete最后一行的，
####################################

for iabc in `tail -n 2 boebinding.json |awk -F':' '{print $4}'`
do 
   echo $iabc
   kki=`echo $iabc|sed 's/},/}/g'`
   echo $kki
   sed 's/'"$iabc"'/'"$kki"'/g' boebinding.json >boebinding.json.bak
done
cp boebinding.json.bak boebinding.json
