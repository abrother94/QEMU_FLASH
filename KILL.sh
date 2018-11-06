#!/bin/sh

# kill previous qemu-system-arm and launch again !!

ps aux | grep "qemu" |  awk '{
    if($11 == "./qemu-system-arm-2.6.0")
    {
       print $2,$11
       cmd1 = "sudo kill -9 " $2
       print cmd1
       system(cmd1)
    }
}'> /dev/null

ps aux | grep "qemu" |  awk '{
    if($11 == "./qemu-system-arm-2.6.0-flash")
    {
       print $2,$11
       cmd1 = "sudo kill -9 " $2
       print cmd1
       system(cmd1)
    }
}'> /dev/null



ps aux | grep "qemu" |  awk '{
    if($11 == "./qemu-system-arm")
    {
       print $2,$11
       cmd1 = "sudo kill -9 " $2
       print cmd1
       system(cmd1)
    }
}' > /dev/null

reset
