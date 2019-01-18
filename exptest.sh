#!/usr/bin/expect -f
set nodedir [lindex $argv 0]
set timeout 30
set hxl [open hxl.txt w+]
spawn ./ghpb --testmode --debug --datadir ./$nodedir/data account new
expect "Passphrase:" { send "123456\r"}
expect "Repeat passphrase:" { send "123456\r"}
expect "}" { send "\r"}
puts $hxl $expect_out(buffer)
close $hxl
expect eof
