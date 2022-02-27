# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set Default firewalld Zone for Incoming Packets
#
# @description
#   To set the default zone to drop for the built-in default zone which processes
#   incoming IPv4 and IPv6 packets, modify the following line in /etc/firewalld/firewalld.conf
#   to be:
#   DefaultZone=drop
#
# @rationale
#   In firewalld the default zone is applied only after all the applicable rules
#   in the table are examined for a match. Setting the default zone to drop implements
#   proper design for a firewall, i.e. any packets which are not explicitly permitted
#   should not be accepted.
#
# @example
#   include almalinux_hardening::system::network::firewalld::default_zone
class almalinux_hardening::system::network::firewalld::default_zone {
  if $almalinux_hardening::enable_firewalld_defaultzone {
    file_line { 'fw_default_zone':
      ensure => 'present',
      path   => '/etc/firewalld/firewalld.conf',
      line   => 'DefaultZone=drop',
      match  => '^(#|).*DefaultZone.*=.*$',
    }
    ~> service { 'firewalld_service_restart':
      ensure => running,
      name   => 'firewalld.service',
      enable => true,
    }
  }
}
