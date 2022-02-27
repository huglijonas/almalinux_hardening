# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable httpd Service
#
# @description
#   The httpd service can be disabled with the following command:
#   $ sudo systemctl mask --now httpd.service
#
# @rationale
#   Running web server software provides a network-based avenue of attack, and
#   should be disabled if not needed.
#
# @example
#   include almalinux_hardening::services::disable::web
class almalinux_hardening::services::disable::web {
  if $almalinux_hardening::enable_disable_web {
    service { 'disable_web':
      ensure => 'stopped',
      name   => 'httpd.service',
      enable => 'mask',
    }
  }
}
