desc 'Initial configuration for Chid app'
task :install do
  print "Chid is an assistant to help your day-to-day life.\n\n"
  print "You can use it as "
  print "a terminal App ".green
  print "or through "
  print "Rake Tasks".green
  print", having a greater interaction with it.\n\n"

  print "To initialize the app you can run the command: "
  print "$ chid\n".blue

  @chid_config.configure_chid_file_only
end
