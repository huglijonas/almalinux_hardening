# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Remove NIS Client
#
# @description
#   The Network Information Service (NIS), formerly known as Yellow Pages, is a
#   client-server directory service protocol used to distribute system configuration
#   files. The NIS client (ypbind) was used to bind a system to an NIS server and
#   receive the distributed configuration files.
#
# @rationale
#	  The NIS service is inherently an insecure system that has been vulnerable to
#   DOS attacks, buffer overflows and has poor authentication for querying NIS maps.
#   NIS generally has been replaced by such protocols as Lightweight Directory Access
#   Protocol (LDAP). It is recommended that the service be removed.
#
# @example
#   include almalinux_hardening::services::uninstall::nis_client
class almalinux_hardening::services::uninstall::nis_client {
  if $almalinux_hardening::enable_uninstall_nis_client {
    package { 'ypbind':
      ensure          => purged,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
