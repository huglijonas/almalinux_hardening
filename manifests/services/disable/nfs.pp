# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Network File System (nfs)
#
# @description
#	  The Network File System (NFS) service allows remote hosts to mount and
#   interact with shared filesystems on the local system. If the local system is
#   not designated as a NFS server then this service should be disabled. The
#   nfs-server service can be disabled with the following command:
#   $ sudo systemctl mask --now nfs-server.service
#
# @rationale
#   Unnecessary services should be disabled to decrease the attack surface of
#   the system.
#
# @example
#   include almalinux_hardening::services::disable::nfs
class almalinux_hardening::services::disable::nfs {
  if $almalinux_hardening::enable_disable_nfs {
    service { 'disable_nfs_service':
      ensure => 'stopped',
      name   => 'nfs-server.service',
      enable => 'mask',
    }
    service { 'disable_nfs_socket':
      ensure => 'stopped',
      name   => 'nfs-server.socket',
      enable => 'mask',
    }
  }
}
