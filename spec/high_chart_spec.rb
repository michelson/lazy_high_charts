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
  
  
  
  # this is almost all flotomatic stuff, and works :)
  describe "initialization" do
     it "should take an optional 'placeholder' argument" do
       HighChart.new(@placeholder).placeholder.should == @placeholder
       HighChart.new.placeholder.should == nil
     end
     
     it "should take an optional html_options argument (defaulting to 300px height)" do
       HighChart.new(@html_options).placeholder.should == @html_options
       HighChart.new.html_options.should == {:style => "height: 300px, width: 615px"}
     end
     
     it "should set options empty by default" do
       HighChart.new.options.should == {}
     end
     
     it "should set options not empty by default" do
       #HighChart.new.data.should == empty?
     end

     it "should take a block setting attributes" do
       flot = HighChart.new {|f| f.data = @data ; f.options = @options }
       flot.data.should == @data
       flot.options.should == @options
     end
     
  end

end