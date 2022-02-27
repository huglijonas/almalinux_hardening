# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable the Automounter
#
# @description
#   The autofs daemon mounts and unmounts filesystems, such as user home directories
#   shared via NFS, on demand. In addition, autofs can be used to handle removable
#   media, and the default configuration provides the cdrom device as /misc/cd.
#   However, this method of providing access to removable media is not common, so
#   autofs can almost always be disabled if NFS is not in use. Even if NFS is
#   required, it may be possible to configure filesystem mounts statically by
#   editing /etc/fstab rather than relying on the automounter.
#   The autofs service can be disabled with the following command:
#   $ sudo systemctl mask --now autofs.service
#
# @rationale
#   Disabling the automounter permits the administrator to statically control
#   filesystem mounting through /etc/fstab.
#   Additionally, automatically mounting filesystems permits easy introduction of
#   unknown devices, thereby facilitating malicious activity.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::mount_fs::disable_automounter
class almalinux_hardening::system::files_perm_masks::mount_fs::disable_automounter {
  if $almalinux_hardening::enable_mountfs_automounter {
    service { 'disable_automounter':
      ensure => 'stopped',
      name   => 'autofs.service',
      enable => 'mask',
    }
  }
}
