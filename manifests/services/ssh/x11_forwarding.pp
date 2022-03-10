# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable X11 Forwarding
#
# @description
#   The X11Forwarding parameter provides the ability to tunnel X11 traffic through
#   the connection to enable remote graphic connections. SSH has the capability to
#   encrypt remote X11 connections when SSH's X11Forwarding option is enabled.
#   To disable X11 Forwarding, add or correct the following line in
#   /etc/ssh/sshd_config:
#   X11Forwarding no
#
# @rationale
#	  Disable X11 forwarding unless there is an operational requirement to use X11
#   applications directly. There is a small risk that the remote X11 servers of
#   users who are logged in via SSH with X11 forwarding could be compromised by
#   other users on the X11 server. Note that even if X11 forwarding is disabled,
#   users can always install their own forwarders.
#
# @example
#   include almalinux_hardening::services::ssh::x11_forwarding
class almalinux_hardening::services::ssh::x11_forwarding inherits almalinux_hardening::services::ssh::service {
  if $almalinux_hardening::enable_ssh_x11_forwarding {
    file_line { 'ssh_x11_forwarding':
      ensure => 'present',
      path   => '/etc/ssh/sshd_config',
      line   => "X11Forwarding ${almalinux_hardening::ssh_x11_forwarding}",
      match  => '^(#|).*X11Forwarding.*.(yes|no).*$',
    }
    ~> Service['sshd']
  }
}
