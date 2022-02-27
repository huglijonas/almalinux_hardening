# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Do Not Allow SSH Environment Options
#
# @description
#   To ensure users are not able to override environment variables of the SSH
#   daemon, add or correct the following line in /etc/ssh/sshd_config:
#   PermitUserEnvironment no
#
# @rationale
#   SSH environment options potentially allow users to bypass access restriction
#   in some configurations.
#
# @example
#   include almalinux_hardening::services::ssh::user_env
class almalinux_hardening::services::ssh::user_env inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_user_env {
    file_line { 'ssh_user_env':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "PermitUserEnvironment ${almalinux_hardening::ssh_user_env}",
      match  => '^(#|).*PermitUserEnvironment.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
