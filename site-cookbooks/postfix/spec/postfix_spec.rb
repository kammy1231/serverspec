require 'spec_helper'

puts "cookbook postfix"

describe command("vzctl exec #{property["openvz"]["ctid"]} 'rpm -q postfix'") do
  its(:stdout) { should match 'postfix' }
end
