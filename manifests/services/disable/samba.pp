# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Samba
#
# @description
#	  The smb service can be disabled with the following command:
#   $ sudo systemctl mask --now smb.service
#
# @rationale
#	  Running a Samba server provides a network-based avenue of attack, and should
#   be disabled if not needed.
#
# @example
#   include almalinux_hardening::services::disable::samba
class almalinux_hardening::services::disable::samba {
  if $almalinux_hardening::enable_disable_samba {
    service { 'disable_samba':
      ensure => 'stopped',
      name   => 'smb.service',
      enable => 'mask',
    }
  }
}
