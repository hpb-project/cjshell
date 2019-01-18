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
##默认为30个挖矿从第二个账户开始
##默认为第二个账户有余额,其他没有
##################################################
echo "==============此脚本支持使用promfile工具免输入账户自动化生成json文件=================================="
echo "       1.按回车键,默认为30个挖矿从第二个账户开始,默认为第二个账户有余额,其他没有"
echo "       2.自定义最多35个初始挖矿账户,从第二个账户开始,输入允许挖矿账户的个数"
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
##自动生成210账户20190116
##########################
killall ghpb
killall iperf3
rm -rf ./node*
rm -rf ./acc.txt
rm -rf ./hanxiaole.json
rm -rf ./hxl.txt
rm -rf ./testnode

>./acc.txt
for k in `seq 210`
do
   echo node$k
   rm -rf ./node$k
   mkdir node$k
   ./cjshell/exptest.sh node$k
   cp  ./binding.json ./node$k/data/
   cat ./hxl.txt|sed 's/^M//g'|sed 's/{/|/g'|sed 's/}/|/g'|awk -F '|' '{print $2}'|sed '/^$/d' >>acc.txt
done
######################
##取账户信息20190116
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
   elif [ $i = "11" ];then
         num11=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "12" ];then
         num12=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "13" ];then
         num13=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "14" ];then
         num14=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "15" ];then
         num15=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "16" ];then
         num16=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "17" ];then
         num17=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "18" ];then
         num18=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "19" ];then
         num19=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "20" ];then
         num20=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "21" ];then
         num21=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "22" ];then
         num22=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "23" ];then
         num23=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "24" ];then
         num24=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "25" ];then
         num25=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "26" ];then
         num26=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "27" ];then
         num27=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "28" ];then
         num28=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "29" ];then
         num29=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "30" ];then
         num30=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "31" ];then
         num31=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "32" ];then
         num32=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "33" ];then
         num33=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "34" ];then
         num34=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "35" ];then
         num35=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "36" ];then
         num36=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "37" ];then
         num37=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "38" ];then
         num38=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "39" ];then
         num39=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "40" ];then
         num40=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "41" ];then
         num41=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "42" ];then
         num42=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "43" ];then
         num43=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "44" ];then
         num44=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "45" ];then
         num45=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "46" ];then
         num46=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "47" ];then
         num47=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "48" ];then
         num48=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "49" ];then
         num49=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "50" ];then
         num50=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "51" ];then
         num51=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "52" ];then
         num52=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "53" ];then
         num53=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "54" ];then
         num54=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "55" ];then
         num55=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "56" ];then
         num56=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "57" ];then
         num57=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "58" ];then
         num58=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "59" ];then
         num59=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "60" ];then
         num60=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "61" ];then
         num61=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "62" ];then
         num62=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "63" ];then
         num63=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "64" ];then
         num64=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "65" ];then
         num65=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "66" ];then
         num66=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "67" ];then
         num67=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "68" ];then
         num68=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "69" ];then
         num69=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "70" ];then
         num70=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "71" ];then
         num71=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "72" ];then
         num72=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "73" ];then
         num73=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "74" ];then
         num74=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "75" ];then
         num75=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "76" ];then
         num76=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "77" ];then
         num77=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "78" ];then
         num78=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "79" ];then
         num79=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "80" ];then
         num80=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "81" ];then
         num81=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "82" ];then
         num82=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "83" ];then
         num83=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "84" ];then
         num84=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "85" ];then
         num85=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "86" ];then
         num86=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "87" ];then
         num87=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "88" ];then
         num88=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "89" ];then
         num89=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "90" ];then
         num90=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "91" ];then
         num91=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "92" ];then
         num92=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "93" ];then
         num93=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "94" ];then
         num94=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "95" ];then
         num95=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "96" ];then
         num96=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "97" ];then
         num97=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "98" ];then
         num98=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "99" ];then
         num99=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "100" ];then
         num100=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "101" ];then
         num101=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "102" ];then
         num102=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "103" ];then
         num103=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "104" ];then
         num104=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "105" ];then
         num105=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "106" ];then
         num106=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "107" ];then
         num107=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "108" ];then
         num108=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "109" ];then
         num109=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "110" ];then
         num110=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "111" ];then
         num111=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "112" ];then
         num112=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "113" ];then
         num113=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "114" ];then
         num114=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "115" ];then
         num115=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "116" ];then
         num116=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "117" ];then
         num117=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "118" ];then
         num118=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "119" ];then
         num119=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "120" ];then
         num120=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "121" ];then
         num121=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "122" ];then
         num122=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "123" ];then
         num123=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "124" ];then
         num124=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "125" ];then
         num125=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "126" ];then
         num126=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "127" ];then
         num127=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "128" ];then
         num128=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "129" ];then
         num129=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "130" ];then
         num130=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "131" ];then
         num131=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "132" ];then
         num132=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "133" ];then
         num133=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "134" ];then
         num134=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "135" ];then
         num135=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "136" ];then
         num136=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "137" ];then
         num137=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "138" ];then
         num138=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "139" ];then
         num139=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "140" ];then
         num140=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "141" ];then
         num141=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "142" ];then
         num142=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "143" ];then
         num143=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "144" ];then
         num144=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "145" ];then
         num145=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "146" ];then
         num146=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "147" ];then
         num147=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "148" ];then
         num148=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "149" ];then
         num149=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "150" ];then
         num150=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "151" ];then
         num151=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "152" ];then
         num152=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "153" ];then
         num153=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "154" ];then
         num154=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "155" ];then
         num155=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "156" ];then
         num156=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "157" ];then
         num157=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "158" ];then
         num158=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "159" ];then
         num159=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "160" ];then
         num160=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "161" ];then
         num161=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "162" ];then
         num162=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "163" ];then
         num163=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "164" ];then
         num164=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "165" ];then
         num165=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "166" ];then
         num166=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "167" ];then
         num167=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "168" ];then
         num168=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "169" ];then
         num169=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "170" ];then
         num170=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "171" ];then
         num171=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "172" ];then
         num172=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "173" ];then
         num173=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "174" ];then
         num174=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "175" ];then
         num175=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "176" ];then
         num176=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "177" ];then
         num177=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "178" ];then
         num178=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "179" ];then
         num179=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "180" ];then
         num180=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "181" ];then
         num181=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "182" ];then
         num182=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "183" ];then
         num183=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "184" ];then
         num184=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "185" ];then
         num185=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "186" ];then
         num186=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "187" ];then
         num187=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "188" ];then
         num188=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "189" ];then
         num189=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "190" ];then
         num190=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "191" ];then
         num191=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "192" ];then
         num192=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "193" ];then
         num193=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "194" ];then
         num194=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "195" ];then
         num195=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "196" ];then
         num196=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "197" ];then
         num197=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "198" ];then
         num198=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "199" ];then
         num199=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "200" ];then
         num200=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "201" ];then
         num201=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "202" ];then
         num202=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "203" ];then
         num203=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "204" ];then
         num204=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "205" ];then
         num205=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "206" ];then
         num206=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "207" ];then
         num207=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "208" ];then
         num208=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "209" ];then
         num209=$accname
        if [ -z $age ];then
           printf_prenode $i $accname
        else
           boeprintf_prenode $i $accname $age
        fi
   elif [ $i = "210" ];then
         num210=$accname
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
elif [ $work = "9" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10
elif [ $work = "10" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11
elif [ $work = "11" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12
elif [ $work = "12" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13
elif [ $work = "13" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14
elif [ $work = "14" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15
elif [ $work = "15" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16
elif [ $work = "16" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17
elif [ $work = "17" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18
elif [ $work = "18" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19
elif [ $work = "19" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20
elif [ $work = "20" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21
elif [ $work = "21" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22
elif [ $work = "22" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23
elif [ $work = "23" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24
elif [ $work = "24" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25
elif [ $work = "25" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26
elif [ $work = "26" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27
elif [ $work = "27" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28
elif [ $work = "28" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29
elif [ $work = "29" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30
elif [ $work = "30" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31
elif [ $work = "31" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32
elif [ $work = "32" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33
elif [ $work = "33" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34
elif [ $work = "34" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34 $num35
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34 $num35
elif [ $work = "35" ];then
	echo "自定义挖矿个数为["$work"]" $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34 $num35 $num36
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34 $num35 $num36
else
      echo "默认从第二个账户开始至第31个账户,为30个挖矿,默认为第二个账户有余额,其他账户没有余额&^_^&"
	./cjshell/promtest.sh $num2 $num3 $num4 $num5 $num6 $num7 $num8 $num9 $num10 $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31
fi
##########################
##初始化节点
##########################
for id in `seq 210`
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
