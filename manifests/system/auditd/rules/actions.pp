# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects System Administrator Actions
#
# @description
#   At a minimum, the audit system should collect administrator actions for all
#   users and root. If the auditd daemon is configured to use the augenrules
#   program to read audit rules during daemon startup (the default), add the
#   following line to a file with suffix .rules in the directory /etc/audit/rules.d:
#   -w /etc/sudoers -p wa -k actions
#   -w /etc/sudoers.d/ -p wa -k actions
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file:
#   -w /etc/sudoers -p wa -k actions
#   -w /etc/sudoers.d/ -p wa -k actions
#
# @rationale
#   The actions taken by system administrators should be audited to keep a record
#   of what was executed on the system, as well as, for accountability purposes.
#
# @example
#   include almalinux_hardening::system::auditd::rules::actions
class almalinux_hardening::system::auditd::rules::actions inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_actions {
    $almalinux_hardening::auditd_rules_actions_paths.each | $path | {
      file_line { "actions_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k actions",
      } ~> Service['auditd']
    }
  }
}
