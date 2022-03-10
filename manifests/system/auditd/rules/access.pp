# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Unsuccessful Access Attempts to Files
#
# @description
#   At a minimum, the audit system should collect unauthorized file accesses for
#   all users and root. If the auditd daemon is configured to use the augenrules
#   program to read audit rules during daemon startup (the default), add the
#   following lines to a file with suffix .rules in the directory /etc/audit/rules.d:
#   -a always,exit -F arch=b32 -S <action> -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
#   -a always,exit -F arch=b32 -S <action> -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
#   If the system is 64 bit then also add the following lines:
#   -a always,exit -F arch=b64 -S <action> -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
#   -a always,exit -F arch=b64 -S <action> -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
#   If the auditd daemon is configured to use the auditctl utility to read audit rules during daemon startup, add the following lines to /etc/audit/audit.rules file:
#   -a always,exit -F arch=b32 -S <action> -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
#   -a always,exit -F arch=b32 -S <action> -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
#   If the system is 64 bit then also add the following lines:
#   -a always,exit -F arch=b64 -S <action> -F exit=-EACCES -F auid>=1000 -F auid!=unset -F key=access
#   -a always,exit -F arch=b64 -S <action> -F exit=-EPERM -F auid>=1000 -F auid!=unset -F key=access
#
# @rationale
#	  Unsuccessful attempts to access files could be an indicator of malicious
#   activity on a system. Auditing these events could serve as evidence of
#   potential system compromise.
#
# @example
#   include almalinux_hardening::system::auditd::rules::access
class almalinux_hardening::system::auditd::rules::access inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_access {
    $almalinux_hardening::auditd_rules_access_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        ['EACCES', 'EPERM'].each | $exit | {
          file_line { "access_${auditd_program}_${action}_${exit}_${arch}":
            ensure  => present,
            path    => $almalinux_hardening::auditd_rules_file,
            line    => "-a always,exit -F arch=b${arch} -S ${action} -F exit=-${exit} -F auid>=1000 -F auid!=unset -F key=access",
          } ~> Service['auditd']
        }
      }
    }
  }
}
