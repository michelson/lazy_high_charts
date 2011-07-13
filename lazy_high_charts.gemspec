# -*- encoding: utf-8 -*-
#require File.expand_path("../lib/lazy_high_charts/version", __FILE__)
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'lazy_high_charts/version'

Gem::Specification.new do |s|
  s.name        = "lazy_high_charts"
  s.version     = LazyHighCharts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Miguel Michelson Martinez','Deshi Xiao']
  s.email       = ['miguelmichelson@gmail.com','xiaods@gmail.com']
  s.homepage    = "https://github.com/xiaods/lazy_high_charts"
  s.summary     = "lazy higcharts plugin for rails"
  s.description = "use highcharts js libary to visualization your data plugin for rails"

  s.extra_rdoc_files  = [ "README.md", "CHANGELOG.md" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "bundler", "~> 1.0"

  s.add_development_dependency "webrat", "~> 0.7"
  s.add_development_dependency "rspec", "~> 2.0"
  s.add_development_dependency "rails", "~> 3.0"

  s.description = <<-DESC
    Lazy_high_charts provides a Rails interface for utilize highcharts to displaying graphs.
  DESC

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'  

end
