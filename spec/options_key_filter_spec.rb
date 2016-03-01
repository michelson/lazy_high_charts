require File.dirname(__FILE__) + '/spec_helper'

describe LazyHighCharts::OptionsKeyFilter do
  it "should filter :pointInterval from seconds to milliseconds" do
    hash = LazyHighCharts::OptionsKeyFilter.filter(pointInterval: 1)
    expect(hash[:pointInterval]).to eq(1000)
  end

  describe "filters :pointStart from a Date to a JavaScript compatible string" do
    before(:each) do
      hash = LazyHighCharts::OptionsKeyFilter.filter(pointStart: Date.new(2012, 9, 13))
      @value = hash[:pointStart]
    end

    it "should be the correct string" do
      expect(@value).to eq("Date.UTC(2012, 8, 13)")
    end

    it "should be js_code" do
      expect(@value.js_code).to be_truthy
    end
  end

  it "should filter keys recursively" do
    hash = LazyHighCharts::OptionsKeyFilter.filter({something: {another_thing: {pointInterval: 2}}})
    expect(hash[:something][:another_thing][:pointInterval]).to eq(2000)
  end
end
