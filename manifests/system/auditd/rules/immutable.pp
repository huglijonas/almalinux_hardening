# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Make the auditd Configuration Immutable
#
# @description
#   If the auditd daemon is configured to use the augenrules program to read
#   audit rules during daemon startup (the default), add the following line to a
#   file with suffix .rules in the directory /etc/audit/rules.d in order to make
#   the auditd configuration immutable:
#   -e 2
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file in order to make the auditd configuration immutable:
#   -e 2
#   With this setting, a reboot will be required to change any audit rules.
#
# @rationale
#	  Making the audit configuration immutable prevents accidental as well as
#   malicious modification of the audit rules, although it may be problematic if
#   legitimate changes are needed during system operation
#
# @example
#   include almalinux_hardening::system::auditd::rules::immutable
class almalinux_hardening::system::auditd::rules::immutable inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_immutable {
    file_line { 'auditd_immutable':
      ensure  => present,
      path    => $almalinux_hardening::auditd_rules_file,
      line    => '-e 2',
    } ~> Service['auditd']
  }
}
