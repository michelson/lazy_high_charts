# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'lazy_high_charts/version'

Gem::Specification.new do |s|
  s.name        = "lazy_high_charts"
  s.version     = LazyHighCharts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Miguel Michelson Martinez','Deshi Xiao']
  s.email       = ['miguelmichelson@gmail.com','xiaods@gmail.com']
  s.homepage    = "https://github.com/xiaods/lazy_high_charts"
  s.summary     = "lazy higcharts gem for rails"
  s.description = "use highcharts js libary to visualization your data by rubygem/rails"

  s.extra_rdoc_files  = [ "README.md", "CHANGELOG.md" ]
  s.rdoc_options      = [ "--charset=UTF-8" ]

  s.required_rubygems_version = "~> 1.3"

  s.add_dependency "bundler", "~> 1.0"

  s.description = <<-DESC
    lazy_high_charts is a Rails 3.x gem for displaying Highcharts graphs.
  DESC

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select{|f| f =~ /^bin/}
  s.require_path = 'lib'

end
