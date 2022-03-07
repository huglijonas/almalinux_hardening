# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Auditing for Processes Which Start Prior to the Audit Daemon
#
# @description
#	  To ensure all processes can be audited, even those which start prior to the
#   audit daemon, add the argument audit=1 to the default GRUB 2 command line
#   for the Linux operating system in /boot/grub2/grubenv, in the manner below:
#   grub2-editenv - set "$(grub2-editenv - list | grep kernelopts) audit=1"
#
# @rationale
#	  Each process on the system carries an "auditable" flag which indicates whether
#   its activities can be audited. Although auditd takes care of enabling this for
#   all processes which launch after it does, adding the kernel argument ensures
#   it is set for every process during boot.
#
# @example
#   include almalinux_hardening::system::auditd::priority
class almalinux_hardening::system::auditd::priority {
  if $almalinux_hardening::enable_auditd_priority {
    kernel_parameter { 'audit=1':
      ensure => present,
    }
  }
}
