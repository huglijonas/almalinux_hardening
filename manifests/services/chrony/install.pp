# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Install Chrony
#
# @description
#   The chrony package can be installed with the following command:
#   $ sudo yum install chrony
#
# @rationale
#   The chrony package must be installed for the Network Time Protocol checks.
#
# @example
#   include almalinux_hardening::services::chrony::install
class almalinux_hardening::services::chrony::install {
  if $almalinux_hardening::enable_chrony_install {
    package { 'chrony':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
