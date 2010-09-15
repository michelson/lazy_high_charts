# coding: utf-8
require 'high_chart'
require "high_charts_helper"

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Helpers::AssetTagHelper.register_javascript_expansion :ie_high_charts => ["excanvas.compiled.js"]

ActionView::Base.send(:include, HighChartsHelper)


