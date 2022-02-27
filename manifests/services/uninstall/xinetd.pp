# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Uninstall xinetd Package
#
# @description
#   The xinetd package can be removed with the following command:
#   $ sudo yum erase xinetd
#
# @rationale
#   Removing the xinetd package decreases the risk of the xinetd service's
#   accidental (or intentional) activation.
#
# @example
#   include almalinux_hardening::services::uninstall::xinetd
class almalinux_hardening::services::uninstall::xinetd {
  if $almalinux_hardening::enable_uninstall_xinetd {
    package { 'xinetd':
      ensure          => purged,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
