# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure No Daemons are Unconfined by SELinux
#
# @description
#   Daemons for which the SELinux policy does not contain rules will inherit the
#   context of the parent process. Because daemons are launched during startup
#   and descend from the init process, they inherit the unconfined_service_t
#   context.
#   To check for unconfined daemons, run the following command:
#   $ sudo ps -eZ | grep "unconfined_service_t"
#   It should produce no output in a well-configured system.
#
# @rationale
#   Daemons which run with the unconfined_service_t context may cause AVC denials,
#   or allow privileges that the daemon does not require.
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
