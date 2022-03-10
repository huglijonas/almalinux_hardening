# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - admin_space_left
#   Configure auditd admin_space_left Action on Low Disk Space
#
# @description - admin_space_left
#	  The auditd service can be configured to take an action when disk space is
#   running low but prior to running out of space completely. Edit the file
#   /etc/audit/auditd.conf. Add or modify the following line, substituting ACTION
#   appropriately:
#   admin_space_left_action = ACTION
#   Set this value to single to cause the system to switch to single user mode for
#   corrective action. Acceptable values also include suspend and halt. For certain
#   systems, the need for availability outweighs the need to log all actions, and a
#   different setting should be determined. Details regarding all possible values for
#   ACTION are described in the auditd.conf man page.
#
# @rationale - admin_space_left
#   Administrators should be made aware of an inability to record audit records.
#   If a separate partition or logical volume of adequate size is used, running low
#   on space for audit records should never occur.
#
# @summary - space_left
#   Configure auditd space_left Action on Low Disk Space
#
# @description - space_left
#   The auditd service can be configured to take an action when disk space starts
#   to run low. Edit the file /etc/audit/auditd.conf. Modify the following line,
#   substituting ACTION appropriately:
#   space_left_action = ACTION
#   Possible values for ACTION are described in the auditd.conf man page. These
#   include:
#   syslog
#   email
#   exec
#   suspend
#   single
#   halt
#   Set this to email (instead of the default, which is suspend) as it is more
#   likely to get prompt attention. Acceptable values also include suspend, single,
#   and halt.
#
# @rationale - space_left
#   Notifying administrators of an impending disk space problem may allow them to
#   take corrective action prior to any disruption.
#
# @summary - mail_acct
#   Configure auditd mail_acct Action on Low Disk Space
#
# @description - mail_acct
#   The auditd service can be configured to send email to a designated account
#   in certain situations. Add or correct the following line in /etc/audit/auditd.conf
#   to ensure that administrators are notified via email for those situations:
#   action_mail_acct = root
#
# @rationale - mail_acct
#   Email sent to the root account is typically aliased to the administrators of
#   the system, who can take appropriate action.
#
# @example
#   include almalinux_hardening::system::auditd::data::space
class almalinux_hardening::system::auditd::data::space inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_data_space {
    file_line { 'data_auditd_admin_space_left':
      ensure => present,
      path   => '/etc/audit/auditd.conf',
      line   => "admin_space_left_action = ${almalinux_hardening::auditd_data_space_adm_action}",
      match  => '^admin_space_left_action\s=\s.*$',
    } ~> Service['auditd']

    file_line { 'data_auditd_space_left':
      ensure => present,
      path   => '/etc/audit/auditd.conf',
      line   => "space_left_action = ${almalinux_hardening::auditd_data_space_action}",
      match  => '^space_left_action\s=\s.*$',
    } ~> Service['auditd']

    file_line { 'data_auditd_mail':
      ensure => present,
      path   => '/etc/audit/auditd.conf',
      line   => 'action_mail_acct = root',
      match  => '^action_mail_acct\s=\s.*$',
    } ~> Service['auditd']
  }
}
