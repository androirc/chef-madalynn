#
# Cookbook Name:: madalynn
# Recipe:: users
#
# Copyright 2015, Madalynn
#
# All rights reserved - Do Not Redistribute
#

ohai 'reload_passwd' do
  action :nothing
  plugin 'etc'
end

include_recipe 'user'

# Create 'blinkseb' user
user_account 'blinkseb' do
  ssh_keygen false
  password chef_vault_item("passwords", "blinkseb")["password"]
  ssh_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAjFWUgpv09Ru+qr/SlW9Pih2WxS6eyZjjRfU7GMqXB8KZIVhZ8w0uGUDJSDzJSfsaLmziLMNshMa6XKZVlY/gGueqK2T+s3XuYl28ByOFHnJ9RslwwlwuwINE5WhMyLCFiEpo36+oxnME97pmh9crDrhscxDqcHD13Y9MTmyQPt0DrE0Ux11VyyIRV0Af9biK7OzDE1DNDY/kkVJ3cs8zM9M878MOuCztlUZIVd8/lvfXeNn4QFAXWuNDkNagOXD0ePUk27f75J6/zFqwkFMabLSLdI8hXAoa+/AnZCK/7Wjsq+QGR0IlAoqE8eMR7KmKp2WU+2UHJakf9x6Cv6xKcQ== blinkseb@pc-salon']
  notifies :reload, 'ohai[reload_passwd]', :immediately
end

# Create 'aerialls' user
user_account 'aerialls' do
  ssh_keygen false
  password chef_vault_item("passwords", "aerialls")["password"]
  ssh_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZUPvDpZ4BaNBAOh5tuArMW+WyLgQenE7hikLhFY9gZ+OOhPx2CXWKdxwKe3tLhYpMmLDB8/eXXd6KQKf9K+58aTNk8aXJbxwXaUuOVn9xHIvW2rKImhe+eZZ7fONEZN0DdSE3aYA8t/inyan3Q+HdIwujHNnduPhP95Yf2KfehhojC9koCbDRu7S6lvPetCivBfH+dEDIKI/KK0Tzbt+boyCYVuuBOp/+RUInz5bOkGQ4fWHrnkKfPbPfH0edp1bolMu4oLgSwxa74lRc53pRTPZVt+bmV+j5TO2X4GvMaEOqF/kS/VQlAqjnGzNBWFbpPAXPZAJmylkgoryGZZPd aerialls@madalynn.eu']
  notifies :reload, 'ohai[reload_passwd]', :immediately
end

user_account 'madalynn' do
  ssh_keygen false
  ssh_keys resources(:user_account => 'blinkseb').ssh_keys.concat(resources(:user_account => 'aerialls').ssh_keys)
  notifies :reload, 'ohai[reload_passwd]', :immediately
end

group 'sudo' do
  append true
  group_name 'sudo'
  members ['madalynn']
  action :modify
end

# Password-less sudo for %sudo group
sudo 'sudo' do
  group '%sudo'
  nopasswd true
end
