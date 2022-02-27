# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure the Default Umask is Set Correctly in login.defs
#
# @description
#   To ensure the default umask controlled by /etc/login.defs is set properly,
#   add or correct the UMASK setting in /etc/login.defs to read as follows:
#   UMASK 027
#
# @rationale
#   The umask value influences the permissions assigned to files when they are
#   created. A misconfigured umask value could result in files with excessive
#   permissions that can be read and written to by unauthorized users.
#
# @example
#   include almalinux_hardening::system::aac::session::umask::login_defs
class almalinux_hardening::system::aac::session::umask::login_defs {
  if $almalinux_hardening::enable_session_umask_login_defs {
    file_line { 'login_defs_umask':
      ensure   => present,
      path     => '/etc/login.defs',
      line     => "UMASK           ${almalinux_hardening::enable_session_umask}",
      match    => '^(#|).*UMASK.*[0-9]{3}.*$',
      multiple => true,
    }
  }
}
