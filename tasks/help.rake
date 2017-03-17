desc 'Show all tasks availabe'
task :help do
  Dir.chdir @chid_config.chid_rake_path
  system("rake -T")
  puts "\nTell me what you need"
end


