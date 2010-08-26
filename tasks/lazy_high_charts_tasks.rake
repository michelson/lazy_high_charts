# desc "Explaining what the task does"
# task :lazy_highcharts do
#   # Task goes here
# end
namespace :lazy_high_charts do
  desc 'Installs required swf in public/ and javascript files to the public/javascripts directory.'
  task :install do
    puts "Copying files..."
    dir = "javascripts"
    ["excanvas.compiled.js", "highcharts.js"].each do |js_file|
    	dest_file = File.join(RAILS_ROOT, "public", dir, js_file)
    	src_file = File.join(RAILS_ROOT + "/vendor/plugins/lazy_high_charts" , dir, js_file)
    	FileUtils.cp_r(src_file, dest_file)
    end
    puts "Files copied - Installation complete!"
  end
  desc 'Removes the javascripts for the plugin.'
  task :remove do
    FileUtils.rm %{excanvas.compiled.js highcharts.js}.collect { |f| RAILS_ROOT + "/public/javascripts/" + f  }
  end
end
