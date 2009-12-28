LazyHighCharts
==============

plugin for make highcharts a la ruby

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
      
      
     @h = HighChart.new('graph') do |f|
        f.series('John', [3, 20, 3, 5, 4, 10, 12 ,3, 5,6,7,7,80,9,9])
        f.series('Jane', [1, 3, 4, 3, 3, 5, 4,-46,7,8,8,9,9,0,0,9] )		
          f.title({ :text=>"example test title from controller"})
          # without overriding 
          f.options[:legend][:layout] = "horizontal"
          f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
          # overriding entire option
          f.series_type("spline")
      end
      
  view:
  
    <%= high_chart("my_id", @h) %>
    


Copyright (c) 2009 [Miguel Michelson Martinez], released under the MIT license
