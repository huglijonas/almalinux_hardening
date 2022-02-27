# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Configure Accepting Router Advertisements on All IPv6 Interfaces
#
# @description
#To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv6.conf.all.accept_ra=0
#   $ sudo sysctl -w net.ipv6.conf.default.accept_ra=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv6.conf.all.accept_ra = 0
#   net.ipv6.conf.default.accept_ra = 0
#
# @rationale
#   An illicit router advertisement message could result in a man-in-the-middle attack.
#
# @example
#   include almalinux_hardening::system::network::ipv6::router_advertisements
class almalinux_hardening::system::network::ipv6::router_advertisements {
  if $almalinux_hardening::enable_ipv6_router_advertisements {
    sysctl { 'net.ipv6.conf.all.accept_ra':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv6.conf.default.accept_ra':
      ensure => 'present',
      value  => '0',
    }
  }
}
