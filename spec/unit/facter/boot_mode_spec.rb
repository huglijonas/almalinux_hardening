# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/boot_mode'

describe :boot_mode, type: :fact do
  subject(:fact) { Facter.fact(:boot_mode) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to match(/^(UEFI|BIOS)$/)
  end
end
