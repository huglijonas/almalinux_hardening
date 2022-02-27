# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Kernel Parameter for Sending ICMP Redirects on IPv4 Interfaces
#
# @description
#	  To set the runtime status kernel parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.conf.all.send_redirects=0
#   $ sudo sysctl -w net.ipv4.conf.default.send_redirects=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   net.ipv4.conf.all.send_redirects = 0
#   net.ipv4.conf.default.send_redirects = 0
#
# @rationale
#   ICMP redirect messages are used by routers to inform hosts that a more direct
#   route exists for a particular destination. These messages contain information
#   from the system's route table possibly revealing portions of the network topology.
#   The ability to send ICMP redirects is only appropriate for systems acting as
#   routers.
#
# @example
#   include almalinux_hardening::system::network::ipv4::disable_sending_icmp_redirects
class almalinux_hardening::system::network::ipv4::disable_sending_icmp_redirects {
  if $almalinux_hardening::enable_ipv4_sending_icmp_redirects {
    sysctl { 'net.ipv4.conf.all.send_redirects':
      ensure => 'present',
      value  => '0',
    }
    sysctl { 'net.ipv4.conf.default.send_redirects':
      ensure => 'present',
      value  => '0',
    }
  }
}
