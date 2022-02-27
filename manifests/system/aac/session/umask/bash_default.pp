# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure the Default Bash Umask is Set Correctly
#
# @description
#	  To ensure the default umask for users of the Bash shell is set properly, add
#   or correct the umask setting in /etc/bashrc to read as follows:
#   umask 027
#
# @rationale
#	  The umask value influences the permissions assigned to files when they are
#   created. A misconfigured umask value could result in files with excessive
#   permissions that can be read or written to by unauthorized users.
#
# @example
#   include almalinux_hardening::system::aac::session::umask::bash_default
class almalinux_hardening::system::aac::session::umask::bash_default {
  if $almalinux_hardening::enable_session_umask_bash {
    file_line { 'bashrc_umask':
      ensure   => present,
      path     => '/etc/bashrc',
      line     => "       umask ${almalinux_hardening::enable_session_umask}",
      match    => '^(#|).*umask.*[0-9]{3}.*$',
      multiple => true,
    }
  }
}
