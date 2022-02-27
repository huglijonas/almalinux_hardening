# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set PAM's Password Hashing Algorithm
#
# @description
#	  The PAM system service can be configured to only store encrypted representations
#   of passwords. In /etc/pam.d/system-auth, the password section of the file controls
#   which PAM modules execute during a password change. Set the pam_unix.so module in
#   the password section to include the argument sha512, as shown below:
#   password    sufficient    pam_unix.so sha512 other arguments...
#   This will help ensure when local users change their passwords, hashes for the new
#   passwords will be generated using the SHA-512 algorithm. This is the default.
#
# @rationale
#   Passwords need to be protected at all times, and encryption is the standard method
#   for protecting passwords. If passwords are not encrypted, they can be plainly read
#   (i.e., clear text) and easily compromised. Passwords that are encrypted with a weak
#   algorithm are no more protected than if they are kepy in plain text.
#   This setting ensures user and group account administration utilities are configured
#   to store only encrypted representations of passwords. Additionally, the crypt_style
#   configuration option ensures the use of a strong hashing algorithm that makes password
#   cracking attacks more difficult.
#
# @example
#   include almalinux_hardening::system::aac::pam::pwd_hashing_algorithm
class almalinux_hardening::system::aac::pam::pwd_hashing_algorithm {
  if $almalinux_hardening::enable_pam_pwd_hashing_algorithm {
    pam { 'pam_hashing_algorithm':
      ensure    => present,
      service   => 'system-auth',
      type      => 'password',
      control   => 'sufficient',
      module    => 'pam_unix.so',
      arguments => ['try_first_pass', 'use_authtok', 'nullok', 'sha512', 'shadow'],
      position  => 'after *[type="password" and module="pam_pwquality.so" and control="requisite"]',
    }
  }
}
