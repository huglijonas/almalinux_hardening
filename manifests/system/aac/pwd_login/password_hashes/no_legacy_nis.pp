# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure there are no legacy + NIS entries
#
# @description
#   The + character file marks a place where entries from a network information
#   service (NIS) should be directly inserted.
#
# @rationale
#   Using this method to include entries is considered legacy and should be avoided.
#   These entries may provide a way for an attacker to gain access to the system.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::password_hashes::no_legacy_nis
class almalinux_hardening::system::aac::pwd_login::password_hashes::no_legacy_nis {
  if $almalinux_hardening::enable_pwdlogin_no_legacy_nis_entry {
    $almalinux_hardening::pwdlogin_no_legacy_nis_entry_paths.each | $path | {
      exec { "nis_entry ${path}":
        path    => '/usr/bin:/bin:/usr/sbin',
        command => "sed -i 's/^\+.*$//g' ${path}",
        onlyif  => "getent group | egrep -q '^\+.*$'",
      }
    }
  }
}
