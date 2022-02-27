# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Modify the System Message of the Day Banner
#
# @description
#   To configure the system message banner edit /etc/motd. Replace the default text with
#   a message compliant with the local site policy or a legal disclaimer.
#
# @rationale
#	  Display of a standardized and approved use notification before granting access
#   to the operating system ensures privacy and security notification verbiage used
#   is consistent with applicable federal laws, Executive Orders, directives, policies,
#   regulations, standards, and guidance.
#   System use notifications are required only for access via login interfaces with human
#   users and are not required when such human interfaces do not exist.
#
# @example
#   include almalinux_hardening::system::aac::banners::motd
class almalinux_hardening::system::aac::banners::motd {
  if $almalinux_hardening::enable_banner_motd {
    file { 'banner_motd':
      ensure  => file,
      path    => '/etc/motd',
      content => template('almalinux_hardening/motd.erb'),
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
    }
  }
}
