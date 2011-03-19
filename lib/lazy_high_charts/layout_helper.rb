# coding: utf-8

module LazyHighCharts
  module LayoutHelper

    def high_chart(placeholder, object, &block)
      if object
        object.html_options.merge!({:id=>placeholder})
        object.options[:chart][:renderTo] = placeholder
        high_graph(placeholder,object , &block).concat(content_tag("div","", object.html_options))
      end
    end

    def high_graph(placeholder, object, &block)
      @options = {
        "chart"       => object.options[:chart],
        "title"       => object.options[:title],
        "legend"      => object.options[:legend],
        "xAxis"       => object.options[:xAxis],
        "yAxis"       => object.options[:yAxis],
        "credits"     => object.options[:credits],
        "plotOptions" => object.options[:plotOptions],
        "series"      => object.options[:series],
        "subtitle"    => object.options[:subtitle]
      }.reject{|k,v| v.nil?}

      graph =<<-EOJS
      <script type="text/javascript">
      jQuery(function() {
            var options = { #{format_options} };
      #{capture(&block) if block_given?}
            var chart = new Highcharts.Chart(options);
        });
        </script>
      EOJS

      return raw(graph) 

    end

    def format_options
      options = []
      @options.each do |k,v|
        options << "#{k}: #{v.to_json}"
      end
      options << "tooltip:{}"
      options.join(', ')
    end

  end
end
