enable_firewall = node[:tags].include?('use_firewall')

if not node['dev_mode']
    return if not enable_firewall
end

# All hosts have public IP on eth0 and private IP on eth1
firewall 'default'

interfaces = ['eth0']
if node['network']['interfaces'].key?('eth1')
    interfaces << 'eth1'
end

private_interface = (node['network']['interfaces'].key?('eth1') && 'eth1') || 'eth0'
if node.role?('has_public_ip') and private_interface == 'eth0'
    Chef::Log.warn('Logic error: this node is tagged as having a public IP, but it has no eth1 interface.')
end

# Allow SSH on public interface only on bouncer
if node.role?('bouncer')
    firewall_rule 'ssh' do
      port      22
      interface 'eth0'
      command   :allow
    end
else
    ssh_interface = (node['network']['interfaces'].key?('eth1') && 'eth1') || 'eth0'

    firewall_rule 'ssh' do
      port      22
      interface ssh_interface
      command   :allow
    end
end

firewall_rule 'icinga2' do
    port      5665
    interface private_interface
    command   :allow
end

if node.role?('webservice')
    interfaces.each do |interface|
        firewall_rule 'http/https' do
          port      [80, 443]
          interface interface
          command   :allow
        end
    end
end

if node.name == "lisa"
    firewall_rule 'vpn' do
      protocol  :udp
      port      1194
      interface 'eth0'
      command   :allow
    end
end

if node.role?('dns')
    interfaces.each do |interface|
        [:udp, :tcp].each do |protocol|
            firewall_rule 'dns' do
              protocol  protocol
              port      53
              interface interface
              command   :allow
            end
        end
    end
end
