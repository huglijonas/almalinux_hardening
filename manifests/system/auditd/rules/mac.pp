# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify the System's Mandatory Access Controls
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::mac
class almalinux_hardening::system::auditd::rules::mac inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_mac {
    $almalinux_hardening::auditd_rules_mac_paths.each | $path | {
      file_line { "mac_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k MAC-policy",
      } ~> Service['auditd']
    }
  }
}
