# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns shadow File
#
# @description - Group ownership
#   To properly set the group owner of /etc/shadow, run the command:
#   $ sudo chgrp root /etc/shadow
#
# @rationale - Group ownership
#   The /etc/shadow file stores password hashes. Protection of this file is critical
#   for system security.
#
# @summary - User ownership
#   Verify User Who Owns shadow File
#
# @description - User ownership
#   To properly set the owner of /etc/shadow, run the command:
#   $ sudo chown root /etc/shadow
#
# @rationale - User ownership
#   The /etc/shadow file contains the list of local system accounts and stores
#   password hashes. Protection of this file is critical for system security.
#   Failure to give ownership of this file to root provides the designated owner
#   with access to sensitive information which could weaken the system security
#   posture.
#
# @summary - Permissions
#   Verify Permissions on shadow File
#
# @description - Permissions
#   To properly set the permissions of /etc/shadow, run the command:
#   $ sudo chmod 0000 /etc/shadow
#
# @rationale - Permissions
#   The /etc/shadow file contains the list of local system accounts and stores
#   password hashes. Protection of this file is critical for system security.
#   Failure to give ownership of this file to root provides the designated owner
#   with access to sensitive information which could weaken the system security
#   posture.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::account_info::shadow
class almalinux_hardening::system::files_perm_masks::important::account_info::shadow {
  if $almalinux_hardening::enable_important_account_shadow {
    file { '/etc/shadow':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0000',
    }
  }
}
