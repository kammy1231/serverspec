require 'spec_helper'

if property["environment"]["set"] == "vps"
puts "Run Recipe postfix_vps"
##########################################

ctid = property["openvz"]["ctid"]
  describe command(%!vzctl exec #{ctid} 'rpm -q postfix'!) do
    its(:stdout) { should match 'postfix' }
end


##########################################
end
