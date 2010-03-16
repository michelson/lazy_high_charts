module HighChartsHelper
  
  
  def high_chart(placeholder, object  , &block)
    object.html_options.merge!({:id=>placeholder})
    object.options[:chart][:renderTo] = placeholder
    high_graph(placeholder,object , &block).concat(content_tag("div","", object.html_options))
  end
  

  def high_graph(placeholder, object, &block)
    graph = javascript_tag <<-EOJS
      jQuery(function() {
        	var chart = new Highcharts.Chart({
            chart: #{object.options[:chart].to_json},
        		title: #{object.options[:title].to_json},
        		legend: #{object.options[:legend].to_json},
        		xAxis: #{object.options[:x_axis].to_json},
        		yAxis: #{object.options[:y_axis].to_json},
        		tooltip: { formatter: #{object.options[:tooltip_formatter]} },
        		credits: #{object.options[:credits].to_json},
        		plotOptions: #{object.options[:plot_options].to_json},
        		series: #{object.data.to_json}
     		});
        #{capture(&block) if block_given?}
      });
    EOJS
    
    return graph unless block_given?
    concat graph, block.binding
  end
  
end

