#
# Cookbook Name:: madalynn
# Recipe:: sshd
#
# Copyright 2015, Madalynn
#
# All rights reserved - Do Not Redistribute
#

# List all users, and disable ssh access by password for users with uid greater or equals to 1000
ruby_block 'list_users' do
  block do
    node.default['sshd']['sshd_config']['Match'] = {}
    node['etc']['passwd'].each do |user, data|
      if data['uid'].to_i >= 1000
        node.default['sshd']['sshd_config']['Match']["User #{user}"] = {
          'PasswordAuthentication' => 'no'
        }
      end
    end
  end

  action :create
end

madalynn_sshd 'Update sshd configuration'
