# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns Crontab
#
# @description - Group ownership
#   To properly set the group owner of /etc/crontab, run the command:
#   $ sudo chgrp root /etc/crontab
#
# @summary - User ownership
#   Verify Owner on Crontab
#
# @description - User ownership
#   To properly set the owner of /etc/crontab, run the command:
#   $ sudo chown root /etc/crontab
#
# @summary - Permissions
#   Verify Permissions on Crontab
#
# @description - Permissions
#   To properly set the permissions of /etc/crontab, run the command:
#   $ sudo chmod 0600 /etc/crontab
#
# @rationale
#	  Service configuration files enable or disable features of their respective
#   services that if configured incorrectly can lead to insecure and vulnerable
#   configurations. Therefore, service configuration files should have the correct
#   access rights to prevent unauthorized changes.
#
# @example
#   include almalinux_hardening::services::cron_at_daemons::crontab
class almalinux_hardening::services::cron_at_daemons::crontab {
  if $almalinux_hardening::enable_cron_crontab {
    file { '/etc/crontab':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0600'
    }
  }
}
