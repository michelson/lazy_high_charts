require 'sinatra'
require 'lazy_high_charts'

require 'lazy_high_charts'
include LazyHighCharts::LayoutHelper


get '/' do
  highchart_example
  erb :index #, :layout => :layout
end

get '/dates' do
  irregular_time_example()
  erb :index
end

def highchart_example
  # https://github.com/michelson/lazy_high_charts/wiki/Combination-Chart
  @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title({ text: "Combination chart"})
    f.options[:xAxis][:categories] =
      ['Apples', 'Oranges', 'Pears', 'Bananas', 'Plums']
    f.labels(:items=>
      [:html=>"Total fruit consumption",
       :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])
    f.series(:type=> 'column',:name=> 'Jane',:data=> [3, 2, 1, 3, 4])
    f.series(:type=> 'column',:name=> 'John',:data=> [2, 3, 5, 7, 6])
    f.series(:type=> 'column', :name=> 'Joe',:data=> [4, 3, 3, 9, 0])
    f.series(:type=> 'spline',:name=> 'Average',
             :data=> [3, 2.67, 3, 6.33, 3.33])
    f.series(:type=> 'column', :data=> [[DateTime.new(10), 100], [DateTime.new(20), 100]])

    f.series(:type=> 'pie',:name=> 'Total consumption',
      :data=> [
        {:name=> 'Jane', :y=> 13, :color=> 'red'},
        {:name=> 'John', :y=> 23,:color=> 'green'},
        {:name=> 'Joe', :y=> 19,:color=> 'blue'}
      ],
      :center=> [100, 80], :size=> 100, :showInLegend=> false)
  end
end

def irregular_time_example()
  @chart = LazyHighCharts::HighChart.new('graph') do |f|
    f.title({ text: "Irregular Time Example"})
    f.xAxis({type: 'datetime' })
    f.series(:type=> 'spline', :data=> make_random_series(1))
    f.series(:type=> 'spline', :data=> make_random_series(2))
    f.series(:type=> 'spline', :data=> make_random_series(3))
  end
end

def make_random_series(step)
  data = []
  for i in 0..10
    data << [DateTime.new(i * step), (rand * 100).to_i]
  end
  data
end
