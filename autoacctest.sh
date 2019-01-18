echo "==============支持自动生成启动节点shell脚本=============================="
echo "       1.输入密码，自动生成启动BOE硬件节点shell脚本                      "
echo "       2.不输入密码按回车键，自动生产testmode模式,不启动BOE硬件节点shell脚本"
read -t 30 -s -p "自动化生成启动BOE硬件节点脚本,请输入远程/本机超级用户密码:" age 
echo -e "\n"

if [ -z $age ];then
      echo "超级用户密码为空，走自动生成无硬件节点脚本^_^"
      echo -e "\n"
else
      echo "自动化生成启动BOE硬件节点脚本,超级用户密码为:$age"
      echo -e "\n"
fi
sleep 3
##################################################
##promfile自动工具
##默认为6个挖矿从第二个账户开始
##默认为第二个账户有余额,其他没有
##################################################
echo "==============此脚本支持使用promfile工具免输入账户自动化生成json文件=================================="
echo "       1.按回车键,默认为6个挖矿从第二个账户开始,默认为第二个账户有余额,其他没有"
echo "       2.自定义最多8个初始挖矿账户,从第二个账户开始,输入允许挖矿账户的个数"
read -t 30 -s -p "自此脚本支持使用promfile工具免输入账户自动生成json文件，请输入允许挖矿账户的个数:" work 
echo -e "\n"

if [ -z $work ];then
      echo "挖矿账户的个数为空，自动生成默认为6个挖矿从第二个账户开始,默认为第二个账户有余额,其他没有&^_^&"
      echo -e "\n"
else
      echo "自动化生成挖矿账户的个数为:$work"
      echo -e "\n"
fi
sleep 3

##########################
##自动生成10账户20180727
##########################
killall ghpb
killall iperf3
rm -rf ./node*
rm -rf ./acc.txt
rm -rf ./hanxiaole.json
rm -rf ./hxl.txt
rm -rf ./testnode

>./acc.txt
for k in `seq 10`
do
   echo node$k
   rm -rf ./node$k
   mkdir node$k
   ./cjshell/exptest.sh node$k
   cp  ./binding.json ./node$k/data/
   cat ./hxl.txt|sed 's/^M//g'|sed 's/{/|/g'|sed 's/}/|/g'|awk -F '|' '{print $2}'|sed '/^$/d' >>acc.txt
done
######################
##取账户信息20180727
######################
rm -rf ./testnode
mkdir -p ./testnode/logs
mkdir -p ./testnode/attach
mkdir -p ./testnode/hptail
mkdir -p ./testnode/nohup
mkdir -p ./testnode/debug
iport=8540
boeprintf_bootnode() {
        echo "$@";
        echo "sudo ../ghpb --datadir "../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport --nodetype bootnode --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode console" >./testnode/$1;
	chmod +x ./testnode/$1;

        echo "../../ghpb attach http://127.0.0.1:1$iport" >./testnode/attach/$1;
        chmod +x ./testnode/attach/$1;

        echo "tail -f ../logs/hpnode$1" >./testnode/hptail/$1;
        chmod +x ./testnode/hptail/$1;

        echo "echo hpb123456 | sudo -S nohup ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport  --rpc --rpcport 1$iport --nodetype bootnode  --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3  > ../logs/hpnode$1 2>&1 &" >./testnode/nohup/$1;
        chmod +x ./testnode/nohup/$1;

        echo "#!""/usr/bin/expect" "-f"  >./testnode/debug/$1;
        echo "spawn sudo gdb --args ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport  --rpc --rpcport 1$iport --nodetype bootnode  --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 4 " >>./testnode/debug/$1;
        echo "expect \"password\" { send \"hpb123456\\r\"}" >>./testnode/debug/$1;
        echo "expect \"(gdb)\" { send \"run\\r\"}"  >>./testnode/debug/$1;
        echo "interact" >>./testnode/debug/$1;
        echo "expect eof" >>./testnode/debug/$1;

        chmod +x ./testnode/debug/$1;

        iport=`expr $iport + 1`;
}

