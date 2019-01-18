#!/usr/bin/expect -f
set hxl [open hxltmp.txt a+] 
spawn ./ghpb --datadir ./node1/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node2/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node3/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node4/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node5/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node6/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node7/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node8/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node9/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
spawn ./ghpb --datadir ./node10/data  --networkid=66300 --port 8540 --nodetype bootnode --debug --testmode console
expect ">" { send "admin\r"}
expect "id:" { send "\r"}
expect "," { send "\r"}
puts $hxl $expect_out(buffer)
expect ">" { send "exit\r" }
close $hxl
expect eof 
