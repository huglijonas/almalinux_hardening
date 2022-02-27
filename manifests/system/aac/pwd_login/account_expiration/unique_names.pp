# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure All Accounts on the System Have Unique Names
#
# @description
#   Ensure accounts on the system have unique names. To ensure all accounts have
#   unique names, run the following command:
#   $ sudo getent passwd | awk -F: '{ print $1}' | uniq -d
#   If a username is returned, change or delete the username.
#
# @rationale
#   Unique usernames allow for accountability on the system.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::account_expiration::unique_names
class almalinux_hardening::system::aac::pwd_login::account_expiration::unique_names {
  if $almalinux_hardening::enable_pwdlogin_expiration_unique_names {
    package { 'util-linux-user':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }

    exec { 'unique_names':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "getent passwd | awk -F: '{print ${1}}' | uniq -d | xargs -I % chsh -s /sbin/nologin %",
      unless  => "getent passwd | awk -F: '{print ${1}}' | uniq -d | wc -l | grep -q -E '^0$'",
    }
  }
}
