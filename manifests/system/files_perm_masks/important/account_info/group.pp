# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns group File
#
# @description - Group ownership
#   To properly set the group owner of /etc/group, run the command:
#   $ sudo chgrp root /etc/group
#
# @rationale - Group ownership
#   The /etc/group file contains information regarding groups that are configured
#   on the system. Protection of this file is important for system security.
#
# @summary - User ownership
#   Verify User Who Owns group File
#
# @description - User ownership
#   To properly set the owner of /etc/group, run the command:
#   $ sudo chown root /etc/group
#
# @rationale - User ownership
#   The /etc/group file contains information regarding groups that are configured
#   on the system. Protection of this file is important for system security.
#
# @summary - Permissions
#   Verify Permissions on group File
#
# @description - Permissions
#   To properly set the permissions of /etc/passwd, run the command:
#   $ sudo chmod 0644 /etc/passwd
#
# @rationale - Permissions
#   The /etc/group file contains information regarding groups that are configured
#   on the system. Protection of this file is important for system security.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::account_info::group
class almalinux_hardening::system::files_perm_masks::important::account_info::group {
  if $almalinux_hardening::enable_important_account_group {
    file { '/etc/group':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}
