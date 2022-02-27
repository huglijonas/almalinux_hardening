# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set the UEFI Boot Loader Password
#
# @description
#   The grub2 boot loader should have a superuser account and password protection
#   enabled to protect boot-time settings.
#   Since plaintext passwords are a security risk, generate a hash for the password
#   by running the following command:
#   $ grub2-setpassword
#   When prompted, enter the password that was selected.
#   Once the superuser password has been added, update the grub.cfg file by running:
#   grub2-mkconfig -o /boot/efi/EFI/almalinux/grub.cfg
#
# @rationale
#   Password protection on the boot loader configuration ensures users with physical
#   access cannot trivially alter important bootloader settings. These include which
#   kernel to use, and whether to enter single-user mode.
#
# @example
#   include almalinux_hardening::system::grub2::password
class almalinux_hardening::system::grub2::password {
  if $almalinux_hardening::enable_grub2_password {
    grub_user { 'root':
      password  => $almalinux_hardening::grub2_password,
      superuser => true,
    }
  }
}
