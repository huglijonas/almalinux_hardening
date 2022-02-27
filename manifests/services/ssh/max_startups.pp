# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure SSH MaxStartups is configured
#
# @description
#   The MaxStartups parameter specifies the maximum number of concurrent
#   unauthenticated connections to the SSH daemon. Additional connections will
#   be dropped until authentication succeeds or the LoginGraceTime expires for a
#   connection. To confgure MaxStartups, you should add or correct the following
#   line in the /etc/ssh/sshd_config file:
#   MaxStartups 10:30:60
#   CIS recommends a MaxStartups value of '10:30:60', or more restrictive where
#   dictated by site policy.
#
# @rationale
#   To protect a system from denial of service due to a large number of pending
#   authentication connection attempts, use the rate limiting function of MaxStartups
#   to protect availability of sshd logins and prevent overwhelming the daemon.
#
# @example
#   include almalinux_hardening::services::ssh::max_startups
class almalinux_hardening::services::ssh::max_startups inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_max_startups {
    file_line { 'ssh_max_startups':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "MaxStartups ${almalinux_hardening::ssh_max_startups}",
      match  => '^(#|).*MaxStartups.*.[0-9:]*.*$',
    }
    ~> Service['sshd']
  }
}
