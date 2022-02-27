# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Remove telnet Clients
#
# @description
#	  The telnet client allows users to start connections to other systems via the
#   telnet protocol.
#
# @rationale
#   The telnet protocol is insecure and unencrypted. The use of an unencrypted
#   transmission medium could allow an unauthorized user to steal credentials.
#   The ssh package provides an encrypted session and stronger security and is
#   included in AlmaLinux 8.
#
# @example
#   include almalinux_hardening::services::uninstall::telnet_client
class almalinux_hardening::services::uninstall::telnet_client {
  if $almalinux_hardening::enable_uninstall_telnet_client {
    package { 'telnet':
      ensure          => purged,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
