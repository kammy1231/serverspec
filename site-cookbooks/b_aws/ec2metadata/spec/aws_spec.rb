if property[:environment][:set] == "aws"
puts "Run Recipe ec2metadata"
###
describe ec2metadata('local_ipv4') do
  it { should eq "#{property[:server][:local_ipv4]}" }
end

###
end
