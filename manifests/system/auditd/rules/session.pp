# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Attempts to Alter Process and Session Initiation Information
#
# @description
#   The audit system already collects process information for all users and root.
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following lines to a file
#   with suffix .rules in the directory /etc/audit/rules.d in order to watch for
#   attempted manual edits of files involved in storing such process information:
#   -w /var/run/utmp -p wa -k session
#   -w /var/log/btmp -p wa -k session
#   -w /var/log/wtmp -p wa -k session
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following lines to /etc/audit/audit.rules
#   file in order to watch for attempted manual edits of files involved in storing
#   such process information:
#   -w /var/run/utmp -p wa -k session
#   -w /var/log/btmp -p wa -k session
#   -w /var/log/wtmp -p wa -k session
#
# @rationale
#   Manual editing of these files may indicate nefarious activity, such as an
#   attacker attempting to remove evidence of an intrusion.
#
# @example
#   include almalinux_hardening::system::auditd::rules::session
class almalinux_hardening::system::auditd::rules::session inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_session {
    $almalinux_hardening::auditd_rules_session_paths.each | $path | {
      file_line { "session_${auditd_program}_${path}":
        ensure => present,
        path   => $almalinux_hardening::auditd_rules_file,
        line   => "-w ${path} -p wa -k session",
      } ~> Service['auditd']
    }
  }
}
