desc 'Open the .chid.config file'
task :chid_config do
  puts "\nOpening the .chid.config..."
  system("vim #{@chid_config.chid_config_path}")
end
