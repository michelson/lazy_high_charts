
module LazyHighCharts
  class HighChart
    include LayoutHelper

    SERIES_OPTIONS = %w(data index legendIndex name stack type xAxis yAxis)

    attr_accessor :series_data, :options, :placeholder, :html_options
    alias :canvas :placeholder
    alias :canvas= :placeholder=

    def initialize(canvas = nil, html_opts = {})

      self.tap do |high_chart|
        high_chart.series_data ||= []
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
      if meth.to_s == 'to_ary'
        super
      end

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
      if not opts.empty?
        @series_data << OptionsKeyFilter.filter(opts.merge(:name => opts[:name], :data => opts[:data]))
      end
    end

    # Pre-processes and returns full set of options relevant to the chart. Identical to what happens in the high_charts
    # view helper.
    #
    # @return [Hash] options JSON options hash
    def full_options
      options_collection_as_string self
    end

    def to_json
      data = self.options.clone
      data[:series] = self.series_data.clone
      data
    end

    # @example
    # chart = LazyHighCharts::HighChart.new('graph') do |f|
    #   f.title({ :text=>"Combination chart"})
    #   f.options[:xAxis][:categories] = ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
    #   f.labels(:items=>[:html=>"Total fruit consumption", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
    #   f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
    #   f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
    #   f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
    #   f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67, 3, 6.33, 3.33])
    #   f.series(:type=> 'pie',:name=> 'Total consumption',
    #     :data=> [
    #       {:name=> 'Jane', :y=> 13, :color=> 'red'},
    #       {:name=> 'John', :y=> 23,:color=> 'green'},
    #       {:name=> 'Joe', :y=> 19,:color=> 'blue'}
    #     ],
    #     :center=> [100, 80], :size=> 100, :showInLegend=> false)
    # end
    #
    # To display the html code use `show`. To see the same in IRuby notebook
    # use `show_in_iruby`.
    # User can also use :
    # `IRubyRuby.html chart.show` (or)
    # `IRuby.html chart.show.to_s` (or)
    # `IRuby.display chart.show, mime: 'text/html'`
    # to get the same chart in IRuby notebook.
    #
    # chart.show
    # chart.show_in_iruby
    #
    def show
      high_chart(random_canvas_id, self)
    end

    def show_in_iruby(placeholder=random_canvas_id)
      IRuby.html high_chart(placeholder, self).to_s
    end

    private

    def random_canvas_id
      canvas_id_length = 11
      # Don't use SecureRandom.urlsafe_base64; it gives invalid characters.
      ('a'..'z').to_a.shuffle.take(canvas_id_length).join
    end

    def series_options
      @options.reject { |k, _| SERIES_OPTIONS.include?(k.to_s) == false }
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
