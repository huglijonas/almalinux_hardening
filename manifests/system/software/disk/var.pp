# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure /var Located On Separate Partition
#
# @description
#   The /var directory is used by daemons and other system services to store
#   frequently-changing data. Ensure that /var has its own partition or logical
#   volume at installation time, or migrate it using LVM.
#
# @rationale
#   Ensuring that /var is mounted on its own partition enables the setting of
#   more restrictive mount options. This helps protect system services such as
#   daemons or other programs which use it. It is not uncommon for the /var
#   directory to contain world-writable directories installed by other software
#   packages.
#
# @example
#   include almalinux_hardening::system::software::disk::var
class almalinux_hardening::system::software::disk::var {
  if $almalinux_hardening::enable_disk_var {
    if ! $facts['mountpoints']['/var'] {
      notify { 'var_separate_notify_type1':
        message  => '/var is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/var'] and $facts['mountpoints']['/var']['device'] !~ /^\/dev\/mapper\/.*var.*$/  {
      notify { 'var_separate_notify_type2':
        message  => '/var seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
