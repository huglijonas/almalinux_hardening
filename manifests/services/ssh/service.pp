# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   None
#
# @description
#   None
#
# @rationale
#	  None
#
# @example
#   include almalinux_hardening::services::ssh::service
class almalinux_hardening::services::ssh::service {
  service { 'sshd':
    ensure => running,
    enable => true,
  }
}
