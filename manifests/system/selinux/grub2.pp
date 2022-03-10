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
#   include almalinux_hardening::system::selinux::grub2
class almalinux_hardening::system::selinux::grub2 {
  if $almalinux_hardening::enable_selinux_grub2 {
    kernel_parameter { 'selinux=1':
      ensure => present,
    }
    kernel_parameter { 'enforcing=1':
      ensure => present,
    }
  }
}
