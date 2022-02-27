# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure No World-Writable Files Exist
#
# @description
#	  It is generally a good idea to remove global (other) write access to a file
#   when it is discovered. However, check with documentation for specific applications
#   before making changes. Also, monitor for recurring world-writable files, as these
#   may be symptoms of a misconfigured application or user account. Finally, this applies
#   to real files and not virtual files that are a part of pseudo file systems such as
#   sysfs or procfs.
#
# @rationale
#   Data in world-writable files can be modified by any user on the system. In almost all
#   circumstances, files can be configured using a combination of user and group permissions
#   to support whatever legitimate access is needed without the risk caused by world-writable
#   files.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::no_world_writable_files
class almalinux_hardening::system::files_perm_masks::important::no_world_writable_files {
  if $almalinux_hardening::enable_important_worldwritable_files {
    exec { 'no_world_writable_files':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | xargs chmod o-w",
      unless  => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -type f -perm -0002 | wc -l | grep -q -E '^0\$'",
    }
  }
}
