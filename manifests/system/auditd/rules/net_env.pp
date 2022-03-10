# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Record Events that Modify the System's Network Environment
#
# @description
#   If the auditd daemon is configured to use the augenrules program to read
#   audit rules during daemon startup (the default), add the following lines to
#   a file with suffix .rules in the directory /etc/audit/rules.d, setting ARCH
#   to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S sethostname,setdomainname -F key=audit_rules_networkconfig_modification
#   -w /etc/issue -p wa -k audit_rules_networkconfig_modification
#   -w /etc/issue.net -p wa -k audit_rules_networkconfig_modification
#   -w /etc/hosts -p wa -k audit_rules_networkconfig_modification
#   -w /etc/sysconfig/network -p wa -k audit_rules_networkconfig_modification
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following lines to /etc/audit/audit.rules
#   file, setting ARCH to either b32 or b64 as appropriate for your system:
#   -a always,exit -F arch=ARCH -S sethostname,setdomainname -F key=audit_rules_networkconfig_modification
#   -w /etc/issue -p wa -k audit_rules_networkconfig_modification
#   -w /etc/issue.net -p wa -k audit_rules_networkconfig_modification
#   -w /etc/hosts -p wa -k audit_rules_networkconfig_modification
#   -w /etc/sysconfig/network -p wa -k audit_rules_networkconfig_modification
#
# @rationale
#	  The network environment should not be modified by anything other than
#   administrator action. Any change to network parameters should be audited.
#
# @example
#   include almalinux_hardening::system::auditd::rules::net_env
class almalinux_hardening::system::auditd::rules::net_env inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_net_env {
    $almalinux_hardening::auditd_rules_net_env_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "net_env_${auditd_program}_${action}_${arch}":
          ensure => present,
          path   => $almalinux_hardening::auditd_rules_file,
          line   => "-a always,exit -F arch=b${arch} -S ${action} -F key=audit_rules_networkconfig_modification",
        } ~> Service['auditd']
      }
    }
    $almalinux_hardening::auditd_rules_net_env_paths.each | $path | {
      file_line { "net_env_${auditd_program}_${path}":
        ensure => present,
        path   => $almalinux_hardening::auditd_rules_file,
        line   => "-w ${path} -p wa -k audit_rules_networkconfig_modification",
      } ~> Service['auditd']
    }
  }
}
