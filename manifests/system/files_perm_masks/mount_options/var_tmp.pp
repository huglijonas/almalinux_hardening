# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - nodev
#   Add nodev Option to /var/tmp
#
# @description - nodev
#	  The nodev mount option can be used to prevent device files from being created
#   in /var/tmp. Legitimate character and block devices should not exist within
#   temporary directories like /var/tmp. Add the nodev option to the fourth column
#   of /etc/fstab for the line which controls mounting of /var/tmp.
#
# @rationale - nodev
#	  The only legitimate location for device files is the /dev directory located on
#   the root partition. The only exception to this is chroot jails.
#
# @summary - noexec
#   Add noexec Option to /var/tmp
#
# @description - noexec
#   The noexec mount option can be used to prevent binaries from being executed out
#   of /var/tmp. Add the noexec option to the fourth column of /etc/fstab for the
#   line which controls mounting of /var/tmp.
#
# @rationale - noexec
#   Allowing users to execute binaries from world-writable directories such as
#   /var/tmp should never be necessary in normal operation and can expose the system
#   to potential compromise.
#
# @summary - nosuid
#   Add nosuid Option to /var/tmp
#
# @description - nosuid
#	  The nosuid mount option can be used to prevent execution of setuid programs in
#   /var/tmp. The SUID and SGID permissions should not be required in these world-writable
#   directories. Add the nosuid option to the fourth column of /etc/fstab for the line
#   which controls mounting of /var/tmp.
#
# @rationale - nosuid
#   The presence of SUID and SGID executables should be tightly controlled. Users
#   should not be able to execute SUID or SGID binaries from temporary storage
#   partitions.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_options::var_tmp
class almalinux_hardening::system::files_perm_masks::mount_options::var_tmp {
  if $almalinux_hardening::enable_mountoptions_vartmp {
    if $almalinux_hardening::mountoptions_vartmp_partitioned {
      mount { 'var_tmp_mount_options':
        name    => '/var/tmp',
        device  => $almalinux_hardening::vartmp_device,
        options => 'defaults,nodev,noexec,nosuid',
        fstype  => 'xfs',
        dump    => 0,
        pass    => 0,
      }
    }
    elsif ! $almalinux_hardening::mountoptions_vartmp_partitioned {
      mount { 'var_tmp_mount_options':
        name    => '/var/tmp',
        device  => '/tmp',
        options => 'bind,nodev,noexec,nosuid',
        fstype  => 'none',
        dump    => 0,
        pass    => 0,
      }
    }
  }
}
