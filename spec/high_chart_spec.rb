require File.dirname(__FILE__) + '/spec_helper'

Record = Struct.new(:frequency, :amplitude)

describe "HighChart" do
  before(:each) do
    @collection   = [Record.new(1,15), Record.new(2,30), Record.new(4,40)]
    @data         = [          [1,15],           [2,30],           [4,40]]

    @placeholder  = "placeholder"
    @html_options = {:class => "stylin"}
    @options      = {:bars => {:show => true}}

    @flot         = LazyHighCharts::HighChart.new(@placeholder, @html_options) {|chart| chart.options = @options }
  end

  # this is almost all flotomatic stuff
  describe "initialization" do
    it "should take an optional 'placeholder' argument" do
      LazyHighCharts::HighChart.new(@placeholder).placeholder.should == @placeholder
      LazyHighCharts::HighChart.new.placeholder.should == nil
    end

    it "should take an optional html_options argument (defaulting to 300px height)" do
      LazyHighCharts::HighChart.new(@placeholder,@html_options).html_options.should == @html_options
    end

    it "should set options by default" do
      LazyHighCharts::HighChart.new.options.should == {
        :title=>{:text=>"example test title from highcharts gem"}, 
        :legend=>{:layout=>"vertical", :style=>{}}, 
        :xAxis=>{}, 
        :yAxis=>{:title=>{:text=>nil}, :labels=>{}}, 
        :tooltip=>{:enabled=>true}, 
        :credits=>{:enabled=>false}, 
        :plotOptions=>{:areaspline=>{}}, 
        :chart=>{:defaultSeriesType=>"line", :renderTo=>nil}, 
        :subtitle=>{}}
    end

    it "should set data empty by default" do
      LazyHighCharts::HighChart.new.data.should == []
    end

    it "should take a block setting attributes" do
      chart = LazyHighCharts::HighChart.new {|f| f.data = @data ; f.options = @options }
      chart.data.should == @data
      chart.options.should == @options
    end

    it "should take a block setting attributes" do
      chart = LazyHighCharts::HighChart.new {|f|  f.options[:legend][:layout] = "horizontal" }
      chart.options[:legend][:layout].should == "horizontal"
    end

    it "should take a block setting attributes" do
      chart = LazyHighCharts::HighChart.new {|f|  f.options[:range_selector] = {}; f.options[:range_selector][:selected] = 1}
      chart.options[:range_selector][:selected].should == 1
    end

    it "should change a block data without overriding options" do
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.series(:name=>'John', :data=>[3, 20])
        f.series(:name=>'Jane',:data=> [1, 3] )        
        # without overriding 
        f.options[:chart][:defaultSeriesType] = "area"
        f.options[:chart][:inverted] = true
        f.options[:legend][:layout] = "horizontal"
        f.options[:xAxis][:categories] = ["uno" ,"dos" , "tres" , "cuatro"]
      end
      chart.data.should ==  [{:name=>"John", :data=>[3, 20]}, {:name=>"Jane", :data=>[1, 3]}]
      chart.options[:legend][:layout].should == "horizontal"
      chart.options[:xAxis][:categories].should == ["uno" ,"dos" , "tres" , "cuatro"]
      chart.options[:chart][:defaultSeriesType].should == "area"
      chart.options[:chart][:inverted].should == true
    end

    it "should change a block data with overriding entire options" do
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.series(:name=>'John', :data=>[3, 20])
        f.series(:name=>'Jane', :data=>[1, 3] )        
        f.title({ :text=>"example test title from controller"})
        # without overriding 
        f.xAxis(:categories => ["uno" ,"dos" , "tres" , "cuatro"] , :labels=>{:rotation=>-45 , :align => 'right'})
        f.chart({:defaultSeriesType=>"spline" , :renderTo => "myRenderArea" , :inverted => true})
      end
      chart.options[:xAxis][:categories].should == ["uno" ,"dos" , "tres" , "cuatro"]      
      chart.options[:xAxis][:labels][:rotation].should == -45     
      chart.options[:xAxis][:labels][:align].should == "right"    
      chart.options[:chart][:defaultSeriesType].should == "spline"    
      chart.options[:chart][:renderTo].should == "myRenderArea"    
      chart.options[:chart][:inverted].should == true    
    end

    it "should have subtitles" do
      chart = LazyHighCharts::HighChart.new('graph') do |f|
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

    it 'should override entire option by default when resetting it again' do
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.xAxis(categories: [3, 5, 7])
        f.xAxis(title: {text: 'x title'})
      end
      chart.options[:xAxis][:categories].should == nil
      chart.options[:xAxis][:title][:text].should == 'x title'
    end

    it 'should allow to build options step by step without overriding previously set values' do
      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.xAxis!(categories: [3, 5, 7])
        f.xAxis!(title: {text: 'x title'})
      end
      chart.options[:xAxis][:categories].should == [3, 5, 7]
      chart.options[:xAxis][:title][:text].should == 'x title'
    end

  end

end
