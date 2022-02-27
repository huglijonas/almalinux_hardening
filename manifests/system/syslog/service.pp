# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable rsyslog Service
#
# @description
#	  The rsyslog service provides syslog-style logging by default on AlmaLinux 8.
#   The rsyslog service can be enabled with the following command:
#   $ sudo systemctl enable rsyslog.service
#
# @rationale
#	  The rsyslog service must be running in order to provide logging services,
#   which are essential to system administration.
#
# @example
#   include almalinux_hardening::system::syslog::service
class almalinux_hardening::system::syslog::service {
  if $almalinux_hardening::enable_syslog_service {
    service { 'syslog_service':
      ensure => running,
      name   => 'rsyslog.service',
      enable => true,
    }
  }
}
