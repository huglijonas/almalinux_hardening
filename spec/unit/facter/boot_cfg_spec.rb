# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/boot_cfg'

describe :boot_cfg, type: :fact do
  subject(:fact) { Facter.fact(:boot_cfg) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to exist(fact.value)
  end
end
