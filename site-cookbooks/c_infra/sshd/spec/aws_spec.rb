if property[:environment][:set] == "aws"
puts "Run Recipe sshd"
###
describe package('openssh') do
  it { should be_installed }
end

describe process("sshd") do
  it { should be_running }
end

describe port(10022) do
  it { should be_listening.on('0.0.0.0').with('tcp') }
end
###
end
