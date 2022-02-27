# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Verify that All World-Writable Directories Have Sticky Bits Set
#
# @description
#   When the so-called 'sticky bit' is set on a directory, only the owner of a
#   given file may remove that file from the directory. Without the sticky bit,
#   any user with write access to a directory may remove any file in the directory.
#   Setting the sticky bit prevents users from removing each other's files. In cases
#   where there is no reason for a directory to be world-writable, a better solution
#   is to remove that permission rather than to set the sticky bit. However, if a
#   directory is used by a particular application, consult that application's documentation
#   instead of blindly changing modes.
#   To set the sticky bit on a world-writable directory DIR, run the following command:
#   $ sudo chmod +t DIR
#
# @rationale
#	  Failing to set the sticky bit on public directories allows unauthorized users to delete
#   files in the directory structure.
#   The only authorized public directories are those temporary directories supplied with
#   the system, or those designed to be temporary file repositories. The setting is normally
#   reserved for directories used by the system, by users for temporary file storage
#   (such as /tmp), and for directories requiring global read/write access.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::important::sticky_bit
class almalinux_hardening::system::files_perm_masks::important::sticky_bit {
  if $almalinux_hardening::enable_important_stickybit {
    exec { 'stickbit_world_writable':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'find / \( -fstype nfs -o -fstype cachefs -o -fstype autofs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type d \( -perm -0002 -a ! -perm -1000 \) -exec chmod +t {} \;',
      unless  => 'find / \( -fstype nfs -o -fstype cachefs -o -fstype autofs -o -fstype ctfs -o -fstype mntfs -o -fstype objfs -o -fstype proc \) -prune -o -type d \( -perm -0002 -a ! -perm -1000 \) -print | wc -l | grep -q -E "^0$"',
    }
  }
}
