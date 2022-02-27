# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Install firewalld Package
#
# @description
#   The firewalld package can be installed with the following command:
#   $ sudo yum install firewalld
#
# @rationale
#   The firewalld package should be installed to provide access control methods.
#
# @example
#   include almalinux_hardening::system::network::firewalld::install
class almalinux_hardening::system::network::firewalld::install {
  if $almalinux_hardening::enable_firewalld_install {
    package { 'firewalld':
      ensure          => latest,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
