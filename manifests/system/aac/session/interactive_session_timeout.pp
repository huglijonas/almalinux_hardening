# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary
#   Set Interactive Session Timeout
#
# @description
#   Setting the TMOUT option in /etc/profile ensures that all user sessions will
#   terminate based on inactivity. The TMOUT setting in a file loaded by /etc/profile,
#   e.g. /etc/profile.d/tmout.sh should read as follows:
#   TMOUT=900
#
# @rationale
#   Terminating an idle session within a short time period reduces the window of
#   opportunity for unauthorized personnel to take control of a management session
#   enabled on the console or console port that has been left unattended.
#
# @example
#   include almalinux_hardening::system::aac::session::interactive_session_timeout
class almalinux_hardening::system::aac::session::interactive_session_timeout {
  if $almalinux_hardening::enable_session_interactive_timeout {
    $almalinux_hardening::session_interactive_timeout_paths.each | $path | {
      case $path {
        '/etc/profile': {
          file_line { "${path}_session_timeout":
            ensure                                => present,
            path                                  => $path,
            line                                  => "TMOUT=${almalinux_hardening::session_interactive_timeout_seconds}",
            match                                 => '^(#|).*TMOUT.*=.*$',
            replace_all_matches_not_matching_line => true,
          }
          file_line { "${path}_readonly_session_timeout":
            ensure                                => present,
            path                                  => $path,
            line                                  => 'readonly TMOUT',
            match                                 => '^(#|).*readonly TMOUT.*$',
            after                                 => '^(#|).*TMOUT.*=.*$',
            replace_all_matches_not_matching_line => true,
          }
          file_line { "${path}_export_session_timeout":
            ensure                                => present,
            path                                  => $path,
            line                                  => 'export TMOUT',
            match                                 => '^(#|).*export TMOUT.*$',
            after                                 => '^(#|).*readonly TMOUT.*$',
            replace_all_matches_not_matching_line => true,
          }
        }
        '/etc/bashrc': {
          file_line { "${path}_session_timeout":
            ensure                                => present,
            path                                  => $path,
            line                                  => "  TMOUT=${almalinux_hardening::session_interactive_timeout_seconds}",
            match                                 => '^(#|).*TMOUT.*=.*$',
            after                                 => '^(#|).*BASHRCSOURCED.*=.*\".*\"$',
            replace_all_matches_not_matching_line => true,
          }
          file_line { "${path}_export_session_timeout":
            ensure                                => present,
            path                                  => $path,
            line                                  => '  export TMOUT',
            match                                 => '^(#|).*export TMOUT.*$',
            after                                 => '^(#|).*TMOUT.*=.*$',
            replace_all_matches_not_matching_line => true,
          }
        }
      }
    }
  }
}
