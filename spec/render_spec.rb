require File.dirname(__FILE__) + '/spec_helper'
require 'tempfile'

describe 'Render' do

  let(:chart) do
    LazyHighCharts::HighChart.new('graph') do |f|
      f.series(name: 'John', data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4])
      f.series(name: 'Jane', data: [140.02, 41.63, 66.72, 113.21, 107.98, 105.71, 28.59, 114.23, 5.56, 93.71, 137.35, 93.16])
      f.title({text: 'Example Data'})
      f.xAxis(categories: %w(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec), labels: {rotation: -45, align: 'right'})
    end
  end

  it 'renders a temp file given an high chart object' do
    image_path = LazyHighCharts::Render.render(chart, width: 500)
    File.exists?(image_path).should be_true
    File.size(image_path).should be > 0
  end

end