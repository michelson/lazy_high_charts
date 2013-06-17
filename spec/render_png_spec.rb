require File.dirname(__FILE__) + '/spec_helper'
require 'tempfile'

describe "RenderPng" do

  it 'should export a png file' do
    json = "{
        xAxis: {
            categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
        },
        series: [{
                     data: [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, 54.4]
                 }]
    }"
    file = Tempfile.new('options.json')
    file.write(json)
    file.rewind
    system_call = "phantomjs vendor/assets/javascripts/highcharts-convert.js -infile #{file.path} -outfile chart.png -constr Chart"
    system system_call
    #debugger
    file.close
    file.unlink
  end

end