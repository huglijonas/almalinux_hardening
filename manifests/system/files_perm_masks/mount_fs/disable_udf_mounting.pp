# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Mounting of udf
#
# @description
#   To configure the system to prevent the udf kernel module from being loaded,
#   add the following line to a file in the directory /etc/modprobe.d:
#   install udf /bin/true
#   This effectively prevents usage of this uncommon filesystem. The udf filesystem
#   type is the universal disk format used to implement the ISO/IEC 13346 and ECMA-167
#   specifications. This is an open vendor filesystem type for data storage on a broad
#   range of media. This filesystem type is neccessary to support writing DVDs and newer
#   optical disc formats.
#
# @rationale
#   Removing support for unneeded filesystem types reduces the local attack surface
#   of the system.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_fs::disable_udf_mounting
class almalinux_hardening::system::files_perm_masks::mount_fs::disable_udf_mounting {
  if $almalinux_hardening::enable_mountfs_udf {
    kmod::install { 'udf':
      command => '/bin/true',
    }
  }
}
