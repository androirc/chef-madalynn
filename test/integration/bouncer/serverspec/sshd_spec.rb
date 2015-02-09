require 'serverspec'
set :backend, :exec

describe 'sshd' do
  describe service('ssh') do
    it { should be_enabled }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should be_a_file }
    its(:content) { should match(/Port 22/) }
    its(:content) { should match(/ListenAddress 0.0.0.0/) }
  end
end
