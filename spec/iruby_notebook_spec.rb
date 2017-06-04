require File.dirname(__FILE__) + '/spec_helper'

describe LazyHighCharts do

  # Add extension libraries loaded before LazyHighCharts.js
  context ".add_dependency" do
    it "should register name and url of the new dependent library" do
      LazyHighCharts.add_dependency("Hoge","http://www.hoge.com")
      module LazyHighCharts
        $dep_libraries = @@dep_libraries
      end
      expect($dep_libraries.keys.index("Hoge").nil?).to eq(false)
      expect($dep_libraries.values.index("http://www.hoge.com").nil?).to eq(false)
    end
  end

  # Add extension libraries loaded after LazyHighCharts.js
  context ".add_additional_library" do
    it "should register name and url of the new additional library" do
      LazyHighCharts.add_additional_library("Hoge","http://www.hoge.com")
      module LazyHighCharts
        $additional_libraries = @@additional_libraries
      end
      expect($additional_libraries.keys.index("Hoge").nil?).to eq(false)
      expect($additional_libraries.values.index("http://www.hoge.com").nil?).to eq(false)
    end
  end

end
