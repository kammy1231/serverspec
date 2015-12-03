require 'rake'
require 'rspec/core/rake_task'
require 'json'

task :spec => 'spec:all'
task :default  => :spec

def get_roles(node_file)
  roles = []
  JSON.parse(File.read(node_file))['run_list'].each do |role|
    roles << role.gsub(/role\[(.+)\]/, '\1')
  end
  roles
end

def get_recipes(role)
  recipes = []
  JSON.parse(File.read("roles/#{role}.json"))['run_list'].each do |recipe|
    recipes << recipe.gsub(/recipe\[(.+)\]/, '\1')
  end
  recipes
end

namespace :spec do
  all = []
  Dir.glob("nodes/**/*.json").each do |node_file|
    recipes = []

    get_roles(node_file).each do |role|
      recipes << get_recipes(role)
    end

    recipes.flatten!

    bname = File.basename(node_file, ".json")
    node = JSON.parse(File.read(node_file))['target_host']
    node_short = node.split(".")[0]

    all << node_short

    desc "Run serverspec to #{bname}"
    RSpec::Core::RakeTask.new(node_short.to_sym) do |t|
      ENV['TARGET_HOST'] = node
      ENV['NODE_FILE'] = node_file
      t.pattern = "site-cookbooks/\{#{recipes.join(',')}\}/spec/*_spec.rb"
      t.fail_on_error = false
      puts "Run Serverspec to #{bname}"
      puts "Run List to #{recipes}"
    end
  task :all => all
  task :default => :all
  end
end
