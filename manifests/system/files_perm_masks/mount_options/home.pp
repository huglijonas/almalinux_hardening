# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Add nodev Option to /home
#
# @description
#   The nodev mount option can be used to prevent device files from being created
#   in /home. Legitimate character and block devices should exist only in the /dev
#   directory on the root partition or within chroot jails built for system services.
#   Add the nodev option to the fourth column of /etc/fstab for the line which controls
#   mounting of /home.
#
# @rationale
#	  The only legitimate location for device files is the /dev directory located on
#   the root partition. The only exception to this is chroot jails.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_options::home
class almalinux_hardening::system::files_perm_masks::mount_options::home {
  if $almalinux_hardening::enable_mountoptions_home {
    mount { 'home_mount_options':
      name    => '/home',
      device  => $almalinux_hardening::home_device,
      options => 'defaults,nodev',
      fstype  => 'xfs',
      atboot  => false,
      pass    => false,
    }
  }
}
