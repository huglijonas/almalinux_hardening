# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable DHCP Service
#
# @description
#   The dhcpd service should be disabled on any system that does not need to act
#   as a DHCP server. The dhcpd service can be disabled with the following command:
#   $ sudo systemctl mask --now dhcpd.service
#
# @rationale
#   Unmanaged or unintentionally activated DHCP servers may provide faulty information
#   to clients, interfering with the operation of a legitimate site DHCP server if
#   there is one.
#
# @example
#   include almalinux_hardening::services::disable::dhcp
class almalinux_hardening::services::disable::dhcp {
  if $almalinux_hardening::enable_disable_dhcp {
    service { 'disable_dhcp':
      ensure => 'stopped',
      name   => 'dhcp.service',
      enable => 'mask',
    }
  }
}
