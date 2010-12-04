module LazyHighCharts
    class InstallGenerator < Rails::Generators::Base
      desc "This generator install highcharts javascripts"
      @@version = "2.1.1"
      
      def install_highcharts
        say_status("installing", "Highcharts javascript (github HEAD)", :green)
        get "https://github.com/highslide-software/highcharts.com/raw/master/js/highcharts.src.js","public/javascripts/highcharts.js"
      rescue OpenURI::HTTPError
        say_status("warning", "could not find Highcharts javascript file", :yellow)
      end

      def remove_highcharts
        say_status("removing", "Highcharts javascript (github HEAD)", :green)
        
      end 
    end
end