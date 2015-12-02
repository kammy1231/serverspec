require 'spec_helper'

puts "Run Recipe postfix"

if property["environment"]["set"] == "vps"
  ctid = property["openvz"]["ctid"]
  describe command("vzctl exec #{ctid} 'rpm -q postfix'") do
    its(:stdout) { should match 'postfix' }
  end
end
################################################################################
if property["environment"]["set"] == "aws"
  describe command("ls") do
    its(:exit_status) { should eq 0 }
  end
end
