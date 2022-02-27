# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable named Service
#
# @description
#   The named service can be disabled with the following command:
#   $ sudo systemctl mask --now named.service
#
# @rationale
#   All network services involve some risk of compromise due to implementation
#   flaws and should be disabled if possible.
#
# @example
#   include almalinux_hardening::services::disable::dns
class almalinux_hardening::services::disable::dns {
  if $almalinux_hardening::enable_disable_dns {
    service { 'disable_dns':
      ensure => 'stopped',
      name   => 'named.service',
      enable => 'mask',
    }
  }
}
