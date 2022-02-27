# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Kernel Parameter to Ignore Bogus ICMP Error Responses on IPv4 Interfaces
#
# @description
#	  To set the runtime status of the net.ipv4.icmp_ignore_bogus_error_responses kernel
#   parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1
#   To make sure that the setting is persistent, add the following line to a file in
#   the directory /etc/sysctl.d:
#   net.ipv4.icmp_ignore_bogus_error_responses = 1
#
# @rationale
#   Ignoring bogus ICMP error responses reduces log size, although some activity would
#   not be logged.
#
# @example
#   include almalinux_hardening::system::network::ipv4::enable_ignore_icmp_bogus
class almalinux_hardening::system::network::ipv4::enable_ignore_icmp_bogus {
  if $almalinux_hardening::enable_ipv4_ignore_icmp_bogus {
    sysctl { 'net.ipv4.icmp_ignore_bogus_error_responses':
      ensure => 'present',
      value  => '1',
    }
  }
}
