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
#   include almalinux_hardening::services::ssh::tcp_forwarding
class almalinux_hardening::services::ssh::tcp_forwarding inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_tcp_forwarding {
    file_line { 'ssh_tcp_forwarding':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "AllowTcpForwarding ${almalinux_hardening::ssh_tcp_forwarding}",
      match  => '^(#|).*AllowTcpForwarding.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
