# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Attempts to Alter Logon and Logout Events
#
# @description
#
#
# @rationale
#
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
