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
#   include almalinux_hardening::system::selinux::libselinux
class almalinux_hardening::system::selinux::libselinux {
  if $almalinux_hardening::enable_selinux_libselinux {
    package { 'libselinux':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
