# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Remove Rsh Trust Files
#
# @description
#   The files /etc/hosts.equiv and ~/.rhosts (in each user's home directory) list
#   remote hosts and users that are trusted by the local system when using the rshd
#   daemon. To remove these files, run the following command to delete them from any
#   location:
#   $ sudo rm /etc/hosts.equiv
#   $ rm ~/.rhosts
#
# @rationale
#	  This action is only meaningful if .rhosts support is permitted through PAM.
#   Trust files are convenient, but when used in conjunction with the R-services,
#   they can allow unauthenticated access to a system.
#
# @example
#   include almalinux_hardening::services::uninstall::rsh
class almalinux_hardening::services::uninstall::rsh {
  if $almalinux_hardening::enable_uninstall_rsh {
    file { '/etc/hosts.equiv':
      ensure  => absent,
    }

    exec { 'rhosts':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'find / -name ".rhosts" -exec rm -f {} \;',
      unless  => 'find / -name ".rhosts" | wc -l | grep -q -E "^0$"',
    }
  }
}
