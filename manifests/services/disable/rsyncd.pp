# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure rsyncd service is diabled
#
# @description
#   The rsyncd service can be disabled with the following command:
#   $ sudo systemctl mask --now rsyncd.service
#
# @rationale
#	  The rsyncd service presents a security risk as it uses unencrypted protocols
#   for communication.
#
# @example
#   include almalinux_hardening::services::disable::rsyncd
class almalinux_hardening::services::disable::rsyncd {
  if $almalinux_hardening::enable_disable_rsyncd {
    service { 'disable_rsyncd':
      ensure => 'stopped',
      name   => 'rsyncd.service',
      enable => 'mask',
    }
  }
}
