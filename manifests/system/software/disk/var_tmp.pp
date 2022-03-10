# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure /var/tmp Located On Separate Partition
#
# @description
#   The /var/tmp directory is a world-writable directory used for temporary file
#   storage. Ensure it has its own partition or logical volume at installation
#   time, or migrate it using LVM.
#
# @rationale
#   The /var/tmp partition is used as temporary storage by many programs. Placing
#   /var/tmp in its own partition enables the setting of more restrictive mount
#   options, which can help protect programs which use it.
#
# @example
#   include almalinux_hardening::system::software::disk::var_tmp
class almalinux_hardening::system::software::disk::var_tmp {
  if $almalinux_hardening::enable_disk_vartmp {
    if ! $facts['mountpoints']['/var/tmp'] {
      notify { 'vartmp_separate_notify_type1':
        message  => '/var/tmp is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/var/tmp'] and $facts['mountpoints']['/var/tmp']['device'] !~ /^\/dev\/mapper\/.*var.*tmp.*$/  {
      notify { 'vartmp_separate_notify_type2':
        message  => '/var/tmp seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
