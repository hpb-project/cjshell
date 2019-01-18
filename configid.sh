#!/usr/bin/expect -f
set hxl [open hxltmp1.txt a+] 
set nodedir [lindex $argv 0]
spawn ./ghpb --datadir ./$nodedir/data  --networkid=66300 --port 8540 --nodetype bootnode --testmode --debug console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
close $hxl
expect ">" { send "exit\r" }
expect eof 
