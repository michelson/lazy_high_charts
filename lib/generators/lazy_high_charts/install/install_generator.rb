module LazyHighCharts
    class InstallGenerator < Rails::Generators::Base
      desc "This generator install highcharts javascripts"
      
      def install_highcharts
        say_status("installing", "Highcharts javascript (github HEAD)", :green)
        get "https://github.com/highslide-software/highcharts.com/raw/master/js/highcharts.src.js","public/javascripts/highcharts.js"
      rescue OpenURI::HTTPError
        say_status("warning", "could not find Highcharts javascript file", :yellow)
      end
      
    end
end
