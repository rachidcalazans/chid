desc 'Initial configuration for Chid app'
task :init do
  print "Chid is an assistant to help your day-to-day life.\n\n"
  print "You can use it as "
  print "a terminal App ".green
  print "or through "
  print "Rake Tasks".green
  print", having a greater interaction with it.\n\n"

  print "To initialize the app you can run the command: "
  print "$ rake\n".blue
  print "Or the command: "
  print "$ chid\n".blue
  print "But the command "
  print "$ chid ".blue
  print "will work after you reload your profile\n"

  @chid_config.configure
end
