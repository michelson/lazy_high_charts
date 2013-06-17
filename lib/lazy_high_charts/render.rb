module LazyHighCharts
  class Render

    class << self

      # Uses phantomjs to render the chart on the server and deliver the image in the form of a tempfile.
      # @param [HighChart] high_chart
      # @return [String] path to the chart object
      #
      def render(high_chart)
        begin
          options = Tempfile.new('options')
          options.write(high_chart.full_options.to_json)
          options.rewind
          chart = Tempfile.new(%w(chart .png))
          chart.binmode
          render_chart = "phantomjs vendor/assets/javascripts/highcharts-convert.js -infile #{options.path} -outfile #{chart.path} -constr Chart"
          silence_stream(STDOUT) do
            system render_chart
          end
          chart.path
        ensure
          options.close
          options.unlink
        end
      end

    end

  end
end
