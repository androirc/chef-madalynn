default['madalynn']['bouncer_ip'] = '10.10.10.254'

override['apt']['unattended_upgrades']['enable'] = true
override['apt']['unattended_upgrades']['remove_unused_dependencies'] = true

override['sshd']['sshd_config']['ListenAddress'] = '0.0.0.0'
override['sshd']['sshd_config']['PermitRootLogin'] = 'without-password'
override['sshd']['sshd_config']['PasswordAuthentication'] = 'no'
