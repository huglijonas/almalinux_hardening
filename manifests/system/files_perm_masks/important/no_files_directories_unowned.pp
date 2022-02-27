# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure All Files Are Owned by a Group
#   Ensure All Files Are Owned by a User
#
# @description - Group
#	  If any files are not owned by a group, then the cause of their lack of
#   group-ownership should be investigated. Following this, the files should be
#   deleted or assigned to an appropriate group. The following command will discover
#   and print any files on local partitions which do not belong to a valid group:
#   $ df --local -P | awk '{if (NR!=1) print $6}' | sudo xargs -I '{}' find '{}' -xdev -nogroup
#   To search all filesystems on a system including network mounted filesystems the
#   following command can be run manually for each partition:
#   $ sudo find PARTITION -xdev -nogroup
#
# @description - User
#   If any files are not owned by a user, then the cause of their lack of ownership
#   should be investigated. Following this, the files should be deleted or assigned
#   to an appropriate user. The following command will discover and print any files on
#   local partitions which do not belong to a valid user:
#   $ df --local -P | awk {'if (NR!=1) print $6'} | sudo xargs -I '{}' find '{}' -xdev -nouser
#   To search all filesystems on a system including network mounted filesystems the
#   following command can be run manually for each partition:
#   $ sudo find PARTITION -xdev -nouser
#
# @rationale
#	  Unowned files do not directly imply a security problem, but they are generally a
#   sign that something is amiss. They may be caused by an intruder, by incorrect
#   software installation or draft software removal, or by failure to remove all files
#   belonging to a deleted account. The files should be repaired so they will not cause
#   problems when accounts are created in the future, and the cause should be discovered
#   and addressed.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::no_files_directories_unowned
class almalinux_hardening::system::files_perm_masks::important::no_files_directories_unowned {
  if $almalinux_hardening::enable_important_files_directories_unowned {
    exec { 'no_unowned_dirfile':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -nouser | xargs chown root",
      unless  => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -nouser | wc -l | grep -q -E '^0\$'",
    }
    exec { 'no_ungrouped_dirfile':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -nouser | xargs chown :root",
      unless  => "df --local -P | awk {'if (NR!=1) print \$6'} | xargs -I '{}' find '{}' -xdev -nogroup | wc -l | grep -q -E '^0\$'",
    }
  }
}
