require File.dirname(__FILE__) + '/spec_helper'

describe LazyHighCharts do

  # Tell the name of new JS extension library to highcharts.js
  context ".add_extension" do
    it "should add extension name to lists" do
      LazyHighCharts.add_extension("Hoge")
      expect(LazyHighCharts.extension_lists.index("Hoge").nil?).to eq(false)
    end
  end

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


  describe '.load_notebook' do
    shared_examples 'inline script' do
      it 'loads javascript sources as inline script' do
        expect(IRuby).to receive(:display) do |rep|
          expect(rep).to be_kind_of(IRuby::Display::Representation)
          expect(rep.options[:mime]).to eq('application/javascript')

          # highcharts.js
          expect(rep.object).to match(/this\.highcharts=/)
        end
        expect(load_notebook).to eq(nil)
      end
    end

    context 'without parameters' do
      subject(:load_notebook) { Highcharts.load_notebook }

      include_examples 'inline script'
    end

    context 'given `assets` parameter is `:inline`' do
      subject(:load_notebook) { Highcharts.load_notebook(:inline) }

      include_examples 'inline script'
    end

    context 'given `assets` parameter is `:cdn`' do
      subject(:load_notebook) { Highcharts.load_notebook(:cdn) }

      it 'loads javascript sources from cdn' do
        expect(IRuby).to receive(:display) do |rep|
          expect(rep).to be_kind_of(IRuby::Display::Representation)
          expect(rep.options[:mime]).to eq('application/javascript')
          expect(rep.object).to include('http://code.highcharts.com/highcharts.js')
        end
        expect(load_notebook).to eq(nil)
      end
    end

end
