module LazyHighCharts

  @@dep_libraries = {
    # Iruby notebook already uses Jquery
    # jquery: 'https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js',
    highcharts: 'http://code.highcharts.com/highcharts.js'
  }
  @@additional_libraries = {}

  # Load extension library to IRuby notebook after LazyHighCharts js is loaded
  def self.add_dependency(name, url)
    @@dep_libraries[name]=url;
  end

  # Load extension library to IRuby notebook before LazyHighCharts js is loaded
  def self.add_additional_library(name, url)
    @@additional_libraries[name]=url
  end

  # generate initializing code
  def self.generate_init_code(assets=:inline)
    dep_libraries = @@dep_libraries
    additional_libraries = @@additional_libraries
    js_dir = File.expand_path("../../../vendor/assets/javascripts/highcharts", __FILE__)
    case assets
    when :cdn
      path = File.expand_path("../../templates/init.cdn.js.erb", __FILE__)
    when :inline
      path = File.expand_path("../../templates/init.inline.js.erb", __FILE__)
    end
    template = File.read(path)
    ERB.new(template).result(binding)
  end

  # Enable to show plots on IRuby notebook
  def self.init_iruby
    js = self.generate_init_code
    IRuby.display(IRuby.javascript(js))
  end

  def self.load_notebook(assets=:inline)
    init_code = generate_init_code
    case assets
    when :cdn
      IRuby.display(IRuby.javascript(init_code))
    when :inline
      IRuby.display(IRuby.html(<<END_HTML))
<script type="application/javascript">
#{init_code}
</script>
END_HTML
    end
    true
  end
  self.init_iruby if defined? IRuby

end