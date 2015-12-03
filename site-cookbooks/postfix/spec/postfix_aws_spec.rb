require 'spec_helper'

if property["environment"]["set"] == "aws"
puts "Run Recipe postfix_aws"
##########################################

describe command("ls") do
    its(:exit_status) { should eq 0 }
end

##########################################
end
