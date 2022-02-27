# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Install AIDE
#
# @description
#   The aide package can be installed with the following command: $ sudo yum install aide
#
# @rationale
#   The AIDE package must be installed if it is to be available for integrity checking.
#
# @example
#   include almalinux_hardening::system::software::integrity::aide::install
class almalinux_hardening::system::software::integrity::aide::install {
  if $almalinux_hardening::enable_integrity_aide_install {
    package { 'aide':
      ensure          => latest,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
