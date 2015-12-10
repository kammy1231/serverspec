if property[:environment][:set] == "aws"
puts "Run Recipe ec2metadata"
###
describe ec2_metadata_public_ip do
  it { should be_exist }
end
p property
describe ec2_metadata("security-groups") do
  its(:stdout) { should match %!#{property[:ec2][:sg]}! }
  #its(:stdout) { should match %!default\navss-archiver! }
end

describe ec2_metadata("iam/security-credentials") do
 its(:stdout) { should match %!av_archiver! }
end

###
end
