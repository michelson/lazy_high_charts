require File.dirname(__FILE__) + '/spec_helper'

describe "HighChartGlobals" do
  before(:each) do
    @chart_globals = LazyHighCharts::HighChartGlobals.new do |chart|
      chart.global( useUTC: false )
      chart.chart(
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
      )
      chart.lang(
        thousandsSep: ","
      )
      chart.colors([
        "#90ed7d", "#f7a35c", "#8085e9", "#f15c80", "#e4d354"
      ])
    end
  end

  # this is almost all flotomatic stuff
  describe "initialization" do

    it "should set options hash by default" do
      @chart_globals.options.is_a?(Hash).should == true
    end

    it "should take a block and set attributes" do
      @chart_globals.options[:lang][:thousandsSep].should == ","
      @chart_globals.options[:global][:useUTC].should == false
      @chart_globals.options[:chart][:backgroundColor][:linearGradient].should == [0, 0, 500, 500]
    end

    it "should override options" do
      chart = LazyHighCharts::HighChartGlobals.new
      chart.global({ useUTC: true })
      chart.options[:global][:useUTC].should == true
      chart.global({ useUTC: false })
      chart.options[:global][:useUTC].should == false
    end

  end
end
