# coding: utf-8

module LazyHighCharts
  module LayoutHelper
    include ActionView::Helpers::TagHelper

    def high_chart(placeholder, object, &block)
      object.html_options.merge!({:id => placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph(placeholder, object, &block).concat(content_tag("div", "", object.html_options))
    end

    def high_stock(placeholder, object, &block)
      object.html_options.merge!({:id => placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph_stock(placeholder, object, &block).concat(content_tag("div", "", object.html_options))
    end

    def high_chart_globals(object)
      build_globals_html_output(object)
    end

    def high_graph(placeholder, object, &block)
      build_html_output("Chart", placeholder, object, &block)
    end

    def high_graph_stock(placeholder, object, &block)
      build_html_output("StockChart", placeholder, object, &block)
    end

    private

    def build_html_output(type, placeholder, object, &block)
      core_js =<<-EOJS
        var options = #{options_collection_as_string(object)};
        #{capture(&block) if block_given?}
        window.chart_#{placeholder.underscore} = new Highcharts.#{type}(options);
      EOJS

      encapsulate_js core_js
    end

    def build_globals_html_output(object)
      options_collection = [generate_json_from_hash(OptionsKeyFilter.filter(object.options))]

      core_js =<<-EOJS
        Highcharts.setOptions({ #{options_collection.join(',')} });
      EOJS

      encapsulate_js core_js
    end

    def generate_json_from_hash hash
      hash.each_pair.map do |key, value|
        k = key.to_s.camelize.gsub!(/\b\w/) { $&.downcase }
        %|"#{k}": #{generate_json_from_value value}|
      end.flatten.join(',')
    end

    def generate_json_from_value value
      if value.is_a? Hash
        %|{ #{generate_json_from_hash value} }|
      elsif value.is_a? Array
        %|[ #{generate_json_from_array value} ]|
      elsif value.respond_to?(:js_code) && value.js_code?
        value
      else
        value.to_json
      end
    end

    def generate_json_from_array array
      array.map { |value| generate_json_from_value(value) }.join(",")
    end

    def request_is_xhr?
      defined?(request) && request.respond_to?(:xhr?) && request.xhr?
    end

    def request_is_referrer?
      defined?(request) && request.respond_to?(:headers) && request.headers["X-XHR-Referer"]
    end

    def request_turbolinks_5_tureferrer?
      defined?(request) && request.respond_to?(:headers) && request.headers["Turbolinks-Referrer"]
    end

    def options_collection_as_string object
      options_collection = [generate_json_from_hash(OptionsKeyFilter.filter(object.options))]
      options_collection << %|"series": [#{generate_json_from_array(object.series_data)}]|
      "{ #{options_collection.join(',')} }"
    end

    def encapsulate_js(core_js)
      js_output = if request_is_xhr?
                    "#{js_start} #{core_js} #{js_end}"
                  # Turbolinks.version < 5
                  elsif defined?(Turbolinks) && request_is_referrer?
                    js_event_function(core_js, 'page:load')
                  # Turbolinks >= 5
                  elsif defined?(Turbolinks) && request_turbolinks_5_tureferrer?
                    js_event_function(core_js, 'turbolinks:load')
                  # Hotwire Turbo
                  elsif defined?(Turbo)
                    js_event_function(core_js, 'turbo:load')
                  else
                    js_event_function(core_js, 'load', 'window')
                  end

      if defined?(raw)
        return raw(js_output)
      else
        return js_output
      end
    end

    def js_event_function(core_js, event, target='document')
      <<-EOJS
        #{js_start}
          var f = function(){
            #{target}.removeEventListener('#{event}', f, true);
            #{core_js}
          };
          #{target}.addEventListener('#{event}', f, true);
        #{js_end}
      EOJS
    end

    def js_start
      <<-EOJS
        <script type="text/javascript">
        (function() {
      EOJS
    end

    def js_end
      <<-EOJS
        })()
        </script>
      EOJS
    end
  end
end

ActionView::Base.send :include, LazyHighCharts::LayoutHelper
