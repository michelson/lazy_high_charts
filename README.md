LazyHighCharts
=======
LazyHighCharts is Rails 2.x/3.x Gem for displaying Highcharts graphs. 
  
Compatibility:
lazy_high_charts 1.x is compatible with Rails 2.x/3.x

Usage
=======
 About javascript Assets notes:
 for Rails 2.x
 1.you need manually put jquery/highcharts js to public/javascript
 2.modify your layout html
 Sample Code:
 <%= javascript_include_tag "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"  %>
 <%= javascript_include_tag :high_charts  %>
 3. add gem name in your config/environment.rb
	config.gem "lazy_high_charts"
 4.done!

 For Rails 3.x
 In your Gemfile, add this line:
	gem 'lazy_high_charts'

 Usage in Controller:
  
     @h = LazyHighCharts::HighChart.new('graph') do |f|
        f.series(:name=>'John', :data=>[3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
        f.series(:name=>'Jane', :data=> [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
      end
 

  Without overriding entire option , (only change a specific option index):  
 
     @h = LazyHighCharts::HighChart.new('graph') do |f|
      .....
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:chart][:inverted] = true
          f.options[:legend][:layout] = "horizontal"
          f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
     ......

  Overriding entire option: 

     @h = LazyHighCharts::HighChart.new('graph') do |f|
       .....
          f.x_axis(:categories => @days.reverse! , :labels=>{:rotation=>-45 , :align => 'right'})
          f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
       .....


  Usage in layout:
      
  <%= javascript_include_tag :high_charts %>
      
  Usage in view:
  
    <%= high_chart("my_id", @h) %>
    
  Passing formatting options in the view to the helper block , because all the helper options declared in the controller are converted in strict/valid json (quoted key);  so we need to extend the json object with some js.
  
      <%= high_chart("my_id", @h) do |c| %>
         	<%= "options.tooltip.formatter = function() { return '<b>HEY!!!'+ this.series.name +'</b><br/>'+ this.x +': '+ this.y +' units';}" %>
         	<%= "options.xAxis.labels.formatter = function() { return 'ho';}" %>
         	<%= "options.yAxis.labels.formatter = function() { return 'hey';}" %>
       <%end %> 
      


  Option reference:

     http://www.highcharts.com/ref/



    
Contributors
=======
	LazyHighCharts gem is maintained by "Deshi Xiao":https://github.com/xiaods
  git shortlog -n -s --no-merges

Copyright (c) 2010 Miguel Michelson Martinez, released under the MIT license
