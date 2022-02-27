# frozen_string_literal: true

require 'spec_helper'
require 'facter'
require 'facter/home_users'

describe :home_users, type: :fact do
  subject(:fact) { Facter.fact(:home_users) }

  before :each do
    # perform any action that should be run before every test
    Facter.clear
  end

  it 'returns a value' do
    (fact.value).each do |home|
      expect(home).to exist(home)
    end
  end
end
