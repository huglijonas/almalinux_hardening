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
