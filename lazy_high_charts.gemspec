# -*- encoding: utf-8 -*-
#require File.expand_path("../lib/lazy_high_charts/version", __FILE__)
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'lazy_high_charts/version'


Gem::Specification.new do |s|
  s.name        = "lazy_high_charts"
  s.version     = LazyHighCharts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Miguel Michelson Martinez']
  s.email       = ['miguelmichelson@gmail.com']
  s.homepage    = "https://github.com/xiaods/lazy_high_charts"
  s.summary     = "lazy higcharts plugin for rails"
  s.description = "use highcharts js libary to visualization your data plugin for rails"

  s.files       = %w( README.md Rakefile CHANGELOG )
  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("spec/**/*")
  s.files       += Dir.glob("javascripts/**/*")
  s.files       += Dir.glob("autotest/*")

  s.require_path  = 'lib'
  s.extra_rdoc_files  = [ "README.md", "CHANGELOG" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "bundler", ">= 1.0.0"

  s.add_development_dependency "rspec", ">= 2.0.1"
  s.add_development_dependency "autotest"


end
