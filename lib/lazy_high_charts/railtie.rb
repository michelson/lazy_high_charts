# encoding: utf-8

module LazyHighCharts
  # @private
  class Railtie < Rails::Railtie
    initializer 'lazy_high_charts.initialize' do
      ActiveSupport.on_load(:action_view) do
        include LazyHighCharts::LayoutHelper
      end
    end
  end
end
