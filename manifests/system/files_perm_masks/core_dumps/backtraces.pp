# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable core dump backtraces
#
# @description
#   The ProcessSizeMax option in [Coredump] section of /etc/systemd/coredump.conf
#   specifies the maximum size in bytes of a core which will be processed. Core
#   dumps exceeding this size may be stored, but the backtrace will not be
#   generated.
#
# @rationale
#	  A core dump includes a memory image taken at the time the operating system
#   terminates an application. The memory image could contain sensitive data and
#   is generally useful only for developers or system operators trying to debug
#   problems. Enabling core dumps on production systems is not recommended, however
#   there may be overriding operational requirements to enable advanced debuging.
#   Permitting temporary enablement of core dumps during such situations should be
#   reviewed through local needs and policy.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::core_dumps::backtraces
class almalinux_hardening::system::files_perm_masks::core_dumps::backtraces {
  if $almalinux_hardening::enable_coredumps_backtraces {
    file_line { 'core_dumps_backtraces':
      ensure => 'present',
      path   => '/etc/systemd/coredump.conf',
      line   => 'ProcessSizeMax=0',
      match  => '^(#|).*ProcessSizeMax=.*$',
    }
  }
}
