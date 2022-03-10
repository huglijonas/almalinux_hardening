# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure /home Located On Separate Partition
#
# @description
#	  If user home directories will be stored locally, create a separate partition
#   for /home at installation time (or migrate it later using LVM). If /home will
#   be mounted from another system such as an NFS server, then creating a separate
#   partition is not necessary at installation time, and the mountpoint can instead
#   be configured later.
#
# @rationale
#   Ensuring that /home is mounted on its own partition enables the setting of more
#   restrictive mount options, and also helps ensure that users cannot trivially fill
#   partitions used for log or audit data storage.
#
# @example
#   include almalinux_hardening::system::software::disk::home
class almalinux_hardening::system::software::disk::home {
  if $almalinux_hardening::enable_disk_home {
    if ! $facts['mountpoints']['/home'] {
      notify { 'home_separate_notify_type1':
        message  => '/home is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/home'] and $facts['mountpoints']['/home']['device'] !~ /^\/dev\/mapper\/.*home.*$/  {
      notify { 'home_separate_notify_type2':
        message  => '/home seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
