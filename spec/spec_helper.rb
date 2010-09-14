require 'rubygems'
require 'rspec'
require 'json'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash'
require 'action_view/helpers/javascript_helper'
require 'action_view/helpers/text_helper'
require 'action_view/helpers/tag_helper'

include ActionView::Helpers::TagHelper::CaptureHelper

module RSpecRails
  class Application < ::Rails::Application
  end
end

Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}

