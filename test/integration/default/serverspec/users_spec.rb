require 'serverspec'
set :backend, :exec

users = %w{
  blinkseb
  aerialls
  madalynn
}

describe 'Users' do
  users.each do |u|
    describe user(u) do
      it { should exist }
    end
  end
end
