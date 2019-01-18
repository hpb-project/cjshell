#################################
##自动生成参数个数的账户20180727
#################################
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
##取账户信息20180727
######################
rm -rf ./testnode
mkdir -p ./testnode/logs
mkdir -p ./testnode/attach
mkdir -p ./testnode/hptail
mkdir -p ./testnode/nohup
iport=8540
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

        echo "nohup ../../ghpb --datadir "../../node$1/data"  --networkid=66300 --port $iport --rpc --rpcport 1$iport   --unlock 0x$2   --password "../../cjshell/pwd" --mine --debug --rpcapi hpb,web3,admin,txpool,debug,personal,net,miner,prometheus --verbosity 3 --testmode > ../logs/hpnode$1 2>&1 &" >./testnode/nohup/$1;
        chmod +x ./testnode/nohup/$1;
        iport=`expr $iport + 1`;
}
i=0
for accname in `cat ./acc.txt`
do
   i=`expr $i + 1`
      echo $i  $accname

   if [ $i = "1" ];then
         num1=$accname
         printf_bootnode $i $accname
   elif [ $i = "2" ];then
         num2=$accname
         printf_bootnode $i $accname
   elif [ $i = "3" ];then
         num3=$accname
	printf_bootnode $i $accname
   elif [ $i = "4" ];then
         num4=$accname
       printf_bootnode $i $accname
   elif [ $i = "5" ];then
         num5=$accname
        printf_bootnode $i $accname
   elif [ $i = "6" ];then
         num6=$accname
       printf_bootnode $i $accname
   elif [ $i = "7" ];then
          num7=$accname
        printf_bootnode $i $accname
   elif [ $i = "8" ];then
         num8=$accname
        printf_bootnode $i $accname
   elif [ $i = "9" ];then
          num9=$accname
        printf_bootnode $i $accname
   elif [ $i = "10" ];then
         num10=$accname
       printf_bootnode $i $accname
   elif [ $i = "11" ];then
         num11=$accname
	printf_prenode $i $accname
   elif [ $i = "12" ];then
         num12=$accname
	printf_prenode $i $accname
   elif [ $i = "13" ];then
         num13=$accname
	printf_prenode $i $accname
   elif [ $i = "14" ];then
         num14=$accname
	printf_prenode $i $accname
   elif [ $i = "15" ];then
         num15=$accname
	printf_prenode $i $accname
   elif [ $i = "16" ];then
         num16=$accname
	printf_prenode $i $accname
   elif [ $i = "17" ];then
         num17=$accname
	printf_prenode $i $accname
   elif [ $i = "18" ];then
         num18=$accname
	printf_prenode $i $accname
   elif [ $i = "19" ];then
         num19=$accname
	printf_prenode $i $accname
   elif [ $i = "20" ];then
         num20=$accname
	printf_prenode $i $accname
   elif [ $i = "21" ];then
         num21=$accname
         printf_prenode $i $accname
   elif [ $i = "22" ];then
         num22=$accname
	printf_prenode $i $accname
   elif [ $i = "23" ];then
         num23=$accname
	printf_prenode $i $accname
   elif [ $i = "24" ];then
         num24=$accname
	printf_prenode $i $accname
   elif [ $i = "25" ];then
         num25=$accname
	printf_prenode $i $accname
   elif [ $i = "26" ];then
        printf_prenode $i $accname
   elif [ $i = "27" ];then
         num27=$accname
	printf_prenode $i $accname
   elif [ $i = "28" ];then
         num28=$accname
	printf_prenode $i $accname
   elif [ $i = "29" ];then
         num29=$accname
	printf_prenode $i $accname
   elif [ $i = "30" ];then
         num30=$accname
	printf_prenode $i $accname
   elif [ $i = "31" ];then
         num31=$accname
	printf_prenode $i $accname
   elif [ $i = "32" ];then
         num32=$accname
	printf_prenode $i $accname
   elif [ $i = "33" ];then
         num33=$accname
	printf_prenode $i $accname
   elif [ $i = "34" ];then
         num34=$accname
	printf_prenode $i $accname
   elif [ $i = "35" ];then
         num35=$accname
	printf_prenode $i $accname
   elif [ $i = "36" ];then
         num36=$accname
	printf_prenode $i $accname
   elif [ $i = "37" ];then
         num37=$accname
	printf_prenode $i $accname
   elif [ $i = "38" ];then
         num38=$accname
	printf_prenode $i $accname
   elif [ $i = "39" ];then
         num39=$accname
	printf_prenode $i $accname
   elif [ $i = "40" ];then
         num40=$accname
	printf_prenode $i $accname
   elif [ $i = "41" ];then
         num41=$accname
	printf_prenode $i $accname
   elif [ $i = "42" ];then
         num42=$accname
	printf_prenode $i $accname
   elif [ $i = "43" ];then
         num43=$accname
	printf_prenode $i $accname
   elif [ $i = "44" ];then
         num44=$accname
	printf_prenode $i $accname
   elif [ $i = "45" ];then
         num45=$accname
	printf_prenode $i $accname
   elif [ $i = "46" ];then
         num46=$accname
	printf_prenode $i $accname
   elif [ $i = "47" ];then
         num47=$accname
	printf_prenode $i $accname
   elif [ $i = "48" ];then
         num48=$accname
	printf_prenode $i $accname
   elif [ $i = "49" ];then
         num49=$accname
	printf_prenode $i $accname
   elif [ $i = "50" ];then
         num50=$accname
	printf_prenode $i $accname
   elif [ $i = "51" ];then
         num51=$accname
	printf_prenode $i $accname
   elif [ $i = "52" ];then
         num52=$accname
	printf_prenode $i $accname
   elif [ $i = "53" ];then
         num53=$accname
	printf_prenode $i $accname
   elif [ $i = "54" ];then
         num54=$accname
	printf_prenode $i $accname
   elif [ $i = "55" ];then
         num55=$accname
	printf_prenode $i $accname
   elif [ $i = "56" ];then
         num56=$accname
	printf_prenode $i $accname
   elif [ $i = "57" ];then
         num57=$accname
	printf_prenode $i $accname
   elif [ $i = "58" ];then
         num58=$accname
	printf_prenode $i $accname
   elif [ $i = "59" ];then
         num59=$accname
	printf_prenode $i $accname
   elif [ $i = "60" ];then
         num60=$accname
	printf_prenode $i $accname
   elif [ $i = "61" ];then
         num61=$accname
	printf_prenode $i $accname
   elif [ $i = "62" ];then
         num62=$accname
	printf_prenode $i $accname
   elif [ $i = "63" ];then
         num63=$accname
	printf_prenode $i $accname
   elif [ $i = "64" ];then
         num64=$accname
	printf_prenode $i $accname
   elif [ $i = "65" ];then
         num65=$accname
	printf_prenode $i $accname
   elif [ $i = "66" ];then
         num66=$accname
	printf_prenode $i $accname
   elif [ $i = "67" ];then
         num67=$accname
	printf_prenode $i $accname
   elif [ $i = "68" ];then
         num68=$accname
	printf_prenode $i $accname
   elif [ $i = "69" ];then
         num69=$accname
	printf_prenode $i $accname
   elif [ $i = "70" ];then
         num70=$accname
	printf_prenode $i $accname
   elif [ $i = "71" ];then
         num71=$accname
	printf_prenode $i $accname
   elif [ $i = "72" ];then
         num72=$accname
	printf_prenode $i $accname
   elif [ $i = "73" ];then
         num73=$accname
	printf_prenode $i $accname
   elif [ $i = "74" ];then
         num74=$accname
	printf_prenode $i $accname
   elif [ $i = "75" ];then
         num75=$accname
	printf_prenode $i $accname
   elif [ $i = "76" ];then
         num76=$accname
	printf_prenode $i $accname
   elif [ $i = "77" ];then
         num77=$accname
	printf_prenode $i $accname
   elif [ $i = "78" ];then
         num78=$accname
	printf_prenode $i $accname
   elif [ $i = "79" ];then
         num79=$accname
	printf_prenode $i $accname
   elif [ $i = "80" ];then
         num80=$accname
	printf_prenode $i $accname
   elif [ $i = "81" ];then
         num81=$accname
	printf_prenode $i $accname
   elif [ $i = "82" ];then
         num82=$accname
	printf_prenode $i $accname
   elif [ $i = "83" ];then
         num83=$accname
	printf_prenode $i $accname
   elif [ $i = "84" ];then
         num84=$accname
	printf_prenode $i $accname
   elif [ $i = "85" ];then
         num85=$accname
	printf_prenode $i $accname
   elif [ $i = "86" ];then
         num86=$accname
	printf_prenode $i $accname
   elif [ $i = "87" ];then
         num87=$accname
	printf_prenode $i $accname
   elif [ $i = "88" ];then
         num88=$accname
	printf_prenode $i $accname
   elif [ $i = "89" ];then
         num89=$accname
	printf_prenode $i $accname
   elif [ $i = "90" ];then
         num90=$accname
	printf_prenode $i $accname
   elif [ $i = "91" ];then
         num91=$accname
	printf_prenode $i $accname
   elif [ $i = "92" ];then
         num92=$accname
	printf_prenode $i $accname
   elif [ $i = "93" ];then
         num93=$accname
	printf_prenode $i $accname
   elif [ $i = "94" ];then
         num94=$accname
	printf_prenode $i $accname
   elif [ $i = "95" ];then
         num95=$accname
	printf_prenode $i $accname
   elif [ $i = "96" ];then
         num96=$accname
	printf_prenode $i $accname
   elif [ $i = "97" ];then
         num97=$accname
	printf_prenode $i $accname
   elif [ $i = "98" ];then
         num98=$accname
	printf_prenode $i $accname
   elif [ $i = "99" ];then
         num99=$accname
	printf_prenode $i $accname
   elif [ $i = "100" ];then
         num100=$accname
	printf_prenode $i $accname
   elif [ $i = "101" ];then
         num101=$accname
	printf_prenode $i $accname
   elif [ $i = "102" ];then
         num102=$accname
	printf_prenode $i $accname
   elif [ $i = "103" ];then
         num103=$accname
	printf_prenode $i $accname
   elif [ $i = "104" ];then
         num104=$accname
	printf_prenode $i $accname
   elif [ $i = "105" ];then
         num105=$accname
	printf_prenode $i $accname
   elif [ $i = "106" ];then
         num106=$accname
	printf_prenode $i $accname
   elif [ $i = "107" ];then
         num107=$accname
	printf_prenode $i $accname
   elif [ $i = "108" ];then
         num108=$accname
	printf_prenode $i $accname
   elif [ $i = "109" ];then
         num109=$accname
	printf_prenode $i $accname
   elif [ $i = "110" ];then
         num110=$accname
	printf_prenode $i $accname
   elif [ $i = "111" ];then
         num111=$accname
	printf_prenode $i $accname
   elif [ $i = "112" ];then
         num112=$accname
	printf_prenode $i $accname
   elif [ $i = "113" ];then
         num113=$accname
	printf_prenode $i $accname
   elif [ $i = "114" ];then
         num114=$accname
	printf_prenode $i $accname
   elif [ $i = "115" ];then
         num115=$accname
	printf_prenode $i $accname
   elif [ $i = "116" ];then
         num116=$accname
	printf_prenode $i $accname
   elif [ $i = "117" ];then
         num117=$accname
	printf_prenode $i $accname
   elif [ $i = "118" ];then
         num118=$accname
	printf_prenode $i $accname
   elif [ $i = "119" ];then
         num119=$accname
	printf_prenode $i $accname
   elif [ $i = "120" ];then
         num120=$accname
	printf_prenode $i $accname
   elif [ $i = "121" ];then
         num121=$accname
         printf_prenode $i $accname
   elif [ $i = "122" ];then
         num122=$accname
	printf_prenode $i $accname
   elif [ $i = "123" ];then
         num123=$accname
	printf_prenode $i $accname
   elif [ $i = "124" ];then
         num124=$accname
	printf_prenode $i $accname
   elif [ $i = "125" ];then
         num125=$accname
	printf_prenode $i $accname
   elif [ $i = "126" ];then
        printf_prenode $i $accname
   elif [ $i = "127" ];then
         num127=$accname
	printf_prenode $i $accname
   elif [ $i = "128" ];then
         num128=$accname
	printf_prenode $i $accname
   elif [ $i = "129" ];then
         num129=$accname
	printf_prenode $i $accname
   elif [ $i = "130" ];then
         num130=$accname
	printf_prenode $i $accname
   elif [ $i = "131" ];then
         num131=$accname
	printf_prenode $i $accname
   elif [ $i = "132" ];then
         num132=$accname
	printf_prenode $i $accname
   elif [ $i = "133" ];then
         num133=$accname
	printf_prenode $i $accname
   elif [ $i = "134" ];then
         num134=$accname
	printf_prenode $i $accname
   elif [ $i = "135" ];then
         num135=$accname
	printf_prenode $i $accname
   elif [ $i = "136" ];then
         num136=$accname
	printf_prenode $i $accname
   elif [ $i = "137" ];then
         num137=$accname
	printf_prenode $i $accname
   elif [ $i = "138" ];then
         num138=$accname
	printf_prenode $i $accname
   elif [ $i = "139" ];then
         num139=$accname
	printf_prenode $i $accname
   elif [ $i = "140" ];then
         num140=$accname
	printf_prenode $i $accname
   elif [ $i = "141" ];then
         num141=$accname
	printf_prenode $i $accname
   elif [ $i = "142" ];then
         num142=$accname
	printf_prenode $i $accname
   elif [ $i = "143" ];then
         num143=$accname
	printf_prenode $i $accname
   elif [ $i = "144" ];then
         num144=$accname
	printf_prenode $i $accname
   elif [ $i = "145" ];then
         num145=$accname
	printf_prenode $i $accname
   elif [ $i = "146" ];then
         num146=$accname
	printf_prenode $i $accname
   elif [ $i = "147" ];then
         num147=$accname
	printf_prenode $i $accname
   elif [ $i = "148" ];then
         num148=$accname
	printf_prenode $i $accname
   elif [ $i = "149" ];then
         num149=$accname
	printf_prenode $i $accname
   elif [ $i = "150" ];then
         num150=$accname
	printf_prenode $i $accname
   elif [ $i = "151" ];then
         num151=$accname
	printf_prenode $i $accname
   elif [ $i = "152" ];then
         num152=$accname
	printf_prenode $i $accname
   elif [ $i = "153" ];then
         num153=$accname
	printf_prenode $i $accname
   elif [ $i = "154" ];then
         num154=$accname
	printf_prenode $i $accname
   elif [ $i = "155" ];then
         num155=$accname
	printf_prenode $i $accname
   elif [ $i = "156" ];then
         num156=$accname
	printf_prenode $i $accname
   elif [ $i = "157" ];then
         num157=$accname
	printf_prenode $i $accname
   elif [ $i = "158" ];then
         num158=$accname
	printf_prenode $i $accname
   elif [ $i = "159" ];then
         num159=$accname
	printf_prenode $i $accname
   elif [ $i = "160" ];then
         num160=$accname
	printf_prenode $i $accname
   elif [ $i = "161" ];then
         num161=$accname
	printf_prenode $i $accname
   elif [ $i = "162" ];then
         num162=$accname
	printf_prenode $i $accname
   elif [ $i = "163" ];then
         num163=$accname
	printf_prenode $i $accname
   elif [ $i = "164" ];then
         num164=$accname
	printf_prenode $i $accname
   elif [ $i = "165" ];then
         num165=$accname
	printf_prenode $i $accname
   elif [ $i = "166" ];then
         num166=$accname
	printf_prenode $i $accname
   elif [ $i = "167" ];then
         num167=$accname
	printf_prenode $i $accname
   elif [ $i = "168" ];then
         num168=$accname
	printf_prenode $i $accname
   elif [ $i = "169" ];then
         num169=$accname
	printf_prenode $i $accname
   elif [ $i = "170" ];then
         num170=$accname
	printf_prenode $i $accname
   elif [ $i = "171" ];then
         num171=$accname
	printf_prenode $i $accname
   elif [ $i = "172" ];then
         num172=$accname
	printf_prenode $i $accname
   elif [ $i = "173" ];then
         num173=$accname
	printf_prenode $i $accname
   elif [ $i = "174" ];then
         num174=$accname
	printf_prenode $i $accname
   elif [ $i = "175" ];then
         num175=$accname
	printf_prenode $i $accname
   elif [ $i = "176" ];then
         num176=$accname
	printf_prenode $i $accname
   elif [ $i = "177" ];then
         num177=$accname
	printf_prenode $i $accname
   elif [ $i = "178" ];then
         num178=$accname
	printf_prenode $i $accname
   elif [ $i = "179" ];then
         num179=$accname
	printf_prenode $i $accname
   elif [ $i = "180" ];then
         num180=$accname
	printf_prenode $i $accname
   elif [ $i = "181" ];then
         num181=$accname
	printf_prenode $i $accname
   elif [ $i = "182" ];then
         num182=$accname
	printf_prenode $i $accname
   elif [ $i = "183" ];then
         num183=$accname
	printf_prenode $i $accname
   elif [ $i = "184" ];then
         num184=$accname
	printf_prenode $i $accname
   elif [ $i = "185" ];then
         num185=$accname
	printf_prenode $i $accname
   elif [ $i = "186" ];then
         num186=$accname
	printf_prenode $i $accname
   elif [ $i = "187" ];then
         num187=$accname
	printf_prenode $i $accname
   elif [ $i = "188" ];then
         num188=$accname
	printf_prenode $i $accname
   elif [ $i = "189" ];then
         num189=$accname
	printf_prenode $i $accname
   elif [ $i = "190" ];then
         num190=$accname
	printf_prenode $i $accname
   elif [ $i = "191" ];then
         num191=$accname
	printf_prenode $i $accname
   elif [ $i = "192" ];then
         num192=$accname
	printf_prenode $i $accname
   elif [ $i = "193" ];then
         num193=$accname
	printf_prenode $i $accname
   elif [ $i = "194" ];then
         num194=$accname
	printf_prenode $i $accname
   elif [ $i = "195" ];then
         num195=$accname
	printf_prenode $i $accname
   elif [ $i = "196" ];then
         num196=$accname
	printf_prenode $i $accname
   elif [ $i = "197" ];then
         num197=$accname
	printf_prenode $i $accname
   elif [ $i = "198" ];then
         num198=$accname
	printf_prenode $i $accname
   elif [ $i = "199" ];then
         num199=$accname
	printf_prenode $i $accname
   elif [ $i = "200" ];then
         num200=$accname
	printf_prenode $i $accname
   elif [ $i = "201" ];then
         num201=$accname
	printf_prenode $i $accname
   elif [ $i = "202" ];then
         num202=$accname
	printf_prenode $i $accname
   elif [ $i = "203" ];then
         num203=$accname
	printf_prenode $i $accname
   elif [ $i = "204" ];then
         num204=$accname
	printf_prenode $i $accname
   elif [ $i = "205" ];then
         num205=$accname
	printf_prenode $i $accname
   elif [ $i = "206" ];then
         num206=$accname
	printf_prenode $i $accname
   elif [ $i = "207" ];then
         num207=$accname
	printf_prenode $i $accname
   elif [ $i = "208" ];then
         num208=$accname
	printf_prenode $i $accname
   elif [ $i = "209" ];then
         num209=$accname
	printf_prenode $i $accname
   elif [ $i = "210" ];then
         num210=$accname
	printf_prenode $i $accname
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
##默认为32个挖矿从第11个账户开始
##默认为第11个账户有余额,其他没有
##################################################
./cjshell/batprom.sh $num11 $num12 $num13 $num14 $num15 $num16 $num17 $num18 $num19 $num20 $num21 $num22 $num23 $num24 $num25 $num26 $num27 $num28 $num29 $num30 $num31 $num32 $num33 $num34 $num35 $num36 $num37  $num38 $num39 $num40 $num41 $num42

##########################
##初始化节点
##########################
for id in `seq 210`
do
   echo node$id
   ./ghpb --datadir node$id/data init hanxiaole.json
done

###################################
##自动找hnode，10个写入程序自动编绎
###################################
> hxltmp.txt
./cjshell/batcheckhnode.sh
sed 's/\"hnode:/\/\/\"hnode:/g' ../../config/networkconfig.go >./hxl.go
for ktxt in `cat ./hxltmp.txt |awk -F'"' '{print $2}'`
do
	sInert="\"hnode://$ktxt@127.0.0.1:8540\","
	echo $sInert
	##sed -i '185a\'"$sInert"'' ./hxl.go
	sed -i '65a\'"$sInert"'' ./hxl.go
done
cp ./hxl.go ../../config/networkconfig.go

############################################
##自动第11个账户至42个账户成生config.json
############################################

>hxltmp1.txt
for k in `seq 11 42`
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
rm -rf ./hxltmp.txt
rm -rf ./hxltmp1.txt
cd ../../
make all
cd -
cp ./config.json.bak ./config.json
cp  ./binding.json ./node1/data/
#rm -rf ./config.json.bak
