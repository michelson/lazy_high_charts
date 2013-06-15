# -*- encoding: utf-8 -*-
$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
version = File.read(File.expand_path("../GEM_VERSION", __FILE__)).strip

Gem::Specification.new do |s|
  s.name = "lazy_high_charts"
  s.version = version
  s.platform = Gem::Platform::RUBY
  s.authors = ['Miguel Michelson', 'Deshi Xiao']
  s.email = ['miguelmichelson@gmail.com', 'xiaods@gmail.com']
  s.homepage = "https://github.com/michelson/lazy_high_charts"
  s.summary = "rubyist way to render variant chart by highcharts without write javascript right now, rails gem library."
  s.description = "lazy_high_charts is leading edge rubyist render charts gem for displaying Highcharts graphs."

  s.extra_rdoc_files = ["README.md", "CHANGELOG.md"]
  s.rdoc_options = ["--charset=UTF-8"]
  key = File.expand_path("~/.ssh/gem-private_key.pem")
  if File.exist?(key)
    s.signing_key = key
    s.cert_chain = ["gem-public_cert.pem"]
  end

  s.required_rubygems_version = ">= 1.3"

  s.add_dependency "bundler", ">= 1.0"
  s.add_dependency "hash-deep-merge"

  s.description = <<-DESC
    lazy_high_charts is leading edge rubyist render charts gem for displaying Highcharts graphs.
  DESC

  s.files = `git ls-files`.split("\n")
  s.executables = `git ls-files`.split("\n").select { |f| f =~ /^bin/ }
  s.require_path = 'lib'

end
