# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects File Deletion Events by User
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::delete
class almalinux_hardening::system::auditd::rules::delete inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_delete {
    $almalinux_hardening::auditd_rules_delete_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "delete_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F auid>=1000 -F auid!=unset -F key=delete",
        } ~> Service['auditd']
      }
    }
  }
}
