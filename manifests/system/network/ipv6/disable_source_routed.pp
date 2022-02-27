# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Kernel Parameter for Accepting Source-Routed Packets on IPv6 Interfaces
#
# @description
#   To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv6.conf.all.accept_source_route=0
#   $ sudo sysctl -w net.ipv6.conf.default.accept_source_route=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv6.conf.all.accept_source_route = 0
#   net.ipv6.conf.default.accept_source_route = 0
#
# @rationale
#	  Source-routed packets allow the source of the packet to suggest routers forward
#   the packet along a different path than configured on the router, which can be
#   used to bypass network security measures. This requirement applies only to the
#   forwarding of source-routerd traffic, such as when IPv6 forwarding is enabled
#   and the system is functioning as a router.
#   Accepting source-routed packets in the IPv6 protocol has few legitimate uses.
#   It should be disabled unless it is absolutely required.
#
# @example
#   include almalinux_hardening::system::network::ipv6::disable_source_routed
class almalinux_hardening::system::network::ipv6::disable_source_routed {
  if $almalinux_hardening::enable_ipv6_source_routed {
    sysctl { 'net.ipv6.conf.all.accept_source_route':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv6.conf.default.accept_source_route':
      ensure => 'present',
      value  => '0',
    }
  }
}
