#
# Cookbook Name:: sshd
# Attributes:: default
#
# Copyright 2012, Chris Aumann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

default['madalynn']['bouncer_ip'] = '10.10.10.254'

# Path to 'sshd_config' configuration file
default['sshd']['config_file'] = case node['platform_family']
when 'mac_os_x'
  '/etc/sshd_config'
else
  '/etc/ssh/sshd_config'
end

# OpenSSH service name
default['sshd']['service_name'] = case node['platform_family']
when 'debian'
  'ssh'
else
  'sshd'
end

# Define sshd_config attributes
default['sshd']['sshd_config'] = {
  'Port' => 22,
  'Protocol' => 2,
  'HostKey' => %w(/etc/ssh/ssh_host_rsa_key
                  /etc/ssh/ssh_host_ed25519_key
                  /etc/ssh/ssh_host_dsa_key
                  /etc/ssh/ssh_host_ecdsa_key),
  'UsePrivilegeSeparation' => 'yes',
  'KeyRegenerationInterval' => '3600',
  'ServerKeyBits' => '1024',
  'SyslogFacility' => 'AUTH',
  'LogLevel' => 'INFO',
  'LoginGraceTime' => '120',
  'PermitRootLogin' => 'without-password',
  'StrictModes' => 'yes',
  'RSAAuthentication' => 'yes',
  'PubkeyAuthentication' => 'yes',
  'IgnoreRhosts' => 'yes',
  'RhostsRSAAuthentication' => 'no',
  'HostbasedAuthentication' => 'no',
  'PermitEmptyPasswords' => 'no',
  'ChallengeResponseAuthentication' => 'no',
  'X11Forwarding' => 'yes',
  'X11DisplayOffset' => '10',
  'PrintMotd' => 'no',
  'PrintLastLog' => 'yes',
  'TCPKeepAlive' => 'yes', 
  'AcceptEnv' => 'LANG LC_*',
  'Subsystem' => 'sftp /usr/lib/openssh/sftp-server',
  'UsePAM' => 'yes',
  'ListenAddress' => '0.0.0.0'
}

override['apt']['unattended-upgrades']['enable'] = true
override['apt']['unattended-upgrades']['remove_unused_dependencies'] = true
