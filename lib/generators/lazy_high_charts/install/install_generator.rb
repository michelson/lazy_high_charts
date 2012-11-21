# encoding: UTF-8

module LazyHighCharts
  class InstallGenerator < Rails::Generators::Base
    desc "This generator install highcharts javascripts and (optionally) highstock"

    # Supply generator for Rails 3.0.x or if asset pipeline is not enabled
    if ::Rails.version < "3.1" || !::Rails.application.config.assets.enabled
      source_root File.expand_path('../../../../../vendor/assets/javascripts', __FILE__)
      def copy_highcharts
        say_status("copying", "HighCharts (2.3.3)", :green)
        copy_file "highcharts.js", "public/javascripts/highcharts.js"
        copy_file "exporting.js", "public/javascripts/exporting.js"
        copy_file "highstock.js","public/javascripts/highstock.js"
      end
    else

      # Just show instructions so people will know what to do when
      # mistakenly using generator for Rails 3.1+ apps
      def do_nothing
        say_status("deprecated", "You are using Rails 3.1+ with the asset pipeline enabled, so this generator is not needed.")
        say_status("", "The necessary files are already in your asset pipeline.")
        say_status("", "Just add `//= require highcharts` and `//= require exporting` to your app/assets/javascripts/application.js")
        say_status("", "If you upgraded your app from Rails 3.0 and still have highcharts.js, exporting.js, or highstock.js in your javascripts, be sure to remove them.")
        say_status("", "If you do not want the asset pipeline enabled, you may turn it off in application.rb and re-run this generator.")
        # ok,nothing
      end
    end

  end
end
