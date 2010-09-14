require 'rubygems'
require 'rspec'
require 'json'

require 'active_support/core_ext/object'
require 'active_support/core_ext/hash'

require 'action_view/helpers/capture_helper'
require 'action_view/helpers/tag_helper'
require 'action_view/helpers/prototype_helper'
require 'action_view/helpers/javascript_helper'


Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}


