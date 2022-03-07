# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify the System's Discretionary Access Controls
#
# @description
#
#
# @rationale
#
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
