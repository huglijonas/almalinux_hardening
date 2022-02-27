# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - nodev
#   Add nodev Option to /dev/shm
#
# @description - nodev
#   The nodev mount option can be used to prevent creation of device files in
#   /dev/shm. Legitimate character and block devices should not exist within
#   temporary directories like /dev/shm. Add the nodev option to the fourth
#   column of /etc/fstab for the line which controls mounting of /dev/shm.
#
# @rationale - nodev
#	  The only legitimate location for device files is the /dev directory located
#   on the root partition. The only exception to this is chroot jails.
#
# @summary - noexec
#   Add noexec Option to /dev/shm
#
# @description - noexec
#	  The noexec mount option can be used to prevent binaries from being executed
#   out of /dev/shm. It can be dangerous to allow the execution of binaries from
#   world-writable temporary storage directories such as /dev/shm. Add the noexec
#   option to the fourth column of /etc/fstab for the line which controls mounting
#   of /dev/shm.
#
# @rationale - noexec
#   Allowing users to execute binaries from world-writable directories such as
#   /dev/shm can expose the system to potential compromise.
#
# @summary - nosuid
#   Add nosuid Option to /dev/shm
#
# @description - nosuid
#	  The nosuid mount option can be used to prevent execution of setuid programs
#   in /dev/shm. The SUID and SGID permissions should not be required in these
#   world-writable directories. Add the nosuid option to the fourth column of
#   /etc/fstab for the line which controls mounting of /dev/shm.
#
# @rationale - nosuid
#   The presence of SUID and SGID executables should be tightly controlled. Users
#   should not be able to execute SUID or SGID binaries from temporary storage
#   partitions.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_options::dev_shm
class almalinux_hardening::system::files_perm_masks::mount_options::dev_shm {
  if $almalinux_hardening::enable_mountoptions_devshm {
    mount { 'devshm_mount_options':
      name    => '/dev/shm',
      device  => 'tmpfs',
      options => 'rw,seclabel,nosuid,noexec,nodev',
      fstype  => 'tmpfs',
      dump    => 0,
      pass    => 0,
    }
  }
}
