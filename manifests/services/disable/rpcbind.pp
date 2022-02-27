# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable rpcbind Service
#
# @description
#   The rpcbind utility maps RPC services to the ports on which they listen. RPC
#   processes notify rpcbind when they start, registering the ports they are listening
#   on and the RPC program numbers they expect to serve. The rpcbind service redirects
#   the client to the proper port number so it can communicate with the requested service.
#   If the system does not require RPC (such as for NFS servers) then this service should
#   be disabled. The rpcbind service can be disabled with the following command:
#   $ sudo systemctl mask --now rpcbind.service
#
# @rationale
#   If the system does not require rpc based services, it is recommended that rpcbind be
#   disabled to reduce the attack surface.
#
# @example
#   include almalinux_hardening::services::disable::rpcbind
class almalinux_hardening::services::disable::rpcbind {
  if $almalinux_hardening::enable_disable_rpcbind {
    service { 'disable_rpcbind_service':
      ensure => 'stopped',
      name   => 'rpcbind.service',
      enable => 'mask',
    }
    service { 'disable_rpcbind_socket':
      ensure => 'stopped',
      name   => 'rpcbind.socket',
      enable => 'mask',
    }

    package { 'nfs-utils':
      ensure          => absent,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
