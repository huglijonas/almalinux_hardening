# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Verify Permissions on SSH Server Public *.pub Key Files
#
# @description
#   To properly set the permissions of /etc/ssh/*.pub, run the command:
#   $ sudo chmod 0644 /etc/ssh/*.pub
#
# @rationale
#   If a public host key file is modified by an unauthorized user, the SSH
#   service may be compromised.
#
# @example
#   include almalinux_hardening::services::ssh::keys
class almalinux_hardening::services::ssh::keys {
  if $almalinux_hardening::enable_ssh_keys {
    exec { 'ssh_keys':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => 'find /etc/ssh -name "*.pub" -type f -not -perm 640 -exec chmod 0640 {} \;',
      unless  => 'find /etc/ssh -name "*.pub" -type f -not -perm 640 | wc -l | grep -q -E "^0$"',
    }
  }
}
