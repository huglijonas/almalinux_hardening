# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Configure Periodic Execution of AIDE
#
# @description
#   At a minimum, AIDE should be configured to run a weekly scan. To implement a daily
#   execution of AIDE at 4:05am using cron, add the following line to /etc/crontab:
#   05 4 * * * root /usr/sbin/aide --check
#
#   To implement a weekly execution of AIDE at 4:05am using cron, add the following line
#   to /etc/crontab:
#   05 4 * * 0 root /usr/sbin/aide --check
#
#   AIDE can be executed periodically through other means; this is merely one example. The usage
#   of cron's special time codes, such as @daily and @weekly is acceptable.
#
# @rationale
#   By default, AIDE does not install itself for periodic execution. Periodically running
#   AIDE is necessary to reveal unexpected changes in installed files. Unauthorized changes
#   to the baseline configuration could make the system vulnerable to various attacks or allow
#   unauthorized access to the operating system. Changes to operating system configurations can
#   have unintended side effects, some of which may be relevant to security. Detecting such changes
#   and providing an automated response can help avoid unintended, negative consequences that could
#   ultimately affect the security state of the operating system. The operating system's Information
#   Management Officer (IMO)/Information System Security Officer (ISSO) and System Administrators (SAs)
#   must be notified via email and/or monitoring system trap when there is an unauthorized modification
#   of a configuration item.
#
# @example
#   include almalinux_hardening::system::software::integrity::aide::periodic_execution
class almalinux_hardening::system::software::integrity::aide::periodic_execution {
  if $almalinux_hardening::enable_integrity_aide_periodic_execution {
    cron { 'aide_cron':
      ensure   => present,
      command  => 'root /usr/sbin/aide --check',
      user     => 'root',
      minute   => $almalinux_hardening::integrity_aide_periodic_execution_minute,
      hour     => $almalinux_hardening::integrity_aide_periodic_execution_hour,
      monthday => $almalinux_hardening::integrity_aide_periodic_execution_monthday,
      month    => $almalinux_hardening::integrity_aide_periodic_execution_month,
      weekday  => $almalinux_hardening::integrity_aide_periodic_execution_weekday,
    }
  }
}
