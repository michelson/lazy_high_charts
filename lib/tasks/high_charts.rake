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

      # Modules
      sh "curl -# http://code.highcharts.com/modules/accessibility.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/accessibility.js"
      sh "curl -# http://code.highcharts.com/modules/annotations.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/annotations.js"
      sh "curl -# http://code.highcharts.com/modules/boost.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/boost.js"
      sh "curl -# http://code.highcharts.com/modules/broken-axis.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/broken-axis.js"
      sh "curl -# http://code.highcharts.com/modules/canvas-tools.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/canvas-tools.js"
      sh "curl -# http://code.highcharts.com/modules/data.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/data.js"
      sh "curl -# http://code.highcharts.com/modules/exporting.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/exporting.js"
      sh "curl -# http://code.highcharts.com/modules/drilldown.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/drilldown.js"
      sh "curl -# http://code.highcharts.com/modules/funnel.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/funnel.js"
      sh "curl -# http://code.highcharts.com/modules/heatmap.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/heatmap.js"
      sh "curl -# http://code.highcharts.com/modules/no-data-to-display.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/no-data-to-display.js"
      sh "curl -# http://code.highcharts.com/modules/offline-exporting.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/offline-exporting.js"
      sh "curl -# http://code.highcharts.com/modules/solid-gauge.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/solid-gauge.js"
      sh "curl -# http://code.highcharts.com/modules/treemap.js -L --compressed -o vendor/assets/javascripts/highcharts/modules/treemap.js"

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
