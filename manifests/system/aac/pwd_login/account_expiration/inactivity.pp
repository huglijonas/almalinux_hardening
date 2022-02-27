# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set Account Expiration Following Inactivity
#
# @description
#   To specify the number of days after a password expires (which signifies inactivity)
#   until an account is permanently disabled, add or correct the following line in
#   /etc/default/useradd:
#   INACTIVE=30
#   If a password is currently on the verge of expiration, then 30 day(s) remain(s)
#   until the account is automatically disabled. However, if the password will not
#   expire for another 60 days, then 60 days plus 30 day(s) could elapse until the
#   account would be automatically disabled. See the useradd man page for more information.
#
# @rationale
#   Disabling inactive accounts ensures that accounts which may not have been responsibly
#   removed are not available to attackers who may have compromised their credentials.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::account_expiration::inactivity
class almalinux_hardening::system::aac::pwd_login::account_expiration::inactivity {
  if $almalinux_hardening::enable_pwdlogin_expiration_inactivity {
    file_line { 'pwd_inactivity':
      ensure => present,
      path   => '/etc/default/useradd',
      line   => "INACTIVE=${almalinux_hardening::pwdlogin_expiration_inactivity_days}",
      match  => '^(#|).*INACTIVE.*=',
    }
  }
}
