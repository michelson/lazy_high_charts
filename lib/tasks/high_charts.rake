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
  task :update => [:core, :stock]
  task :core do
    say "Grabbing Core from Highcharts codebase..." do
      sh "mkdir -p vendor/assets/javascripts/highcharts/modules/"
      sh "mkdir -p vendor/assets/javascripts/highcharts/adapters/"

      sh "curl -# http://code.highcharts.com/highcharts.js -L --compressed -o vendor/assets/javascripts/highcharts/highcharts.js"
      sh "curl -# http://code.highcharts.com/highcharts-more.js -L --compressed -o vendor/assets/javascripts/highcharts/highcharts-more.js"
      sh "curl -# http://code.highcharts.com/modules/exporting.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/exporting.js"
      sh "curl -# http://code.highcharts.com/modules/funnel.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/funnel.js"
      sh "curl -# http://code.highcharts.com/adapters/mootools-adapter.js -L --compressed -o vendor/assets/javascripts/highcharts/adapters/mootools-adapter.js"
      sh "curl -# http://code.highcharts.com/adapters/prototype-adapter.js -L --compressed -o vendor/assets/javascripts/highcharts/adapters/prototype-adapter.js"
    end
  end

  task :stock do
    say "Grabbing Highcharts Stock JS from Upstream..." do

      sh "mkdir -p vendor/assets/javascripts/highcharts/stock/modules/"
      sh "mkdir -p vendor/assets/javascripts/highcharts/stock/adapters/"
      
      sh "curl -# http://code.highcharts.com/stock/highstock.js -L --compressed -o vendor/assets/javascripts/highcharts/highstock.js"
      sh "curl -# http://code.highcharts.com/stock/highcharts-more.js -L --compressed -o vendor/assets/javascripts/highcharts/stock/highcharts-more.js"
      sh "curl -# http://code.highcharts.com/stock/modules/exporting.js -L --compressed -o vendor/assets/javascripts/highcharts/stock/modules/exporting.js"
      sh "curl -# http://code.highcharts.com/stock/modules/funnel.js -L --compressed -o vendor/assets/javascripts/highcharts/stock/modules/funnel.js"
      sh "curl -# http://code.highcharts.com/stock/adapters/mootools-adapter.js -L --compressed -o vendor/assets/javascripts/highcharts/stock/adapters/mootools-adapter.js"
      sh "curl -# http://code.highcharts.com/stock/adapters/prototype-adapter.js -L --compressed -o vendor/assets/javascripts/highcharts/stock/adapters/prototype-adapter.js"
    end
  end

end
