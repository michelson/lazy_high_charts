require 'rake'
require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'

if defined?(RSpec)
  desc 'Test the formtastic plugin.'
  RSpec::Core::RakeTask.new('spec') do |t|
    t.pattern = FileList['spec/**/*_spec.rb']
  end
end
