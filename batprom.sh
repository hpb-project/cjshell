#!/usr/bin/expect -f
#######################
##acc1至acc6为preenode
#######################
set nodeacc1 [lindex $argv 0]
set nodeacc2 [lindex $argv 1]
set nodeacc3 [lindex $argv 2]
set nodeacc4 [lindex $argv 3]
set nodeacc5 [lindex $argv 4]
set nodeacc6 [lindex $argv 5]
set nodeacc7 [lindex $argv 6]
set nodeacc8 [lindex $argv 7]
set nodeacc9 [lindex $argv 8]
set nodeacc10 [lindex $argv 9]
set nodeacc11 [lindex $argv 10]
set nodeacc12 [lindex $argv 11]
set nodeacc13 [lindex $argv 12]
set nodeacc14 [lindex $argv 13]
set nodeacc15 [lindex $argv 14]
set nodeacc16 [lindex $argv 15]
set nodeacc17 [lindex $argv 16]
set nodeacc18 [lindex $argv 17]
set nodeacc19 [lindex $argv 18]
set nodeacc20 [lindex $argv 19]
set nodeacc21 [lindex $argv 20]
set nodeacc22 [lindex $argv 21]
set nodeacc23 [lindex $argv 22]
set nodeacc24 [lindex $argv 23]
set nodeacc25 [lindex $argv 24]
set nodeacc26 [lindex $argv 25]
set nodeacc27 [lindex $argv 26]
set nodeacc28 [lindex $argv 27]
set nodeacc29 [lindex $argv 28]
set nodeacc30 [lindex $argv 29]
set nodeacc31 [lindex $argv 30]
set nodeacc32 [lindex $argv 31]

set jsonname hanxiaole
set passwd 66300
set hans hanslovehpb
set timeout 30

spawn ./promfile
expect ">" { send "$jsonname\r"}
expect ">" { send "1\r"}
expect ">" { send "5\r"}
expect ">" { send "100\r"}
expect "> 0x" { send "$nodeacc1\r"}
expect "> 0x" { send "$nodeacc2\r"}
expect "> 0x" { send "$nodeacc3\r"}
expect "> 0x" { send "$nodeacc4\r"}
expect "> 0x" { send "$nodeacc5\r"}
expect "> 0x" { send "$nodeacc6\r"}
expect "> 0x" { send "$nodeacc7\r"}
expect "> 0x" { send "$nodeacc8\r"}
expect "> 0x" { send "$nodeacc9\r"}
expect "> 0x" { send "$nodeacc10\r"}
expect "> 0x" { send "$nodeacc11\r"}
expect "> 0x" { send "$nodeacc12\r"}
expect "> 0x" { send "$nodeacc13\r"}
expect "> 0x" { send "$nodeacc14\r"}
expect "> 0x" { send "$nodeacc15\r"}
expect "> 0x" { send "$nodeacc16\r"}
expect "> 0x" { send "$nodeacc17\r"}
expect "> 0x" { send "$nodeacc18\r"}
expect "> 0x" { send "$nodeacc19\r"}
expect "> 0x" { send "$nodeacc20\r"}
expect "> 0x" { send "$nodeacc21\r"}
expect "> 0x" { send "$nodeacc22\r"}
expect "> 0x" { send "$nodeacc23\r"}
expect "> 0x" { send "$nodeacc24\r"}
expect "> 0x" { send "$nodeacc25\r"}
expect "> 0x" { send "$nodeacc26\r"}
expect "> 0x" { send "$nodeacc27\r"}
expect "> 0x" { send "$nodeacc28\r"}
expect "> 0x" { send "$nodeacc29\r"}
expect "> 0x" { send "$nodeacc30\r"}
expect "> 0x" { send "$nodeacc31\r"}
expect "> 0x" { send "$nodeacc32\r"}
expect "> 0x" { send "\r"}
expect "> 0x" { send "$nodeacc1\r"}
expect "> 0x" { send "\r"}
expect ">" { send "\r"}
expect ">" { send "$passwd\r"}
expect ">" { send "$hans\r"}
expect ">" { send "2\r"}
expect ">" { send "1\r"}
expect ">" { send "\r"}
expect ">" { send \003 }
expect eof
