# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Require Authentication for Single User Mode
#
# @description
#   Single-user mode is intended as a system recovery method, providing a single
#   user root access to the system by providing a boot option at startup. By default,
#   no authentication is performed if single-user mode is selected.
#   By default, single-user mode is protected by requiring a password and is set in
#   /usr/lib/systemd/system/rescue.service.
#
# @rationale
#   This prevents attackers with physical access from trivially bypassing security on
#   the machine and gaining root access. Such accesses are further prevented by configuring
#   the bootloader password.
#
# @example
#   include almalinux_hardening::system::aac::console::single_user
class almalinux_hardening::system::aac::console::single_user {
  exec { 'single_user_daemon_reload':
    path        => '/usr/bin:/bin:/usr/sbin',
    command     => 'systemctl daemon-reload',
    refreshonly => true,
  }

  if $almalinux_hardening::enable_console_rescue {
    file_line { 'rescue_service':
      ensure => present,
      path   => '/usr/lib/systemd/system/rescue.service',
      line   => 'ExecStart=-/usr/lib/systemd/systemd-sulogin-shell rescue',
      match  => '^(#|).*ExecStart.*=',
    } ~> Exec['single_user_daemon_reload']
  }

  if $almalinux_hardening::enable_console_singleuser {
    file_line { 'single_user_target':
      ensure => present,
      path   => '/usr/lib/systemd/system/runlevel1.target',
      line   => 'Requires=sysinit.target rescue.service',
      match  => '^(#|).*Requires.*=',
    } ~> Exec['single_user_daemon_reload']
  }
}
