# coding: utf-8
require 'rubygems'
require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'action_mailer'

require 'rspec'

Rspec.configure do |c|
  c.mock_with :rspec
end

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/high_chart'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/high_charts_helper'))

module HighChartsHelper
  include ActionPack
  include ActionView::Context if defined?(ActionView::Context)
  include ActionView::Helpers::UrlHelper
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::ActiveRecordHelper if defined?(ActionView::Helpers::ActiveRecordHelper)
  include ActionView::Helpers::ActiveModelHelper if defined?(ActionView::Helpers::ActiveModelHelper)
  include ActionView::Helpers::DateHelper
  include ActionView::Helpers::CaptureHelper
  include ActionView::Helpers::AssetTagHelper
  include ActiveSupport
end


