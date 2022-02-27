# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Kernel Parameter to Ignore ICMP Broadcast Echo Requests on IPv4 Interfaces
#
# @description
#   To set the runtime status of the net.ipv4.icmp_echo_ignore_broadcasts kernel
#   parameter, run the following command:
#   $ sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
#   To make sure that the setting is persistent, add the following line to a file in
#   the directory /etc/sysctl.d:
#   net.ipv4.icmp_echo_ignore_broadcasts = 1
#
# @rationale
#   Responding to broadcast (ICMP) echoes facilitates network mapping and provides a
#   vector for amplification attacks.
#   Ignoring ICMP echo requests (pings) sent to broadcast or multicast addresses makes
#   the system slightly more difficult to enumerate on the network.
#
# @example
#   include almalinux_hardening::system::network::ipv4::enable_ignore_icmp_broadcast_echo
class almalinux_hardening::system::network::ipv4::enable_ignore_icmp_broadcast_echo {
  if $almalinux_hardening::enable_ipv4_ignore_icmp_broadcast_echo {
    sysctl { 'net.ipv4.icmp_echo_ignore_broadcasts':
      ensure => 'present',
      value  => '1',
    }
  }
}
