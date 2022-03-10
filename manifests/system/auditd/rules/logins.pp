# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Attempts to Alter Logon and Logout Events
#
# @description
#   The audit system already collects login information for all users and root.
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following lines to a file
#   with suffix .rules in the directory /etc/audit/rules.d in order to watch for
#   attempted manual edits of files involved in storing logon events:
#   -w <path> -p wa -k logins
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following lines to /etc/audit/audit.rules
#   file in order to watch for unattempted manual edits of files involved in storing
#   logon events:
#   -w <path> -p wa -k logins
#
# @rationale
#	  Manual editing of these files may indicate nefarious activity, such as an
#   attacker attempting to remove evidence of an intrusion.
#
# @example
#   include almalinux_hardening::system::auditd::rules::logins
class almalinux_hardening::system::auditd::rules::logins inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_logins {
    $almalinux_hardening::auditd_rules_logins_paths.each | $path | {
      file_line { "logins_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k logins",
      } ~> Service['auditd']
    }
  }
}
