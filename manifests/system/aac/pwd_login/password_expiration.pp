# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set Password Expiration Parameters
#
# @description - Maximum Age
#   To specify password maximum age for new accounts, edit the file /etc/login.defs
#   and add or correct the following line:
#   PASS_MAX_DAYS 365
#   A value of 180 days is sufficient for many environments. The DoD requirement is
#   60. The profile requirement is 365.
#
# @rationale - Maximum Age
#   Any password, no matter how complex, can eventually be cracked. Therefore,
#   passwords need to be changed periodically. If the operating system does not limit
#   the lifetime of passwords and force users to change their passwords, there is the
#   risk that the operating system passwords could be compromised.
#   Setting the password maximum age ensures users are required to periodically change
#   their passwords. Requiring shorter password lifetimes increases the risk of users
#   writing down the password in a convenient location subject to physical compromise.
#
# @description - Minimum Age
#   To specify password minimum age for new accounts, edit the file /etc/login.defs and
#   add or correct the following line:
#   PASS_MIN_DAYS 7
#   A value of 1 day is considered sufficient for many environments. The DoD requirement
#   is 1. The profile requirement is 7.
#
# @rationale - Minimum Age
#   Enforcing a minimum password lifetime helps to prevent repeated password changes to
#   defeat the password reuse or history enforcement requirement. If users are allowed to
#   immediately and continually change their password, then the password could be repeatedly
#   changed in a short period of time to defeat the organization's policy regarding password
#   reuse.
#   Setting the minimum password age protects against users cycling back to a favorite password
#   after satisfying the password reuse requirement.
#
# @description - Warning Age
#   To specify how many days prior to password expiration that a warning will be issued to users,
#   edit the file /etc/login.defs and add or correct the following line:
#   PASS_WARN_AGE 7
#   The DoD requirement is 7. The profile requirement is 7.
#
# @rationale - Warning Age
#	  Setting the password warning age enables users to make the change at a practical time.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::password_expiration
class almalinux_hardening::system::aac::pwd_login::password_expiration {
  if $almalinux_hardening::enable_pwdlogin_pwd_expiration {
    file_line { 'pwd_max_age':
      ensure => present,
      path   => '/etc/login.defs',
      line   => "PASS_MAX_DAYS   ${almalinux_hardening::pwdlogin_pwd_expiration_maxdays}",
      match  => '^(#|).*PASS_MAX_DAYS.*[0-9]+',
    }

    file_line { 'pwd_min_age':
      ensure => present,
      path   => '/etc/login.defs',
      line   => "PASS_MIN_DAYS   ${almalinux_hardening::pwdlogin_pwd_expiration_mindays}",
      match  => '^(#|).*PASS_MIN_DAYS.*[0-9]+',
    }

    file_line { 'pwd_warning_age':
      ensure => present,
      path   => '/etc/login.defs',
      line   => "PASS_WARN_AGE   ${almalinux_hardening::pwdlogin_pwd_expiration_warndays}",
      match  => '^(#|).*PASS_WARN_AGE.*[0-9]+',
    }
  }
}
