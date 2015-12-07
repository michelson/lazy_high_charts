module LazyHighCharts
  class HighChartGlobals
  	include LayoutHelper

  	attr_accessor :options

  	def initialize
  	  self.tap do |chart_globals|
        chart_globals.options ||= {}
        yield chart_globals if block_given?
      end
  	end

  	# Pass other methods through to the high_chart_globals object.
    #
    # For instance: <tt>high_chart_globals.global(:useUTC => false)</tt>
    def method_missing(meth, opts = {})
      if meth.to_s == 'to_ary'
        super
      end
      merge_options meth, opts      
    end

    def merge_options(name, opts)
      @options.merge! name => opts
    end

  end
end