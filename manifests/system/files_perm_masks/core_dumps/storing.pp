# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable storing core dump
#
# @description
#   The Storage option in [Coredump] section of /etc/systemd/coredump.conf can
#   be set to none to disable storing core dumps permanently.
#
# @rationale
#   A core dump includes a memory image taken at the time the operating system
#   terminates an application. The memory image could contain sensitive data and
#   is generally useful only for developers or system operators trying to debug
#   problems. Enabling core dumps on production systems is not recommended, however
#   there may be overriding operational requirements to enable advanced debuging.
#   Permitting temporary enablement of core dumps during such situations should be
#   reviewed through local needs and policy.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::core_dumps::storing
class almalinux_hardening::system::files_perm_masks::core_dumps::storing {
  if $almalinux_hardening::enable_coredumps_storing {
    file_line { 'core_dumps_storing':
      ensure => 'present',
      path   => '/etc/systemd/coredump.conf',
      line   => 'Storage=none',
      match  => '^(#|).*Storage=.*$',
    }
  }
}
