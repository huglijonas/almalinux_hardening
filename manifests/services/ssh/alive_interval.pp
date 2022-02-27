# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set SSH Idle Timeout Interval
#
# @description
#   SSH allows administrators to set an idle timeout interval. After this interval
#   has passed, the idle user will be automatically logged out.
#   To set an idle timeout interval, edit the following line in /etc/ssh/sshd_config
#   as follows:
#   ClientAliveInterval 900
#   The timeout interval is given in seconds. For example, have a timeout of 10
#   minutes, set interval to 600.
#   If a shorter timeout has already been set for the login shell, that value will
#   preempt any SSH setting made in /etc/ssh/sshd_config. Keep in mind that some
#   processes may stop SSH from correctly detecting that the user is idle.
#
# @rationale
#   Terminating an idle ssh session within a short time period reduces the window
#   of opportunity for unauthorized personnel to take control of a management session
#   enabled on the console or console port that has been let unattended.
#
# @example
#   include almalinux_hardening::services::ssh::alive_interval
class almalinux_hardening::services::ssh::alive_interval inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_alive_interval {
    file_line { 'ssh_alive_interval':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "ClientAliveInterval ${almalinux_hardening::ssh_alive_interval}",
      match  => '^(#|).*ClientAliveInterval.*.[0-9]*.*$',
    }
    ~> Service['sshd']
  }
}
