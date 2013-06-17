module LazyHighCharts
  class Render

    RENDER_OPTIONS = %w(scale width constr)

    class << self

      # Uses phantomjs to render the chart on the server and deliver the image in the form of a tempfile.
      # @param [HighChart] high_chart
      # @param [Hash] options
      # @return [String] path to the chart object
      #
      def render(high_chart, options = {})
        options = options.select {|key, value| RENDER_OPTIONS.include?(key.to_s) }
        begin
          infile = Tempfile.new('options')
          infile.write(high_chart.full_options.to_json)
          infile.rewind
          outfile = Tempfile.new(%w(chart .png))
          system_call = "phantomjs #{LazyHighCharts.root}/vendor/assets/javascripts/highcharts-convert.js -infile #{infile.path} -outfile #{outfile.path}"
          RENDER_OPTIONS.each do |key|
            system_call += " -#{key} #{options[key.to_sym]}" unless options[key.to_sym].blank?
          end
          silence_stream(STDOUT) do
            system system_call
          end
          outfile.path
        ensure
          infile.close
          infile.unlink
        end
      end

    end

  end
end
