namespace :rbsavvy do
  task :setup do
    Rake::Task['rbsavvy:setup:db'].invoke
    Rake::Task['rbsavvy:setup:foreman'].invoke
    Rake::Task['rbsavvy:setup:cleanup'].invoke
  end

  namespace :setup do
    task :db do
      puts "\n== Preparing database =="
      unless File.directory? '.postgres'
        system "initdb"
      end

      print "Waiting for postgres to start"
      loop do
        break if system 'psql -d postgres -c "select 1" >/dev/null 2>&1'
        print '.'
        sleep 1
      end
      puts

      copy_template 'database.yml', './config'

      Rake::Task['db:create'].invoke
      Rake::Task['db:migrate'].invoke
    end

    task :foreman do
      puts "\n== Setting up Foreman =="
      copy_template 'Procfile', '.'
    end

    task :cleanup do
      puts "\n== Removing old logs and tempfiles =="
      system "rm -f log/*"
      system "rm -rf tmp/cache"
    end
  end
end
