# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Kernel Parameter for IPv6 Forwarding
#
# @description
#	  To set the runtime status of the net.ipv6.conf.all.forwarding kernel parameter,
#   run the following command:
#   $ sudo sysctl -w net.ipv6.conf.all.forwarding=0
#   To make sure that the setting is persistent, add the following line to a file in
#   the directory /etc/sysctl.d:
#   net.ipv6.conf.all.forwarding = 0
#
# @rationale
#	  IP forwarding permits the kernel to forward packets from one network interface
#   to another. The ability to forward packets between two networks is only appropriate
#   for systems acting as routers.
#
# @example
#   include almalinux_hardening::system::network::ipv6::disable_ip_forwarding
class almalinux_hardening::system::network::ipv6::disable_ip_forwarding {
  if $almalinux_hardening::enable_ipv6_ip_forwarding {
    sysctl { 'net.ipv6.conf.all.forwarding':
      ensure => 'present',
      value  => '0',
    }
  }
}
