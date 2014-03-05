# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Searchtester::Application.load_tasks

## rspec stuff
require 'rspec/core/rake_task'

## default
task default: :spec
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = '--format documentation --drb --color'
end

## unit tests
namespace :spec do
  desc 'Run all specs in spec directory (excluding feature specs)'
  RSpec::Core::RakeTask.new(:units) do |task|
    task.rspec_opts = '--format documentation --drb'
    file_list = FileList['spec/**/*_spec.rb']
    task.pattern = file_list.exclude("spec/features/**/*_spec.rb")
  end
end

