# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Attempts to Alter Process and Session Initiation Information
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::session
class almalinux_hardening::system::auditd::rules::session inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_session {
    $almalinux_hardening::auditd_rules_session_paths.each | $path | {
      file_line { "session_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k session",
      } ~> Service['auditd']
    }
  }
}
