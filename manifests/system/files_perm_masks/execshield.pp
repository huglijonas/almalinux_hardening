# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Enable Randomized Layout of Virtual Address Space
#
# @description
#   To set the runtime status of the kernel.randomize_va_space kernel parameter,
#   run the following command:
#   $ sudo sysctl -w kernel.randomize_va_space=2
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   kernel.randomize_va_space = 2
#
# @rationale
#	  Address space layout randomization (ASLR) makes it more difficult for an
#   attacker to predict the location of attack code they have introduced into a
#   process's address space during an attempt at exploitation. Additionally, ASLR
#   makes it more difficult for an attacker to know the location of existing code
#   in order to re-purpose it using return oriented programming (ROP) techniques.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::execshield
class almalinux_hardening::system::files_perm_masks::execshield {
  if $almalinux_hardening::enable_execshield {
    sysctl { 'kernel.randomize_va_space':
      ensure => 'present',
      value  => '2',
    }
  }
}
