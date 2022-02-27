# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure users' home directories permissions are 750 or more restrictive
#
# @description
#   While the system administrator can establish secure permissions for users'
#   home directories, the users can easily override these.
#
# @rationale
#   Group or world-writable user home directories may enable malicious users to
#   steal or modify other users' data or to gain another user's system privileges.
#
# @credits
#   Inspired by:
#   https://raw.githubusercontent.com/dev-sec/puppet-os-hardening/master/manifests/minimize_access.pp
#   Copyright 2014, Deutsche Telekom AG
#   Licensed under the Apache License, Version 2.0 (the "License");
#   http://www.apache.org/licenses/LICENSE-2.0
#
# @example
#   include almalinux_hardening::optional::home_permissions
class almalinux_hardening::optional::home_permissions {
  if $almalinux_hardening::enable_optional_home_permissions {
    $definitive_home_users = difference($facts['home_users'],$almalinux_hardening::ignore_home_users)
    $definitive_home_users.each | $home | {
      file { $home:
        ensure       => directory,
        links        => follow,
        mode         => '0750',
        recurse      => true,
        recurselimit => 5,
      }
    }

    exec { 'home_permissions_ownership':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'egrep -v \"^\\+\" /etc/passwd | awk -F: \'($6!="/" && $3>=1000) {system("chown -R "$3":"$4" "$6)}\'',
      onlyif  => 'egrep -v \"^\\+\" /etc/passwd | awk -F: \'($6!="/" && $3>=1000) {system("if [[ $(stat -L -c \"%U\" "$6") == "$1" ]]; then echo 0; else echo 1; fi")}\' | grep -P ^1$',
    }
  }
}
