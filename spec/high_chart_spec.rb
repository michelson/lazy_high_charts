require File.dirname(__FILE__) + '/spec_helper'

Record = Struct.new(:frequency, :amplitude)


describe "HighChart" do
  before(:each) do
    @collection   = [Record.new(1,15), Record.new(2,30), Record.new(4,40)]
    @data         = [          [1,15],           [2,30],           [4,40]]

    @placeholder  = "placeholder"
    @html_options = {:class => "stylin"}
    @options      = {:bars => {:show => true}}

    @flot         = HighChart.new(@placeholder, @html_options) {|chart| chart.options = @options }
  end
  
  
  
  # this is almost all flotomatic stuff
  describe "initialization" do
    it "should take an optional 'placeholder' argument" do
       HighChart.new(@placeholder).placeholder.should == @placeholder
       HighChart.new.placeholder.should == nil
     end
     
    it "should take an optional html_options argument (defaulting to 300px height)" do
       HighChart.new(@html_options).placeholder.should == @html_options
      # HighChart.new.html_options.should == {:style => "height: 300px, width:  615px"}
     end
     
    it "should set options by default" do
       HighChart.new.options.should == {:tooltip_formatter=>"function() { return '<b>'+ this.series.name +'</b><br/>'+ this.x +': '+ this.y +' units';}", :credits=>{:enabled=>false}, :title=>{:text=>"example test title from plugin"}, :plot_options=>{:areaspline=>{:fillOpacity=>0.5}}, :legend=>{:backgroundColor=>"#FFFFFF", :layout=>"vertical", :style=>{:left=>"150px", :position=>"absolute", :bottom=>"auto", :top=>"150px"}, :borderWidth=>1}, :series_type=>"areaspline", :x_axis=>{:categories=>["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], :plotBands=>[{:from=>6.0, :color=>"rgba(68, 170, 213, .2)", :to=>6.5}]}, :y_axis=>{:title=>{:text=>"Fruit units"}}}
       
     end
     
    it "should set data empty by default" do
     HighChart.new.data.should == []
    end

    it "should take a block setting attributes" do
     chart = HighChart.new {|f| f.data = @data ; f.options = @options }
     chart.data.should == @data
     chart.options.should == @options
    end
     
    it "should take a block setting attributes" do
      chart = HighChart.new {|f|  f.options[:legend][:layout] = "horizontal" }
      chart.options[:legend][:layout].should == "horizontal"
    end
      
    it "should change a block data" do
      chart = HighChart.new('graph') do |f|
          f.series('John', [3, 20])
          f.series('Jane', [1, 3] )        
            f.title({ :text=>"example test title from controller"})
            # without overriding 
            f.options[:legend][:layout] = "horizontal"
            f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
            # overriding entire option
            f.series_type("spline")
        end
      chart.data.should ==  [{:name=>"John", :data=>[3, 20]}, {:name=>"Jane", :data=>[1, 3]}]
    end
     
  end

end