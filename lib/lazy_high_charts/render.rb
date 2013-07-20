
module LazyHighCharts
  class Render

    RENDER_OPTIONS = %w(scale width constr)

    class << self

      # Uses PhantomJS to render the chart on the server and return it in a Tempfile.
      #
      # @param [HighChart] high_chart HighCharts object
      # @param [String] chart_format Resultant chart's image format
      # @param [Hash] options Hash containing relevant chart generation options
      # @return [Tempfile] Tempfile containing the chart image
      #
      def render(high_chart, chart_format, options = {})
        options = options.select {|key, value| RENDER_OPTIONS.include?(key.to_s) }
        begin
          infile = Tempfile.new('options')
          infile.write(high_chart.full_options)
          infile.rewind
          outfile = Tempfile.new(%W(chart .#{chart_format}))
          system_call = "phantomjs #{LazyHighCharts.root}/vendor/assets/javascripts/highcharts/highcharts-convert.js -infile #{infile.path} -outfile #{outfile.path}"
          RENDER_OPTIONS.each do |key|
            system_call += " -#{key} #{options[key.to_sym]}" unless options[key.to_sym].blank?
          end
          silence_stream(STDOUT) do
            system system_call
          end
          outfile
        ensure
          infile.close
          infile.unlink
        end
      end
    end
  end
end
