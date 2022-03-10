# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Configure SELinux Policy
#
# @description
#   The SELinux targeted policy is appropriate for general-purpose desktops and
#   servers, as well as systems in many other roles. To configure the system to
#   use this policy, add or correct the following line in /etc/selinux/config:
#   SELINUXTYPE=targeted
#   Other policies, such as mls, provide additional security labeling and greater
#   confinement but are not compatible with many general-purpose use cases.
#
# @rationale
#   Setting the SELinux policy to targeted or a more specialized policy ensures
#   the system will confine processes that are likely to be targeted for
#   exploitation, such as network or system services.
#   Note: During the development or debugging of SELinux modules, it is common
#   to temporarily place non-production systems in permissive mode. In such
#   temporary cases, SELinux policies should be developed, and once work is
#   completed, the system should be reconfigured to targeted.
#
# @example
#   include almalinux_hardening::system::selinux::policy
class almalinux_hardening::system::selinux::policy {
  if $almalinux_hardening::enable_selinux_policy {
    file_line { 'selinux_policy':
      ensure => 'present',
      path   => '/etc/selinux/config',
      line   => 'SELINUXTYPE=targeted',
      match  => '^(#|).*SELINUXTYPE.*=',
    }
  }
}
