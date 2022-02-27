# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include almalinux_hardening::services::ssh::service
class almalinux_hardening::services::ssh::service {
  service { 'sshd':
    ensure => running,
    enable => true,
  }
}