boeprintf_prenode() {
	echo "$@"; 
	>./testnode/$1;
	echo "#""!""/usr/bin/expect -f" >>./testnode/$1;
        echo "spawn sudo ../ghpb --datadir "../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport --unlock 0x$2 --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode console" >>./testnode/$1;
 echo "expect { " >>./testnode/$1;
 echo "\"：\" {  send \"$3\\r\";exp_continue }" >>./testnode/$1;
 echo "\"password:\" { send \"$3\\r\"}" >>./testnode/$1;
 echo "}" >>./testnode/$1;
        echo "expect \"Passphrase:\" { send \"123456\\r\"}" >>./testnode/$1;
	echo "expect \">\" { send \"miner.start()\\r\"}" >>./testnode/$1;
	#echo "expect \">\" { send \"hpb.getBalance(hpb.accounts[0])\\r\"}" >>./testnode/$1;
	echo "expect eof" >>./testnode/$1;
	echo "interact" >>./testnode/$1;
	chmod +x ./testnode/$1;

        echo "../../ghpb attach http://127.0.0.1:1$iport" >./testnode/attach/$1;
        chmod +x ./testnode/attach/$1;

        echo "tail -f ../logs/hpnode$1" >./testnode/hptail/$1;
        chmod +x ./testnode/hptail/$1;

        echo "echo hpb123456 | sudo -S nohup ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport   --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3  > ../logs/hpnode$1 2>&1 &" >./testnode/nohup/$1;
        chmod +x ./testnode/nohup/$1;

        echo "#!""/usr/bin/expect" "-f"  >./testnode/debug/$1;
        echo "spawn sudo gdb --args ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport   --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 4  " >>./testnode/debug/$1;
        echo "expect \"password\" { send \"hpb123456\\r\"}" >>./testnode/debug/$1;
        echo "expect \"(gdb)\" { send \"run\\r\"}"  >>./testnode/debug/$1;
        echo "interact" >>./testnode/debug/$1;
        echo "expect eof" >>./testnode/debug/$1;
        chmod +x ./testnode/debug/$1;

        iport=`expr $iport + 1`;
}
printf_bootnode() {
        echo "$@";
        echo "../ghpb --datadir "../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport --nodetype bootnode --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode console" >./testnode/$1;
	chmod +x ./testnode/$1;

        echo "../../ghpb attach http://127.0.0.1:1$iport" >./testnode/attach/$1;
        chmod +x ./testnode/attach/$1;

        echo "tail -f ../logs/hpnode$1" >./testnode/hptail/$1;
        chmod +x ./testnode/hptail/$1;

        echo "nohup ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport  --rpc --rpcport 1$iport --nodetype bootnode  --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode > ../logs/hpnode$1 2>&1 &" >./testnode/nohup/$1;
        chmod +x ./testnode/nohup/$1;

        echo "#!""/usr/bin/expect" "-f"  >./testnode/debug/$1;
        echo "spawn sudo gdb --args ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport  --rpc --rpcport 1$iport --nodetype bootnode  --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 4 --testmode " >>./testnode/debug/$1;
        echo "expect \"password\" { send \"hpb123456\\r\"}" >>./testnode/debug/$1;
        echo "expect \"(gdb)\" { send \"run\\r\"}"  >>./testnode/debug/$1;
        echo "interact" >>./testnode/debug/$1;
        echo "expect eof" >>./testnode/debug/$1;
        chmod +x ./testnode/debug/$1;

        iport=`expr $iport + 1`;
}

