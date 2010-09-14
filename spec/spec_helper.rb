require 'rails/all'

module RSpecRails
  class Application < ::Rails::Application
  end
end

Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each {|f| require f}

