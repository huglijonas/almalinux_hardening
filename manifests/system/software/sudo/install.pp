# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Install sudo Package
#
# @description
#   The sudo package can be installed with the following command:
#   $ sudo yum install sudo
#
# @rationale
#   sudo is a program designed to allow a system administrator to give limited root
#   privileges to users and log root activity. The basic philosophy is to give as few
#   privileges as possible but still allow system users to get their work done.
#
# @example
#   include almalinux_hardening::system::software::disksoftware::sudo::install
class almalinux_hardening::system::software::sudo::install {
  if $almalinux_hardening::enable_sudo_install {
    package { 'sudo':
      ensure          => latest,
      install_options => ['--disablerepo',"${almalinux_hardening::disable_repos}",'--enablerepo',"${almalinux_hardening::enable_repos}"],
    }
  }
}
