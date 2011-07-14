<<<<<<< HEAD
# encoding: utf-8
require 'lazy_high_charts'
require 'lazy_high_charts/layout_helper'
=======
# coding: utf-8
require 'lazy_high_charts'
require 'lazy_high_charts/layout_helper'
ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Base.send :include, LazyHighCharts::LayoutHelper
>>>>>>> 954abaf04d09af7f5b59dd308f177a83d3c928a5

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Base.send :include, LazyHighCharts::LayoutHelper
