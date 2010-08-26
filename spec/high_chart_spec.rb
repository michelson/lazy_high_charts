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
     end
     
    it "should set options by default" do
       HighChart.new.options.should == {
         :subtitle=>{}, 
         :chart=>{:renderTo=>nil, :defaultSeriesType=>"areaspline"}, 
         :plot_options=>{:areaspline=>{:fillOpacity=>0.5}}, 
         :legend=>{
           :borderWidth=>1, 
           :backgroundColor=>"#FFFFFF", 
           :layout=>"vertical", 
           :style=>{:top=>"150px", 
             :left=>"150px", :position=>"absolute", :bottom=>"auto"}
             }, 
             :tooltip=>{:enabled=>true}, 
             :x_axis=>{
               :categories=>["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], 
               :plotBands=>[{:to=>6.5, :from=>6.0, :color=>"rgba(68, 170, 213, .2)"}], 
               :labels=>{:align=>"right", :rotation=>45}}, 
               :y_axis=>{:title=>{:text=>"Fruit units"}, 
               :labels=>{:align=>"right"}}, 
               :title=>{:text=>"example test title from plugin"}, 
               :credits=>{:enabled=>false}
               }          
           
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
      
    it "should change a block data without overriding options" do
      chart = HighChart.new('graph') do |f|
          f.series(:name=>'John', :data=>[3, 20])
          f.series(:name=>'Jane',:data=> [1, 3] )        
          # without overriding 
          f.options[:chart][:defaultSeriesType] = "area"
          f.options[:chart][:inverted] = true
          f.options[:legend][:layout] = "horizontal"
          f.options[:x_axis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
      end
      chart.data.should ==  [{:name=>"John", :data=>[3, 20]}, {:name=>"Jane", :data=>[1, 3]}]
      chart.options[:legend][:layout].should == "horizontal"
      chart.options[:x_axis][:categories].should == ["uno" ,"dos" , "tres" , "cuatro"]
      chart.options[:chart][:defaultSeriesType].should == "area"
      chart.options[:chart][:inverted].should == true
    end
    
    it "should change a block data with overriding entire options" do
      chart = HighChart.new('graph') do |f|
          f.series(:name=>'John', :data=>[3, 20])
          f.series(:name=>'Jane', :data=>[1, 3] )        
          f.title({ :text=>"example test title from controller"})
          # without overriding 
          f.x_axis(:categories => ["uno" ,"dos" , "tres" , "cuatro"] , :labels=>{:rotation=>-45 , :align => 'right'})
          f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
      end
      chart.options[:x_axis][:categories].should == ["uno" ,"dos" , "tres" , "cuatro"]      
      chart.options[:x_axis][:labels][:rotation].should == -45     
      chart.options[:x_axis][:labels][:align].should == "right"    
      chart.options[:chart][:defaultSeriesType].should == "spline"    
      chart.options[:chart][:renderTo].should == "myRenderArea"    
      chart.options[:chart][:inverted].should == true    
    end
    
    it "should have subtitles" do
       chart = HighChart.new('graph') do |f|
            f.series(:name=>'John',:data=> [3, 20])
            f.series(:name=>'Jane', :data=>[1, 3] )        
            f.title({ :text=>"example test title from controller"})
            # without overriding 
            f.x_axis(:categories => ["uno" ,"dos" , "tres" , "cuatro"] , :labels=>{:rotation=>-45 , :align => 'right'})
            f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
            f.subtitle({:text=>"Bar"})
        end
       chart.options[:subtitle][:text].should == "Bar"
    end
     
  end

end