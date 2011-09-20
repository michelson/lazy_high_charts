# coding: utf-8

module LazyHighCharts
  module LayoutHelper
    
    def high_chart(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph(placeholder,object , &block).concat(content_tag("div","", object.html_options))
    end
    
    def high_stock(placeholder, object  , &block)
      object.html_options.merge!({:id=>placeholder})
      object.options[:chart][:renderTo] = placeholder
      high_graph_stock(placeholder,object , &block).concat(content_tag("div","", object.html_options))
    end

    def high_graph(placeholder, object, &block)
      build_html_output("Chart", placeholder, object, &block)
    end

    def high_graph_stock(placeholder, object, &block)
      build_html_output("StockChart", placeholder, object, &block)
    end

    def build_html_output(type, placeholder, object, &block)
      options_collection = []
      object.options.keys.each do |key|
        k = key.to_s.camelize.gsub!(/\b\w/) { $&.downcase }
        options_collection << "#{k}: #{object.options[key].to_json}"
      end
    
      graph =<<-EOJS
      <script type="text/javascript">
      jQuery(function() {
            // 1. Define JSON options
              var options = { #{options_collection.join(",")} };
            // 2. Add callbacks (non-JSON compliant)
              #{capture(&block) if block_given?}
            // 3. Build the chart
            var chart = new Highcharts.#{type}(options);
        });
        </script>
      EOJS
      
      if defined?(raw)
        return raw(graph) 
      else
        return graph
      end
      
    end
  end
end

