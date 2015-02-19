#
# Cookbook Name:: madalynn
# Recipe:: hosts
#
# Copyright 2015, Madalynn
#
# All rights reserved - Do Not Redistribute
#

host = node['hostname']

entries = {
    'milhouse' => '10.10.10.1',
    'kodos' => '10.10.10.2',
    'homer' => '10.10.10.3',
    'marge' => '10.10.10.4',
    'flanders' => '10.10.10.5',
    'burns' => '10.10.10.253',
    'moe' => '10.10.10.254',

    host => '127.0.1.1'
}

entries.each do |h, ip|
    hostsfile_entry ip do
        hostname  "#{h}.madalynn.eu"
        aliases   ["#{h}.madalynn.local", h]
        unique    true
        action    :create
    end
end
