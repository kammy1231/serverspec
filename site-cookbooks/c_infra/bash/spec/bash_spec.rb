
puts "cookbook bash"

if property[:environment][:set] == "aws"
  describe command("aws s3 ls") do
    its(:stdout) { should match %r!av-01! }
  end
end
