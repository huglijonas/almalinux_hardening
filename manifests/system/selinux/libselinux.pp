# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Install libselinux Package
#
# @description
#   The libselinux package can be installed with the following command:
#   $ sudo yum install libselinux
#
# @rationale
#	  Security-enhanced Linux is a feature of the Linux kernel and a number of
#   utilities with enhanced security functionality designed to add mandatory
#   access controls to Linux. The libselinux package contains the core library
#   of the Security-enhanced Linux system.
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
