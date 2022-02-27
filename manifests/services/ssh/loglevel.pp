# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set SSH Daemon LogLevel to VERBOSE
#
# @description
#   The VERBOSE parameter configures the SSH daemon to record login and logout
#   activity. To specify the log level in SSH, add or correct the following line
#   in the /etc/ssh/sshd_config file:
#   LogLevel VERBOSE
#
# @rationale
#	  SSH provides several logging levels with varying amounts of verbosity. DEBUG
#   is specifically not recommended other than strictly for debugging SSH communications
#   since it provides so much data that it is difficult to identify important security
#   information. INFO or VERBOSE level is the basic level that only records login activity
#   of SSH users. In many situations, such as Incident Response, it is important to determine
#   when a particular user was active on a system. The logout record can eliminate those
#   users who disconnected, which helps narrow the field.
#
# @example
#   include almalinux_hardening::services::ssh::loglevel
class almalinux_hardening::services::ssh::loglevel inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_loglevel {
    file_line { 'ssh_loglevel':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "LogLevel ${almalinux_hardening::ssh_loglevel}",
      match  => '^(#|).*LogLevel.*.[A-Z]*.*$',
    }
    ~> Service['sshd']
  }
}
