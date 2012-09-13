# coding: utf-8
require 'rubygems'
require 'bundler'
Bundler.setup

require 'active_support'
require 'action_pack'
require 'action_view'
require 'action_controller'
require 'rails'
#require 'action_mailer'
require "active_support/core_ext"


require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/layout_helper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/lazy_high_charts/options_key_filter'))

require 'webrat'
require 'rspec'

# RSpec 1.x and 2.x compatibility
if defined?(RSpec)
  RSPEC_NAMESPACE = RSPEC_CONFIGURER = RSpec
elsif defined?(Spec)
  RSPEC_NAMESPACE = Spec
  RSPEC_CONFIGURER = Spec::Runner
else
  begin
    require 'rspec'
    RSPEC_NAMESPACE = RSPEC_CONFIGURER = Rspec
  rescue LoadError
    require 'spec'
    RSPEC_NAMESPACE = Spec
    RSPEC_CONFIGURER = Spec::Runner
  end
end

RSPEC_CONFIGURER.configure do |config|
  config.include ActionView::Helpers  
  config.include Webrat::Matchers
end

module HighChartsHelper
  include ActionView::Helpers::TagHelper
end
