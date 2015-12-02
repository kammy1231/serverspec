require 'serverspec'
require 'net/ssh'
require 'specinfra/helper/set'
require 'json'
include Specinfra::Helper::Set


set :backend, :ssh

# if ENV['ASK_SUDO_PASSWORD']
#   begin
#     require 'highline/import'
#   rescue LoadError
#     fail "highline is not available. Try installing it."
#   end
#   set :sudo_password, ask("Enter sudo password: ") { |q| q.echo = false }
# else
#   set :sudo_password, ENV['SUDO_PASSWORD']
# end

host = ENV['TARGET_HOST']
bname = ENV['BNAME']
set_property JSON.parse(File.read("./nodes/#{bname}.json"))['attributes']
options = Net::SSH::Config.for(host)

options[:user] ||= Etc.getlogin

set :host, options[:host_name] || host
options[:password] = "odebuchan!"
set :shell, '/bin/bash'
set :ssh_options, options
