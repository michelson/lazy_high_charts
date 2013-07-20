require File.join(File.dirname(__FILE__), *%w[lazy_high_charts core_ext string])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts options_key_filter])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts layout_helper])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts high_chart])
if defined?(::Rails::Railtie)
  require File.join(File.dirname(__FILE__), *%w[lazy_high_charts railtie])
  require File.join(File.dirname(__FILE__), *%w[lazy_high_charts engine]) if ::Rails.version.to_s >= '3.1'
end

module LazyHighCharts
  def self.root
    File.expand_path '../..', __FILE__
  end
end
