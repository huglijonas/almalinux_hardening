# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#
#
# @description
#
#
# @rationale
#
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
