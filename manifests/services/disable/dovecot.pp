# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Dovecot Service
#
# @description
#   The dovecot service can be disabled with the following command:
#   $ sudo systemctl mask --now dovecot.service
#
# @rationale
#   Running an IMAP or POP3 server provides a network-based avenue of attack,
#   and should be disabled if not needed.
#
# @example
#   include almalinux_hardening::services::disable::dovecot
class almalinux_hardening::services::disable::dovecot {
  if $almalinux_hardening::enable_disable_dovecot {
    service { 'disable_dovecot':
      ensure => 'stopped',
      name   => 'dovecot.service',
      enable => 'mask',
    }
  }
}
