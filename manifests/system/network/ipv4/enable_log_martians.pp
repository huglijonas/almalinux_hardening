# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Kernel Parameter to Log Martian Packets on IPv4 Interfaces
#
# @description
#   To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.conf.all.log_martians=1
#   $ sudo sysctl -w net.ipv4.conf.default.log_martians=1
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.conf.all.log_martians = 1
#   net.ipv4.conf.default.log_martians = 1
#
# @rationale
#   The presence of "martian" packets (which have impossible addresses) as well as
#   spoofed packets, source-routed packets, and redirects could be a sign of nefarious
#   network activity. Logging these packets enables this activity to be detected.
#
# @example
#   include almalinux_hardening::system::network::ipv4::enable_log_martians
class almalinux_hardening::system::network::ipv4::enable_log_martians {
  if $almalinux_hardening::enable_ipv4_log_martians {
    sysctl { 'net.ipv4.conf.all.log_martians':
      ensure => 'present',
      value  => '1',
    }
    sysctl { 'net.ipv4.conf.default.log_martians':
      ensure => 'present',
      value  => '1',
    }
  }
}
