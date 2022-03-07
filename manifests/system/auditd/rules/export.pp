# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects Information on Exporting to Media
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::export
class almalinux_hardening::system::auditd::rules::export inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_export {
    $almalinux_hardening::auditd_rules_export_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "export_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F auid>=1000 -F auid!=unset -F key=export",
        } ~> Service['auditd']
      }
    }
  }
}
