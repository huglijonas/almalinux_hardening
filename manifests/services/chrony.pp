# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - Install
#   Install Chrony
#
# @description - Install
#   The chrony package can be installed with the following command:
#   $ sudo yum install chrony
#
# @rationale - Install
#   The chrony package must be installed for the Network Time Protocol checks.
#
#
# @summary - Chronyd
#   Ensure that chronyd is running under chrony user account
#
# @description - Chronyd
#   chrony is a daemon which implements the Network Time Protocol (NTP). It is
#   designed to synchronize system clocks across a variety of systems and use a
#   source that is highly accurate. More information on chrony can be found at
#   http://chrony.tuxfamily.org/. Chrony can be configured to be a client and/or
#   a server. To ensure that chronyd is running under chrony user account, Add or
#   edit the OPTIONS variable in /etc/sysconfig/chronyd to include -u chrony:
#   OPTIONS="-u chrony"
#   This recommendation only applies if chrony is in use on the system.
#
# @rationale - Chronyd
#   If chrony is in use on the system proper configuration is vital to ensuring
#   time synchronization is working properly.
#
#
# @summary - Remote Time Server
#   A remote time server for Chrony is configured
#
# @description - Remote Time Server
#   Chrony is a daemon which implements the Network Time Protocol (NTP). It is
#   designed to synchronize system clocks across a variety of systems and use a
#   source that is highly accurate. More information on chrony can be found at
#   http://chrony.tuxfamily.org/. Chrony can be configured to be a client and/or
#   a server. Add or edit server or pool lines to /etc/chrony.conf as appropriate:
#   server <remote-server>
#   Multiple servers may be configured.
#
# @rationale - Remote Time Server
#   If chrony is in use on the system proper configuration is vital to ensuring
#   time synchronization is working properly.
#
# @example
#   include almalinux_hardening::services::chrony
class almalinux_hardening::services::chrony {
  if $almalinux_hardening::enable_chrony_install {
    if $almalinux_hardening::enable_chrony_time_server {
      class { 'chrony':
        servers => $almalinux_hardening::time_servers,
      }
    }
    if $almalinux_hardening::enable_chrony_service {
      exec { 'reload_chrony':
        path        => '/usr/bin',
        command     => 'systemctl restart chronyd',
        refreshonly => true,
      }
      file_line { 'chronyd_options':
        ensure => 'present',
        path   => '/etc/sysconfig/chronyd',
        line   => 'OPTIONS="-u chrony"',
        match  => '^(#|).*OPTIONS.*=.*',
        notify => Exec['reload_chrony'],
      }
    }
  }
}
