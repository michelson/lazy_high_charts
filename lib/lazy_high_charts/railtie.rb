# encoding: UTF-8
module LazyHighCharts
  class Railtie < ::Rails::Railtie
    config.before_configuration do
      if config.action_view.javascript_expansions
        config.action_view.javascript_expansions[:high_charts] |= %w(highcharts exporting)
      end
    end
  end

end
