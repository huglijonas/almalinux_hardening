# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Modify the System Login Banner
#
# @description
#	  To configure the system login banner edit /etc/issue. Replace the default text with
#   a message compliant with the local site policy or a legal disclaimer.
#
# @rationale
#   Display of a standardized and approved use notification before granting access
#   to the operating system ensures privacy and security notification verbiage used
#   is consistent with applicable federal laws, Executive Orders, directives, policies,
#   regulations, standards, and guidance.
#   System use notifications are required only for access via login interfaces with human
#   users and are not required when such human interfaces do not exist.
#
# @example
#   include almalinux_hardening::system::aac::banners::login
class almalinux_hardening::system::aac::banners::login {
  if $almalinux_hardening::enable_banner_issue {
    $almalinux_hardening::banner_issue_files.each | $file | {
      file { "banner_issue ${file}":
        ensure => file,
        path   => $file,
        source => 'puppet:///modules/almalinux_hardening/issue',
        mode   => '0644',
        owner  => 'root',
        group  => 'root',
      }
    }
  }
}
