# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify User/Group Information
#
# @description
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following lines to a file
#   with suffix .rules in the directory /etc/audit/rules.d, in order to capture
#   events that modify account changes:
#   -w <path> -p wa -k audit_rules_usergroup_modification
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following lines to /etc/audit/audit.rules
#   file, in order to capture events that modify account changes:
#   -w <path> -p wa -k audit_rules_usergroup_modification
#
# @rationale
#   In addition to auditing new user and group accounts, these watches will alert
#   the system administrator(s) to any modifications. Any unexpected users, groups,
#   or modifications should be investigated for legitimacy.
#
# @example
#   include almalinux_hardening::system::auditd::rules::usergroup
class almalinux_hardening::system::auditd::rules::usergroup inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_usergroup {
    $almalinux_hardening::auditd_rules_usergroup_paths.each | $path | {
      file_line { "usergroup_${auditd_program}_${path}":
        ensure => present,
        path   => $almalinux_hardening::auditd_rules_file,
        line   => "-w ${path} -p wa -k audit_rules_usergroup_modification",
      } ~> Service['auditd']
    }
  }
}
