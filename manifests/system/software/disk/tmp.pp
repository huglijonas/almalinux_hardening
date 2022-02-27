# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure /tmp is Located On Separate Partition
#
# @description
#   The /tmp directory is a world-writable directory used for temporary file storage.
#   Ensure it has its own partition or logical volume at installation time, or migrate
#   it using LVM.
#
# @rationale
#   The /tmp partition is used as temporary storage by many programs. Placing /tmp in
#   its own partition enables the setting of more restrictive mount options, which can
#   help protect programs which use it.
#
# @example
#   include almalinux_hardening::system::software::disk::tmp
class almalinux_hardening::system::software::disk::tmp {
  if $almalinux_hardening::enable_disk_tmp {
    if ! $facts['mountpoints']['/tmp'] {
      notify { 'tmp_separate_notify_type1':
        message  => '/tmp is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/tmp'] and $facts['mountpoints']['/tmp']['device'] !~ /^\/dev\/mapper\/.*tmp.*$/  {
      notify { 'tmp_separate_notify_type2':
        message  => '/tmp seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
