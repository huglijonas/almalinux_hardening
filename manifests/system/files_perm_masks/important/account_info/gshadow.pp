# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns gshadow File
#
# @description - Group ownership
#	  To properly set the group owner of /etc/gshadow, run the command:
#   $ sudo chgrp root /etc/gshadow
#
# @rationale - Group ownership
#	  The /etc/gshadow file contains group password hashes. Protection of this file
#   is critical for system security.
#
# @summary - User ownership
#   Verify User Who Owns gshadow File
#
# @description - User ownership
#   To properly set the owner of /etc/gshadow, run the command:
#   $ sudo chown root /etc/gshadow
#
# @rationale - User ownership
#   The /etc/gshadow file contains group password hashes. Protection of this file
#   is critical for system security.
#
# @summary - Permissions
#   Verify Permissions on gshadow File
#
# @description - Permissions
#   To properly set the permissions of /etc/gshadow, run the command:
#   $ sudo chmod 0000 /etc/gshadow
#
# @rationale - Permissions
#	  The /etc/gshadow file contains group password hashes. Protection of this file
#   is critical for system security.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::account_info::gshadow
class almalinux_hardening::system::files_perm_masks::important::account_info::gshadow {
  if $almalinux_hardening::enable_important_account_gshadow {
    file { '/etc/gshadow':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0000',
    }
  }
}
