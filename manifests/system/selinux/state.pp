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
#   include almalinux_hardening::system::selinux::state
class almalinux_hardening::system::selinux::state {
  if $almalinux_hardening::enable_selinux_state {
    file_line { 'selinux_state':
      ensure => 'present',
      path   => '/etc/selinux/config',
      line   => 'SELINUX=enforcing',
      match  => '^(#|).*SELINUX.*=',
    }
  }
}
