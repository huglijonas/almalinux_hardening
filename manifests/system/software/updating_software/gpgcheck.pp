# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure gpgcheck Enabled In Main yum Configuration
#
# @description
#   The gpgcheck option controls whether RPM packages' signatures are always checked
#   prior to installation. To configure yum to check package signatures before installing
#   them, ensure the following line appears in /etc/yum.conf in the [main] section:
#   gpgcheck=1
#
# @rationale
#   Changes to any software components can have significant effects on the overall security
#   of the operating system. This requirement ensures the software has not been tampered with
#   and that it has been provided by a trusted vendor.
#   Accordingly, patches, service packs, device drivers, or operating system components must be
#   signed with a certificate recognized and approved by the organization.
#   Verifying the authenticity of the software prior to installation validates the integrity of
#   the patch or upgrade received from a vendor. This ensures the software has not been tampered
#   with and that it has been provided by a trusted vendor. Self-signed certificates are disallowed
#   by this requirement. Certificates used to verify the software must be from an approved Certificate
#   Authority (CA).
#
# @example
#   include almalinux_hardening::system::software::updating_software::gpgcheck
class almalinux_hardening::system::software::updating_software::gpgcheck {
  if $almalinux_hardening::enable_gpgcheck {
    file_line { 'gpgcheck':
      ensure => present,
      path   => '/etc/yum.conf',
      line   => 'gpgcheck=1',
      match  => '^(#|).*gpgcheck.*=',
    }
  }
}