printf_prenode() {
	echo "$@"; 
	>./testnode/$1;
	echo "#""!""/usr/bin/expect -f" >>./testnode/$1;
        echo "spawn ../ghpb --datadir "../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport --unlock 0x$2 --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode console" >>./testnode/$1;
	echo "expect \"Passphrase:\" { send \"123456\\r\"}" >>./testnode/$1;
	echo "expect \">\" { send \"miner.start()\\r\"}" >>./testnode/$1;
	#echo "expect \">\" { send \"hpb.getBalance(hpb.accounts[0])\\r\"}" >>./testnode/$1;
	echo "expect eof" >>./testnode/$1;
	echo "interact" >>./testnode/$1;
	chmod +x ./testnode/$1;

        echo "../../ghpb attach http://127.0.0.1:1$iport" >./testnode/attach/$1;
        chmod +x ./testnode/attach/$1;

        echo "tail -f ../logs/hpnode$1" >./testnode/hptail/$1;
        chmod +x ./testnode/hptail/$1;

	echo "nohup ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport   --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmo    de > ../logs/hpnode$1 2>&1 &" >./testnode/nohup/$1;
	chmod +x ./testnode/nohup/$1;

        echo "#!""/usr/bin/expect" "-f"  >./testnode/debug/$1;
        echo "spawn sudo gdb --args ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport   --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 4 --testmode " >>./testnode/debug/$1;
        echo "expect \"password\" { send \"hpb123456\\r\"}" >>./testnode/debug/$1;
        echo "expect \"(gdb)\" { send \"run\\r\"}"  >>./testnode/debug/$1;
        echo "interact" >>./testnode/debug/$1;
        echo "expect eof" >>./testnode/debug/$1;
        chmod +x ./testnode/debug/$1;
        iport=`expr $iport + 1`;
}
i=0
for accname in `cat ./acc.txt`
do
   i=`expr $i + 1`
      echo $i  $accname

   if [ $i = "1" ];then
         num1=$accname
        if [ -z $age ];then
           printf_bootnode $i $accname
        else
           boeprintf_bootnode $i $accname $age
        fi
   elif [ $i = "2" ];then
         num2=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "3" ];then
         num3=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "4" ];then
         num4=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "5" ];then
         num5=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "6" ];then
         num6=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "7" ];then
          num7=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "8" ];then
         num8=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "9" ];then
          num9=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "10" ];then
         num10=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
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
##默认为6个挖矿从第二个账户开始
##默认为第二个账户有余额,其他没有
##20180912新增自定义挖矿个数,最多8个挖矿&^_^&
##################################################
if [ $work = "1" ];then
	echo "自定义挖矿个数为["$work"]" $num2
	./cjshell/promtest.sh $num2 
elif [ $work = "2" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3
	./cjshell/promtest.sh $num2 $num3 
elif [ $work = "3" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4
	./cjshell/promtest.sh $num2 $num3 $num4 
elif [ $work = "4" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 
elif [ $work = "5" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 
elif [ $work = "6" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 
elif [ $work = "7" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8
elif [ $work = "8" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9
else
      echo "默认从第二个账户开始至第七个账户,为6个挖矿,默认为第二个账户有余额,其他账户没有余额&^_^&"
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7
fi
##########################
##初始化节点
##########################
for id in `seq 10`
do
   echo node$id
   ./ghpb --datadir node$id/data init hanxiaole.json
done

################################
##自动找hnode，写入程序自动编绎
################################
./cjshell/checkhnode.sh
ktxt=`cat ./hxltmp.txt |awk -F'"' '{print $2}'|head -n 1`
sInert="\"hnode://$ktxt@127.0.0.1:8540\","
echo $sInert
sed 's/\"hnode:/\/\/\"hnode:/g' ../../config/networkconfig.go >./hxl.go
####sed -i '185a\'"$sInert"'' ./hxl.go
sed -i '65a\'"$sInert"'' ./hxl.go
cp ./hxl.go ../../config/networkconfig.go

ktxttwo=`cat ./hxltmp.txt |awk -F'"' '{print $2}'|tail -n 1`
sInerttwo="\"hnode://$ktxt@$ktxttwo:8540\","
echo $sInerttwo
sed -i '65a\'"$sInerttwo"'' ../../config/networkconfig.go

################################
##自动成生config.json
################################

>hxltmp1.txt
confignum=`expr $work + 1`
echo "从第2个账户节点开始，自动成生config.json node个数["$confignum"]"
for k in `seq 2 $confignum`
do
   ./cjshell/configid.sh node$k
   echo $k
done

>./config.json
echo "[" >>config.json
for i in `cat hxltmp1.txt|awk -F'"' '{print substr($2,1,16)}'`
do
  echo "{\"pid\":\""$i"\"}," >>config.json
done
echo "]" >>config.json
####################################
##自动config.json delete最后一行的，
####################################

for iabc in `tail -n 2 config.json |awk -F':' '{print $2}'`
do 
   echo $iabc
   kki=`echo $iabc|sed 's/},/}/g'`
   echo $kki
   sed 's/'"$iabc"'/'"$kki"'/g' config.json >config.json.bak
done


rm -rf ./hxl.go
#rm -rf ./acc.txt
rm -rf ./hxl.txt
#rm -rf ./hxltmp.txt
rm -rf ./hxltmp1.txt
cd ../../
make all
cd -
cp ./config.json.bak ./config.json
#rm -rf ./config.json.bak
