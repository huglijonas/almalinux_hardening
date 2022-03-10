# Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
# Copyright (C) 2022  Jonas Hügli
#
# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include almalinux_hardening
class almalinux_hardening (
  Enum['server']            $profile                              = 'server',
  Enum['1', '2', 'custom']  $level                                = '1',
  Array[String]             $server_level_1                       = [],
  Array[String]             $server_level_2                       = [],
  Array[String]             $server_custom_level                  = [],
  Array[String]             $pam_services                         = ['password-auth','system-auth'],
  String                    $root_account                         = 'root',
  String                    $nologin_shell                        = '/sbin/nologin',
  String                    $home_device                          = '/dev/mapper/vg-home',
  String                    $tmp_device                           = '/dev/mapper/vg-tmp',
  String                    $vartmp_device                        = '/dev/mapper/vg-var-tmp',
  Array[String]             $gui_packages                         = ['xorg-x11-server-Xorg','xorg-x11-server-common','xorg-x11-server-utils','xorg-x11-server-Xwayland'],
  Array[String]             $time_servers                         = ['time.google.com'],
  Array[String]             $ignore_system_users                  = [],
  Array[String]             $ignore_home_users                    = [''],
  String                    $disable_repos                        = '',
  String                    $enable_repos                         = '',
  Boolean                   $mountoptions_vartmp_partitioned      = true,
  Enum['augenrules','auditctl'] $auditd_rules_program             = 'augenrules',

  # Level 1
  Boolean           $enable_banner_issue                          = true,
  Array[String]     $banner_issue_files                           = ['/etc/issue','/etc/issue.net'],
  Boolean           $enable_banner_motd                           = true,
  Boolean           $enable_console_rescue                        = true,
  Boolean           $enable_console_singleuser                    = true,
  Boolean           $enable_console_systemd_target                = true,
  Boolean           $enable_pam_pwd_reuse                         = true,
  Integer           $pam_pwd_reuse_remember                       = 5,
  Integer           $pam_pwd_reuse_retry                          = 3,
  Boolean           $enable_pam_pwd_hashing_algorithm             = true,
  Boolean           $enable_pam_pwquality                         = true,
  Integer           $pam_pwquality_minlen                         = 14,
  Integer           $pam_pwquality_minclass                       = 4,
  Integer           $pam_pwquality_dcredit                        = -1,
  Integer           $pam_pwquality_ucredit                        = -1,
  Integer           $pam_pwquality_ocredit                        = -1,
  Integer           $pam_pwquality_lcredit                        = -1,
  Boolean           $enable_pwdlogin_expiration_inactivity        = true,
  Integer           $pwdlogin_expiration_inactivity_days          = 30,
  Boolean           $enable_pwdlogin_expiration_unique_names      = true,
  Boolean           $enable_pwdlogin_no_legacy_nis_entry          = true,
  Array[String]     $pwdlogin_no_legacy_nis_entry_paths           = ['/etc/group', '/etc/passwd', '/etc/shadow'],
  Boolean           $enable_pwdlogin_no_netrc                     = true,
  Boolean           $enable_pwdlogin_pwd_expiration               = true,
  Integer           $pwdlogin_pwd_expiration_maxdays              = 365,
  Integer           $pwdlogin_pwd_expiration_mindays              = 7,
  Integer           $pwdlogin_pwd_expiration_warndays             = 7,
  Boolean           $enable_pwdlogin_root_uid_exec                = true,
  Boolean           $enable_pwdlogin_root_nologin_exec            = true,
  Boolean           $enable_pwdlogin_root_su_restriction          = true,
  Boolean           $enable_session_env_path                      = true,
  Boolean           $enable_session_interactive_timeout           = true,
  Array[String]     $session_interactive_timeout_paths            = ['/etc/bashrc','/etc/profile'],
  Integer           $session_interactive_timeout_seconds          = 900,
  Boolean           $enable_session_umask_bash                    = true,
  Boolean           $enable_session_umask_login_defs              = true,
  Boolean           $enable_session_umask_profile                 = true,
  String            $enable_session_umask                         = '027',
  Boolean           $enable_coredumps_backtraces                  = true,
  Boolean           $enable_coredumps_storing                     = true,
  Boolean           $enable_coredumps_uid_programs                = true,
  Boolean           $enable_coredumps_users                       = true,
  Boolean           $enable_important_files_directories_unowned   = true,
  Boolean           $enable_important_worldwritable_files         = true,
  Boolean           $enable_important_stickybit                   = true,
  Boolean           $enable_important_account_group               = true,
  Boolean           $enable_important_account_group_backup        = true,
  Boolean           $enable_important_account_gshadow             = true,
  Boolean           $enable_important_account_gshadow_backup      = true,
  Boolean           $enable_important_account_passwd              = true,
  Boolean           $enable_important_account_passwd_backup       = true,
  Boolean           $enable_important_account_shadow              = true,
  Boolean           $enable_important_account_shadow_backup       = true,
  Boolean           $enable_mountfs_automounter                   = true,
  Boolean           $enable_mountfs_cramfs                        = true,
  Boolean           $enable_mountfs_modprobe_usb                  = true,
  Boolean           $enable_mountfs_squashfs                      = true,
  Boolean           $enable_mountfs_udf                           = true,
  Boolean           $enable_mountoptions_devshm                   = true,
  Boolean           $enable_mountoptions_home                     = true,
  Boolean           $enable_mountoptions_tmp                      = true,
  Boolean           $enable_mountoptions_vartmp                   = true,
  Boolean           $enable_execshield                            = true,
  Boolean           $enable_grub2_cfg_perms                       = true,
  Boolean           $enable_grub2_password                        = true,
  String            $grub2_password                               = '',
  Boolean           $enable_firewalld_install                     = true,
  Boolean           $enable_firewalld_defaultzone                 = true,
  Boolean           $enable_firewalld_service                     = true,
  Boolean           $enable_ipv4_icmp_redirects                   = true,
  Boolean           $enable_ipv4_ip_forwarding                    = true,
  Integer           $ipv4_ip_forwarding                           = 0,
  Boolean           $enable_ipv4_secure_redirects                 = true,
  Boolean           $enable_ipv4_sending_icmp_redirects           = true,
  Boolean           $enable_ipv4_source_routed                    = true,
  Boolean           $enable_ipv4_ignore_icmp_bogus                = true,
  Boolean           $enable_ipv4_ignore_icmp_broadcast_echo       = true,
  Boolean           $enable_ipv4_log_martians                     = true,
  Boolean           $enable_ipv4_reverse_path_filtering           = true,
  Boolean           $enable_ipv4_tcp_syncookies                   = true,
  Boolean           $enable_ipv6_icmp_redirects                   = true,
  Boolean           $enable_ipv6_ip_forwarding                    = true,
  Boolean           $enable_ipv6_source_routed                    = true,
  Boolean           $enable_ipv6_router_advertisements            = true,
  Boolean           $enable_wireless_deactivate                   = true,
  Boolean           $enable_disk_tmp                              = true,
  Boolean           $enable_integrity_aide_install                = true,
  Boolean           $enable_integrity_aide_periodic_execution     = true,
  String            $integrity_aide_periodic_execution_minute     = '05',
  String            $integrity_aide_periodic_execution_hour       = '4',
  String            $integrity_aide_periodic_execution_monthday   = '*',
  String            $integrity_aide_periodic_execution_month      = '*',
  String            $integrity_aide_periodic_execution_weekday    = '0',
  Boolean           $enable_integrity_crypto_ssh                  = true,
  Boolean           $enable_integrity_crypto_system               = true,
  Boolean           $enable_sudo_install                          = true,
  Boolean           $enable_sudo_logfile                          = true,
  String            $sudo_logfile                                 = '/var/log/sudo.log',
  Boolean           $enable_sudo_use_pty                          = true,
  Boolean           $enable_gpgcheck                              = true,
  Boolean           $enable_syslog_install                        = true,
  Boolean           $enable_syslog_service                        = true,
  Boolean           $enable_cron_hourly                           = true,
  Boolean           $enable_cron_monthly                          = true,
  Boolean           $enable_cron_weekly                           = true,
  Boolean           $enable_cron_crond                            = true,
  Boolean           $enable_cron_crontab                          = true,
  Boolean           $enable_cron_service                          = true,
  Boolean           $enable_cron_daily                            = true,
  Boolean           $enable_disable_cups                          = true,
  Boolean           $enable_disable_dhcp                          = true,
  Boolean           $enable_disable_dns                           = true,
  Boolean           $enable_disable_dovecot                       = true,
  Boolean           $enable_disable_ftp                           = true,
  Boolean           $enable_disable_gui                           = true,
  Boolean           $enable_disable_nfs                           = true,
  Boolean           $enable_disable_postfix_listening             = true,
  Boolean           $enable_disable_rpcbind                       = true,
  Boolean           $enable_disable_rsyncd                        = true,
  Boolean           $enable_disable_samba                         = true,
  Boolean           $enable_disable_snmpd                         = true,
  Boolean           $enable_disable_squid                         = true,
  Boolean           $enable_disable_web                           = true,
  Boolean           $enable_disable_avahi                         = true,
  Boolean           $enable_ssh_permissions                       = true,
  Boolean           $enable_ssh_host_based_auth                   = true,
  Enum['no','yes']  $ssh_host_based_auth                          = 'no',
  Boolean           $enable_ssh_empty_passwords                   = true,
  Enum['no','yes']  $ssh_empty_passwords                          = 'no',
  Boolean           $enable_ssh_ignore_rhosts                     = true,
  Enum['no','yes']  $ssh_ignore_rhosts                            = 'yes',
  Boolean           $enable_ssh_root_login                        = true,
  Enum['no','yes']  $ssh_root_login                               = 'no',
  Boolean           $enable_ssh_user_env                          = true,
  Enum['no','yes']  $ssh_user_env                                 = 'no',
  Boolean           $enable_ssh_alive_interval                    = true,
  Integer           $ssh_alive_interval                           = 900,
  Boolean           $enable_ssh_alive_max                         = true,
  Integer           $ssh_alive_max                                = 0,
  Boolean           $enable_ssh_loglevel                          = true,
  Enum['QUIET', 'FATAL', 'ERROR', 'INFO', 'VERBOSE', 'DEBUG', 'DEBUG1', 'DEBUG2', 'DEBUG3'] $ssh_loglevel = 'VERBOSE',
  Boolean           $enable_ssh_max_auth_tries                    = true,
  Integer           $ssh_max_auth_tries                           = 4,
  Boolean           $enable_ssh_max_sessions                      = true,
  Integer           $ssh_max_sessions                             = 4,
  Boolean           $enable_ssh_max_startups                      = true,
  String            $ssh_max_startups                             = '10:30:60',
  Boolean           $enable_ssh_keys                              = true,
  Boolean           $enable_uninstall_ldap_client                 = true,
  Boolean           $enable_uninstall_nis_client                  = true,
  Boolean           $enable_uninstall_rsh                         = true,
  Boolean           $enable_uninstall_telnet_client               = true,
  Boolean           $enable_uninstall_xinetd                      = true,
  Boolean           $enable_chrony_install                        = true,
  Boolean           $enable_chrony_service                        = true,
  Boolean           $enable_chrony_time_server                    = true,
  Boolean           $enable_optional_home_permissions             = true,
  Boolean           $enable_optional_log_permissions              = true,

  # Level 2
  Boolean           $enable_auditd_rules_perm_mod                 = true,
  Array[String]     $auditd_rules_perm_mod_actions                = ['chmod', 'chown', 'fchmod', 'fchmodat', 'fchown', 'fchownat', 'fremovexattr', 'fsetxattr', 'lchown', 'lremovexattr', 'lsetxattr', 'removexattr', 'setxattr'],
  Boolean           $enable_auditd_rules_delete                   = true,
  Array[String]     $auditd_rules_delete_actions                  = ['rename', 'renameat', 'unlink', 'unlinkat'],
  Boolean           $enable_auditd_rules_access                   = true,
  Array[String]     $auditd_rules_access_actions                  = ['creat', 'ftruncate', 'open', 'openat', 'truncate'],
  Boolean           $enable_auditd_rules_modules                  = true,
  Array[String]     $auditd_rules_modules_actions                 = ['delete_module', 'init_module'],
  Boolean           $enable_auditd_rules_logins                   = true,
  Array[String]     $auditd_rules_logins_paths                    = ['/var/run/faillock', '/var/log/lastlog'],
  Boolean           $enable_auditd_rules_time                     = true,
  Array[String]     $auditd_rules_time_actions                    = ['adjtimex', 'clock_settime', 'stime'],
  Array[String]     $auditd_rules_time_paths                      = ['/etc/localtime'],
  Boolean           $enable_auditd_rules_mac                      = true,
  Array[String]     $auditd_rules_mac_paths                       = ['/etc/selinux/'],
  Boolean           $enable_auditd_rules_export                   = true,
  Array[String]     $auditd_rules_export_actions                  = ['mount'],
  Boolean           $enable_auditd_rules_net_env                  = true,
  Array[String]     $auditd_rules_net_env_actions                 = ['sethostname,setdomainname'],
  Array[String]     $auditd_rules_net_env_paths                   = ['/etc/issue', '/etc/issue.net', '/etc/hosts', '/etc/sysconfig/network'],
  Boolean           $enable_auditd_rules_session                  = true,
  Array[String]     $auditd_rules_session_paths                   = ['/var/run/utmp', '/var/log/btmp', '/var/log/wtmp'],
  Boolean           $enable_auditd_rules_actions                  = true,
  Array[String]     $auditd_rules_actions_paths                   = ['/etc/sudoers', '/etc/sudoers.d/'],
  Boolean           $enable_auditd_rules_usergroup                = true,
  Array[String]     $auditd_rules_usergroup_paths                 = ['/etc/group', '/etc/gshadow', '/etc/security/opasswd', '/etc/passwd', '/etc/shadow'],
  Boolean           $enable_auditd_rules_immutable                = true,
  Boolean           $enable_auditd_data_log                       = true,
  Integer           $auditd_data_log_maxsize                      = 6,
  Enum['syslog', 'suspend', 'rotate', 'keep_logs'] $auditd_data_log_maxsize_action = 'keep_logs',
  Boolean           $enable_auditd_data_space                     = true,
  Enum['single', 'suspend', 'halt'] $auditd_data_space_adm_action = 'halt',
  Enum['syslog', 'email', 'exec', 'suspend', 'single', 'halt'] $auditd_data_space_action = 'email',
  Boolean           $enable_auditd_backlog                        = true,
  Integer           $auditd_backlog                               = 8192,
  Boolean           $enable_auditd_install                        = true,
  Boolean           $enable_auditd_service                        = true,
  Boolean           $enable_auditd_priority                       = true,
  Boolean           $enable_selinux_libselinux                    = true,
  Boolean           $enable_selinux_mcstrans                      = true,
  Boolean           $enable_selinux_setroubleshoot                = true,
  Boolean           $enable_selinux_grub2                         = true,
  Boolean           $enable_selinux_unconfined                    = true,
  Boolean           $enable_selinux_policy                        = true,
  Boolean           $enable_selinux_state                         = true,
  Boolean           $enable_network_uncommon_dccp                 = true,
  Boolean           $enable_network_uncommon_rds                  = true,
  Boolean           $enable_network_uncommon_sctp                 = true,
  Boolean           $enable_network_uncommon_tipc                 = true,
  Boolean           $enable_disk_home                             = true,
  Boolean           $enable_disk_var                              = true,
  Boolean           $enable_disk_varlog                           = true,
  Boolean           $enable_disk_varlogaudit                      = true,
  Boolean           $enable_disk_vartmp                           = true,
  ) {

  $auditd_rules_file = $auditd_rules_program ? {
    'augenrules'  => '/etc/audit/rules.d/audit.rules',
    'auditd'      => '/etc/audit/audit.rules',
  }
  $auditd_arch = $facts['os']['architecture'] ? {
    'x86_64'  => ['32', '64'],
    'x32'     => ['32'],
  }

  $rules = $profile ? {
    'server' => $level ? {
      '1'       => $server_level_1,
      '2'       => $server_level_2,
      'custom'  => $server_custom_level,
    }
  }

  $included_rules = $rules.map | String $line | {
    "almalinux_hardening::${line}"
  }

  include $included_rules
}
