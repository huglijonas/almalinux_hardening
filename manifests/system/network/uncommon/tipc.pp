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
#   include almalinux_hardening::system::network::uncommon::tipc
class almalinux_hardening::system::network::uncommon::tipc {
  if $almalinux_hardening::enable_network_uncommon_tipc {
    kmod::install { 'tipc':
      command => '/bin/true',
    }
  }
}
