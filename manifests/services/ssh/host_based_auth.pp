# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Host-Based Authentication
#
# @description
#   SSH's cryptographic host-based authentication is more secure than .rhosts
#   authentication. However, it is not recommended that hosts unilaterally trust
#   one another, even within an organization.
#   To disable host-based authentication, add or correct the following line in
#   /etc/ssh/sshd_config:
#   HostbasedAuthentication no
#
# @rationale
#   SSH trust relationships mean a compromise on one host can allow an attacker
#   to move trivially to other hosts.
#
# @example
#   include almalinux_hardening::services::ssh::host_based_auth
class almalinux_hardening::services::ssh::host_based_auth inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_host_based_auth {
    file_line { 'ssh_host_based_auth':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "HostbasedAuthentication ${almalinux_hardening::ssh_host_based_auth}",
      match  => '^(#|).*HostbasedAuthentication.*(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
