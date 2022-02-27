# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Require Authentication for Emergency Systemd Target
#
# @description
#   Emergency mode is intended as a system recovery method, providing a single user
#   root access to the system during a failed boot sequence.
#   By default, Emergency mode is protected by requiring a password and is set in
#   /usr/lib/systemd/system/emergency.service.
#
# @rationale
#   This prevents attackers with physical access from trivially bypassing security
#   on the machine and gaining root access. Such accesses are further prevented by
#   configuring the bootloader password.
#
# @example
#   include almalinux_hardening::system::aac::console::systemd_target
class almalinux_hardening::system::aac::console::systemd_target {
  exec { 'systemd_target_daemon_reload':
    path        => '/usr/bin:/bin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
  }

  if $almalinux_hardening::enable_console_systemd_target {
    file_line { 'emergency_service':
      ensure => present,
      path   => '/usr/lib/systemd/system/emergency.service',
      line   => 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell emergency',
      match  => '^(#|).*ExecStart.*=',
    } ~> Exec['systemd_target_daemon_reload']

    file_line { 'emergency_target':
      ensure => present,
      path   => '/usr/lib/systemd/system/emergency.target',
      line   => 'Requires=emergency.service',
      match  => '^(#|).*Requires.*=',
    } ~> Exec['systemd_target_daemon_reload']
  }
}
