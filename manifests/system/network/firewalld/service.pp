# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Verify firewalld Enabled
#
# @description
#   The firewalld service can be enabled with the following command:
#   $ sudo systemctl enable firewalld.service
#
# @rationale
#	  Access control methods provide the ability to enhance system security posture
#   by restricting services and known good IP addresses and address ranges. This
#   prevents connections from unknown hosts and protocols.
#
# @example
#   include almalinux_hardening::system::network::firewalld::service
class almalinux_hardening::system::network::firewalld::service {
  if $almalinux_hardening::enable_firewalld_service {
    service { 'firewalld':
      ensure => running,
      enable => true,
    }
  }
}
