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
#   include almalinux_hardening::system::selinux::policy
class almalinux_hardening::system::selinux::policy {
  if $almalinux_hardening::enable_selinux_policy {
    file_line { 'selinux_policy':
      ensure => 'present',
      path   => '/etc/selinux/config',
      line   => 'SELINUXTYPE=targeted',
      match  => '^(#|).*SELINUXTYPE.*=',
    }
  }
}
