# encoding: utf-8

require 'lazy_high_charts'
require 'lazy_high_charts/layout_helper.rb'

require 'rails'

module LazyHighCharts
  class Railtie < Rails::Railtie
    initializer 'lazy_high_charts.initialize', :after => :after_initialize do
      ActionView::Base.send :include, LazyHighCharts::LayoutHelper
      ActionView::Base.send(:include, LazyHighCharts::LayoutHelper)
    end
  end
end
