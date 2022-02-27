# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Mounting of squashfs
#
# @description
#   To configure the system to prevent the squashfs kernel module from being loaded,
#   add the following line to a file in the directory /etc/modprobe.d:
#   install squashfs /bin/true
#   This effectively prevents usage of this uncommon filesystem. The squashfs
#   filesystem type is a compressed read-only Linux filesystem embedded in small
#   footprint systems (similar to cramfs). A squashfs image can be used without
#   having to first decompress the image.
#
# @rationale
#   Removing support for unneeded filesystem types reduces the local attack surface
#   of the system.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_fs::disable_squashfs_mounting
class almalinux_hardening::system::files_perm_masks::mount_fs::disable_squashfs_mounting {
  if $almalinux_hardening::enable_mountfs_squashfs {
    kmod::install { 'squashfs':
      command => '/bin/true',
    }
  }
}
