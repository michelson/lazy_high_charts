module LazyHighCharts
  class HighChart
    SERIES_OPTIONS = %w(data dataParser dataURL index legendIndex name stack type xAxis yAxis)

    attr_accessor :data, :options, :placeholder, :html_options
    alias  :canvas :placeholder
    alias  :canvas= :placeholder=

    def initialize(canvas = nil, html_opts = {})

      @collection_filter = nil
      self.tap do |high_chart|
        high_chart.data       ||= []
        high_chart.options    ||= {}
        high_chart.defaults_options
        high_chart.html_options ||={}
        high_chart.canvas       = canvas if canvas
        yield high_chart if block_given?
      end
    end

    #	title:		legend: 		xAxis: 		yAxis: 		tooltip: 	credits:  :plotOptions
    def defaults_options
      self.title({ :text=>"example test title from highcharts gem"})
      self.legend({ :layout=>"vertical", :style=>{} })
      self.xAxis({})
      self.yAxis({ :title=> {:text=> nil}, :labels=>{} })
      self.tooltip({ :enabled=>true })
      self.credits({ :enabled => false})
      self.plotOptions({ :areaspline => { } })
      self.chart({ :defaultSeriesType=>"line" , :renderTo => nil})
      self.subtitle({})
    end


    # Pass other methods through to the javascript high_chart object.
    #
    # For instance: <tt>high_chart.grid(:color => "#699")</tt>
    def method_missing(meth, opts = {})
      merge_options meth, opts
    end

    # Add a simple series to the graph:
    # 
    #   data = [[0,5], [1,5], [2,5]]
    #   @high_chart.series :name=>'Updated', :data=>data
    #   @high_chart.series :name=>'Updated', :data=>[5, 1, 6, 1, 5, 4, 9]
    def series(opts = {})
      @data ||= []
      if not opts.empty?
        @data << OptionsKeyFilter.filter(opts.merge(:name => opts[:name], :data => opts[:data]))
      end
    end

private

    def series_options
      @options.reject {|k,v| SERIES_OPTIONS.include?(k.to_s) == false}
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

  end
end
