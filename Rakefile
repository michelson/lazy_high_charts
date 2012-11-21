# encoding: utf-8

require 'rspec/core/rake_task'
require 'bundler'
Bundler::GemHelper.install_tasks

desc 'Default: run unit specs.'
task :default => :spec

desc 'Test the lazy_high_charts plugin.'
RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
end
