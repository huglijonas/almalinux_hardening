# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Restrict Root Logins
#
# @description - Verify Only Root Has UID 0
#         If any account other than root has a UID of 0, this misconfiguration should be
#   investigated and the accounts other than root should be removed or have their
#   UID changed.
#   If the account is associated with system commands or applications the UID should
#   be changed to one greater than "0" but less than "1000." Otherwise assign a UID
#   greater than "1000" that has not already been assigned.
#
# @rationale - Verify Only Root Has UID 0
#         An account has root authority if it has a UID of 0. Multiple accounts with a UID
#   of 0 afford more opportunity for potential intruders to guess a password for a
#   privileged account. Proper configuration of sudo is recommended to afford multiple
#   system administrators access to root privileges in an accountable manner.
#
# @description - Ensure that System Accounts Do Not Run a Shell Upon Login
#   Some accounts are not associated with a human user of the system, and exist to
#   perform some administrative function. Should an attacker be able to log into these
#   accounts, they should not be granted access to a shell.
#   The login shell for each local account is stored in the last field of each line in
#   /etc/passwd. System accounts are those user accounts with a user ID less than UID_MIN,
#   where value of UID_MIN directive is set in /etc/login.defs configuration file. In the
#   default configuration UID_MIN is set to 1000, thus system accounts are those user accounts
#   with a user ID less than 1000. The user ID is stored in the third field. If any system
#   account SYSACCT (other than root) has a login shell, disable it with the command:
#   $ sudo usermod -s /sbin/nologin SYSACCT
#
# @rationale - Ensure that System Accounts Do Not Run a Shell Upon Login
#         Ensuring shells are not given to system accounts upon login makes it more difficult for
#   attackers to make use of system accounts.
#
# @description - Enforce usage of pam_wheel for su authentication
#   To ensure that only users who are members of the wheel group can run commands with altered
#   privileges through the su command, make sure that the following line exists in the file
#   /etc/pam.d/su:
#   auth             required        pam_wheel.so use_uid
#
# @rationale - Enforce usage of pam_wheel for su authentication
#   The su program allows to run commands with a substitute user and group ID. It is commonly
#   used to run commands as the root user. Limiting access to such command is considered a
#   good security practice.
#
# @example
#   include almalinux_hardening::system::aac::pwd_login::root
class almalinux_hardening::system::aac::pwd_login::root {
  if $almalinux_hardening::enable_pwdlogin_root_uid_exec {
    exec { 'root_uid_exec':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "awk -F: '(\$3 == 0) {print \$1}\' /etc/passwd | sed '/^${almalinux_hardening::root_account}\$/d' | xargs -L 1 -I '{}' sed -i '/^{}/d' /etc/passwd",
      unless  => "awk -F: '(\$3 == 0) {print \$1}\' /etc/passwd | wc -l | grep -q -E \'^1\$'",
    }
  }

  if $almalinux_hardening::enable_pwdlogin_root_nologin_exec {
    $ignore_home_users = join($almalinux_hardening::ignore_home_users,' ')
    exec { 'nologin_exec':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "egrep -v \"^\\+\" /etc/passwd | awk -F: '((${ignore_home_users})!~\"\^\$1\$\" && \$1!=\"${almalinux_hardening::root_account}\" && \$1!=\"sync\" && \$1!=\"shutdown\" && \$1!=\"halt\" && \$3<1000 && \$7!~\"/sbin/nologin\" && \$7!=\"/bin/false\") {print}' | awk -F: '{print \$1}' | xargs -L 1 -I % usermod -s ${almalinux_hardening::nologin_shell} % &>/dev/null",
      unless  => "egrep -v \"^\\+\" /etc/passwd | awk -F: '((${ignore_home_users})!~\"\^\$1\$\" && \$1!=\"${almalinux_hardening::root_account}\" && \$1!=\"sync\" && \$1!=\"shutdown\" && \$1!=\"halt\" && \$3<1000 && \$7!~\"/sbin/nologin\" && \$7!=\"/bin/false\") {print}' | wc -l | grep -q -E '^0$'",
    }
  }

  if $almalinux_hardening::enable_pwdlogin_root_su_restriction {
    file_line { 'su_restriction':
      ensure            => 'present',
      path              => '/etc/pam.d/su',
      line              => 'auth            required        pam_wheel.so use_uid',
      match             => '^(#|).*auth\s*[a-zA-Z]*\s*pam_wheel.so use_uid.*$',
      match_for_absence => true,
    }
  }
}
