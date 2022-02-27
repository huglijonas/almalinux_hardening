# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   UEFI GRUB2 bootloader configuration
#
# @description - grub.cfg Group Ownership
#	  The file /boot/efi/EFI/almalinux/grub.cfg should be group-owned by the root
#   group to prevent destruction or modification of the file. To properly set the
#   group owner of /boot/efi/EFI/almalinux/grub.cfg, run the command:
#   $ sudo chgrp root /boot/efi/EFI/almalinux/grub.cfg
#
# @rationale - grub.cfg Group Ownership
#   The root group is a highly-privileged group. Furthermore, the group-owner of
#   this file should not have any access privileges anyway.
#
# @description - grub.cfg User Ownership
#   The file /boot/efi/EFI/almalinux/grub.cfg should be owned by the root user to
#   prevent destruction or modification of the file. To properly set the owner of
#   /boot/efi/EFI/almalinux/grub.cfg, run the command:
#   $ sudo chown root /boot/efi/EFI/almalinux/grub.cfg
#
# @rationale - grub.cfg User Ownership
#   Only root should be able to modify important boot parameters.
#
# @description - grub.cfg Permissions
#   File permissions for /boot/efi/EFI/almalinux/grub.cfg should be set to 700.
#   To properly set the permissions of /boot/efi/EFI/almalinux/grub.cfg, run the
#   command:
#   $ sudo chmod 700 /boot/efi/EFI/almalinux/grub.cfg
#
# @rationale - grub.cfg Permissions
#   Proper permissions ensure that only the root user can modify important boot
#   parameters.
#
# @example
#   include almalinux_hardening::system::grub2::cfg_perms
class almalinux_hardening::system::grub2::cfg_perms {
  if $almalinux_hardening::enable_grub2_cfg_perms {
    mount { 'cfg_perms':
      name    => '/boot/efi',
      device  => $facts['boot_efi_uuid'],
      options => 'umask=0177,shortname=winnt',
      fstype  => 'vfat',
      dump    => 0,
      pass    => 2,
    }
  }
}
