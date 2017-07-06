default['madalynn']['bouncer_ip'] = '10.10.10.254'

override['apt']['unattended_upgrades']['enable'] = true
override['apt']['unattended_upgrades']['remove_unused_dependencies'] = true

override['apt']['unattended_upgrades']['allowed_origins'] = [
  '${distro_id}:${distro_codename}',
  '${distro_id}:${distro_codename}-security',
  '${distro_id}:${distro_codename}-updates',
  'MariaDB:',
  'LP-PPA-formorer-icinga:${distro_codename}',
  'Node Source:'
]

override['sshd']['sshd_config']['ListenAddress'] = '0.0.0.0'
override['sshd']['sshd_config']['PermitRootLogin'] = 'without-password'
override['sshd']['sshd_config']['PasswordAuthentication'] = 'no'
