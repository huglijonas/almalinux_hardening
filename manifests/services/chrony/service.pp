# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure that chronyd is running under chrony user account
#
# @description
#   chrony is a daemon which implements the Network Time Protocol (NTP). It is
#   designed to synchronize system clocks across a variety of systems and use a
#   source that is highly accurate. More information on chrony can be found at
#   http://chrony.tuxfamily.org/. Chrony can be configured to be a client and/or
#   a server. To ensure that chronyd is running under chrony user account, Add or
#   edit the OPTIONS variable in /etc/sysconfig/chronyd to include -u chrony:
#   OPTIONS="-u chrony"
#   This recommendation only applies if chrony is in use on the system.
#
# @rationale
#   If chrony is in use on the system proper configuration is vital to ensuring
#   time synchronization is working properly.
#
# @example
#   include almalinux_hardening::services::chrony::service
class almalinux_hardening::services::chrony::service {
  if $almalinux_hardening::enable_chrony_service {
    file_line { 'chronyd_options':
      ensure => 'present',
      path   => '/etc/sysconfig/chronyd',
      line   => 'OPTIONS="-u chrony"',
      match  => '^(#|).*OPTIONS.*=.*',
    }
    ~> service { 'chronyd':
      ensure => running,
      enable => true,
    }
  }
}
