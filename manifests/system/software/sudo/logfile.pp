# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure Sudo Logfile Exists - sudo logfile
#
# @description
#   A custom log sudo file can be configured with the 'logfile' tag. This rule
#   configures a sudo custom logfile at the default location suggested by CIS,
#   which uses /var/log/sudo.log.
#
# @rationale
#	  A sudo log file simplifies auditing of sudo commands.
#
# @example
#   include almalinux_hardening::system::software::disksoftware::sudo::logfile
class almalinux_hardening::system::software::sudo::logfile {
  if $almalinux_hardening::enable_sudo_logfile {
    file_line { 'sudo_log':
      path  => '/etc/sudoers',
      line  => "Defaults logfile=${almalinux_hardening::sudo_logfile}",
      match => '^(#|).*Defaults\s+logfile.*=.*',
    }
  }
}
