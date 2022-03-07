# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record attempts to alter time
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::time
class almalinux_hardening::system::auditd::rules::time inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_time {
    $almalinux_hardening::auditd_rules_time_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "time_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F key=audit_time_rules",
        } ~> Service['auditd']
      }
    }
    $almalinux_hardening::auditd_rules_time_paths.each | $path | {
      file_line { "time_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k audit_time_rules",
      } ~> Service['auditd']
    }

    $almalinux_hardening::auditd_arch.each | $arch | {
      file_line { "time_${$arch}_clock_settime":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-a always,exit -F arch=b${arch} -S clock_settime -F a0=0x0 -F key=time-change",
      } ~> Service['auditd']
    }
  }
}
