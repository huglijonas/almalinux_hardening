# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure SELinux Not Disabled in /etc/default/grub
#
# @description
#   SELinux can be disabled at boot time by an argument in /etc/default/grub.
#   Remove any instances of selinux=0 from the kernel arguments in that file to
#   prevent SELinux from being disabled at boot.
#
# @rationale
#   Disabling a major host protection feature, such as SELinux, at boot time
#   prevents it from confining system services at boot time. Further, it increases
#   the chances that it will remain off during system operation.
#
# @example
#   include almalinux_hardening::system::selinux::grub2
class almalinux_hardening::system::selinux::grub2 {
  if $almalinux_hardening::enable_selinux_grub2 {
    kernel_parameter { 'selinux=1':
      ensure => present,
    }
    kernel_parameter { 'enforcing=1':
      ensure => present,
    }
  }
}
