# coding: utf-8
require 'LazyHighCharts'
require 'LazyHighCharts/layout_helper'

ActionView::Base.send :include, LazyHighCharts::LayoutHelper

module ActionView::Helpers::AssetTagHelper
  register_javascript_expansion :high_charts => ["highcharts"]
end
