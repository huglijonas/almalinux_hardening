# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable graphical user interface
#
# @description
#   By removing the following packages, the system no longer has X Windows
#   installed. xorg-x11-server-Xorg xorg-x11-server-common xorg-x11-server-utils
#   xorg-x11-server-Xwayland If X Windows is not installed then the system cannot
#   boot into graphical user mode. This prevents the system from being accidentally
#   or maliciously booted into a graphical.target mode. To do so, run the following
#   command:
#   sudo yum remove xorg-x11-server-Xorg xorg-x11-server-common \
#   xorg-x11-server-utils xorg-x11-server-Xwayland
#   Additionally, setting the system's default target to multi-user.target will
#   prevent automatic startup of the X server. To do so, run:
#   $ systemctl set-default multi-user.target
#   You should see the following output:
#   Removed symlink /etc/systemd/system/default.target.
#   Created symlink from /etc/systemd/system/default.target to /usr/lib/systemd/system/multi-user.target.
#
# @rationale
#	  Unnecessary service packages must not be installed to decrease the attack
#   surface of the system. X windows has a long history of security vulnerabilities
#   and should not be installed unless approved and documented.
#
# @example
#   include almalinux_hardening::services::disable::gui
class almalinux_hardening::services::disable::gui {
  if $almalinux_hardening::enable_disable_gui {
    package { $almalinux_hardening::gui_packages:
      ensure          => absent,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }

    exec { 'system_default_target':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'systemctl set-default multi-user.target',
      unless  => 'systemctl get-default | grep -q "multi-user.target"',
    }
  }
}
