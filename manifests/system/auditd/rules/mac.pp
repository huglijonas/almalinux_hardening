# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify the System's Mandatory Access Controls
#
# @description
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following line to a file
#   with suffix .rules in the directory /etc/audit/rules.d:
#   -w <path> -p wa -k MAC-policy
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file:
#   -w <path> -p wa -k MAC-policy
#
# @rationale
#   The system's mandatory access policy (SELinux) should not be arbitrarily
#   changed by anything other than administrator action. All changes to MAC policy
#   should be audited.
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
