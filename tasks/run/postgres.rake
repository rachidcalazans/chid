namespace :run do

  desc 'Start Postgres'
  task :postgres do
    @chid_config.on_osx do
      system('postgres -D /usr/local/var/postgres')
    end
  end

end


