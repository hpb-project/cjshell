#!/usr/bin/expect -f
#######################
##acc1至acc5为hnode
#######################
set nodeacc1 [lindex $argv 0]
set nodeacc2 [lindex $argv 1]
set nodeacc3 [lindex $argv 2]
set nodeacc4 [lindex $argv 3]
set nodeacc5 [lindex $argv 4]
set nodeacc6 [lindex $argv 5]

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
