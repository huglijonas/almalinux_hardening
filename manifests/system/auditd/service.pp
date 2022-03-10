# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable auditd Service
#
# @description
#   The auditd service is an essential userspace component of the Linux Auditing
#   System, as it is responsible for writing audit records to disk. The auditd
#   service can be enabled with the following command:
#   $ sudo systemctl enable auditd.service
#
# @rationale
#   Without establishing what type of events occurred, it would be difficult to
#   establish, correlate, and investigate the events leading up to an outage or
#   attack. Ensuring the auditd service is active ensures audit records generated
#   by the kernel are appropriately recorded.
#   Additionally, a properly configured audit subsystem ensures that actions of
#   individual system users can be uniquely traced to those users so they can be
#   held accountable for their actions.
#
# @example
#   include almalinux_hardening::system::auditd::service
class almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_service {
    service { 'auditd':
      ensure => running,
      enable => true,
    }
  }
}
