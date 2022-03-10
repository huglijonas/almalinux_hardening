# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::network::uncommon::rds
class almalinux_hardening::system::network::uncommon::rds {
  if $almalinux_hardening::enable_network_uncommon_rds {
    kmod::install { 'rds':
      command => '/bin/true',
    }
  }
}
