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

# ruby-shadow gem is needed for passwords
apt_package 'ruby-dev'
gem_package 'ruby-shadow'

# Create 'blinkseb' user
user_account 'blinkseb' do
  ssh_keygen false
  password chef_vault_item("passwords", "blinkseb")["password"]
  ssh_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAjFWUgpv09Ru+qr/SlW9Pih2WxS6eyZjjRfU7GMqXB8KZIVhZ8w0uGUDJSDzJSfsaLmziLMNshMa6XKZVlY/gGueqK2T+s3XuYl28ByOFHnJ9RslwwlwuwINE5WhMyLCFiEpo36+oxnME97pmh9crDrhscxDqcHD13Y9MTmyQPt0DrE0Ux11VyyIRV0Af9biK7OzDE1DNDY/kkVJ3cs8zM9M878MOuCztlUZIVd8/lvfXeNn4QFAXWuNDkNagOXD0ePUk27f75J6/zFqwkFMabLSLdI8hXAoa+/AnZCK/7Wjsq+QGR0IlAoqE8eMR7KmKp2WU+2UHJakf9x6Cv6xKcQ== blinkseb@pc-salon',
            'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCvqSolHloZf2xFors3HwC4PTAczuWk+V2OC0tVf0SqIdkx8HVT7WhoTT/KFWNkU4ASkKVXeDMrl7Xx5qjA+kWF6nk7elv6VGNUmA6C0xO/E/mvNSBRWCCTrChtkChSAeLG9jAI0jqp8ujw8posFwJPeskJx6jWLwfP5689lWMKn479oUgCqJ27XxOBDIID1kFmUF9laBmUnbRw1z+nEyHkXfFrdddZkb2rIC1jPBHBUdRq9FzEvj8qdOmeUnuRArW+YHUwsIQEYsYCT8ZRxvZXChFNcGZqtgPE+UBKOWO4n1cgBPjtRK9RZdoez+WJN2Vhdmq23ns6OEOtVp3EzDZx sebastien.brochet@cern.ch']
  notifies :reload, 'ohai[reload_passwd]', :immediately
end

# Create 'aerialls' user
user_account 'aerialls' do
  ssh_keygen false
  password chef_vault_item("passwords", "aerialls")["password"]
  ssh_keys ['ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCkirKHAyb/NUqBOvks/WyBYL2Dwty7DX7gTDxlSzIZrbatLHYSN8F+QJI1FVFPekWd+s90tOFZK5ctzXEZbrPHJdQNVAFr7bAJ4My0rXYBR9iG8QjwmptOFpG4+Od2c06oxwrENK5ckYpRlGD26DtEovF9x+8GcO/vbQ8NKL85RH5apE2SDwSFF3Tcm2gkkN+1NaR+2dYHV1ytpmllqcGn9r75km7LeWMJy3Me4sjsLzqRTH6b4ReshP3D591MoEWpKWFiWcYiO6WafOtARo6KvPuUazwV06USM9TleY2f9q+n3WQAK/XYM41d7nxWIIUzf6mkCAEiRvApPC0LSQ/TWL7132Ozq6B72BMOSj51bLlc8DhxU1JCm0wxwGzGWBjBIbNlFYxBXCYep+Pz2Crvo6U/rbi4knO2G45EttCNJAqE9lsdRUOK/ato9xuLjaCI4YYQadHeaxB87a1pM/0U8ELRqYPh2itpxjjUP4P3TaloxxxTX2JuMYDUMTy5RkVGUxEf7q4UrF1TnqkQ6mPclOMpW1+GvMP3WtzFLR5uj8tvmyqzi1JLiukto+IE1Ju9/elSDdwsOXhLUhV+R08p1TG7UbpAeEydBGrA+sUxNPrMkr70Ji7gOLLSbzC2kFeWf6h1x0XijcLDFfV7db7lJfGTSqql9AUjcDDc1Oztrw== julien@julien.wtf']
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
