# coding: utf-8
require 'LazyHighCharts'
require 'LazyHighCharts/high_charts_helper'
ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Base.send :include, LazyHighCharts::LayoutHelper

