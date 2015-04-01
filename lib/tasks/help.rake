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
