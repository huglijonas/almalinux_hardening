# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable cron Service
#
# @description
#   The crond service is used to execute commands at preconfigured times. It is
#   required by almost all systems to perform necessary maintenance tasks, such
#   as notifying root of system activity. The crond service can be enabled with
#   the following command:
#   $ sudo systemctl enable crond.service
#
# @rationale
#   Due to its usage for maintenance and security-supporting tasks, enabling the
#   cron daemon is essential.
#
# @example
#   include almalinux_hardening::services::cron_at_daemons::service
class almalinux_hardening::services::cron_at_daemons::service {
  if $almalinux_hardening::enable_cron_service {
    service { 'crond':
      ensure => running,
      enable => true,
    }
  }
}
