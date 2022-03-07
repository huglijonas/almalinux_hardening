# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Unsuccessful Access Attempts to Files
#
# @description
#
#
# @rationale
#
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
