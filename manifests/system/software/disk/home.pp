# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#
#
# @description
#
#
# @rationale
#
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
