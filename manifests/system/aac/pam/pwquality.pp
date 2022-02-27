# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure PAM Enforces Password Requirement
#
# @description - Minimum Different Categories
#	  The pam_pwquality module's minclass parameter controls requirements for usage
#   of different character classes, or types, of character that must exist in a
#   password before it is considered valid. For example, setting this value to three
#   (3) requires that any password must have characters from at least three different
#   categories in order to be approved. The default value is zero (0), meaning there
#   are no required classes. There are four categories available:
#   * Upper-case characters
#   * Lower-case characters
#   * Digits
#   * Special characters (for example, punctuation)
#   Modify the minclass setting in /etc/security/pwquality.conf entry to require 4
#   differing categories of characters when changing passwords.
#
# @rationale - Minimum Different Categories
#   Use of a complex password helps to increase the time and resources required to
#   compromise the password. Password complexity, or strength, is a measure of the
#   effectiveness of a password in resisting attempts at guessing and brute-force
#   attacks.
#   Password complexity is one factor of several that determines how long it takes
#   to crack a password. The more complex the password, the greater the number of
#   possible combinations that need to be tested before the password is compromised.
#   Requiring a minimum number of character categories makes password guessing attacks
#   more difficult by ensuring a larger search space.
#
#
# @description - Minimum Length
#   The pam_pwquality module's minlen parameter controls requirements for minimum
#   characters required in a password. Add minlen=14 after pam_pwquality to set minimum
#   password length requirements.
#
# @rationale - Minimum Length
#   The shorter the password, the lower the number of possible combinations that need
#   to be tested before the password is compromised.
#   Password complexity, or strength, is a measure of the effectiveness of a password
#   in resisting attempts at guessing and brute-force attacks. Password length is one
#   factor of several that helps to determine strength and how long it takes to crack a
#   password. Use of more characters in a password helps to exponentially increase the
#   time and/or resources required to compromose the password.
#
#
# @description - Authentication Retry Prompts Permitted Per-Session
#   To configure the number of retry prompts that are permitted per-session: Edit the
#   pam_pwquality.so statement in /etc/pam.d/system-auth to show retry=3, or a lower
#   value if site policy is more restrictive. The DoD requirement is a maximum of 3
#   prompts per session.
#
# @rationale - Authentication Retry Prompts Permitted Per-Session
#   Setting the password retry prompts that are permitted on a per-session basis to a
#   low value requires some software, such as SSH, to re-connect. This can slow down
#   and draw additional attention to some types of password-guessing attacks. Note that
#   this is different from account lockout, which is provided by the pam_faillock module.
#
# @example
#   include almalinux_hardening::system::aac::pam::pwquality
class almalinux_hardening::system::aac::pam::pwquality {
  if $almalinux_hardening::enable_pam_pwquality {
    package { 'libpwquality':
      ensure          => latest,
      install_options => ['--disablerepo',$almalinux_hardening::disable_repos,'--enablerepo',$almalinux_hardening::enable_repos],
    }
    -> File_line <| path == '/etc/security/pwquality.conf' |>
    file_line { 'pam minlen':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "minlen = ${almalinux_hardening::pam_pwquality_minlen}",
      match  => '^(#|).*minlen.*=',
    }
    file_line { 'pam minclass':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "minclass = ${almalinux_hardening::pam_pwquality_minclass}",
      match  => '^(#|).*minclass.*=',
    }
    file_line { 'pam dcredit':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "dcredit = ${almalinux_hardening::pam_pwquality_dcredit}",
      match  => '^(#|).*dcredit.*=',
    }
    file_line { 'pam ucredit':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "ucredit = ${almalinux_hardening::pam_pwquality_ucredit}",
      match  => '^(#|).*ucredit.*=',
    }
    file_line { 'pam ocredit':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "ocredit = ${almalinux_hardening::pam_pwquality_ocredit}",
      match  => '^(#|).*ocredit.*=',
    }
    file_line { 'pam lcredit':
      ensure => 'present',
      path   => '/etc/security/pwquality.conf',
      line   => "lcredit = ${almalinux_hardening::pam_pwquality_lcredit}",
      match  => '^(#|).*lcredit.*=',
    }

    $almalinux_hardening::pam_services.each | $service | {
      pam { "pam_pwquality ${service}":
        ensure    => present,
        service   => $service,
        type      => 'password',
        control   => 'requisite',
        module    => 'pam_pwquality.so',
        arguments => ['try_first_pass', "retry=${almalinux_hardening::pam_pwd_reuse_retry}"]
      }
    }
  }
}
