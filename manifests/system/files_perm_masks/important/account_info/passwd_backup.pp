# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns Backup passwd File
#
# @description - Group ownership
#	  To properly set the group owner of /etc/passwd-, run the command:
#   $ sudo chgrp root /etc/passwd-
#
# @rationale - Group ownership
#	  The /etc/passwd- file is a backup file of /etc/passwd, and as such, it contains
#   information about the users that are configured on the system. Protection of this
#   file is critical for system security.
#
# @summary - User ownership
#   Verify User Who Owns Backup passwd File
#
# @description - User ownership
#   To properly set the owner of /etc/passwd-, run the command:
#   $ sudo chown root /etc/passwd-
#
# @rationale - User ownership
#   The /etc/passwd- file is a backup file of /etc/passwd, and as such, it contains
#   information about the users that are configured on the system. Protection of this
#   file is critical for system security.
#
# @summary - Permissions
#   Verify Permissions on Backup passwd File
#
# @description - Permissions
#   To properly set the permissions of /etc/passwd-, run the command:
#   $ sudo chmod 0644 /etc/passwd-
#
# @rationale - Permissions
#   The /etc/passwd- file is a backup file of /etc/passwd, and as such, it contains
#   information about the users that are configured on the system. Protection of this
#   file is critical for system security.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::account_info::passwd_backup
class almalinux_hardening::system::files_perm_masks::important::account_info::passwd_backup {
  if $almalinux_hardening::enable_important_account_passwd_backup {
    file { '/etc/passwd-':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}
