# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify the System's Network Environment
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::auditd::rules::net_env
class almalinux_hardening::system::auditd::rules::net_env inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_net_env {
    $almalinux_hardening::auditd_rules_net_env_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "net_env_${auditd_program}_${action}_${arch}":
          ensure  => present,
          path    => $almalinux_hardening::auditd_rules_file,
          line    => "-a always,exit -F arch=b${arch} -S ${action} -F key=audit_rules_networkconfig_modification",
        } ~> Service['auditd']
      }
    }
    $almalinux_hardening::auditd_rules_net_env_paths.each | $path | {
      file_line { "net_env_${auditd_program}_${path}":
        ensure  => present,
        path    => $almalinux_hardening::auditd_rules_file,
        line    => "-w ${path} -p wa -k audit_rules_networkconfig_modification",
      } ~> Service['auditd']
    }
  }
}
