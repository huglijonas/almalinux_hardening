# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Kernel Parameter for IP Forwarding on IPv4 Interfaces
#
# @description
#   To set the runtime status of the net.ipv4.ip_forward kernel parameter, run
#   the following command:
#   $ sudo sysctl -w net.ipv4.ip_forward=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.ip_forward = 0
#
# @rationale
#   Routing protocol daemons are typically used on routers to exchange network
#   topology information with other routers. If this capability is used when not
#   required, system network information may be unnecessarily transmitted across
#   the network.
#
# @example
#   include almalinux_hardening::system::network::ipv4::disable_ip_forwarding
class almalinux_hardening::system::network::ipv4::disable_ip_forwarding {
  if $almalinux_hardening::enable_ipv4_ip_forwarding {
    sysctl { 'net.ipv4.ip_forward':
      ensure => 'present',
      value  => $almalinux_hardening::ipv4_ip_forwarding,
    }
  }
}
