# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure the audit Subsystem is Installed
#
# @description
#   The audit package should be installed.
#
# @rationale
#   The auditd service is an access monitoring and accounting daemon, watching
#   system calls to audit any access, in comparison with potential local access
#   control policy such as SELinux policy.
#
# @example
#   include almalinux_hardening::system::auditd::install
class almalinux_hardening::system::auditd::install {
  if $almalinux_hardening::enable_auditd_install {
    package { 'audit':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
