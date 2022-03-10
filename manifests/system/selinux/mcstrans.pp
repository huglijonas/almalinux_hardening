# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Uninstall mcstrans Package
#
# @description
#   The mcstransd daemon provides category label information to client processes
#   requesting information. The label translations are defined in
#   /etc/selinux/targeted/setrans.conf. The mcstrans package can be removed with
#   the following command:
#   $ sudo yum erase mcstrans
#
# @rationale
#   Since this service is not used very often, disable it to reduce the amount
#   of potentially vulnerable code running on the system.
#
# @example
#   include almalinux_hardening::system::selinux::mcstrans
class almalinux_hardening::system::selinux::mcstrans {
  if $almalinux_hardening::enable_selinux_mcstrans {
    package { 'mcstrans':
      ensure          => absent,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
