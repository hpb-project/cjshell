#!/usr/bin/expect -f
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

set timeout 30
spawn  ssh $ar2@$ar1
expect { 
   "Are you sure you want to continue connecting (yes/no)?" {  send "yes\r";exp_continue }
   "password:" { send "$ar3\r"}
}
expect "" { send "cd $ar4\r"}
if { "$ar5" != "" } {
expect "" { send "$ar5\r"}
}
if { "$ar6" != "" } {
expect "" { send "$ar6\r"}
}
if { "$ar7" != "" } {
expect "" { send "$ar7\r"}
}
if { "$ar8" != "" } {
expect "" { send "$ar8\r"}
}
if { "$ar9" != "" } {
expect "" { send "$ar9\r"}
}
if { "$ar10" != "" } {
expect "" { send "$ar10\r"}
}
if { "$ar11" != "" } {
expect "" { send "$ar11\r"}
}
if { "$ar12" != "" } {
expect "" { send "$ar12\r"}
}
if { "$ar13" != "" } {
expect "" { send "$ar13\r"}
}
if { "$ar14" != "" } {
expect "" { send "$ar14\r"}
}
if { "$ar15" != "" } {
expect "" { send "$ar15\r"}
}
if { "$ar16" != "" } {
expect "" { send "$ar16\r"}
}
if { "$ar17" != "" } {
expect "" { send "$ar17\r"}
}
if { "$ar18" != "" } {
expect "" { send "$ar18\r"}
}
if { "$ar19" != "" } {
expect "" { send "$ar19\r"}
}
if { "$ar20" != "" } {
expect "" { send "$ar20\r"}
}
if { "$ar21" != "" } {
expect "" { send "$ar21\r"}
}
if { "$ar22" != "" } {
expect "" { send "$ar22\r"}
}
if { "$ar23" != "" } {
expect "" { send "$ar23\r"}
}
if { "$ar24" != "" } {
expect "" { send "$ar24\r"}
}
if { "$ar25" != "" } {
expect "" { send "$ar25\r"}
}
if { "$ar26" != "" } {
expect "" { send "$ar26\r"}
}
if { "$ar27" != "" } {
expect "" { send "$ar27\r"}
}
if { "$ar28" != "" } {
expect "" { send "$ar28\r"}
}
if { "$ar29" != "" } {
expect "" { send "$ar29\r"}
}
if { "$ar30" != "" } {
expect "" { send "$ar30\r"}
}
if { "$ar31" != "" } {
expect "" { send "$ar31\r"}
}
expect "" { send "exit\r"}
expect eof
