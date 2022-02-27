# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Disable Core Dumps for SUID programs
#
# @description
#   To set the runtime status of the fs.suid_dumpable kernel parameter, run the
#   following command:
#   $ sudo sysctl -w fs.suid_dumpable=0
#   To make sure that the setting is persistent, add the following line to a file
#   in the directory /etc/sysctl.d:
#   fs.suid_dumpable = 0
#
# @rationale
#	  The core dump of a setuid program is more likely to contain sensitive data,
#   as the program itself runs with greater privileges than the user who initiated
#   execution of the program. Disabling the ability for any setuid program to write
#   a core file decreases the risk of unauthorized access of such data.
#
# @example
#   include almalinux_hardening::system::files_perm_masks::core_dumps::suid_programs
class almalinux_hardening::system::files_perm_masks::core_dumps::suid_programs {
  if $almalinux_hardening::enable_coredumps_uid_programs {
    sysctl { 'fs.suid_dumpable':
      ensure => 'present',
      value  => '0',
    }
  }
}
