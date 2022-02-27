# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure rsyslog is Installed
#
# @description
#	  Rsyslog is installed by default. The rsyslog package can be installed with
#   the following command:
#   $ sudo yum install rsyslog
#
# @rationale
#	  The rsyslog package provides the rsyslog daemon, which provides system logging
#   services.
#
# @example
#   include almalinux_hardening::system::syslog::install
class almalinux_hardening::system::syslog::install {
  if $almalinux_hardening::enable_syslog_install {
    package { 'rsyslog':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
