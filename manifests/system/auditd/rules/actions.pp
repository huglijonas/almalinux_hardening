# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects System Administrator Actions
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::actions
class almalinux_hardening::system::auditd::rules::actions inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_actions {
    $almalinux_hardening::auditd_rules_actions_paths.each | $path | {
      file_line { "actions_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k actions",
      } ~> Service['auditd']
    }
  }
}
