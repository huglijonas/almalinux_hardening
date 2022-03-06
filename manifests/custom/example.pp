# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Custom rule summary
#
# @description
#   Custom rule description
#
# @rationale
#   Custom rule rationale
#
# @example
#   include almalinux_hardening::custom::example
class almalinux_hardening::custom::example {
  notify { 'Example rule':
    message  => 'You activated the example rule...',
    loglevel => 'info',
  }
}
