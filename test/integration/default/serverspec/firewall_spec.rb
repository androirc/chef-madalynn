require 'serverspec'
set :backend, :exec

describe 'firewall' do
  describe service('ufw') do
    it { should be_enabled }
    it { should be_running }
  end
end
