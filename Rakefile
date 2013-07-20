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

# Below implement highcharts js files bootstrap logic
def say(msg, &block)
  print "#{msg}..."

  if block_given?
      yield
    puts " Done."
  end
end

namespace :highcharts do
  desc "Update highcharts.js from latest Builds on Highcharts codebase: http://code.highcharts.com/"
  task :update => [:core, :stock, :exporting]
  task :core do
    say "Grabbing Core from Highcharts codebase..." do
      sh "curl -# http://code.highcharts.com/highcharts.js -o vendor/assets/javascripts/highcharts/highcharts.js"
      sh "curl -# http://code.highcharts.com/highcharts-more.js -o vendor/assets/javascripts/highcharts/highcharts-more.js"
      sh "curl -# http://code.highcharts.com/modules/exporting.js -o vendor/assets/javascripts/highcharts/modules/exporting.js"
      sh "curl -# http://code.highcharts.com/adapters/mootools-adapter.js -o vendor/assets/javascripts/highcharts/adapters/mootools-adapter.js"
      sh "curl -# http://code.highcharts.com/adapters/prototype-adapter.js -o vendor/assets/javascripts/highcharts/adapters/prototype-adapter.js"
    end
  end

  task :stock do
    say "Grabbing Highcharts Stock JS from Upstream..." do
      sh "curl -# http://code.highcharts.com/stock/highstock.js -o vendor/assets/javascripts/highcharts/highstock.js"
      sh "curl -# http://code.highcharts.com/stock/highcharts-more.js -o vendor/assets/javascripts/highcharts/stock/highcharts-more.js"
      sh "curl -# http://code.highcharts.com/stock/modules/exporting.js -o vendor/assets/javascripts/highcharts/stock/modules/exporting.js"
      sh "curl -# http://code.highcharts.com/stock/adapters/mootools-adapter.js -o vendor/assets/javascripts/highcharts/stock/adapters/mootools-adapter.js"
      sh "curl -# http://code.highcharts.com/stock/adapters/prototype-adapter.js -o vendor/assets/javascripts/highcharts/stock/adapters/prototype-adapter.js"
    end
  end

  task :exporting do
    say "Grabbing exporting files about phatmonjs solution, https://github.com/highslide-software/highcharts.com/tree/master/exporting-server/phantomjs"
    sh "curl -# https://raw.github.com/highslide-software/highcharts.com/master/exporting-server/phantomjs/highcharts-convert.js -o vendor/assets/javascripts/highcharts/highcharts-convert.js"
    sh "curl -# https://raw.github.com/highslide-software/highcharts.com/master/exporting-server/phantomjs/data.js -o vendor/assets/javascripts/highcharts/data.js"
    sh "curl -# https://raw.github.com/highslide-software/highcharts.com/master/exporting-server/phantomjs/jquery.1.9.1.min.js -o vendor/assets/javascripts/highcharts/jquery.1.9.1.min.js"
  end

end
