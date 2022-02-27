# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Kernel Parameter to Use Reverse Path Filtering on IPv4 Interfaces
#
# @description
#   To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.conf.all.rp_filter=1
#   $ sudo sysctl -w net.ipv4.conf.default.rp_filter=1
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.conf.all.rp_filter = 1
#   net.ipv4.conf.default.rp_filter = 1
#
# @rationale
#   Enabling reverse path filtering drops packets with source addresses that should
#   not have been able to be received on the interface they were received on. It should
#   not be used on systems which are routers for complicated networks, but is helpful
#   for end hosts and routers serving small networks.
#
# @example
#   include almalinux_hardening::system::network::ipv4::enable_reverse_path_filtering
class almalinux_hardening::system::network::ipv4::enable_reverse_path_filtering {
  if $almalinux_hardening::enable_ipv4_reverse_path_filtering {
    sysctl { 'net.ipv4.conf.all.rp_filter':
      ensure => 'present',
      value  => '1',
    }
    sysctl { 'net.ipv4.conf.default.rp_filter':
      ensure => 'present',
      value  => '1',
    }
  }
}
