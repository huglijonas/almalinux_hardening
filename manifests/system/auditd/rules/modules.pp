# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure auditd Collects Information on Kernel Module Unloading
#
# @description
#   To capture kernel module unloading events, use following line, setting ARCH
#   to either b32 for 32-bit system, or having two lines for both b32 and b64 in
#   case your system is 64-bit:
#   -a always,exit -F arch=ARCH -S <action> -F key=modules
#   Place to add the line depends on a way auditd daemon is configured. If it is
#   configured to use the augenrules program (the default), add the line to a file
#   with suffix .rules in the directory /etc/audit/rules.d. If the auditd daemon
#   is configured to use the auditctl utility, add the line to file
#   /etc/audit/audit.rules.
#
# @rationale
#   The removal of kernel modules can be used to alter the behavior of the kernel
#   and potentially introduce malicious code into kernel space. It is important
#   to have an audit trail of modules that have been introduced into the kernel.
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
