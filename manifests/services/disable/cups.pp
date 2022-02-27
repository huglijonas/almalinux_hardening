# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable the CUPS Service
#
# @description
#	  The cups service can be disabled with the following command:
#   $ sudo systemctl mask --now cups.service
#
# @rationale
#   Turn off unneeded services to reduce attack surface.
#
# @example
#   include almalinux_hardening::services::disable::cups
class almalinux_hardening::services::disable::cups {
  if $almalinux_hardening::enable_disable_cups {
    service { 'disable_cups':
      ensure => 'stopped',
      name   => 'cups.service',
      enable => 'mask',
    }
  }
}
