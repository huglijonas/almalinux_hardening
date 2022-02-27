# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Core Dumps for All Users
#
# @description
#	  To disable core dumps for all users, add the following line to
#   /etc/security/limits.conf, or to a file within the /etc/security/limits.d/
#   directory:
#   *     hard   core    0
#
# @rationale
#   A core dump includes a memory image taken at the time the operating system
#   terminates an application. The memory image could contain sensitive data and
#   is generally useful only for developers trying to debug problems.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::core_dumps::users
class almalinux_hardening::system::files_perm_masks::core_dumps::users {
  if $almalinux_hardening::enable_coredumps_users {
    file_line { 'core_dumps_users':
      ensure => 'present',
      path   => '/etc/security/limits.conf',
      line   => '*                hard    core            0',
      match  => '^(#|).*(hard\s*core\s*)[0-9]*$',
    }
  }
}
