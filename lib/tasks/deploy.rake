namespace :deploy do
  task :after_hook do
    puts "After deploy hook"
  end
end