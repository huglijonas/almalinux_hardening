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
