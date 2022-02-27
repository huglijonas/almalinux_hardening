# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable snmpd Service
#
# @description
#   The snmpd service can be disabled with the following command:
#   $ sudo systemctl mask --now snmpd.service
#
# @rationale
#   Running SNMP software provides a network-based avenue of attack, and should
#   be disabled if not needed.
#
# @example
#   include almalinux_hardening::services::disable::snmpd
class almalinux_hardening::services::disable::snmpd {
  if $almalinux_hardening::enable_disable_snmpd {
    service { 'disable_snmp':
      ensure => 'stopped',
      name   => 'snmpd.service',
      enable => 'mask',
    }
  }
}
