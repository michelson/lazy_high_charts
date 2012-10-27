# LazyHighCharts

Easily displaying Highcharts graphs with gem style.
[![Build Status](https://secure.travis-ci.org/michelson/lazy_high_charts.png)](http://travis-ci.org/michelson/lazy_high_charts)

## Notice
Current
[VERSION](https://github.com/xiaods/lazy_high_charts/blob/master/GEM_VERSION)
[ChangeLog](https://github.com/xiaods/lazy_high_charts/blob/master/CHANGELOG.md)

### Installation instructions for Rails 3

### Installing it by rubygems
To install it, you just need to add it to your Gemfile:
    gem 'lazy_high_charts'

And then run this to install the javascript files:
    rails g lazy_high_charts:install

### Installing it as a plugin for rails 2.3.x

    script/plugin install git://github.com/michelson/lazy_high_charts.git ##(for rails 2)

    rails plugin install git://github.com/michelson/lazy_high_charts.git  ##(for rails 3)

### HighStocks
    LazyHighCharts now compatible with beta HighStock, http://www.highcharts.com/stock/demo/

## Usage

About javascript Assets notes:

### For Rails 3.2.x
1. add your highcart js to app/assets/javascripts/application.js
````
//= require highcharts
````

### For Rails 2.x/3.0.x

1. you need manually put jquery/highcharts js to public/javascript
2. modify your layout html
   Sample Code:
  ````
   <%= javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"  %>
   <%= javascript_include_tag :highcharts  %>
  ````

3. add gem name in your config/environment.rb
````
config.gem "lazy_high_charts"
````
4. Done!

### Demo Usage in Controller:
````
@h = LazyHighCharts::HighChart.new('graph') do |f|
  f.options[:chart][:defaultSeriesType] = "area"
  f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
  f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
end
````

Without overriding entire option , (only change a specific option index):

````
@h = LazyHighCharts::HighChart.new('graph') do |f|
  #.....
  f.options[:chart][:defaultSeriesType] = "area"
  f.options[:chart][:inverted] = true
  f.options[:legend][:layout] = "horizontal"
  f.options[:xAxis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
  #......
````

Overriding entire option:

````
@h = LazyHighCharts::HighChart.new('graph') do |f|
  #.....
  f.xAxis(:categories => @days.reverse! , :labels=>{:rotation=>-45 , :align => 'right'})
  f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
  #.....
````

If you want to use this syntax and still be able to build option step-by-step without overriding:

````
@h = LazyHighCharts::HighChart.new('graph') do |f|
 #.....
 f.xAxis!(:categories => @days.reverse! , :labels=>{:rotation=>-45 , :align => 'right'})
 f.chart!({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
 #.....
````

Using the datetime axis type:

````
@h = LazyHighCharts::HighChart.new('graph', style: '') do |f|
  f.options[:chart][:defaultSeriesType] = "area"
  f.options[:plotOptions] = {areaspline: {pointInterval: 1.day, pointStart: 10.days.ago}}
  f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
  f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9])
  f.xAxis(type: :datetime)
end
````
A datetime axis [example](http://jsfiddle.net/gh/get/jquery/1.7.2/highslide-software/highcharts.com/tree/master/samples/highcharts/xaxis/type-datetime/)


Usage in layout:
````
<%= javascript_include_tag :highcharts %>
````

Usage in view:
````
<%= high_chart("my_id", @h) %>
````

You can pass in additional javascript into to the view with a block, this will be executed before the high chart is called

````
<%= high_chart("my_id", @h) do |c| %>
  alert('hello')
<%end %>
````
To include javascript function calls or callbacks you can use the js_code method on your string`"function".js_code`:

````
f.options[:plotOptions] = {
  :column => { :events => { :click => %|function() { window.location = "http://www.highcharts.com" }|.js_code } }
}
````


## HighStock Support:

Just call HighChart Helper this way:
````
<%= high_stock("my_id", @h) %>
````

## Option reference:

http://www.highcharts.com/ref/

## HighCharts License:

http://www.highcharts.com/license


## Contributing

We're open to any contribution. It has to be tested properly though.

* [Fork](http://help.github.com/forking/) the project
* Do your changes and commit them to your repository
* Test your changes. We won't accept any untested contributions (except if they're not testable).
* Create an [issue](https://github.com/michelson/lazy_high_charts/issues) with a link to your commits.

Contributer List:
* [Troy Anderson](https://github.com/troya2)
* [David Biehl](https://github.com/lazylodr)

Thanks for Troy & David
## Maintainers
* Miguel Michelson Martinez [github/michelson](https://github.com/michelson)
* Deshi Xiao [github/xiaods](https://github.com/xiaods)

## License
* Copyright (c) 2011,2012 Deshi Xiao,released under the MIT license
* Copyright (c) 2010 Miguel Michelson Martinez, released under the MIT license
