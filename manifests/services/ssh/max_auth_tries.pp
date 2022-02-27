# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set SSH authentication attempt limit
#
# @description
#   The MaxAuthTries parameter specifies the maximum number of authentication
#   attempts permitted per connection. Once the number of failures reaches half
#   this value, additional failures are logged. to set MaxAUthTries edit
#   /etc/ssh/sshd_config as follows:
#   MaxAuthTries 4
#
# @rationale
#   Setting the MaxAuthTries parameter to a low number will minimize the risk of
#   successful brute force attacks to the SSH server.
#
# @example
#   include almalinux_hardening::services::ssh::max_auth_tries
class almalinux_hardening::services::ssh::max_auth_tries inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_max_auth_tries {
    file_line { 'ssh_max_auth_tries':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "MaxAuthTries ${almalinux_hardening::ssh_max_auth_tries}",
      match  => '^(#|).*MaxAuthTries.*.[0-9]*.*$',
    }
    ~> Service['sshd']
  }
}
