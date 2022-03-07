# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Make the auditd Configuration Immutable
#
# @description
#
#
# @rationale
#
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
