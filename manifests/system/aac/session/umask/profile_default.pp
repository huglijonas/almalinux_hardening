# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure the Default Umask is Set Correctly in /etc/profile
#
# @description
#	  To ensure the default umask controlled by /etc/profile is set properly, add
#   or correct the umask setting in /etc/profile to read as follows:
#   umask 027
#
# @rationale
#	  The umask value influences the permissions assigned to files when they are
#   created. A misconfigured umask value could result in files with excessive
#   permissions that can be read or written to by unauthorized users.
#
# @example
#   include almalinux_hardening::system::aac::session::umask::profile_default
class almalinux_hardening::system::aac::session::umask::profile_default {
  if $almalinux_hardening::enable_session_umask_profile {
    file_line { 'profile_umask':
      ensure   => present,
      path     => '/etc/profile',
      line     => "       umask ${almalinux_hardening::enable_session_umask}",
      match    => '^(#|).*umask.*[0-9]{3}.*$',
      multiple => true,
    }
  }
}
