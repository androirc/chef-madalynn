default['madalynn']['bouncer_ip'] = '10.10.10.254'

override['apt']['unattended_upgrades']['enable'] = true
override['apt']['unattended_upgrades']['remove_unused_dependencies'] = true

override['apt']['unattended_upgrades']['allowed_origins'] = [
  '${distro_id}:${distro_codename}',
  '${distro_id}:${distro_codename}-security',
  '${distro_id}:${distro_codename}-updates',
  'MariaDB:',
  'LP-PPA-formorer-icinga:${distro_codename}',
  'LP-PPA-ondrej-php:${distro_codename}',
  'LP-PPA-nginx-stable:${distro_codename}',
  'Node Source:'
]

override['sshd']['sshd_config']['ListenAddress'] = '0.0.0.0'
override['sshd']['sshd_config']['PermitRootLogin'] = 'without-password'
override['sshd']['sshd_config']['PasswordAuthentication'] = 'no'

# Configure logrotate to restart chef-client service instead of reload
# because latter crash the service
default['chef_client']['log_rotation']['postrotate'] =  case node['chef_client']['init_style']
                                                        when 'systemd'
                                                          'systemctl restart chef-client.service >/dev/null || :'
                                                        when 'upstart'
                                                          'initctl restart chef-client >/dev/null || :'
                                                        else
                                                          '/etc/init.d/chef-client restart >/dev/null || :'
                                                        end
