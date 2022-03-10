# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#
#
# @description
#
#
# @rationale
#
#
# @example
#   include almalinux_hardening::system::selinux::unconfined
class almalinux_hardening::system::selinux::unconfined {
  if $almalinux_hardening::enable_selinux_unconfined {
    if $daemons_unconfined != 'None' {
      $daemons_unconfined.each | $daemon_unconfined | {
        notify { "daemon_unconfined - ${daemon_unconfined}":
          message  => "There is a unconfined daemon: ${daemon_unconfined}! Please fix if quickly!",
          loglevel => 'warning',
        }
      }
    }
  }
}
