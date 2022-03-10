# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# frozen_string_literal: true

Facter.add(:daemons_unconfined) do
  # https://puppet.com/docs/puppet/latest/fact_overview.html
  setcode do
    unconfined = Facter::Core::Execution.execute("ps -eZ | grep 'unconfined_service_t' | awk '{print \$5}' | sort | uniq | tr '\n' ' '")
    if unconfined.empty?
      'None'
    else
      unconfined.split(' ')
    end
  end
end
