# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable vsftpd Service
#
# @description
#	  The vsftpd service can be disabled with the following command:
#   $ sudo systemctl mask --now vsftpd.service
#
# @rationale
#   Running FTP server software provides a network-based avenue of attack, and
#   should be disabled if not needed. Furthermore, the FTP protocol is unencrypted
#   and creates a risk of compromising sensitive information.
#
# @example
#   include almalinux_hardening::services::disable::ftp
class almalinux_hardening::services::disable::ftp {
  if $almalinux_hardening::enable_disable_ftp {
    service { 'disable_ftp':
      ensure => 'stopped',
      name   => 'vsftpd.service',
      enable => 'mask',
    }
  }
}
