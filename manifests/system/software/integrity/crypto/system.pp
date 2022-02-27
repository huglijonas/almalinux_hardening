# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Configure System Cryptography Policy
#
# @description
#	  To configure the system cryptography policy to use ciphers only from the DEFAULT
#   policy, run the following command:
#   $ sudo update-crypto-policies --set DEFAULT
#   The rule checks if settings for selected crypto policy are configured as expected.
#   Configuration files in the /etc/crypto-policies/back-ends are either symlinks to
#   correct files provided by Crypto-policies package or they are regular files in case
#   crypto policy customizations are applied. Crypto policies may be customized by crypto
#   policy modules, in which case it is delimited from the base policy using a colon.
#
# @rationale
#   Centralized cryptographic policies simplify applying secure ciphers across an operating
#   system and the applications that run on that operating system. Use of weak or untested
#   encryption algorithms undermines the purposes of utilizing encryption to protect data.
#
# @example
#   include almalinux_hardening::system::software::integrity::crypto::system
class almalinux_hardening::system::software::integrity::crypto::system {
  if $almalinux_hardening::enable_integrity_crypto_system {
    exec { 'crypto_policies_set':
      path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin',
      command => 'update-crypto-policies --show | sed "s/\(LEGACY\|FIPS\)/DEFAULT/g" | xargs -I % update-crypto-policies --set %',
      unless  => "update-crypto-policies --show | grep -qE '^DEFAULT(:|).*$'",
    }
  }
}
