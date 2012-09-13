#
# A way to filter certain keys of data provided to the LazyHighCharts#series method and the LazyHighCharts#options
#
# Add methods or keys to the FILTER_MAP hash to have them applied to the options in a series
# In the FILTER_MAP, the hash keys are methods, and the values are arrays of the hash keys the filter should be
# applied to
#
# Be careful that it is OK to filter the hash keys you specify for every key of the options or series hash
#
module LazyHighCharts
  module OptionsKeyFilter
    def self.milliseconds value
      value * 1000
    end

    def self.date_to_js_code date
      "Date.UTC(#{date.year}, #{date.month - 1}, #{date.day})".js_code
    end

    def self.filter options
      new_options = options.map do |k, v|
        if v.is_a? ::Hash
          v = filter v
        else
          FILTER_MAP.each_pair do |method, matchers|
            v = method.call(v) if matchers.include?(k)
          end
        end
        [k, v]
      end
      Hash[new_options]
    end

    FILTER_MAP = {
        method(:milliseconds) => [:pointInterval],
        method(:date_to_js_code) => [:pointStart]
    }
  end
end