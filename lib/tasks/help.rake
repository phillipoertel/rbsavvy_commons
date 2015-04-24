desc "Helpful tips for working with an RBSavvy Rails app"
task :help do
  puts <<-TEXT.strip_heredoc
  Here are some helpful tips to navigate a RBSavvy Rails app

  Environment Variables
  ---------------------
  LOG_LEVEL     - Sets the logging level
  NEW_RELIC_LOG - Place for newrelic log output. For debugging, set to "STDOUT"
  TEXT
end

def copy_template template, path
  $commons_path ||= `bundle list rbsavvy_commons`.strip
  src  = "#{$commons_path}/lib/defaults/#{template}"
  dest = "#{path}/#{template}"

  unless File.exists? dest
    puts "copy from #{src} to #{dest}"
    FileUtils.cp src, dest
  end

end
