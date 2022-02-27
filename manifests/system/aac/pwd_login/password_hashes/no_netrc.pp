# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Verify No netrc Files Exist
#
# @description
#	  The .netrc files contain login information used to auto-login into FTP servers
#   and reside in the user's home directory. These files may contain unencrypted
#   passwords to remote FTP servers making them susceptible to access by unauthorized
#   users and should not be used. Any .netrc files should be removed.
#
# @rationale
#	  Unencrypted passwords for remote FTP servers may be stored in .netrc files.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::password_hashes::no_netrc
class almalinux_hardening::system::aac::pwd_login::password_hashes::no_netrc {
  if $almalinux_hardening::enable_pwdlogin_no_netrc {
    exec { 'no_netrc':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'getent passwd | cut -d: -f6 | sort | uniq | xargs -I % find % -maxdepth 1 -type f -name ".netrc" -exec rm -f {} \;',
      unless  => 'getent passwd | cut -d: -f6 | sort | uniq | xargs -I % find % -maxdepth 1 -type f -name ".netrc" | wc -l | grep -q -E "^0$"',
    }
  }
}
