#!/bin/sh
sudo brctl addbr br0
sudo brctl addif br0 eth0
ifconfig eth0 0.0.0.0
