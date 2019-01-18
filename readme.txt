#####################################################
####hanxiaole 20180731    cjshell hpb console test
#####################################################

sudo apt-get install tcl tk expect

cjshell.20180727.0.tar.gz  放在/go-hpb/build/bin

tar zxvf cjshell.20180727.0.tar.gz

./cjshell/autoacctest.sh

cd testnode/ 
启动脚本说明
1 启动脚本为bootnode
2 启动脚本为prenode 初始有余额
3 启动脚本至10为prenode初始无余额 

说明如下：
开发人员可用./cjshell/autoacctest.sh自动化初始数据
第一个账户为BOOTNODE 第二个账户到七个账户为挖矿账户
第二个账户初始有余额
自动找hnode，写入程序自动编绎
自动生成1至10启动免输入密码，名输入miner.start脚本
20180802自动成生config.json


##运维人员在有ghpb,promfile与cjshell同一目录下执行./cjshell/batautoacc.sh
20180812 新增自动生成110个账户前10个账户为bootnode,共10个
20180812 新增自动生成从第11个账户至42账户为prenode,共32个
20180812 第11个账户初始有余额,其它没有
20180812 自动找10个账户的hnode，写入程序自动编绎
20180812 自动生成1至110节点启动免输入密码，名输入miner.start脚本
20180812 自动成生32个prenode添入config.json
先执行command.txt里的put所有行,ssh所有行,get所有行

20180813##优化批量上传远程服务器内容BUG
20180813##自动生成启动脚本nohup启动 并logs目录生成ghpb进程日志
20180813##自动生成启动脚本tail -f 查看日志
20180813##自动生成启动脚本attach nohup启动节点操作台

20180815##新增自动适应promfile,Please input the initialization hardware random

20180819##修正自动化创建账户shell脚本代码冗余，优化代码提升可读性与处理效率。
20180819##batautoacc.sh脚本原来支持110个账户升级为自动创建210个账户
20180819##autoacctest.sh自动化创建10个账户，net端囗防止重复功能

20180821##新增自动生成启动脚本增加--testmode参数

cjterm文件夹shell 为默认支持22端囗，无需配置远程服务器端囗，如阿里云
devterm文件夹shell 支持可配置远程服务器开通的端囗，如开发与测试机房服务器
20180903  针对autoacctest.sh自动生成启动节点shell脚本做了程序优化,新功能如下:
          1.输入密码，自动生成启动BOE硬件节点shell脚本                      
          2.不输入密码按回车键，自动生产testmode模式,不启动BOE硬件节点shell脚本
20180903 修正 自动启动节点程序，找id截取后，组合生成config.json BUG

20180912 自定义最多8个初始挖矿账户,从第二个账户开始,输入允许挖矿账户的个数,自动化写入promfile工具生成的json文件
20180912 autoacctest.sh新增shell程序自动适应允许挖矿账户的个数，自动化成生config.json

20180913 新增新建账户适应--testmode模式
20180913 优化ssh过滤执行远程空命令

20181026 支持自动查找本地IP与127.0.0.1自动写入源码编绎生成ghpb，提升一键搭建私链健壮性
20181026 支持自动部署binding.json,修正自动化生成启动节点脚本，启动后连不上BOOTNODE节点BUG
20181219 支持自动化生成gdb 启动调试节点脚本,放在testnode/debug/目录下
20190116 支持为210个账户，自定义节点启动是软件或硬件,自定义高性能节点个数等自动化生成启动脚本。在bin目录下执行./cjshell/batautohardware.sh
20190117 210devterm为控制远程服务器测试脚本
         start.sh 启动38台服务器节点，分别从node1至node38节点
	 stop.sh 停此38台服务器节点，分别从node1至node38节点
	 rmplog.sh 删除每个节点日志，分别从node1至node38节点
         inststart.sh初始化每个节点数据区块从0开始，分别从node1至node38节点
	 makenew编绎最新程序,并将执行程序ghpb分别放到这38台测试服务器上
	 seeerr.sh查看ghpb执行程序放在远程服务器,数据传输的情况
	 t1.sh至t38.sh分别是自动化登陆查看每一台服务器节点运行日志
20190118 修正了，在cjshell/210devterm/执行./t1.sh至t38.sh查看不到日志问题
20190118 新增自动化生成binding.json文件操作步骤如下：
	1.自动化执行硬件绑定BOE配置.xlsx里面的内容ctrl+c,粘帖在go-hpb/build/bin/cjshell/210devterm/command.txt文件中
	2.go-hpb/build/bin/cjshell/210devterm/目录下执行./cjcommand.sh
	3.go-hpb/build/bin/cjshell/210devterm/目录下执行./writebindjson.sh
	4.vi boebinding.json将内容复制至node1节点也就是bootnode环境中(/home/hpb/go-ghpb/node1/data/binding.json)


1. git clone https://github.com/hpb-project/go-hpb
2. cd go-hpb
3. make all
4. cd /build/bin
5. cjshell.2019011801.tar.gz (go-hpb/build/bin)放入此目录下
6. tar -zxvf cjshell.2019011801.tar.gz
7. sudo apt-get install tcl tk expect
8.  ./cjshell/autoacctest.sh
