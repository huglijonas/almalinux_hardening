# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Accepting ICMP Redirects for IPv4 Interfaces
#
# @description
#   To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
#   $ sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.conf.all.accept_redirects = 0
#   net.ipv4.conf.default.accept_redirects = 0
#
# @rationale
#   ICMP redirect messages are used by routers to inform hosts that a more direct
#   route exists for a particular destination. These messages modify the host's
#   route table and are unauthenticated. An illicit ICMP redirect message could
#   result in a man-in-the-middle attack.
#   This feature of the IPv4 protocol has few legitimate uses. It should be disabled
#   unless absolutely required."
#
# @example
#   include almalinux_hardening::system::network::ipv4::disable_icmp_redirects
class almalinux_hardening::system::network::ipv4::disable_icmp_redirects {
  if $almalinux_hardening::enable_ipv4_icmp_redirects {
    sysctl { 'net.ipv4.conf.all.accept_redirects':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv4.conf.default.accept_redirects':
      ensure => 'present',
      value  => '0',
    }
  }
}
