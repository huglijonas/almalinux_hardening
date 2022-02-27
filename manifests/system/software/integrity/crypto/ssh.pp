# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Configure SSH to use System Crypto Policy
#
# @description
#   Crypto Policies provide a centralized control over crypto algorithms usage of
#   many packages. SSH is supported by crypto policy, but the SSH configuration may
#   be set up to ignore it. To check that Crypto Policies settings are configured
#   correctly, ensure that the CRYPTO_POLICY variable is either commented or not set
#   at all in the /etc/sysconfig/sshd.
#
# @rationale
#   Overriding the system crypto policy makes the behavior of the SSH service
#   violate expectations, and makes system configuration more fragmented.
#
# @example
#   include almalinux_hardening::system::software::integrity::crypto::ssh
class almalinux_hardening::system::software::integrity::crypto::ssh {
  if $almalinux_hardening::enable_integrity_crypto_ssh {
    file_line { 'ssh_crypto_policy':
      ensure            => 'present',
      path              => '/etc/sysconfig/sshd',
      line              => '# CRYPTO_POLICY = ',
      match             => '^(#|).*CRYPTO_POLICY.*=$',
      match_for_absence => true,
    }
  }
}
