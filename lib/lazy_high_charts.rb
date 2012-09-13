require File.join(File.dirname(__FILE__), *%w[lazy_high_charts core_ext string])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts options_key_filter])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts high_chart])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts layout_helper])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts railtie]) if defined?(::Rails::Railtie)

module LazyHighCharts

end
