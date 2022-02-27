# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Deactivate Wireless Network Interfaces
#
# @description
#   Deactivating wireless network interfaces should prevent normal usage of the
#   wireless capability.
#   Configure the system to disable all wireless network interfaces with the following
#   command:
#   $ sudo nmcli radio wifi off
#
# @rationale
#	  The use of wireless networking can introduce many different attack vectors into
#   the organization's network. Common attack vectors such as malicious association
#   and ad hoc networks will allow an attacker to spoof a wireless access point (AP),
#   allowing validated systems to connect to the malicious AP and enabling the attacker
#   to monitor and record network traffic. These malicious APs can also serve to create
#   a man-in-the-middle attack or be used to create a denial of service to valid network
#   resources.
#
# @example
#   include almalinux_hardening::system::network::wireless::software_configuration::deactivate
class almalinux_hardening::system::network::wireless::software_configuration::deactivate {
  if $almalinux_hardening::enable_wireless_deactivate {
    exec { 'disable_wifi':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'nmcli radio wifi off',
      onlyif  => "nmcli radio wifi | egrep -q '^enabled$'",
    }
  }
}
