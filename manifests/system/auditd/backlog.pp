# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Extend Audit Backlog Limit for the Audit Daemon
#
# @description
#	  To improve the kernel capacity to queue all log events, even those which
#   occurred prior to the audit daemon, add the argument audit_backlog_limit=8192
#   to the default GRUB 2 command line for the Linux operating system in /etc/default/grub,
#   in the manner below:
#   GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=VolGroup/LogVol06 rd.lvm.lv=VolGroup/lv_swap
#   rhgb quiet rd.shell=0 audit=1 audit_backlog_limit=8192"
#
# @rationale
#   audit_backlog_limit sets the queue length for audit events awaiting transfer
#   to the audit daemon. Until the audit daemon is up and running, all log messages
#   are stored in this queue. If the queue is overrun during boot process, the action
#   defined by audit failure flag is taken.
#
# @example
#   include almalinux_hardening::system::auditd::backlog
class almalinux_hardening::system::auditd::backlog {
  if $almalinux_hardening::enable_auditd_backlog {
    kernel_parameter { "audit_backlog_limit=${almalinux_hardening::auditd_backlog}":
      ensure   => present,
      bootmode => 'default',
    }
  }
}
