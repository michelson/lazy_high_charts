# coding: utf-8
require 'LazyHighCharts'
require 'LazyHighCharts/high_charts_helper'

ActionView::Helpers::AssetTagHelper.register_javascript_expansion :high_charts => ["highcharts"]
ActionView::Helpers::AssetTagHelper.register_javascript_expansion :ie_high_charts => ["excanvas.compiled"]

ActionView::Base.send :include, Formtastic::HighChartsHelper

