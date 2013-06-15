module LazyHighCharts
  class HighChart
    SERIES_OPTIONS = %w(data dataParser dataURL index legendIndex name stack type xAxis yAxis)

    attr_accessor :data, :options, :placeholder, :html_options
    alias :canvas :placeholder
    alias :canvas= :placeholder=

    def initialize(canvas = nil, html_opts = {})

      @collection_filter = nil
      self.tap do |high_chart|
        high_chart.data ||= []
        high_chart.options ||= {}
        high_chart.defaults_options
        high_chart.html_options ||= html_opts
        high_chart.canvas = (canvas ? canvas : random_canvas_id)
        yield high_chart if block_given?
      end
    end

    #	title:		legend: 		xAxis: 		yAxis: 		tooltip: 	credits:  :plotOptions
    def defaults_options
      self.title({:text => nil})
      self.legend({:layout => "vertical", :style => {}})
      self.xAxis({})
      self.yAxis({:title => {:text => nil}, :labels => {}})
      self.tooltip({:enabled => true})
      self.credits({:enabled => false})
      self.plotOptions({:areaspline => {}})
      self.chart({:defaultSeriesType => "line", :renderTo => nil})
      self.subtitle({})
    end


    # Pass other methods through to the javascript high_chart object.
    #
    # For instance: <tt>high_chart.grid(:color => "#699")</tt>
    def method_missing(meth, opts = {})
      if meth.to_s.end_with? '!'
        deep_merge_options meth[0..-2].to_sym, opts
      else
        merge_options meth, opts
      end
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

    def random_canvas_id
      canvas_id_length = 11
# Don't use SecureRandom.urlsafe_base64; it gives invalid characters.
      ('a'..'z').to_a.shuffle.take(canvas_id_length).join
    end

    def series_options
      @options.reject { |k, v| SERIES_OPTIONS.include?(k.to_s) == false }
    end

    def merge_options(name, opts)
      @options.merge! name => opts
    end

    def deep_merge_options(name, opts)
      @options.deep_merge! name => opts
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
