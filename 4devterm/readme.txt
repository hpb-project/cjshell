####通过配置command.txt本脚本支持控制上百台远程服务器,上传或下载文件运行服务器命令
cjcmmand.sh会自动归集执行command.txt里的put,ssh,最后是get
打开execl编著command.ods复制全部内容至command.txt在本目录执行./cjcmmand.sh
20180815修正同时可批量上传,下载可带5个附件,减少command.txt配置多行运程控制命令

20180816串行执行批量上传,下载,修改为并行上传，下载，执行ssh控制命令,提升工作效率。
20180816执行批量上传、下载、ssh控制命令写入logs目录日志优化

20180817优化并行上传BUG,经测试14M内容同时上传至110台服务器,在5分钟内。
20180817新增seeputok.sh可查看上传远程服务器的内容成功与失败,统计成功数与失败数，经过分析显示出那台服务器上传失败！
20180817经过测试sftp效率不如scp,上传文件修改为scp脚本工具
20180817修正上传文件command.txt格式如下：
put	39.14.59.14	root	123456	hxl.sh
put	39.14.59.24	root	123456	hxl.sh
put	39.14.59.34	root	123456	hxl.sh
put	39.14.59.44	root	123456	hxl.sh

20180819 修正sftp put,get BUG
20180819 新增scp put,get 自动适应服务器返回值yes与no，自动输入yes
==配置文件command.txt======================================================================================================================================================
#scpget/scpput/sftpget/sftpput/ssh      服务器地址      用户名  密码    操作目录/执行命令       操作目录/执行命令       执行命令2       执行命令3       执行命令4       执行命令5
scpput  47.104.142.206  root    Hpb123456       kk1.txt kk2.txt kk3.txt kk4.txt kk5.txt hpnodelog.20180818.tar.gz
scpput  47.104.142.207  root    Hpb123456       kk1.txt kk2.txt kk3.txt kk4.txt kk5.txt kk6.txt
scpput  结束                                                                                    
scpget  47.104.142.206  root    Hpb123456       /root/kk1.txt   ./logs                          
scpget  47.104.142.207  root    Hpb123456       /root/kk1.txt   ./logs  
scpget  结束                                                            
sftpput 47.104.142.206  root    Hpb123456       ./      kk1.txt kk2.txt kk3.txt kk4.txt hpnodelog.20180818.tar.gz
sftpput 47.104.142.207  root    Hpb123456       ./      kk1.txt kk2.txt kk3.txt kk4.txt kk5.txt
sftpput 结束                                                            
sftpget 47.104.142.206  root    Hpb123456       ./      kk1.txt kk2.txt kk3.txt kk4.txt hpnodelog.20180818.tar.gz
sftpget 47.104.142.207  root    Hpb123456       ./      kk1.txt kk2.txt kk3.txt kk4.txt hpnodelog.20180818.tar.gz
sftpget 结束                                                            
ssh     47.104.142.206  root    Hpb123456       ./      ls      pwd     df              
ssh     47.104.142.206  root    Hpb123456       ./      ls      pwd     df
ssh     结束                                       
#scpput 默认上传/root/目录下    支付6个附件同时上传                                     
#scpget /root/kk1.txt   下载绝对路经文件名              ./表示把服务器内容下载到当前目录                                        
=============================================================================================================================================================================
20180821新增语法转换器功能,之前只支持单个命令ls、cal、ss，现可支持配置发送远程服务器
        连续控制命令如ls -ltr *.sh & ls -ltrh在command.txt配置成ls@-ltr@*.sh@&@ls@-ltrh
	实例如下：
#scpget/scpput/sftpget/sftpput/ssh	服务器地址	用户名	密码	操作目录/执行命令	操作目录/执行命令	执行命令2	执行命令3	执行命令4	执行命令5
ssh     47.104.142.206  root    Hpb123456       ./      cd@go-ghpb@&@ls@-ltrh      pwd     df              
ssh     47.104.142.206  root    Hpb123456       ./      cd@go-ghpb@&@ls@-ltrh      cd@go-ghpb     ls@-ltrh  cal             
ssh     结束
20180822修订可同时上传25个附件
20180822可同时传输操控远程服务器25条组合命令

20180904注cjcommand.sh配置command.txt可批量执行command.txt中远程服务器命令。
20180904新增selfcommand.sh支持传入为文件参数,如 ./selfcommand.sh getlog.txt
20180904新增自动初始化块加启动服务节点inststart.sh脚本，需配置文件inststart.txt
20180904新增自动启动服务节点start.sh脚本，需配置文件start.txt
20180904新增自动停止服务节点stop.sh脚本，需配置文件stop.txt
20180904新增更新ghpb文件upexec.sh脚本，需配置文件upftpexec.txt
20180904新增自动下载远程文件getlog.sh脚本，需配置文件getlog.txt
###############################远程服务器golang环境部署##############################
sudo tar -zxvf go1.9.2.linux-amd64.tar.gz -C /usr/local/
vi ~/.bashrc
export GOPATH=/home/gopath
export GOROOT=/usr/local/go
PATH=$GOROOT/bin:$GOPATH/bin:$PATH
#########################################################################################
注:devterm目录规定在go-hpb/build/bin/cjshell/devterm,如目录发生改变，无法执行下面步骤
20180904新增自动化编绎go-hpb源码生成执行程序，自动化部署于远程服务器，便于开发与测试人员调试
        开发或测试人员操作步骤如下：
        1.在devterm目录下执行./makenew 自动化编绎go-hpb源码，同时发部到远程服务器命令
        2.在devterm目录下执行./seeerr.sh 查看上传远程服务器执行进度，如果没有显示内容，说明最新程序已经完成上传于远程服务器,可执行第3步骤
        3.在devterm目录下执行./updateghpb.sh更新服务器最新ghpb应用程序
        4.在devterm目录下执行./start.sh启动远程服务器各个节点
20180904新增自动化本地显示远程服务器各个节点日志,可执行./t1.sh、t2.sh、t3.sh、t4.sh、t5.sh、t6.sh、t7.sh、t8.sh
20180904新增自动化执行远程服务器各节点压力测试转账交易,可执行./yl.sh
