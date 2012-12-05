require File.join(File.dirname(__FILE__), *%w[lazy_high_charts core_ext string])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts options_key_filter])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts high_chart])
require File.join(File.dirname(__FILE__), *%w[lazy_high_charts layout_helper])
if defined?(::Rails::Railtie)
  require File.join(File.dirname(__FILE__), *%w[lazy_high_charts railtie])
  require File.join(File.dirname(__FILE__), *%w[lazy_high_charts engine]) if ::Rails.version >= '3.1'
end

module LazyHighCharts

end
