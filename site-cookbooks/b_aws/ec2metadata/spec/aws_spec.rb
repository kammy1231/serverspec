if property[:environment][:set] == "aws"
puts "Run Recipe ec2metadata"
###
describe ec2_metadata_ami_id("#{property[:ec2][:ami_id]}") do
  it { should be_exist }
end

describe ec2_metadata("security-groups") do
  its(:stdout) { should match %!default! }
  its(:stdout) { should match %!avss-archiver! }
end
###
end
