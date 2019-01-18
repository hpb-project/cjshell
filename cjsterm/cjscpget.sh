#!/usr/bin/expect -f
#####scp ghpb.20180817.0.tar.gz root@39.104.146.240:/root/
set ar1 [lindex $argv 0]
set ar2 [lindex $argv 1]
set ar3 [lindex $argv 2]
set ar4 [lindex $argv 3]
set ar5 [lindex $argv 4]
set ar6 [lindex $argv 5]
set ar7 [lindex $argv 6]
set ar8 [lindex $argv 7]
set ar9 [lindex $argv 8]
set timeout 3600
spawn  scp $ar2@$ar1:$ar4 $ar5
expect { 
   "Are you sure you want to continue connecting (yes/no)?" {  send "yes\r";exp_continue }
   "password:" { send "$ar3\r"}
}
expect eof
