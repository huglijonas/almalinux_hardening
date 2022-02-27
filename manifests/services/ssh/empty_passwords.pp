# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable SSH Access via Empty Passwords
#
# @description
#   To explicitly disallow SSH login from accounts with empty passwords, add or
#   correct the following line in /etc/ssh/sshd_config:
#   PermitEmptyPasswords no
#   Any accounts with empty passwords should be disabled immediately, and PAM
#   configuration should prevent users from being able to assign themselves empty
#   passwords.
#
# @rationale
#   Configuring this setting for the SSH daemon provides additional assurance that
#   remote login via SSH will require a password, even in the event of misconfiguration
#   elsewhere.
#
# @example
#   include almalinux_hardening::services::ssh::empty_passwords
class almalinux_hardening::services::ssh::empty_passwords inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_empty_passwords {
    file_line { 'ssh_empty_passwords':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "PermitEmptyPasswords ${almalinux_hardening::ssh_empty_passwords}",
      match  => '^(#|).*PermitEmptyPasswords.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
