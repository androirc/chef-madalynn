require 'serverspec'
set :backend, :exec

describe 'Sudo' do
  describe group('sudo') do
    it { should exist }
  end

  describe user('madalynn') do
    it { should belong_to_group 'sudo' }
  end

  describe file('/etc/sudoers.d/sudo') do
    it { should be_a_file }
    its(:content) { should match(/NOPASSWD/) }
  end
end
