# AlmaLinux Hardening

## Table of Contents

1. [Description](#description)
    * [Major Releases Supported](#major-releases-supported)
1. [Setup](#setup)
    * [What is this module affecting?](#what-is-this-module-affecting?)
    * [Setup Requirements](#setup-requirements)
    * [Beginning with the module](#beginning-with-the-module)
1. [Usage](#usage)
    * [Parameters](#parameters)
      * [Level 1](#level-1)
      * [Level 2](#level-2)
      * [Custom Level](#custom-level)
1. [Limitations](#limitations)
1. [Development](#development)
1. [Credits](#credits)
1. [Author](#author)
1. [License](#license)


## Description
This Puppet module performs the hardening in accordance with the CIS (*Center for Internet Security*) benchmarks for the AlmaLinux servers.
It is based on [the official AlmaLinux *OpenScap Guide*](https://wiki.almalinux.org/documentation/openscap-guide.html#about-openscap).
All the CIS rules have been tested with [*OpenScap*](https://www.open-scap.org/).

A report is available [here](https://github.com/huglijonas/almalinux_hardening/blob/0.2.0/reports/level1_security_guide.html).

__*WARNING: Do not attempt to implement any of the settings with this Puppet module without first testing them in a non-operational environment. The creators of this guidance assume no responsibility whatsoever for its use by other parties, and makes no guarantees, expressed or implied, about its quality, reliability, or any other characteristic.*__

### Major Releases Supported
For the moment, there is only one major release for AlmaLinux: 8.


## Setup

### What is this module affecting?
This module affects a lot of parameters. The following list is not exhaustive, so it is recommanded to read [the full report](https://github.com/huglijonas/almalinux_hardening/blob/0.2.0/reports/level1_security_guide.html) before using the module:
* Kernel settings ;
* Packages (installations, deletions...) ;
* Services (settings, statuses...) ;
* Disks and partitions (options, warnings...) ;
* Files and directories (permissions, additions, deletions...) ;
* Network settings (deactivations, activations, firewall settings...) ;
* Bootloader settings ;
* And much more...


### Setup Requirements
* Puppet: >= 6.21.0 < 8.0.0
* [puppetlabs/stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib/8.1.0): >= 4.25.0 < 9.0.0
* [puppet/cron](https://forge.puppet.com/modules/puppet/cron/3.0.0): >= 3.0.0
* [puppet/kmod](https://forge.puppet.com/modules/puppet/kmod/3.1.0): >= 3.1.0
* [herculesteam/augeasproviders_core](https://forge.puppet.com/modules/herculesteam/augeasproviders_core/2.7.0): 2.4.0 < 3.0.0
* [herculesteam/augeasproviders_sysctl](https://forge.puppet.com/modules/herculesteam/augeasproviders_sysctl/2.6.2): >= 2.6.2
* [herculesteam/augeasproviders_pam](https://forge.puppet.com/modules/herculesteam/augeasproviders_pam/2.3.0): >= 2.3.0
* [herculesteam/augeasproviders_grub](https://forge.puppet.com/modules/herculesteam/augeasproviders_grub/3.2.0): >= 3.2.0


### Beginning with the module
Starting with this module is relatively easy, but it is really recommanded to read the full report before using the module.

First, add this module. After adding it, you can use the class like the following code block.
```rb
class { '::almalinux_hardening':
  # Basic parameters
  $level                  = '1',
  $root_account           = 'root',
  $nologin_shell          = '/sbin/nologin',
  $home_device            = '/dev/mapper/vg-home',
  $tmp_device             = '/dev/mapper/vg-tmp',
  $vartmp_device          = '/dev/mapper/vg-var-tmp',
  $time_server            = ['time.google.com'],
  $ignore_system_users    = [],
  $ignore_home_users      = [],
  $disable_repos          = '',
  $enable_repos           = '',
}
```
Be careful to adapt the listed parameters with your server(s).


All parameters are stored in the `manifests/init.pp` file.
All rules are enabled by default. If you want to disable one, you can override a parameter like this:
```rb
class { 'almalinux_hardening':
  # Basic parameters
  $level                  = '1',
  $root_account           = 'root',
  $nologin_shell          = '/sbin/nologin',
  $home_device            = '/dev/mapper/vg-home',
  $tmp_device             = '/dev/mapper/vg-tmp',
  $vartmp_device          = '/dev/mapper/vg-var-tmp',
  $time_server            = ['time.google.com'],
  $ignore_system_users    = [],
  $ignore_home_users      = [],
  $disable_repos          = '',
  $enable_repos           = '',

  # Rules
  $enable_grub2_password  = false,
}
```


## Usage

### Parameters

#### Level 1
To choose the level 1, the `$level` variable must be set to `1`.

| Name | Description | Type | Default Value |
|------|-------------|------|---------------|
| profile | Type of machine | Enum['server'] | Server |
| level | Hardening Level | Enum['1', '2'] | 1 |
| root_account | Name of the root account | String | root |
| nologin_shell | Path of the nologin shell | String | /sbin/nologin |
| home_device | Path of the dedicated device for /home | String | /dev/mapper/vg-home |
| tmp_device | Path of the dedicated device for /tmp | String | /dev/mapper/vg-tmp |
| vartmp_device | Path of the dedicated device for /var/tmp | String | /dev/mapper/vg-var-tmp |
| time_server | List of the used time server(s) | Array[String] | ['time.google.com'] |
| ignore_system_users | List of users who will not be affected by the module | Array[String] | [] |
| ignore_home_users | List of users homes who will not be affected by the module | Array[String] | [] |
| disable_repos | Disable repositories for the `dnf` command | String | '' |
| enable_repos | Enable repositories for the `dnf` command | String | '' |
| enable_banner_issue | See `manifests/system/aac/banners/login.pp` | Boolean | true |
| banner_issue_files | Paths for issue and issue.net files | Array[String] | ['/etc/issue','/etc/issue.net'] |
| enable_banner_motd | See `manifests/system/aac/banners/motd.pp` | Boolean | true |
| enable_console_rescue | See `manifests/system/aac/console/single_user.pp` | Boolean | true |
| enable_console_singleuser | See `manifests/system/aac/console/single_user.pp` | Boolean | true |
| enable_console_systemd_target | See `manifests/system/aac/console/systemd_target.pp` | Boolean | true |
| enable_pam_pwd_reuse | See `manifests/system/aac/pam/password_reuse.pp` | Boolean | true |
| pam_pwd_reuse_remember |  Limit of remembered passwords used | Integer | 5 |
| pam_pwd_reuse_retry |  Reused password retries limit | Integer | 3 |
| enable_pam_pwd_hashing_algorithm | See `manifests/system/aac/pam/pwd_hashing_algorithm.pp` | Boolean | true |
| enable_pam_pwquality | See `manifests/system/aac/pam/pwquality.pp` | Boolean | true |
| pam_pwquality_minlen |  Minimum characters of passwords | Integer | 14 |
| pam_pwquality_minclass |  Minimum different categories of passwords | Integer | 4 |
| pam_pwquality_dcredit |  Maximum number of digits that will generate a credit | Integer | -1 |
| pam_pwquality_ucredit |  Maximum number of uppercase characters that will generate a credit | Integer | -1 |
| pam_pwquality_ocredit |  Maximum number of other characters that will generate a credit | Intger | -1 |
| pam_pwquality_lcredit |  Maximum number of lowercase characters that will generate a credit | Integer | -1 |
| enable_pwdlogin_expiration_inactivity | See `manifests/system/aac/pwd_login/account_expiration/inactivity.pp` | Boolean | true |
| pwdlogin_expiration_inactivity_days |  Specify the number of days after a password expires | Integer | 30 |
| enable_pwdlogin_expiration_unique_names | See `manifests/system/aac/pwd_login/account_expiration/unique_names.pp` | Boolean | true |
| enable_pwdlogin_no_legacy_nis_entry | See `manifests/system/aac/pwd_login/password_hashes/no_legacy_nis.pp` | Boolean | true |
| pwdlogin_no_legacy_nis_entry_paths |  Files to search Legacy NIS entries | Array[String] | ['/etc/group', '/etc/passwd', '/etc/shadow'] |
| enable_pwdlogin_no_netrc | See `manifests/system/aac/pwd_login/password_hashes/no_netrc.pp` | Boolean | true |
| enable_pwdlogin_pwd_expiration | See `manifests/system/aac/pwd_login/password_expiration.pp` | Boolean | true |
| pwdlogin_pwd_expiration_maxdays |  Specify password maximum age for new accounts | Integer | 365 |
| pwdlogin_pwd_expiration_mindays |  Specify password minimum age for new accounts | Integer | 7 |
| pwdlogin_pwd_expiration_warndays | Specify how many days prior to password expiration that a warning will be issued to users | Integer | 7 |
| enable_pwdlogin_root_uid_exec | See `manifests/system/aac/pwd_login/root.pp` | Boolean | true |
| enable_pwdlogin_root_nologin_exec | See `manifests/system/aac/pwd_login/root.pp` | Boolean | true |
| enable_pwdlogin_root_su_restriction | See `manifests/system/aac/pwd_login/root.pp` | Boolean | true |
| enable_session_env_path | See `manifests/system/aac/session/env_path.pp` | Boolean | true |
| enable_session_interactive_timeout | See `manifests/system/aac/session/interactive_session_timeout.pp` | Boolean | true |
| session_interactive_timeout_paths |  Files to apply TMOUT variable | Array[String] | ['/etc/bashrc','/etc/profile'] |
| session_interactive_timeout_seconds | Inactivity seconds until user sessions will be termintated | Integer | 900 |
| enable_session_umask_bash | See `manifests/system/aac/session/umask/bash_default.pp` | Boolean | true |
| enable_session_umask_login_defs | See `manifests/system/aac/session/umask/login_defs.pp` | Boolean | true |
| enable_session_umask_profile | See `manifests/system/aac/session/umask/profile_default.pp` | Boolean | true |
| enable_session_umask | Session umask | String | '027' |
| enable_coredumps_backtraces | See `manifests/system/files_perm_masks/core_dumps/backtraces.pp` | Boolean | true |
| enable_coredumps_storing | See `manifests/system/files_perm_masks/core_dumps/storing.pp` | Boolean | true |
| enable_coredumps_uid_programs | See `manifests/system/files_perm_masks/core_dumps/suid_programs.pp` | Boolean | true |
| enable_coredumps_users | See `manifests/system/files_perm_masks/core_dumps/users.pp` | Boolean | true |
| enable_important_files_directories_unowned | See `manifests/system/files_perm_masks/important/no_files_directories_unowned.pp` | Boolean | true |
| enable_important_worldwritable_files | See `manifests/system/files_perm_masks/important/no_world_writable_files.pp` | Boolean | true |
| enable_important_stickybit | See `manifests/system/files_perm_masks/important/sticky_bit.pp` | Boolean | true |
| enable_important_account_group | See `manifests/system/files_perm_masks/important/account_info/group.pp` | Boolean | true |
| enable_important_account_group_backup | See `manifests/system/files_perm_masks/important/account_info/group_backup.pp` | Boolean | true |
| enable_important_account_gshadow | See `manifests/system/files_perm_masks/important/account_info/gshadow.pp` | Boolean | true |
| enable_important_account_gshadow_backup | See `manifests/system/files_perm_masks/important/account_info/gshadow_backup.pp` | Boolean | true |
| enable_important_account_passwd | See `manifests/system/files_perm_masks/important/account_info/passwd.pp` | Boolean | true |
| enable_important_account_passwd_backup | See `manifests/system/files_perm_masks/important/account_info/passwd_backup.pp` | Boolean | true |
| enable_important_account_shadow | See `manifests/system/files_perm_masks/important/account_info/shadow.pp` | Boolean | true |
| enable_important_account_shadow_backup | See `manifests/system/files_perm_masks/important/account_info/shadow_backup.pp` | Boolean | true |
| enable_mountfs_automounter | See `manifests/system/files_perm_masks/mount_fs/disable_automounter.pp` | Boolean | true |
| enable_mountfs_cramfs | See `manifests/system/files_perm_masks/mount_fs/disable_cramfs_mounting.pp` | Boolean | true |
| enable_mountfs_modprobe_usb | See `manifests/system/files_perm_masks/mount_fs/disable_modprobe_loading_usb.pp` | Boolean | true |
| enable_mountfs_squashfs | See `manifests/system/files_perm_masks/mount_fs/disable_squashfs_mounting.pp` | Boolean | true |
| enable_mountfs_udf | See `manifests/system/files_perm_masks/mount_fs/disable_udf_mounting.pp` | Boolean | true |
| enable_mountoptions_devshm | See `manifests/system/files_perm_masks/mount_options/dev_shm.pp` | Boolean | true |
| enable_mountoptions_home | See `manifests/system/files_perm_masks/mount_options/home.pp` | Boolean | true |
| enable_mountoptions_tmp | See `manifests/system/files_perm_masks/mount_options/tmp.pp` | Boolean | true |
| enable_mountoptions_vartmp | See `manifests/system/files_perm_masks/mount_options/var_tmp.pp` | Boolean | true |
| mountoptions_vartmp_partitioned | If the /var/tmp directory is in a specific partition | Boolean | true |
| enable_execshield | See `manifests/system/files_perm_masks/execshield.pp` | Boolean | true |
| enable_grub2_cfg_perms | See `manifests/system/grub2/cfg_perms.pp` | Boolean | true |
| enable_grub2_password | See `manifests/system/grub2/password.pp` | Boolean | true |
| grub2_password | Grub2 password - The value must be like 'grub.pbkdf2.sha512': use `grub2-mkpasswd-pbkdf2`| String | '' |
| enable_firewalld_install | See `manifests/system/network/firewalld/install.pp` | Boolean | true |
| enable_firewalld_defaultzone | See `manifests/system/network/firewalld/default_zone.pp` | Boolean | true |
| enable_firewalld_service | See `manifests/system/network/firewalld/service.pp` | Boolean | true |
| enable_ipv4_icmp_redirects | See `manifests/system/network/ipv4/disable_icmp_redirects.pp` | Boolean | true |
| enable_ipv4_ip_forwarding | See `manifests/system/network/ipv4/disable_ip_forwarding.pp` | Boolean | true |
| ipv4_ip_forwarding | If you enable the IPv4 forwarding rule, you can adjust the value. It can be useful if you have a Docker server. | Integer | 0 |
| enable_ipv4_secure_redirects | See `manifests/system/network/ipv4/disable_secure_redirects.pp` | Boolean | true |
| enable_ipv4_sending_icmp_redirects | See `manifests/system/network/ipv4/disable_sending_icmp_redirects.pp` | Boolean | true |
| enable_ipv4_source_routed | See `manifests/system/network/ipv4/disable_source_routed.pp` | Boolean | true |
| enable_ipv4_ignore_icmp_bogus | See `manifests/system/network/ipv4/enable_ignore_icmp_bogus.pp` | Boolean | true |
| enable_ipv4_ignore_icmp_broadcast_echo | See `manifests/system/network/ipv4/enable_ignore_icmp_broadcast_echo.pp` | Boolean | true |
| enable_ipv4_log_martians | See `manifests/system/network/ipv4/enable_log_martians.pp` | Boolean | true |
| enable_ipv4_reverse_path_filtering | See `manifests/system/network/ipv4/enable_reverse_path_filtering.pp` | Boolean | true |
| enable_ipv4_tcp_syncookies | See `manifests/system/network/ipv4/enable_tcp_syncookies.pp` | Boolean | true |
| enable_ipv6_icmp_redirects | See `manifests/system/network/ipv6/disable_icmp_redirects.pp` | Boolean | true |
| enable_ipv6_ip_forwarding | See `manifests/system/network/ipv6/disable_ip_forwarding.pp` | Boolean | true |
| enable_ipv6_source_routed | See `manifests/system/network/ipv6/disable_source_routed.pp` | Boolean | true |
| enable_ipv6_router_advertisements | See `manifests/system/network/ipv6/router_advertisements.pp` | Boolean | true |
| enable_wireless_deactivate | See `manifests/system/network/wireless/software_configuration/deactivate.pp` | Boolean | true |
| enable_disk_tmp | See `manifests/system/software/disk/tmp.pp` | Boolean | true |
| enable_integrity_aide_install | See `manifests/system/software/integrity/aide/install.pp` | Boolean | true |
| enable_integrity_aide_periodic_execution | See `manifests/system/software/integrity/aide/periodic_execution.pp` | Boolean | true |
| integrity_aide_periodic_execution_minute | AIDE cron minute field | String | '05' |
| integrity_aide_periodic_execution_hour | AIDE cron hour field | String | '4' |
| integrity_aide_periodic_execution_monthday | AIDE cron monthday field | String | '*' |
| integrity_aide_periodic_execution_month | AIDE cron month field | String | '*' |
| integrity_aide_periodic_execution_weekday | AIDE cron weekday field | String | '0' |
| enable_integrity_crypto_ssh | See `manifests/system/software/integrity/crypto/ssh.pp` | Boolean | true |
| enable_integrity_crypto_system | See `manifests/system/software/integrity/crypto/system.pp` | Boolean | true |
| enable_sudo_install | See `manifests/system/software/sudo/install.pp` | Boolean | true |
| enable_sudo_logfile | See `manifests/system/software/sudo/logfile.pp` | Boolean | true |
| sudo_logfile |  Logfile path | String | '/var/log/sudo.log' |
| enable_sudo_use_pty | See `manifests/system/software/sudo/use_pty.pp` | Boolean | true |
| enable_gpgcheck | See `manifests/system/software/updating_software/gpgcheck.pp` | Boolean | true |
| enable_syslog_install | See `manifests/system/syslog/install.pp` | Boolean | true |
| enable_syslog_service | See `manifests/system/syslog/service.pp` | Boolean | true |
| enable_cron_hourly | See `manifests/services/cron_at_daemons/cron_hourly.pp` | Boolean | true |
| enable_cron_monthly | See `manifests/services/cron_at_daemons/cron_monthly.pp` | Boolean | true |
| enable_cron_weekly | See `manifests/services/cron_at_daemons/cron_weekly.pp` | Boolean | true |
| enable_cron_crond | See `manifests/services/cron_at_daemons/crond.pp` | Boolean | true |
| enable_cron_crontab | See `manifests/services/cron_at_daemons/crontab.pp` | Boolean | true |
| enable_cron_service | See `manifests/services/cron_at_daemons/service.pp` | Boolean | true |
| enable_cron_daily | See `manifests/services/cron_at_daemons/cron_daily.pp` | Boolean | true |
| enable_disable_cups | See `manifests/services/disable/cups.pp` | Boolean | true |
| enable_disable_dhcp | See `manifests/services/disable/dhcp.pp` | Boolean | true |
| enable_disable_dns | See `manifests/services/disable/dns.pp` | Boolean | true |
| enable_disable_dovecot | See `manifests/services/disable/dovecot.pp` | Boolean | true |
| enable_disable_ftp | See `manifests/services/disable/ftp.pp` | Boolean | true |
| enable_disable_gui | See `manifests/services/disable/gui.pp` | Boolean | true |
| enable_disable_nfs | See `manifests/services/disable/nfs.pp` | Boolean | true |
| enable_disable_postfix_listening | See `manifests/services/disable/postfix_listening.pp` | Boolean | true |
| enable_disable_rpcbind | See `manifests/services/disable/rpcbind.pp` | Boolean | true |
| enable_disable_rsyncd | See `manifests/services/disable/rsyncd.pp` | Boolean | true |
| enable_disable_samba | See `manifests/services/disable/samba.pp` | Boolean | true |
| enable_disable_snmpd | See `manifests/services/disable/snmpd.pp` | Boolean | true |
| enable_disable_squid | See `manifests/services/disable/squid.pp` | Boolean | true |
| enable_disable_web | See `manifests/services/disable/web.pp` | Boolean | true |
| enable_disable_avahi | See `manifests/services/disable/avahi.pp` | Boolean | true |
| enable_ssh_permissions | See `manifests/services/ssh/permissions.pp` | Boolean | true |
| enable_ssh_host_based_auth | See `manifests/services/ssh/host_based_auth.pp` | Boolean | true |
| ssh_host_based_auth | Enable or disable Host Based Authentication | Enum['no','yes'] | 'no' |
| enable_ssh_empty_passwords | See `manifests/services/ssh/empty_passwords.pp` | Boolean | true |
| ssh_empty_passwords | Allow or disallow empty passwords | Enum['no','yes'] | 'no' |
| enable_ssh_ignore_rhosts | See `manifests/services/ssh/ignore_rhosts.pp` | Boolean | true |
| ssh_ignore_rhosts | Ignoring or not rhosts | Enum['no','yes'] | 'yes' |
| enable_ssh_root_login | See `manifests/services/ssh/root_login.pp` | Boolean | true |
| ssh_root_login | Allow or disallow root login | Enum['no','yes'] | 'no' |
| enable_ssh_user_env | See `manifests/services/ssh/user_env.pp` | Boolean | true |
| ssh_user_env | Allow or disable overriden environment variables of SSH daemon | Enum['no','yes'] | 'no' |
| enable_ssh_alive_interval | See `manifests/services/ssh/alive_interval.pp` | Boolean | true |
| ssh_alive_interval | Set an idle timeout interval | Integer | 900 |
| enable_ssh_alive_max | See `manifests/services/ssh/alive_max.pp` | Boolean | true |
| ssh_alive_max | Sets the number of client alive messages which may be sent without sshd receiving any messages back from the client | Integer | 0 |
| enable_ssh_loglevel | See `manifests/services/ssh/loglevel.pp` | Boolean | true |
| ssh_loglevel | Verbosity Level | Enum['QUIET', 'FATAL', 'ERROR', 'INFO', 'VERBOSE', 'DEBUG', 'DEBUG1', 'DEBUG2', 'DEBUG3'] | 'VERBOSE' |
| enable_ssh_max_auth_tries | See `manifests/services/ssh/max_auth_tries.pp` | Boolean | true |
| ssh_max_auth_tries | Specify the maximum number of authentication attempts permitted per connection | Integer | 4 |
| enable_ssh_max_sessions | See `manifests/services/ssh/max_sessions.pp` | Boolean | true |
| ssh_max_sessions | Specify the maximum number of open sessions permitted from a given connection | Integer | 4 |
| enable_ssh_max_startups | See `manifests/services/ssh/max_startups.pp` | Boolean | true |
| ssh_max_startups | Specify the maximum number of concurrent unauthenticated connections to the SSH daemon | String | '10:30:60' |
| enable_ssh_keys | See `manifests/services/ssh/keys.pp` | Boolean | true |
| enable_uninstall_ldap_client | See `manifests/services/uninstall/ldap_client.pp` | Boolean | true |
| enable_uninstall_nis_client | See `manifests/services/uninstall/nis_client.pp` | Boolean | true |
| enable_uninstall_rsh | See `manifests/services/uninstall/rsh.pp` | Boolean | true |
| enable_uninstall_telnet_client | See `manifests/services/uninstall/telnet_client.pp` | Boolean | true |
| enable_uninstall_xinetd | See `manifests/services/uninstall/xinetd.pp` | Boolean | true |
| enable_chrony_install | See `manifests/services/chrony/install.pp` | Boolean | true |
| enable_chrony_service | See `manifests/services/chrony/service.pp` | Boolean | true |
| enable_chrony_time_server | See `manifests/services/chrony/time_server.pp` | Boolean | true |
| enable_optional_home_permissions | See `manifests/optional/home_permissions.pp` | Boolean | true |
| enable_optional_log_permissions | See `manifests/optional/log_permissions.pp` | Boolean | true |

#### Level 2
__*NOT IMPLEMENTED YET*__


#### Custom Level
To choose the custom level, the `$level` variable must be set to `custom`.

You can create your own rules with the dedicated script `custom-rule.sh` who is in the `scripts` directory. This script will create an entry in the `data/os/AlmaLinux/version/8.yaml` file, and it will create a `.pp` file in `manifests/custom` directory. When you want to execute the script, you only need to specify the name of your future custom rule like this:
```bash
# Example:
# scripts/custom-rule.sh -n custom_kernel
scripts/custom-rule.sh -n <rulename>
```

If you want to create a rule in a specific directory inside the `custom`, like `manifests/custom/kernel`, type this:
```bash
# Example:
# scripts/custom-rule.sh -n kernel/custom
scripts/custom-rule.sh -n <directory>/<rulename>
```

If you need help with the script, type `scripts/custom-rule.sh -h` or `scripts/custom-rule.sh --help`. If you want to add level 1 or 2 rules, you can edit the `data/os/AlmaLinux/version/8.yaml` to copy and paste rules you want.


## Limitations
This module is dedicated for AlmaLinux 8 servers. It has been tested with a AlmaLinux 8.5 minimal installation.


## Development
All contributions are welcome, so any help is appreciated!
You can contribute on the official page: https://github.com/huglijonas/almalinux_hardening


## Credits
This module is inspired by two other modules:
* [os_hardening](https://forge.puppet.com/modules/hardening/os_hardening) ;
* [secure_linux_cis](https://forge.puppet.com/modules/fervid/secure_linux_cis).


## Author
* Author: Jonas Hügli.


## License
```
Puppet Module to perform AlmaLinux 8 OS Hardening with CIS benchmark.
Copyright (C) 2022  Jonas Hügli

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
