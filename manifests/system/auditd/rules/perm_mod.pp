# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Unsuccessful Access Attempts to Files
#
# @description
#   At a minimum, the audit system should collect file permission changes for all
#   users and root. If the auditd daemon is configured to use the augenrules program
#   to read audit rules during daemon startup (the default), add the following line
#   to a file with suffix .rules in the directory /etc/audit/rules.d:
#   -a always,exit -F arch=b32 -S <action> -F auid>=1000 -F auid!=unset -F key=perm_mod
#   If the system is 64 bit then also add the following line:
#   -a always,exit -F arch=b64 -S <action> -F auid>=1000 -F auid!=unset -F key=perm_mod
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file:
#   -a always,exit -F arch=b32 -S <action> -F auid>=1000 -F auid!=unset -F key=perm_mod
#   If the system is 64 bit then also add the following line:
#   -a always,exit -F arch=b64 -S <action> -F auid>=1000 -F auid!=unset -F key=perm_mod
#
# @rationale
#   The changing of file permissions could indicate that a user is attempting to
#   gain access to information that would otherwise be disallowed. Auditing DAC
#   modifications can facilitate the identification of patterns of abuse among both
#   authorized and unauthorized users.
#
# @example
#   include almalinux_hardening::system::auditd::rules::perm_mod
class almalinux_hardening::system::auditd::rules::perm_mod inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_perm_mod {
    $almalinux_hardening::auditd_rules_perm_mod_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "perm_mod_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F auid>=1000 -F auid!=unset -F key=perm_mod",
        } ~> Service['auditd']
      }
    }
  }
}
