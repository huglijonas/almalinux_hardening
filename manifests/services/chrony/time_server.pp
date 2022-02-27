# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   A remote time server for Chrony is configured
#
# @description
#   Chrony is a daemon which implements the Network Time Protocol (NTP). It is
#   designed to synchronize system clocks across a variety of systems and use a
#   source that is highly accurate. More information on chrony can be found at
#   http://chrony.tuxfamily.org/. Chrony can be configured to be a client and/or
#   a server. Add or edit server or pool lines to /etc/chrony.conf as appropriate:
#   server <remote-server>
#   Multiple servers may be configured.
#
# @rationale
#   If chrony is in use on the system proper configuration is vital to ensuring
#   time synchronization is working properly.
#
# @example
#   include almalinux_hardening::services::chrony::time_server
class almalinux_hardening::services::chrony::time_server {
  if $almalinux_hardening::enable_chrony_time_server {
    $almalinux_hardening::time_servers.each | $time_server | {
      file_line { '':
        ensure                                => 'present',
        path                                  => '/etc/chrony.conf',
        line                                  => "server ${time_server}",
        match                                 => '^(#|)server\s.*$',
        replace_all_matches_not_matching_line => true,
      }
      ~> service { 'chronyd':
        ensure => running,
        enable => true,
      }
    }
  }
}
