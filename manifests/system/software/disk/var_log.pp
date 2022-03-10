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
#   include almalinux_hardening::system::software::disk::var_log
class almalinux_hardening::system::software::disk::var_log {
  if $almalinux_hardening::enable_disk_varlog {
    if ! $facts['mountpoints']['/var/log'] {
      notify { 'varlog_separate_notify_type1':
        message  => '/var/log is not on a separate partition LV!',
        loglevel => 'warning',
      }
    }
    elsif $facts['mountpoints']['/var/log'] and $facts['mountpoints']['/var/log']['device'] !~ /^\/dev\/mapper\/.*var.*log.*$/  {
      notify { 'varlog_separate_notify_type2':
        message  => '/var/log seems to not be on a separate partition or LV!',
        loglevel => 'warning',
      }
    }
  }
}
