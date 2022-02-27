# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure LDAP client is not installed
#
# @description
#	  The Lightweight Directory Access Protocol (LDAP) is a service that provides a
#   method for looking up information from a central database. The openldap-clients
#   package can be removed with the following command:
#   $ sudo yum erase openldap-clients
#
# @rationale
#   If the system does not need to act as an LDAP client, it is recommended that
#   the software is removed to reduce the potential attack surface.
#
# @example
#   include almalinux_hardening::services::uninstall::ldap_client
class almalinux_hardening::services::uninstall::ldap_client {
  if $almalinux_hardening::enable_uninstall_ldap_client {
    package { 'openldap-clients':
      ensure          => purged,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
