include Sshd::Helpers

def whyrun_supported?
  true
end

action :update do
  converge_by("Updating #{ @new_resource }") do
    update_config
  end
end

def update_config
  sshd_config = generate_sshd_config(node['sshd']['sshd_config'])

  name = @new_resource.name
  template name do
    owner     'root'
    group     'root'
    mode      00644
    source    'sshd_config.erb'
    variables config: sshd_config
    action    :create
  end

  #service node['sshd']['service_name'] do
  #  # Due to a bug in Chef, we need to manually set the provider to Upstart for Ubuntu 13.10 and 14.04
  #  # This will probably be fixed in chef-client 11.14
  #  provider Chef::Provider::Service::Upstart if node['platform'] == 'ubuntu' && node['platform_version'] >= '13.10' && node['platform_version'] <= '14.04'
  #  supports status: true, restart: true, reload: true
  #  subscribes :restart, "template[#{name}]"
  #end
end
