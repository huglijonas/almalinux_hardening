# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Postfix Network Listening
#
# @description
#   Edit the file /etc/postfix/main.cf to ensure that only the following
#   inet_interfaces line appears:
#   inet_interfaces = loopback-only
#
# @rationale
#	  This ensures postfix accepts mail messages (such as cron job reports) from
#   the local system only, and not from the network, which protects it from network
#   attack.
#
# @example
#   include almalinux_hardening::services::disable::postfix_listening
class almalinux_hardening::services::disable::postfix_listening {
  if $almalinux_hardening::enable_disable_postfix_listening {
    if find_file('/etc/postfix/main.cf') {
      file_line { 'postfix_listening':
        ensure => 'present',
        path   => '/etc/postfix/main.cf',
        line   => 'inet_interfaces = loopback-only',
        match  => '^\s*inet_interfaces\s+=\s+',
      }
    }
  }
}
