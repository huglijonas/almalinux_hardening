# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable SSH Root Login
#
# @description
#   The root user should never be allowed to login to a system directly over a
#   network. To disable root login via SSH, add or correct the following line in
#   /etc/ssh/sshd_config:
#   PermitRootLogin no
#
# @rationale
#	  Even though the communications channel may be encrypted, an additional layer
#   of security is gained by extending the policy of not logging directly on as
#   root. In addition, logging in with a user-specific account provides individual
#   accountability of actions performed on the system and also helps to minimize
#   direct attack attempts on root's password.
#
# @example
#   include almalinux_hardening::services::ssh::root_login
class almalinux_hardening::services::ssh::root_login inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_root_login {
    file_line { 'ssh_root_login':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "PermitRootLogin ${almalinux_hardening::ssh_root_login}",
      match  => '^(#|).*PermitRootLogin.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
