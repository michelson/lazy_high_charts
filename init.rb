# coding: utf-8
require 'lazy_high_charts'
require 'lazy_high_charts/high_charts_helper'
ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Base.send :include, LazyHighCharts::LayoutHelper

