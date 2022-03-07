# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects Information on Kernel Module Unloading
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::modules
class almalinux_hardening::system::auditd::rules::modules inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_modules {
    $almalinux_hardening::auditd_rules_modules_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "modules_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F key=modules",
        } ~> Service['auditd']
      }
    }
  }
}
