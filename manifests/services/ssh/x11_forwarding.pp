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
#   include almalinux_hardening::services::ssh::x11_forwarding
class almalinux_hardening::services::ssh::x11_forwarding inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_x11_forwarding {
    file_line { 'ssh_x11_forwarding':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "X11Forwarding ${almalinux_hardening::ssh_x11_forwarding}",
      match  => '^(#|).*X11Forwarding.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
