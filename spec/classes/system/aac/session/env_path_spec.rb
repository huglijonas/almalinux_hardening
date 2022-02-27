# frozen_string_literal: true

require 'spec_helper'

describe 'almalinux_hardening::system::aac::session::env_path' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
