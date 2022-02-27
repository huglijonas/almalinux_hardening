# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Kernel Parameter for Accepting Secure ICMP Redirects on IPv4 Interfaces
#
# @description
#	  To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
#   $ sudo sysctl -w net.ipv4.conf.default.secure_redirects=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.conf.all.secure_redirects = 0
#   net.ipv4.conf.default.secure_redirects = 0
#
# @rationale
#   Accepting "secure" ICMP redirects (from those gateways listed as default gateways)
#   has few legitimate uses. It should be disabled unless it is absolutely required.
#
# @example
#   include almalinux_hardening::system::network::ipv4::disable_secure_redirects
class almalinux_hardening::system::network::ipv4::disable_secure_redirects {
  if $almalinux_hardening::enable_ipv4_secure_redirects {
    sysctl { 'net.ipv4.conf.all.secure_redirects':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv4.conf.default.secure_redirects':
      ensure => 'present',
      value  => '0',
    }
  }
}
