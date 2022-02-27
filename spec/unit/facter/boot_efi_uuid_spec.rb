# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/boot_efi_uuid'

describe :boot_efi_uuid, type: :fact do
  subject(:fact) { Facter.fact(:boot_efi_uuid) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to match(/^UUID=[a-fA-F0-9-]*$/)
  end
end
