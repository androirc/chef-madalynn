property :config, default: lazy { node['sshd']['sshd_config'].to_hash }
property :config_filename, default: node["sshd"]["config_file"]
property :sshd_path, default: node["sshd"]["sshd_path"]
property :service_name, default: node["sshd"]["service_name"]

class Chef::Resource
    include Sshd::Helpers
end

action :update do
  sshd_config = generate_sshd_config(config)

  # Check sshd_config
  execute 'check_sshd_config' do
    command "#{new_resource.sshd_path} -t -f #{new_resource.config_filename}"
    action :nothing
  end

  service service_name do
    supports status: true, restart: true, reload: true
    action :nothing
  end

  template config_filename do
    owner     'root'
    group     node['root_group']
    mode      0o644
    cookbook  'sshd'
    source    'sshd_config.erb'
    variables config: sshd_config
    action    :create

    # Test sshd_config before actually restarting
    notifies :run, 'execute[check_sshd_config]', :immediately
    notifies :restart, "service[#{new_resource.service_name}]", :delayed
  end
end
