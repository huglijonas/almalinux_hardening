# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set SSH Client Alive Count Max
#
# @description
#   The SSH server sends at most ClientAliveCountMax messages during a SSH session
#   and waits for a response from the SSH client. The option ClientAliveInterval
#   configures timeout after each ClientAliveCountMax message. If the SSH server
#   does not receive a response from the client, then the connection is considered
#   idle and terminated. For SSH earlier than v8.2, a ClientAliveCountMax value of
#   0 causes an idle timeout precisely when the ClientAliveInterval is set. Starting
#   with v8.2, a value of 0 disables the timeout functionality completely. If the
#   option is set to a number greater than 0, then the idle session will be disconnected
#   after ClientAliveInterval * ClientAliveCountMax seconds.
#
# @rationale
#   This ensures a user login will be terminated as soon as the ClientAliveInterval
#   is reached.
#
# @example
#   include almalinux_hardening::services::ssh::alive_max
class almalinux_hardening::services::ssh::alive_max inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_alive_max {
    file_line { 'ssh_alive_max':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "ClientAliveCountMax ${almalinux_hardening::ssh_alive_max}",
      match  => '^(#|).*ClientAliveCountMax.*.[0-9]*.*$',
    }
    ~> Service['sshd']
  }
}
