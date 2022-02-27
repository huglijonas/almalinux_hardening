# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set SSH MaxSessions limit
#
# @description
#   The MaxSessions parameter specifies the maximum number of open sessions
#   permitted from a given connection. To set MaxSessions edit /etc/ssh/sshd_config
#   as follows:
#   MaxSessions 4
#
# @rationale
#   To protect a system from denial of service due to a large number of concurrent
#   sessions, use the rate limiting function of MaxSessions to protect availability
#   of sshd logins and prevent overwhelming the daemon.
#
# @example
#   include almalinux_hardening::services::ssh::max_sessions
class almalinux_hardening::services::ssh::max_sessions inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_max_sessions {
    file_line { 'ssh_max_sessions':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "MaxSessions ${almalinux_hardening::ssh_max_sessions}",
      match  => '^(#|).*MaxSessions.*.[0-9]*.*$',
    }
    ~> Service['sshd']
  }
}
