# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Group ownership
#   Verify Group Who Owns cron.daily
#
# @description - Group ownership
#   To properly set the group owner of /etc/cron.daily, run the command:
#   $ sudo chgrp root /etc/cron.daily
#
# @summary - User ownership
#   Verify Owner on cron.daily
#
# @description - User ownership
#   To properly set the owner of /etc/cron.daily, run the command:
#   $ sudo chown root /etc/cron.daily
#
# @summary - Permissions
#   Verify Permissions on cron.daily
#
# @description - Permissions
#	  To properly set the permissions of /etc/cron.daily, run the command:
#   $ sudo chmod 0700 /etc/cron.daily
#
# @rationale
#   Service configuration files enable or disable features of their respective
#   services that if configured incorrectly can lead to insecure and vulnerable
#   configurations. Therefore, service configuration files should have the correct
#   access rights to prevent unauthorized changes.
#
# @example
#   include almalinux_hardening::services::cron_at_daemons::cron_daily
class almalinux_hardening::services::cron_at_daemons::cron_daily {
  if $almalinux_hardening::enable_cron_daily {
    file { '/etc/cron.daily':
      recurse => false,
      owner   => 'root',
      group   => 'root',
      mode    => '0700'
    }
  }
}
