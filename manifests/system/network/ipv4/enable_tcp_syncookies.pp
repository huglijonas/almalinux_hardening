# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Kernel Parameter to Use TCP Syncookies on IPv4 Interfaces
#
# @description
#   To set the runtime status of the net.ipv4.tcp_syncookies kernel parameter,
#   run the following command:
#   $ sudo sysctl -w net.ipv4.tcp_syncookies=1
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.tcp_syncookies = 1
#
# @rationale
#	  A TCP SYN flood attack can cause a denial of service by filling a system's TCP
#   connection table with connections in the SYN_RCVD state. Syncookies can be used
#   to track a connection when a subsequent ACK is received, verifying the initiator
#   is attempting a valid connection and is not a flood source. This feature is activated
#   when a flood condition is detected, and enables the system to continue servicing
#   valid connection requests.
#
# @example
#   include almalinux_hardening::system::network::ipv4::enable_tcp_syncookies
class almalinux_hardening::system::network::ipv4::enable_tcp_syncookies {
  if $almalinux_hardening::enable_ipv4_tcp_syncookies {
    sysctl { 'net.ipv4.tcp_syncookies':
      ensure => 'present',
      value  => '1',
    }
  }
}
