# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Squid
#
# @description
#   The squid service can be disabled with the following command:
#   $ sudo systemctl mask --now squid.service
#
# @rationale
#   Running proxy server software provides a network-based avenue of attack, and
#   should be removed if not needed.
#
# @example
#   include almalinux_hardening::services::disable::squid
class almalinux_hardening::services::disable::squid {
  if $almalinux_hardening::enable_disable_squid {
    service { 'disable_squid':
      ensure => 'stopped',
      name   => 'squid.service',
      enable => 'mask',
    }
  }
}
