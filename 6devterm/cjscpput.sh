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
set ar10 [lindex $argv 9]
set ar11 [lindex $argv 10]
set ar12 [lindex $argv 11]
set ar13 [lindex $argv 12]
set ar14 [lindex $argv 13]
set ar15 [lindex $argv 14]
set ar16 [lindex $argv 15]
set ar17 [lindex $argv 16]
set ar18 [lindex $argv 17]
set ar19 [lindex $argv 18]
set ar20 [lindex $argv 19]
set ar21 [lindex $argv 20]
set ar22 [lindex $argv 21]
set ar23 [lindex $argv 22]
set ar24 [lindex $argv 23]
set ar25 [lindex $argv 24]
set ar26 [lindex $argv 25]
set ar27 [lindex $argv 26]
set ar28 [lindex $argv 27]
set ar29 [lindex $argv 28]
set ar30 [lindex $argv 29]
set ar31 [lindex $argv 30]

set timeout 3600
spawn  scp -P $ar4 $ar5 $ar6 $ar7 $ar8 $ar9 $ar10 $ar11 $ar12 $ar13 $ar14 $ar15 $ar16 $ar17 $ar18 $ar19 $ar20 $ar21 $ar22 $ar23 $ar24 $ar25 $ar26 $ar27 $ar28 $ar29 $ar30 $ar31 $ar2@$ar1:/home/hpb/
expect { 
   "Are you sure you want to continue connecting (yes/no)?" {  send "yes\r";exp_continue }
   "password:" { send "$ar3\r"}
}
expect eof
