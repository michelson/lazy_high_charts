# coding: utf-8
require 'rubygems'
require 'bundler/setup'

require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require "active_support/core_ext"


require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/layout_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/options_key_filter'))

require 'webrat'
require 'rspec'

RSpec.configure do |config|
  config.include ActionView::Helpers
  config.include Webrat::Matchers
end

module HighChartsHelper
  include ActionView::Helpers::TagHelper
end
