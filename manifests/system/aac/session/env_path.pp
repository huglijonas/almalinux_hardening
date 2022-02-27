# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Ensure that No Dangerous Directories Exist in Root's Path
#
# @description - Ensure that Root's Path Does Not Include World or Group-Writable Directories
#	  For each element in root's path, run:
#   # ls -ld DIR
#   and ensure that write permissions are disabled for group and other.
#
# @rationale - Ensure that Root's Path Does Not Include World or Group-Writable Directories
#	  Such entries increase the risk that root could execute code provided by unprivileged users,
#   and potentially malicious code.
#
# @description - Ensure that Root's Path Does Not Include Relative Paths or Null Directories
#   Ensure that none of the directories in root's path is equal to a single . character, or
#   that it contains any instances that lead to relative path traversal, such as .. or
#   beginning a path without the slash (/) character. Also ensure that there are no "empty"
#   elements in the path, such as in these examples:
#   PATH=:/bin
#   PATH=/bin:
#   PATH=/bin::/sbin
#   These empty elements have the same effect as a single . character.
#
# @rationale - Ensure that Root's Path Does Not Include Relative Paths or Null Directories
#	  Including these entries increases the risk that root could execute code from an untrusted
#   location.
#
# @example
#   include almalinux_hardening::system::aac::session::env_path
class almalinux_hardening::system::aac::session::env_path {
  if $almalinux_hardening::enable_session_env_path {
    exec { 'root_env_path_worldwritable':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "echo ${facts['path']} | tr \":\" \"\n\" | xargs -I % find % -type d -perm -755 ! -perm 755 -exec chmod -R g-w,o-w {} \;",
      unless  => "echo ${facts['path']} | tr \":\" \"\n\" | xargs -I % find % -type d -perm -755 ! -perm 755 -print | wc -l | grep -q -E '^0\$'",
    }

    exec { 'root_env_path_integrity_exec':
      path    => '/usr/bin:/bin:/usr/sbin',
      command => "wall \"Error in $facts['path']\"",
      onlyif  => "echo $facts['path'] | grep -qE '(^:|::|:[a-zA-Z0-9]|\.|:$)'",
    }
  }
}
