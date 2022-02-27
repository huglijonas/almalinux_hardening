# frozen_string_literal: true
# Author: PenguinFreeDom
# URL: https://raw.githubusercontent.com/dev-sec/puppet-os-hardening/master/lib/facter/home_users.rb

# Try to read UID_MIN from /etc/login.defs to caluclate SYS_UID_MAX
# if that fails set some predefined values based on os_family fact.
logindefs = '/etc/login.defs'

if File.exist?(logindefs)
  su_maxid = File.readlines(logindefs).each do |line|
    break Regexp.last_match[1].to_i - 1 if line =~ %r{^\s*UID_MIN\s+(\d+)(\s*#.*)?$}
  end
else
  su_maxid = 1000
end

# Retrieve all system users and build custom fact with the usernames
# using comma separated values.
Facter.add(:home_users) do
  home_users = []
  Etc.passwd do |u|
    home_users.push(u.dir) if u.uid >= su_maxid && u.uid <= 60_000 && u.dir !~ /^\/$/
  end

  setcode do
    home_users
  end
end
