# frozen_string_literal: true

require 'spec_helper'

describe 'almalinux_hardening::system::files_perm_masks::important::account_info::shadow' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end
end
