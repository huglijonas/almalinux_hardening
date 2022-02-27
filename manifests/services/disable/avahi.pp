# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Avahi Server Software
#
# @description
#   The avahi-daemon service can be disabled with the following command:
#   $ sudo systemctl mask --now avahi-daemon.service
#
# @rationale
#   Because the Avahi daemon service keeps an open network port, it is subject
#   to network attacks. Its functionality is convenient but is only appropriate
#   if the local network can be trusted.
#
# @example
#   include almalinux_hardening::services::disable::avahi
class almalinux_hardening::services::disable::avahi {
  if $almalinux_hardening::enable_disable_avahi {
    service { 'disable_avahi':
      ensure => 'stopped',
      name   => 'avahi-daemon.service',
      enable => 'mask',
    }
  }
}
