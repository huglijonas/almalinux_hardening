# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable SSH Support for .rhosts Files
#
# @description
#   SSH can emulate the behavior of the obsolete rsh command in allowing users
#   to enable insecure access to their accounts via .rhosts files.
#   To ensure this behavior is disabled, add or correct the following line in
#   /etc/ssh/sshd_config:
#   IgnoreRhosts yes
#
# @rationale
#	  SSH trust relationships mean a compromise on one host can allow an attacker
#   to move trivially to other hosts.
#
# @example
#   include almalinux_hardening::services::ssh::ignore_rhosts
class almalinux_hardening::services::ssh::ignore_rhosts inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_ignore_rhosts {
    file_line { 'ssh_ignore_rhosts':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "IgnoreRhosts ${almalinux_hardening::ssh_ignore_rhosts}",
      match  => '^(#|).*IgnoreRhosts.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
