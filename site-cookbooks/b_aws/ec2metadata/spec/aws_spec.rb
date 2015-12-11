if property[:environment][:set] == "aws"
puts "Run Recipe ec2metadata"
###
describe ec2_metadata_public_ip do
  it { should be_exist }
end

describe ec2_metadata("security-groups") do
  its(:stdout) { should match %!#{property[:ec2][:sg]}! }
end

describe ec2_metadata("iam/security-credentials") do
 its(:stdout) { should match %!#{property[:ec2][:iam]}! }
end

describe ec2_metadata("instance-id") do
  its(:stdout) { should match %!#{property[:ec2][:i_id]}! }
end

describe ec2_metadata("instance-type") do
  its(:stdout) { should match %!#{property[:ec2][:i_type]}! }
end

###
end
