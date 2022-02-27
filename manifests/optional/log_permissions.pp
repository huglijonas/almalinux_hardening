# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure permissions on all logfiles are configured
#
# @description
#   Log files stored in /var/log/ contain logged information from many services
#   on the system, or on log hosts others as well.
#
# @rationale
#   It is important to ensure that log files have the correct permissions to ensure
#   that sensitive data is archived and protected.
#
# @example
#   include almalinux_hardening::optional::log_permissions
class almalinux_hardening::optional::log_permissions {
  if $almalinux_hardening::enable_optional_log_permissions {
    exec { 'log_permissions':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'find /var/log -type f -exec chmod g-wx,o-rwx "{}" + -o -type d -exec chmod g- w,o-rwx "{}" +',
      unless  => 'find /var/log -type f -perm /037 -ls -o -type d -perm /026 | wc -l | grep -q -E "^0$"',
    }
  }
}
