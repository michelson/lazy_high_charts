# encoding: utf-8
require 'rubygems'
require 'rake/dsl_definition'
require 'rake'
require 'rspec/core/rake_task'
require 'bundler'

desc 'Default: run specs.'
task :default => :spec

desc 'Test the Lazy_high_charts gem.'
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = FileList['spec/**/*_spec.rb']
end
