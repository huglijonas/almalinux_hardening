# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# frozen_string_literal: true

Facter.add(:boot_cfg) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    Facter::Core::Execution.execute('find /boot -name "grub*.cfg"')
  end
end
