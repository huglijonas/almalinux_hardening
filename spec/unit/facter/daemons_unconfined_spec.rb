# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/daemons_unconfined'

describe :daemon_unconfined, type: :fact do
  subject(:fact) { Facter.fact(:daemons_unconfined) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    expect(fact.value).to eq('None').or be_an_instance_of(Array)
  end
end
