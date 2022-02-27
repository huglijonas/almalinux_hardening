# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Modprobe Loading of USB Storage Driver
#
# @description
#   To prevent USB storage devices from being used, configure the kernel module
#   loading system to prevent automatic loading of the USB storage driver. To
#   configure the system to prevent the usb-storage kernel module from being loaded,
#   add the following line to a file in the directory /etc/modprobe.d:
#   install usb-storage /bin/true
#   This will prevent the modprobe program from loading the usb-storage module,
#   but will not prevent an administrator (or another program) from using the insmod
#   program to load the module manually.
#
# @rationale
#   USB storage devices such as thumb drives can be used to introduce malicious
#   software.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_fs::disable_modprobe_loading_usb
class almalinux_hardening::system::files_perm_masks::mount_fs::disable_modprobe_loading_usb {
  if $almalinux_hardening::enable_mountfs_modprobe_usb {
    kmod::install { 'usb-storage':
      command => '/bin/true',
    }
  }
}
