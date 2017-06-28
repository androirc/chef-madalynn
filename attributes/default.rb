default['madalynn']['bouncer_ip'] = '10.10.10.254'

override['apt']['unattended-upgrades']['enable'] = true
override['apt']['unattended-upgrades']['remove_unused_dependencies'] = true

override['sshd']['sshd_config']['ListenAddress'] = '0.0.0.0'
