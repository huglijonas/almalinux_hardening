# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Max Log File Size
#   Configure auditd Max Log File Size
#
# @description - Max Log File Size
#	  Determine the amount of audit data (in megabytes) which should be retained
#   in each log file. Edit the file /etc/audit/auditd.conf. Add or modify the
#   following line, substituting the correct value of 6 for STOREMB:
#   max_log_file = STOREMB
#   Set the value to 6 (MB) or higher for general-purpose systems. Larger values,
#   of course, support retention of even more audit data.
#
# @rationale - Max Log File Size
#   The total storage for audit log files must be large enough to retain log
#   information over the period required. This is a function of the maximum log
#   file size and the number of logs retained.
#
# @summary - Max Log File Size Action
#   Configure auditd max_log_file_action Upon Reaching Maximum Log Size
#
# @description - Max Log File Size Action
#	  The default action to take when the logs reach their maximum size is to rotate
#   the log files, discarding the oldest one. To configure the action taken by
#   auditd, add or correct the line in /etc/audit/auditd.conf:
#   max_log_file_action = ACTION
#   Possible values for ACTION are described in the auditd.conf man page. These
#   include:
#   syslog
#   suspend
#   rotate
#   keep_logs
#   Set the ACTION to rotate to ensure log rotation occurs. This is the default.
#   The setting is case-insensitive.
#
# @rationale - Max Log File Size Action
#	  Automatically rotating logs (by setting this to rotate) minimizes the chances
#   of the system unexpectedly running out of disk space by being overwhelmed with
#   log data. However, for systems that must never discard log data, or which use
#   external processes to transfer it and reclaim space, keep_logs can be employed.
#
# @example
#   include almalinux_hardening::system::auditd::data::log
class almalinux_hardening::system::auditd::data::log inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_data_log {
    file_line { 'data_auditd_log_maxsize':
      ensure => present,
      path   => '/etc/audit/auditd.conf',
      line   => "max_log_file = ${almalinux_hardening::auditd_data_log_maxsize}",
      match  => '^max_log_file\s=\s.*$',
    } ~> Service['auditd']

    file_line { 'data_auditd_log_maxsize_action':
      ensure => present,
      path   => '/etc/audit/auditd.conf',
      line   => "max_log_file_action = ${almalinux_hardening::auditd_data_log_maxsize_action}",
      match  => '^max_log_file_action\s=\s.*$',
    } ~> Service['auditd']
  }
}
