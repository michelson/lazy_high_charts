module LazyHighCharts
    class InstallGenerator < Rails::Generators::Base
      desc "This generator install highcharts javascripts"
      
      def install_highcharts(opts = nil)
        say_status("installing", "Highcharts javascript (github STOCK branch)", :green)
        if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR >= 1
         get 'http://highcharts.com/js/highstock.js', 'vendor/assets/javascripts/highcharts.js'
        else
          get "https://raw.github.com/highslide-software/highcharts.com/stock/js/highcharts.src.js","public/javascripts/highcharts.js"
        end
              rescue OpenURI::HTTPError
        say_status("warning", "could not find Highcharts javascript file", :yellow)
      end
      
    end
end
