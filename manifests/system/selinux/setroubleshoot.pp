# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Uninstall setroubleshoot Package
#
# @description
#   The SETroubleshoot service notifies desktop users of SELinux denials. The
#   service provides information around configuration errors, unauthorized
#   intrusions, and other potential errors. The setroubleshoot package can be
#   removed with the following command:
#   $ sudo yum erase setroubleshoot
#
# @rationale
#   The SETroubleshoot service is an unnecessary daemon to have running on a
#   server, especially if X Windows is removed or disabled.
#
# @example
#   include almalinux_hardening::system::selinux::setroubleshoot
class almalinux_hardening::system::selinux::setroubleshoot {
  if $almalinux_hardening::enable_selinux_setroubleshoot {
    package { 'setroubleshoot':
      ensure          => absent,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
  }
}
