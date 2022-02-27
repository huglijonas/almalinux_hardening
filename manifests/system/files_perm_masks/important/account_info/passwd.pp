# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns passwd File
#
# @description - Group ownership
#   To properly set the group owner of /etc/passwd, run the command:
#   $ sudo chgrp root /etc/passwd
#
# @rationale - Group ownership
#   The /etc/passwd file contains information about the users that are configured
#   on the system. Protection of this file is critical for system security.
#
# @summary - User ownership
#   Verify User Who Owns passwd File
#
# @description - User ownership
#   To properly set the owner of /etc/passwd, run the command:
#   $ sudo chown root /etc/passwd
#
# @rationale - User ownership
#	  The /etc/passwd file contains information about the users that are configured
#   on the system. Protection of this file is critical for system security.
#
# @summary - Permissions
#   Verify Permissions on passwd File
#
# @description - Permissions
#   To properly set the permissions of /etc/passwd, run the command:
#   $ sudo chmod 0644 /etc/passwd
#
# @rationale - Permissions
#	  If the /etc/passwd file is writable by a group-owner or the world the risk of
#   its compromise is increased. The file contains the list of accounts on the system
#   and associated information, and protection of this file is critical for system
#   security.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::account_info::passwd
class almalinux_hardening::system::files_perm_masks::important::account_info::passwd {
  if $almalinux_hardening::enable_important_account_passwd {
    file { '/etc/passwd':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
    }
  }
}
