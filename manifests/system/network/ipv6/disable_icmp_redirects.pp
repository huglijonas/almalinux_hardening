# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Accepting ICMP Redirects for IPv6 Interfaces
#
# @description
#   To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
#   $ sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv6.conf.all.accept_redirects = 0
#   net.ipv6.conf.default.accept_redirects = 0
#
# @rationale
#	  An illicit ICMP redirect message could result in a man-in-the-middle attack.
#
# @example
#   include almalinux_hardening::system::network::ipv6::disable_icmp_redirects
class almalinux_hardening::system::network::ipv6::disable_icmp_redirects {
  if $almalinux_hardening::enable_ipv6_icmp_redirects {
    sysctl { 'net.ipv6.conf.all.accept_redirects':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv6.conf.default.accept_redirects':
      ensure => 'present',
      value  => '0',
    }
  }
}
