# VERSION 1.5.0
  * Sun Jul 21, 2013
    1. change chart.data to chart.series_data
    2. remove Deprecated api options: dataParser, dataURL
# VERSION 1.4.3
  * Sat Jul 20, 2013
    1. Formatting all files
    2. change js update methods to rake, use rake highcharts:update to fetch upstream js files.
    3. update highcharts to 3.0.2

# VERSION 1.4.2
  * April 17, 2013
    1. bump new version to release
# VERSION 1.4.1
  * Sat Apr 6, 2013
    1. support HighCharts 3.0
    2. support signing gem
       model.http://blog.meldium.com/home/2013/3/3/signed-rubygems-part
# VERSION 1.4.0
  * Sun Feb 24, 2013
  1. replace autotest with guard-spec
  2. support rubygem 2.0
  3. Fix Turbolinks support and eliminate jQuery dependency by reed

# VERSION 1.3.3
  * Fri Jan 18, 2013
  1. rails 4 feature turbolinks supported.
  [#95](https://github.com/michelson/lazy_high_charts/isues/95)
  2. Can be used without rails, such as sinatra web framework.
  [#94](https://github.com/michelson/lazy_high_charts/isues/96)
  3. You shouldn't be forced to override the default chart text
  [#93](https://github.com/michelson/lazy_high_charts/issues/93)
  4. Add chart to window scope for dynamic series addition
  [#99](https://github.com/michelson/lazy_high_charts/pull/99)

# VERSION 1.3.2
  * Nov 22, 2012
  1. ActiveView method is not found.
  [#87](https://github.com/michelson/lazy_high_charts/issues/87)

# VERSION 1.3.1
  * Nov 21, 2012
  1. Fix invalid js encoding from wget highcharts cdn source url.
  [#85](https://github.com/michelson/lazy_high_charts/issues/85)
  * Nov 20, 2012
  1. html_opt is not set
  [#83](https://github.com/michelson/lazy_high_charts/issues/83)
  * Oct 27, 2012
  1. merged hash deep merge patch
  [#77](https://github.com/michelson/lazy_high_charts/issues/77)
  2. enhance example case in README.md
  [#78](https://github.com/michelson/lazy_high_charts/issues/78)

# VERSION 1.2.2
* Aug 31, 2012
  1. Correct highchart js location
    [issue#74](https://github.com/michelson/lazy_high_charts/issues/74)
  2. support series data add javascript event
    [issue#73](https://github.com/michelson/lazy_high_charts/issues/73)
  3. remove default html options.
    [issue#72](https://github.com/michelson/lazy_high_charts/issues/72)

* Aug 26, 2012
  1. Troy Anderson (laptop) <troy@tlainvestments.com>
    Added ability to supply an array of axes or other objects and still use .js_code within the array of hashes.
  2. David Biehl <lazylodr@gmail.com>
    removing the window.onload function for AJAX requests

* Jun 27, 2012
    update assets path for rails 3.x

* Jun 25, 2012
    support inline javascript in click event on ruby runtime.
    https://github.com/michelson/lazy_high_charts/issues/57

* Jul 14, 2011
  add support rails 3.1 rc4 now

* Jul 13, 2011
  HighStock support
  remove some defaults

  Jan 31, 2011
* backwards compatibility for rails 2.3.x in rendering callbacks options

  Nov 30,2010
* dumped to gem 0.0.1

  Sep 13,2010
* truely support rails 3.0(returning is deprecate function,use tap) deshi(xiaods@gmail.com)

  Sep 14,2010
* update codebase to support rails3.0 and rspec2

  Oct 8,2010
* update rake.it works now!

