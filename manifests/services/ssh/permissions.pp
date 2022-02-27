# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns SSH Server config file
#
# @description - Group ownership
#	  To properly set the group owner of /etc/ssh/sshd_config, run the command:
#   $ sudo chgrp root /etc/ssh/sshd_config
#
# @summary - User ownership
#   Verify Owner on SSH Server config file
#
# @description - User ownership
#   To properly set the owner of /etc/ssh/sshd_config, run the command:
#   $ sudo chown root /etc/ssh/sshd_config
#
# @summary - Permissions
#   Verify Permissions on SSH Server config file
#
# @description - Permissions
#	  To properly set the permissions of /etc/ssh/sshd_config, run the command:
#   $ sudo chmod 0600 /etc/ssh/sshd_config
#
# @rationale
#   Service configuration files enable or disable features of their respective
#   services that if configured incorrectly can lead to insecure and vulnerable
#   configurations. Therefore, service configuration files should be owned by the
#   correct group to prevent unauthorized changes.
#
# @example
#   include almalinux_hardening::services::ssh::permissions
class almalinux_hardening::services::ssh::permissions {
  if $almalinux_hardening::enable_ssh_permissions {
    file { '/etc/ssh/sshd_config':
      ensure  => file,
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0600'
    }
  }
}
