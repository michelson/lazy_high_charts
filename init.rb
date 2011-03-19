# coding: utf-8
require 'LazyHighCharts'
require 'LazyHighCharts/layout_helper'

ActionView::Base.send :include, LazyHighCharts::LayoutHelper

ActiveSupport.on_load(:action_view) do
  ActiveSupport.on_load(:after_initialize) do
    ActionView::Helpers::AssetTagHelper::register_javascript_expansion :high_charts => ["highcharts"]
  end
end

