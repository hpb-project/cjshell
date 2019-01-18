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
set nodeacc33 [lindex $argv 32]
set nodeacc34 [lindex $argv 33]
set nodeacc35 [lindex $argv 34]
set nodeacc36 [lindex $argv 35]
set nodeacc37 [lindex $argv 36]
set jsonname hanxiaole
set passwd 66300
set hans hanslovehpb
set timeout 30

spawn ./promfile
expect ">" { send "$jsonname\r"}
expect ">" { send "1\r"}
expect ">" { send "5\r"}
expect ">" { send "100\r"}
if { "$nodeacc1" != "" } {
expect "> 0x" { send "$nodeacc1\r"}
}
if { "$nodeacc2" != "" } {
expect "> 0x" { send "$nodeacc2\r"}
}
if { "$nodeacc3" != "" } {
expect "> 0x" { send "$nodeacc3\r"}
}
if { "$nodeacc4" != "" } {
expect "> 0x" { send "$nodeacc4\r"}
}
if { "$nodeacc5" != "" } {
expect "> 0x" { send "$nodeacc5\r"}
}
if { "$nodeacc6" != "" } {
expect "> 0x" { send "$nodeacc6\r"}
}
if { "$nodeacc7" != "" } {
expect "> 0x" { send "$nodeacc7\r"}
}
if { "$nodeacc8" != "" } {
expect "> 0x" { send "$nodeacc8\r"}
}
if { "$nodeacc9" != "" } {
expect "> 0x" { send "$nodeacc9\r"}
}
if { "$nodeacc10" != "" } {
expect "> 0x" { send "$nodeacc10\r"}
}
if { "$nodeacc11" != "" } {
expect "> 0x" { send "$nodeacc11\r"}
}
if { "$nodeacc12" != "" } {
expect "> 0x" { send "$nodeacc12\r"}
}
if { "$nodeacc13" != "" } {
expect "> 0x" { send "$nodeacc13\r"}
}
if { "$nodeacc14" != "" } {
expect "> 0x" { send "$nodeacc14\r"}
}
if { "$nodeacc15" != "" } {
expect "> 0x" { send "$nodeacc15\r"}
}
if { "$nodeacc16" != "" } {
expect "> 0x" { send "$nodeacc16\r"}
}
if { "$nodeacc17" != "" } {
expect "> 0x" { send "$nodeacc17\r"}
}
if { "$nodeacc18" != "" } {
expect "> 0x" { send "$nodeacc18\r"}
}
if { "$nodeacc19" != "" } {
expect "> 0x" { send "$nodeacc19\r"}
}
if { "$nodeacc20" != "" } {
expect "> 0x" { send "$nodeacc20\r"}
}
if { "$nodeacc21" != "" } {
expect "> 0x" { send "$nodeacc21\r"}
}
if { "$nodeacc22" != "" } {
expect "> 0x" { send "$nodeacc22\r"}
}
if { "$nodeacc23" != "" } {
expect "> 0x" { send "$nodeacc23\r"}
}
if { "$nodeacc24" != "" } {
expect "> 0x" { send "$nodeacc24\r"}
}
if { "$nodeacc25" != "" } {
expect "> 0x" { send "$nodeacc25\r"}
}
if { "$nodeacc26" != "" } {
expect "> 0x" { send "$nodeacc26\r"}
}
if { "$nodeacc27" != "" } {
expect "> 0x" { send "$nodeacc27\r"}
}
if { "$nodeacc28" != "" } {
expect "> 0x" { send "$nodeacc28\r"}
}
if { "$nodeacc29" != "" } {
expect "> 0x" { send "$nodeacc29\r"}
}
if { "$nodeacc30" != "" } {
expect "> 0x" { send "$nodeacc30\r"}
}
if { "$nodeacc31" != "" } {
expect "> 0x" { send "$nodeacc31\r"}
}
if { "$nodeacc32" != "" } {
expect "> 0x" { send "$nodeacc32\r"}
}
if { "$nodeacc33" != "" } {
expect "> 0x" { send "$nodeacc33\r"}
}
if { "$nodeacc34" != "" } {
expect "> 0x" { send "$nodeacc34\r"}
}
if { "$nodeacc35" != "" } {
expect "> 0x" { send "$nodeacc35\r"}
}
if { "$nodeacc36" != "" } {
expect "> 0x" { send "$nodeacc36\r"}
}
if { "$nodeacc37" != "" } {
expect "> 0x" { send "$nodeacc37\r"}
}
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
