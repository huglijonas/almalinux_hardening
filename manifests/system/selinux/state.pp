# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure SELinux State is Enforcing
#
# @description
#	  The SELinux state should be set to enforcing at system boot time. In the file
#   /etc/selinux/config, add or correct the following line to configure the system
#   to boot into enforcing mode:
#   SELINUX=enforcing
#
# @rationale
#   Setting the SELinux state to enforcing ensures SELinux is able to confine
#   potentially compromised processes to the security policy, which is designed
#   to prevent them from causing damage to the system or further elevating their
#   privileges.
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
