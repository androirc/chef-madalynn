#
# Cookbook Name:: madalynn
# Recipe:: sshd_listen_address
#
# Copyright 2015, Madalynn
#
# All rights reserved - Do Not Redistribute
#

# Change sshd ListenAddress to listen on private ip (eth1)

interface = (node['network']['interfaces'].key?('eth1') && 'eth1') || 'eth0'

ip = node['network']['interfaces'][interface]['addresses'].detect{ |k, v| v['family'] == 'inet' }.first
node.override['sshd']['sshd_config']['ListenAddress'] = ip
