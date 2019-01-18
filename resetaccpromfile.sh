##################################
##高性能节点增加与减少重新初始化
##################################
killall ghpb
killall iperf3
rm -rf ./hanxiaole.json

i=0
for accname in `cat ./acc.txt`
do
   i=`expr $i + 1`
      echo $i  $accname

   if [ $i = "1" ];then
         num1=$accname
   elif [ $i = "2" ];then
         num2=$accname
   elif [ $i = "3" ];then
         num3=$accname
   elif [ $i = "4" ];then
         num4=$accname
   elif [ $i = "5" ];then
         num5=$accname
   elif [ $i = "6" ];then
         num6=$accname
   elif [ $i = "7" ];then
          num7=$accname
   elif [ $i = "8" ];then
         num8=$accname
   elif [ $i = "9" ];then
          num9=$accname
   elif [ $i = "10" ];then
         num10=$accname
   else
      echo "I'm not"
   fi
done

echo $num1
echo $num2
echo $num3
echo $num4
echo $num5
echo $num6
echo $num7
echo $num8
echo $num9
echo $num10
##################################################
##promfile自动工具
##默认为6个挖矿从第二个账户开始,配置增加与减少
##默认为第二个账户有余额,其他没有
##################################################
./cjshell/repromtest.sh $num2 $num3 $num4 $num5 $num6

##########################
##初始化节点
##########################
for id in `seq 10`
do
   echo node$id
   ./ghpb --datadir node$id/data init hanxiaole.json
done
