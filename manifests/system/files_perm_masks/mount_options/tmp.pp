# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - nodev
#   Add nodev Option to /tmp
#
# @description - nodev
#   The nodev mount option can be used to prevent device files from being created
#   in /tmp. Legitimate character and block devices should not exist within temporary
#   directories like /tmp. Add the nodev option to the fourth column of /etc/fstab
#   for the line which controls mounting of /tmp.
#
# @rationale - nodev
# 	The only legitimate location for device files is the /dev directory located on
#   the root partition. The only exception to this is chroot jails.
#
# @summary - noexec
#   Add noexec Option to /tmp
#
# @description - noexec
#	  The noexec mount option can be used to prevent binaries from being executed
#   out of /tmp. Add the noexec option to the fourth column of /etc/fstab for the
#   line which controls mounting of /tmp.
#
# @rationale - noexec
#	  Allowing users to execute binaries from world-writable directories such as /tmp
#   should never be necessary in normal operation and can expose the system to potential
#   compromise.
#
# @summary - nosuid
#   Add nosuid Option to /tmp
#
# @description - nosuid
#	  The nosuid mount option can be used to prevent execution of setuid programs in
#   /tmp. The SUID and SGID permissions should not be required in these world-writable
#   directories. Add the nosuid option to the fourth column of /etc/fstab for the line
#   which controls mounting of /tmp.
#
# @rationale - nosuid
#	  The presence of SUID and SGID executables should be tightly controlled. Users
#   should not be able to execute SUID or SGID binaries from temporary storage
#   partitions.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_options::tmp
class almalinux_hardening::system::files_perm_masks::mount_options::tmp {
  if $almalinux_hardening::enable_mountoptions_tmp {
    mount { 'tmp_mount_options':
      name    => '/tmp',
      device  => $almalinux_hardening::tmp_device,
      options => 'defaults,nodev,noexec,nosuid',
      fstype  => 'xfs',
      dump    => 0,
      pass    => 0,
    }
  }
}
