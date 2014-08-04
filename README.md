# LazyHighCharts

This gem provides a simple and extremely flexible way to use HighCharts from ruby code.
Tested on Ruby on Rails, Sinatra and Nanoc, but it should work with others too.


[![Build Status](https://travis-ci.org/michelson/lazy_high_charts.png?branch=master)](http://travis-ci.org/michelson/lazy_high_charts)
[![Code Climate](https://codeclimate.com/github/michelson/lazy_high_charts.png)](https://codeclimate.com/github/michelson/lazy_high_charts)

[VERSION](https://github.com/michelson/lazy_high_charts/blob/master/GEM_VERSION)
[ChangeLog](https://github.com/michelson/lazy_high_charts/blob/master/CHANGELOG.md)

## Information

* RDoc documentation [available on RubyDoc.info](http://rubydoc.info/gems/lazy_high_charts/frames)
* Source code [available on GitHub](http://github.com/michelson/lazy_high_charts)
* More information, known limitations, and how-tos [available on the wiki](https://github.com/michelson/lazy_high_charts/wiki)

## Getting Help

* Please report bugs on the [issue tracker](http://github.com/michelson/lazy_high_charts/issues) but read the "getting help" section in the wiki first.

## Installation

### Installation with rubygems

To install it, you just need to add it to your Gemfile:

```ruby
gem 'lazy_high_charts'
```
edge version on trial
```ruby
gem 'lazy_high_charts' --pre
```

then run

```bash
bundle install
```

to install it.

## Usage:

### Controller code:
```ruby
@chart = LazyHighCharts::HighChart.new('graph') do |f|
  f.title(:text => "Population vs GDP For 5 Big Countries [2009]")
  f.xAxis(:categories => ["United States", "Japan", "China", "Germany", "France"])
  f.series(:name => "GDP in Billions", :yAxis => 0, :data => [14119, 5068, 4985, 3339, 2656])
  f.series(:name => "Population in Millions", :yAxis => 1, :data => [310, 127, 1340, 81, 65])

  f.yAxis [
    {:title => {:text => "GDP in Billions", :margin => 70} },
    {:title => {:text => "Population in Millions"}, :opposite => true},
  ]

  f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
  f.chart({:defaultSeriesType=>"column"})
end
```

### View Helpers:
```ruby
<%= high_chart("some_id", @chart) %>
```

###Demo projects:

[Nanoc App](spec/dummy_nanoc/README.md)

[Rails App](spec/dummy_rails/README.md)

[Sinatra App](spec/dummy_sinatra/README.md)


### Update to latest js library. Aditional command line

  To update to the current highcharts.js directly from http://code.highcharts.com/",  you can always run 

    rake highcharts:update

  And HC will be copied to your vendor/assets directory on your app

### Deprecation notice: 

If you use rails 2.3.x or 3.0.x or 3.1.x, please use versions less than 1.3.3.

## Contributing

We're open to any contribution. It has to be tested properly though.

* [Fork](http://help.github.com/forking/) the project
* Do your changes and commit them to your repository
* Test your changes. We won't accept any untested contributions (except if they're not testable).
* Create an [issue](https://github.com/michelson/lazy_high_charts/issues) with a link to your commits.

Thanks for all [contributers](https://github.com/michelson/lazy_high_charts/contributors)

## Maintainers
* Deshi Xiao [github/xiaods](https://github.com/xiaods)
* Miguel Michelson [github/michelson](https://github.com/michelson)

## License
* Copyright (c) 2008-2014 [MIT LICENSE](MIT-LICENSE)
