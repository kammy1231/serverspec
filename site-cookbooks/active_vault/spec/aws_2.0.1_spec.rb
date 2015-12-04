#require 'spec_helper'
if property[:environment][:set] == "aws"
puts "Run Recipe postfix_aws"
if property[:vault][:version] == "2.0.1"

describe command(%!ls /usr/local!) do
  its(:stdout) { should match %r!active! }
end



end
end
