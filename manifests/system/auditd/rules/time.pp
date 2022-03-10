# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary - adjtimex & clock_settime
#   Record attempts to alter time through adjtimex & clock_settime
#
# @description - adjtimex & clock_settime
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following line to a file
#   with suffix .rules in the directory /etc/audit/rules.d:
#   -a always,exit -F arch=b32 -S <action> -F a0=0x0 -F key=time-change
#   If the system is 64 bit then also add the following line:
#   -a always,exit -F arch=b64 -S <action> -F a0=0x0 -F key=time-change
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file:
#   -a always,exit -F arch=b32 -S <action> -F a0=0x0 -F key=time-change
#   If the system is 64 bit then also add the following line:
#   -a always,exit -F arch=b64 -S <action> -F a0=0x0 -F key=time-change
#   The -k option allows for the specification of a key in string form that can
#   be used for better reporting capability through ausearch and aureport. Multiple
#   system calls can be defined on the same line to save space if desired, but is
#   not required. See an example of multiple combined syscalls:
#   -a always,exit -F arch=b64 -S <action>,settimeofday -F key=audit_time_rules
#
# @rationale - adjtimex & clock_settime
#   Arbitrary changes to the system time can be used to obfuscate nefarious
#   activities in log files, as well as to confuse network services that are
#   highly dependent upon an accurate system time (such as sshd). All changes to
#   the system time should be audited.
#
# @summary - stime
#   Record Attempts to Alter Time Through stime
#
# @description - stime
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following line to a file
#   with suffix .rules in the directory /etc/audit/rules.d for both 32 bit and
#   64 bit systems:
#   -a always,exit -F arch=b32 -S stime -F key=audit_time_rules
#   Since the 64 bit version of the "stime" system call is not defined in the audit
#   lookup table, the corresponding "-F arch=b64" form of this rule is not expected
#   to be defined on 64 bit systems (the aforementioned "-F arch=b32" stime rule
#   form itself is sufficient for both 32 bit and 64 bit systems). If the auditd
#   daemon is configured to use the auditctl utility to read audit rules during
#   daemon startup, add the following line to /etc/audit/audit.rules file for both
#   32 bit and 64 bit systems:
#   -a always,exit -F arch=b32 -S stime -F key=audit_time_rules
#   Since the 64 bit version of the "stime" system call is not defined in the audit
#   lookup table, the corresponding "-F arch=b64" form of this rule is not expected
#   to be defined on 64 bit systems (the aforementioned "-F arch=b32" stime rule
#   form itself is sufficient for both 32 bit and 64 bit systems). The -k option
#   allows for the specification of a key in string form that can be used for better
#   reporting capability through ausearch and aureport. Multiple system calls can be
#   defined on the same line to save space if desired, but is not required. See an
#   example of multiple combined system calls:
#   -a always,exit -F arch=b64 -S adjtimex,settimeofday -F key=audit_time_rules
#
# @rationale - stime
#   Arbitrary changes to the system time can be used to obfuscate nefarious
#   activities in log files, as well as to confuse network services that are highly
#   dependent upon an accurate system time (such as sshd). All changes to the system
#   time should be audited.
#
# @summary - localtime
#   Record Attempts to Alter the localtime File
#
# @description - localtime
#   If the auditd daemon is configured to use the augenrules program to read audit
#   rules during daemon startup (the default), add the following line to a file
#   with suffix .rules in the directory /etc/audit/rules.d:
#   -w /etc/localtime -p wa -k audit_time_rules
#   If the auditd daemon is configured to use the auditctl utility to read audit
#   rules during daemon startup, add the following line to /etc/audit/audit.rules
#   file:
#   -w /etc/localtime -p wa -k audit_time_rules
#   The -k option allows for the specification of a key in string form that can be
#   used for better reporting capability through ausearch and aureport and should
#   always be used.
#
# @rationale - localtime
#   Arbitrary changes to the system time can be used to obfuscate nefarious
#   activities in log files, as well as to confuse network services that are highly
#   dependent upon an accurate system time (such as sshd). All changes to the system
#   time should be audited.
#
# @example
#   include almalinux_hardening::system::auditd::rules::time
class almalinux_hardening::system::auditd::rules::time inherits almalinux_hardening::system::auditd::service {
  if $almalinux_hardening::enable_auditd_rules_time {
    $almalinux_hardening::auditd_rules_time_actions.each | $action | {
      $almalinux_hardening::auditd_arch.each | $arch | {
        file_line { "time_${auditd_program}_${action}_${arch}":
          ensure => present,
          path   => $almalinux_hardening::auditd_rules_file,
          line   => "-a always,exit -F arch=b${arch} -S ${action} -F key=audit_time_rules",
        } ~> Service['auditd']
      }
    }
    $almalinux_hardening::auditd_rules_time_paths.each | $path | {
      file_line { "time_${auditd_program}_${path}":
        ensure => present,
        path   => $almalinux_hardening::auditd_rules_file,
        line   => "-w ${path} -p wa -k audit_time_rules",
      } ~> Service['auditd']
    }

    $almalinux_hardening::auditd_arch.each | $arch | {
      file_line { "time_${$arch}_clock_settime":
        ensure => present,
        path   => $almalinux_hardening::auditd_rules_file,
        line   => "-a always,exit -F arch=b${arch} -S clock_settime -F a0=0x0 -F key=time-change",
      } ~> Service['auditd']
    }
  }
}
