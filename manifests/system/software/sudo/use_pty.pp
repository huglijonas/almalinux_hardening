# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure Only Users Logged In To Real tty Can Execute Sudo - sudo use_pty
#
# @description
#   The sudo use_pty tag, when specified, will only execute sudo commands from users
#   logged in to a real tty. This should be enabled by making sure that the use_pty
#   tag exists in /etc/sudoers configuration file or any sudo configuration snippets
#   in /etc/sudoers.d/.
#
# @rationale
#	  Requiring that sudo commands be run in a pseudo-terminal can prevent an attacker
#   from retaining access to the user's terminal after the main program has finished
#   executing.
#
# @example
#   include almalinux_hardening::system::software::disksoftware::sudo::use_pty
class almalinux_hardening::system::software::sudo::use_pty {
  if $almalinux_hardening::enable_sudo_use_pty {
    file_line { 'sudo_use_pty':
      path  => '/etc/sudoers',
      line  => 'Defaults use_pty',
      match => '^(#|).*Defaults\s*use_pty.*=.*',
    }
  }
}
