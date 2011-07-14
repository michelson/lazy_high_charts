module LazyHighCharts
    class InstallGenerator < Rails::Generators::Base
      desc "This generator install highcharts javascripts"
      
      def install_highcharts(opts = nil)
        say_status("installing", "Highcharts javascript (github STOCK branch)", :green)
        get "https://raw.github.com/highslide-software/highcharts.com/stock/js/highcharts.src.js","public/javascripts/highcharts.js"
      rescue OpenURI::HTTPError
        say_status("warning", "could not find Highcharts javascript file", :yellow)
      end
      
    end
end
