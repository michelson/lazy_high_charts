# coding: utf-8
require File.dirname(__FILE__) + '/spec_helper'

describe HighChartsHelper do
  include LazyHighCharts::LayoutHelper

  before(:each) do
    @class = "stylin"
    @placeholder = "placeholder"
    @chart = LazyHighCharts::HighChart.new(@placeholder)
    @data = "data"
    @options = "options"
  end

  context "layout_helper" do
    it "should return a div with an id of high_chart object" do
      high_chart(@placeholder, @chart).should have_selector('div', :id => @placeholder)
    end

    it "should return a script" do
      hc = LazyHighCharts::HighChart.new("placeholder")
      high_chart(hc.placeholder, hc).should have_selector('script')
    end
  end

  context "high_chart_graph" do
    describe "ready function" do
      it "should be a javascript script" do
        high_chart(@placeholder, @chart).should have_selector('script', :type => 'text/javascript')
        high_chart(@placeholder, @chart).should match(/}\)\(\)/)
      end

      it "should assign to the onload event" do
        high_chart(@placeholder, @chart).should include('window.onload = function(){')
      end
      it "should call any existing onload function" do
        high_chart(@placeholder, @chart).should match(/onload = window.onload;/)
        high_chart(@placeholder, @chart).should match(/if \(typeof onload == "function"\)\s*onload\(\)/)
      end
    end
    describe "initialize HighChart" do
      it "should set variables `chart` `options`" do
        high_chart(@placeholder, @chart).should match(/var\s+options\s+=/)
        high_chart(@placeholder, @chart).should match(/window.chart_placeholder\s=/)
      end
      it "should set Chart data" do
        high_chart(@placeholder, @chart).should match(/window\.chart_placeholder\s=\snew\sHighcharts.Chart/)
      end

      it "should set chart renderTo" do
        high_chart(@placeholder, @chart).should match(/"renderTo": "placeholder"/)
      end

      it "should set Chart Stock" do
        high_stock(@placeholder, @chart).should match(/window\.chart_placeholder\s+=\s+new\s+Highcharts.StockChart/)
      end
    end

    describe "HighChart Variable" do
      it "should underscore chart_ variable" do
        high_chart("place-holder", @chart).should match(/window.chart_place_holder\s=/)
        high_chart("PlaceHolder",  @chart).should match(/window.chart_place_holder\s=/)
      end
    end
  end


  it "should take a block setting attributes" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.options[:rangeSelector] = {:selected => 1};
      f.series(:type => "spline",
               :name => "Historias",
               :pointInterval => (1.day.to_i * 1000),
               :pointStart => (Time.now.to_i * 1000),
               :data => [0, 1, 2, 3, 5, 6, 0, 7]
      )
    }
    chart.options[:rangeSelector][:selected].should == 1
    high_chart(@placeholder, chart).should match(/rangeSelector/)
    high_chart(@placeholder, chart).should match(/xAxis/)
    high_chart(@placeholder, chart).should match(/yAxis/)
    high_chart(@placeholder, chart).should match(/series/)

  end


  it "should take a block setting attributes" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.others(:foo => "bar")
    }
    high_chart(@placeholder, chart).should match(/foo/)
  end

  it "should allow js code as attribute" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.options[:foo] = "function () { alert('hello') }".js_code
    }

    high_chart(@placeholder, chart).should match(/"foo": function \(\) { alert\('hello'\) }/)
  end

  it "should convert keys to proper format" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.options[:foo_bar] = {:bar_foo => "someattrib"}
    }

    high_chart(@placeholder, chart).should match(/fooBar/)
    high_chart(@placeholder, chart).should match(/barFoo/)
  end

  # issue #62 .js_code setting ignored
  # https://github.com/michelson/lazy_high_charts/issues/62
  it "should allow js code in array && nest attributs" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.yAxis([{
                   :labels => {
                       :formatter => %|function() {return this.value + ' W';}|.js_code
                   }
               }])
    }
    high_chart(@placeholder, chart).should match(/"formatter": function\(\) {return this.value \+ ' W';}/)
  end

  it "should support js_code in Individual data label for each point" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.series(
          :data => [29.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1, 95.6, {
              :dataLabels => {:enabled => true,
                              :align => 'left',
                              :x => 10,
                              :y => 4,
                              :style => {:fontWeight => 'bold'},
                              :formatter => "function() { return this.x; }".js_code
              },
              :y => 54.4}
          ])
    }
    high_chart(@placeholder, chart).should match(/"formatter": function\(\) {\ return this.x;\ }/)
  end

end
