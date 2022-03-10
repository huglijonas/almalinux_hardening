# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects Information on Exporting to Media
#
# @description
#   At a minimum, the audit system should collect media exportation events for
#   all users and root. If the auditd daemon is configured to use the augenrules
#   program to read audit rules during daemon startup (the default), add the
#   following line to a file with suffix .rules in the directory /etc/audit/rules.d,
#   setting ARCH to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S mount -F auid>=1000 -F auid!=unset -F key=export
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file, setting ARCH to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S mount -F auid>=1000 -F auid!=unset -F key=export
#
# @rationale
#   The unauthorized exportation of data to external media could result in an
#   information leak where classified information, Privacy Act information, and
#   intellectual property could be lost. An audit trail should be created each
#   time a filesystem is mounted to help identify and guard against information
#   loss.
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
