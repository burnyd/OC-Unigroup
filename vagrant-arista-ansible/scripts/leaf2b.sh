#!/bin/sh

sleep 5

FastCli -p 15 -c "configure
hostname leaf2b
!
username api secret password
!
username vagrant secret vagrant
!
event-handler Terminattr
   trigger on-boot
   action bash /usr/bin/TerminAttr -grpcaddr 0.0.0.0:6042 -allowed_ips 0.0.0.0/0 -disableaaa
!
ip name-server vrf default 8.8.8.8
ip domain-list 8.8.8.8
!
vlan 6
!
interface vlan 6
ip address 10.0.6.3/24
vrrp 6 ip 10.0.6.1
no shut
!
interface Ethernet1
  no switchport
  ip address 10.0.0.104/24
!
interface Ethernet2
description connection-to-spine1
no switchport
ip address 10.0.221.2/24
!
interface Ethernet3
description connection-to-spine2
no switchport
ip address 10.0.222.2/24
!
interface Ethernet4
description connection-to-leaf1b
switchport
switchport mode trunk
!
interface Ethernet5
description connection-to-host2
switchport mode access
switchport access vlan 6
!
int loopback0
ip address 6.6.6.6/32
!
ip route 0.0.0.0/0 10.0.2.2
!
management api http-commands
   protocol http
   no shutdown
!
management api gnmi
transport grpc default
port 6030
no ssl profile
no shutdown
!
exit"
