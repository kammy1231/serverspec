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
node_file = ENV['NODE_FILE']
#set_property JSON.parse(File.read(node_file), symbolize_names: true)[:attributes]
attributes = JSON.parse(File.read(node_file), symbolize_names: true)[:attributes]
set_property attributes
options = Net::SSH::Config.for(host)

options[:user] ||= Etc.getlogin

set :host, options[:host_name] || host
options[:password] = "#{attributes[:server][:password]}"
set :shell, '/bin/bash'
set :ssh_options, options
