# LazyHighCharts

Easily displaying Highcharts graphs with gem style.
[![Build Status](https://secure.travis-ci.org/michelson/lazy_high_charts.png)](http://travis-ci.org/michelson/lazy_high_charts)

## Notice

lasted version: 1.1.7

### Installation instructions for Rails 3

### Installing it by rubygems
To install it, you just need to add it to your Gemfile:
    gem 'lazy_high_charts'

And then run this to install the javascript files:
    rails g lazy_high_charts:install

### Installing it as a plugin for rails 2.3.5 and rails 3

    script/plugin install git://github.com/michelson/lazy_high_charts.git ##(for rails 2)

    rails plugin install git://github.com/michelson/lazy_high_charts.git  ##(for rails 3)

### HighStocks
    LazyHighCharts now compatible with beta HighStock, http://www.highcharts.com/stock/demo/

## Usage

About javascript Assets notes:

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

### For Rails 3.1
In your Gemfile, add this line:
````
gem 'lazy_high_charts', '~> 1.1.5'
````
then execuate command:
````
Rails g lazy_high_charts:install
````

### Usage in Controller:
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

## Maintainers
* Miguel Michelson Martinez ([github/michelson]https://github.com/michelson)
* Deshi Xiao ([github/xiaods]https://github.com/xiaods)

## License
* Copyright 2011 Deshi Xiao,MIT License
* Copyright (c) 2010 Miguel Michelson Martinez, released under the MIT license
