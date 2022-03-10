# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure /var/log/audit Located On Separate Partition
#
# @description
#	  Audit logs are stored in the /var/log/audit directory. Ensure that it has
#   its own partition or logical volume at installation time, or migrate it later
#   using LVM. Make absolutely certain that it is large enough to store all audit
#   logs that will be created by the auditing daemon.
#
# @rationale
#   Placing /var/log/audit in its own partition enables better separation between
#   audit files and other files, and helps ensure that auditing cannot be halted
#   due to the partition running out of space.
#
# @example
#   include almalinux_hardening::system::software::disk::var_log_audit
class almalinux_hardening::system::software::disk::var_log_audit {
  if $almalinux_hardening::enable_disk_varlogaudit {
    if ! $facts['mountpoints']['/var/log/audit'] {
      notify { 'varlogaudit_separate_notify_type1':
        message  => '/var/log/audit is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/var/log/audit'] and $facts['mountpoints']['/var/log/audit']['device'] !~ /^\/dev\/mapper\/.*var.*log.*audit.*$/  {
      notify { 'varlogaudit_separate_notify_type2':
        message  => '/var/log/audit seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
