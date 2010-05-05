class HighChart
  CANVAS_DEFAULT_HTML_OPTIONS = {:style => "height: 300px, width:615px" }
  SERIES_OPTIONS = %w(lines points bars shadowSize colors)
  
  attr_accessor :data, :options, :placeholder, :html_options
  alias  :canvas :placeholder
  alias  :canvas= :placeholder=


  def initialize(canvas = nil, html_opts = {})

    @collection_filter = nil
    returning(self) do |high_chart|
      high_chart.data       ||= []
      high_chart.options    ||= {}
      high_chart.defaults_options
      high_chart.html_options = html_opts.reverse_merge(CANVAS_DEFAULT_HTML_OPTIONS)
      high_chart.canvas       = canvas if canvas
      yield high_chart if block_given?
    end
  end
  
  #	title:		legend: 		xAxis: 		yAxis: 		tooltip: 	credits:  :plotOptions
  
  def defaults_options
    self.title({ :text=>"example test title from plugin"})
    self.legend({:layout=>"vertical", :style=>{:position=>'absolute', :bottom=>'auto', :left=>'150px', :top=>'150px'} , :borderWidth=> 1,
		:backgroundColor=>'#FFFFFF'}) 
		self.x_axis(
		{:categories=> ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'],
			:plotBands=> [{ 
        :from=> 6.0,:to=> 6.5,:color=> 'rgba(68, 170, 213, .2)'
			}],
		 :labels=>{ :align=>'right',:rotation=>45 }
		})
		self.y_axis({:title=> {:text=> 'Fruit units'}, :labels=>{:align=>'right'} })
		self.tooltip({ :enabled=>true })
		self.credits({:enabled => false})
		self.plot_options({
			:areaspline => {
				:fillOpacity => 0.5
			}
		})
		self.chart({:defaultSeriesType=>"areaspline" , :renderTo => nil})
  end


  # Pass other methods through to the javascript high_chart object.
  #
  # For instance: <tt>high_chart.grid(:color => "#699")</tt>
  #
  def method_missing(meth, opts = {})
    merge_options meth, opts
  end

  # Setup a filter that will be used to limit all datasets in the graph.
  #
  # For instance, to limit the graph to positive amounts:
  #   high_chart.filter {|collection| collection.select {|record| record.amount > 0 }}
  #
  def filter(&block)
    @collection_filter = block
  end

  # Add a simple series to the graph:
  # 
  #   data = [[0,5], [1,5], [2,5]]
  #   @high_chart.series "Horizontal Line", data
  #   @high_chart.series "Red Line", data, :color => '#f00'  # or is it "'#f00'"
  #
  def series(label, d, opts = {})
    if opts.blank?
      @data << series_options.merge(:name => label, :data => d)
    else
      @data << opts.merge(:name => label, :data => d)
    end
  end
  
  
private
  def series_options
    @options.reject {|k,v| SERIES_OPTIONS.include?(k.to_s) == false}
  end

  def map_collection(collection, x, y)
    col = @collection_filter ? @collection_filter.call(collection) : collection
    col.map {|model| [get_coordinate(model, x), get_coordinate(model, y)]}
  end

  def merge_options(name, opts)
    @options.merge!  name => opts
  end
  
  def arguments_to_options(args)
    if args.blank? 
      {:show => true}
    elsif args.is_a? Array
      args.first
    else
      args
    end
  end
  
  def get_coordinate(model, method)
    method.is_a?(Proc) ? method.call(model) : model.send(method)
  end
end