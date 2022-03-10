# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects File Deletion Events by User
#
# @description
#	  At a minimum, the audit system should collect file deletion events for all
#   users and root. If the auditd daemon is configured to use the augenrules
#   program to read audit rules during daemon startup (the default), add the
#   following line to a file with suffix .rules in the directory /etc/audit/rules.d,
#   setting ARCH to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S <action> -F auid>=1000 -F auid!=unset -F key=delete
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file, setting ARCH to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S <action> -F auid>=1000 -F auid!=unset -F key=delete
#
# @rationale
#   Auditing file deletions will create an audit trail for files that are removed
#   from the system. The audit trail could aid in system troubleshooting, as well
#   as, detecting malicious processes that attempt to delete log files to conceal
#   their presence.
#
# @example
#   include almalinux_hardening::system::auditd::rules::delete
class almalinux_hardening::system::auditd::rules::delete inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_delete {
    $almalinux_hardening::auditd_rules_delete_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "delete_${auditd_program}_${action}_${arch}":
          ensure => present,
          path   => $almalinux_hardening::auditd_rules_file,
          line   => "-a always,exit -F arch=b${arch} -S ${action} -F auid>=1000 -F auid!=unset -F key=delete",
        } ~> Service['auditd']
      }
    }
  }
}
