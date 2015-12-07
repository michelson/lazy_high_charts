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
    @chart_globals = LazyHighCharts::HighChartGlobals.new do |chart|
      chart.global({ useUTC: false })
      chart.chart({
        backgroundColor: {
          linearGradient: [0, 0, 500, 500],
          stops: [
            [0, "rgb(255, 255, 255)"],
            [1, "rgb(240, 240, 255)"]
          ]
        },
        borderWidth: 2,
        plotBackgroundColor: "rgba(255, 255, 255, .9)",
        plotShadow: true,
        plotBorderWidth: 1
      })
      chart.lang({
        thousandsSep: ","
      })
      chart.colors([
        "#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"
      ])
    end
  end

  context "layout_helper" do
    it "should return a div with an id of high_chart object" do
      expect(high_chart(@placeholder, @chart)).to have_selector('div', :id => @placeholder)
    end

    it "should return a script" do
      hc = LazyHighCharts::HighChart.new("placeholder")
      expect(high_chart(hc.placeholder, hc)).to have_selector('script')
    end
  end

  context "high_chart_globals" do
    it "should return a script" do
      high_chart_globals(@chart_globals).should have_selector('script')
    end

    it "should take a block and set attributes" do
      high_chart_globals(@chart_globals).should match(/useUTC/)
      high_chart_globals(@chart_globals).should match(/backgroundColor/)
      high_chart_globals(@chart_globals).should match(/thousandsSep/)
    end
  end

  context "high_chart_graph" do
    describe "ready function" do
      it "should be a javascript script" do
        expect(high_chart(@placeholder, @chart)).to have_selector('script', :type => 'text/javascript')
        expect(high_chart(@placeholder, @chart)).to match(/}\)\(\)/)
      end

      it "should assign to the onload event" do
        expect(high_chart(@placeholder, @chart)).to include('window.onload = function(){')
      end
      it "should call any existing onload function" do
        expect(high_chart(@placeholder, @chart)).to match(/onload = window.onload;/)
        expect(high_chart(@placeholder, @chart)).to match(/if \(typeof onload == "function"\)\s*onload\(\)/)
      end
    end
    describe "initialize HighChart" do
      it "should set variables `chart` `options`" do
        expect(high_chart(@placeholder, @chart)).to match(/var\s+options\s+=/)
        expect(high_chart(@placeholder, @chart)).to match(/window.chart_placeholder\s=/)
      end
      it "should set Chart data" do
        expect(high_chart(@placeholder, @chart)).to match(/window\.chart_placeholder\s=\snew\sHighcharts.Chart/)
      end

      it "should set chart renderTo" do
        expect(high_chart(@placeholder, @chart)).to match(/"renderTo": "placeholder"/)
      end

      it "should set Chart Stock" do
        expect(high_stock(@placeholder, @chart)).to match(/window\.chart_placeholder\s+=\s+new\s+Highcharts.StockChart/)
      end
    end

    describe "HighChart Variable" do
      it "should underscore chart_ variable" do
        expect(high_chart("place-holder", @chart)).to match(/window.chart_place_holder\s=/)
        expect(high_chart("PlaceHolder",  @chart)).to match(/window.chart_place_holder\s=/)
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
    expect(chart.options[:rangeSelector][:selected]).to eq(1)
    expect(high_chart(@placeholder, chart)).to match(/rangeSelector/)
    expect(high_chart(@placeholder, chart)).to match(/xAxis/)
    expect(high_chart(@placeholder, chart)).to match(/yAxis/)
    expect(high_chart(@placeholder, chart)).to match(/series/)

  end


  it "should take a block setting attributes" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.others(:foo => "bar")
    }
    expect(high_chart(@placeholder, chart)).to match(/foo/)
  end

  it "should allow js code as attribute" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.options[:foo] = "function () { alert('hello') }".js_code
    }

    expect(high_chart(@placeholder, chart)).to match(/"foo": function \(\) { alert\('hello'\) }/)
  end

  it "should convert keys to proper format" do
    chart = LazyHighCharts::HighChart.new { |f|
      f.options[:foo_bar] = {:bar_foo => "someattrib"}
    }

    expect(high_chart(@placeholder, chart)).to match(/fooBar/)
    expect(high_chart(@placeholder, chart)).to match(/barFoo/)
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
    expect(high_chart(@placeholder, chart)).to match(/"formatter": function\(\) {return this.value \+ ' W';}/)
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
    expect(high_chart(@placeholder, chart)).to match(/"formatter": function\(\) {\ return this.x;\ }/)
  end

end
