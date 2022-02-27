# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Limit Password Reuse
#
# @description
#   Do not allow users to reuse recent passwords. This can be accomplished by using
#   the remember option for the pam_pwhistory PAM modules.
#   Make sure the parameter remember is present, and that the value for the remember
#   parameter is 5 or greater. For example:
#   password required pam_pwhistory.so ...existing_options... remember=5 use_authtok
#   The DoD STIG requirement is 5 passwords.
#
# @rationale
#   Preventing re-use of previous passwords helps ensure that a compromised password
#   is not re-used by a user.
#
# @example
#   include almalinux_hardening::system::aac::pam::password_reuse
class almalinux_hardening::system::aac::pam::password_reuse {
  if $almalinux_hardening::enable_pam_pwd_reuse {
    $almalinux_hardening::pam_services.each | $service | {
      pam { "pam_password_reuse ${service}":
        ensure    => present,
        service   => $service,
        type      => 'password',
        control   => 'required',
        module    => 'pam_pwhistory.so',
        arguments => ["remember=${almalinux_hardening::pam_pwd_reuse_remember}", "retry=${almalinux_hardening::pam_pwd_reuse_retry}", 'use_authtok'],
        position  => 'after *[type="password" and module="pam_pwquality.so" and control="requisite"]',
      }
    }
  }
}
