# coding: utf-8
require 'rubygems'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_mailer'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/high_chart'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/high_charts_helper'))

require 'webrat'
require 'webrat/core/matchers'


require 'rspec'
Rspec.configure do |c|
  c.mock_with :rspec
end

module HighChartsHelper
  include ActionView::Helpers::TagHelper
end
