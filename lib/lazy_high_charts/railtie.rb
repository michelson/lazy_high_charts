require 'lazy_high_charts'
<<<<<<< HEAD
require 'lazy_high_charts/layout_helper'
=======
require 'lazy_high_charts/layout_helper.rb'

>>>>>>> 954abaf04d09af7f5b59dd308f177a83d3c928a5
require 'rails'

module LazyHighCharts

    class Railtie < ::Rails::Railtie
      config.before_configuration do
        config.action_view.javascript_expansions[:high_charts] = %w(highcharts)
      end

      initializer 'lazy_high_charts.initialize' do
        ActiveSupport.on_load(:action_view) do
          include LazyHighCharts::LayoutHelper
        end
      end
    end
    
end
