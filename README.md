LazyHighCharts
==============

plugin for make highcharts a la ruby

  highcharts:http://www.highcharts.com/demo/

Some Ideas & code taken from 

  flotomatic

  open_flash_chart_lazy
  

Usage
=======

  controller:
  
     @h = HighChart.new('graph') do |f|
        f.series('John', [3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
        f.series('Jane', [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )
      end
 

  without overriding:  
 
     @h = HighChart.new('graph') do |f|
      .....

          f.options[:legend][:layout] = "horizontal"
          f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
     ......

  overriding entire option: 

     @h = HighChart.new('graph') do |f|
       .....
          f.x_axis(:categories => @days.reverse! , :labels=>{:rotation=>-45 , :align => 'right'})
          f.series_type("spline")
       .....


      
  view:
  
    <%= high_chart("my_id", @h) %>
    


Copyright (c) 2009 [Miguel Michelson Martinez], released under the MIT license
