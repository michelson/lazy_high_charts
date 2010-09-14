require File.dirname(__FILE__) + '/spec_helper'

describe HighChartsHelper do  
  attr_accessor :_erbout
  include HighChartsHelper
  
  before(:each) do
    @class       = "stylin"
    @placeholder = "placeholder"
    @chart        = HighChart.new(@placeholder)
    @data        = "data"
    @options     = "options"
    
    self._erbout = ''

    #@chart.data.stub!(:to_json).and_return @data
    #@chart.options.stub!(:to_json).and_return @options
  end
  
  describe "high_chart_includes" do
    it "should have a script tag" do
      javascript_include_tag(:high_charts).should have_tag('script')
    end
    
    it "should have a script tag for ie" do
      javascript_include_tag(:ie_high_charts).should have_tag('script')
    end

  end
  
  describe "high_chart_helper" do

     it "should return a div with an id of high_chart object" do
       hc = HighChart.new("placeholder", :class => 'stylin')
       high_chart(hc.placeholder, hc).should have_tag('div[id=?][class=?]', hc.placeholder, 'stylin')
     end
     
     it "should return a script" do
       hc = HighChart.new("placeholder")
       high_chart(hc.placeholder, hc).should have_tag('script')
     end
  end
   
  describe "high_chart_graph" do
     describe "ready function" do
       it "should be a javascript script" do
         high_chart(@placeholder, @chart).should have_tag('script[type=?]', 'text/javascript')
         high_chart(@placeholder, @chart).should match(/\}\s*\)\s*;/)
       end

       it "should generate generate ready function (no conflict with prototype)" do
         high_chart(@placeholder, @chart).should match(/jQuery\(function\(\)\s*\{/)
       end
     end
     describe "initialize HighChart" do
        it "should set Chart data" do
          high_chart(@placeholder, @chart).should =~ /var\s+chart\s+=\s+new\s+Highcharts.Chart/
        end       

        it "should set chart renderTo" do  
          high_chart(@placeholder, @chart).should match(/chart:\s+{\"renderTo\":\"placeholder\"/)             
        end
        
     end
  end
  

end
